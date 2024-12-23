import 'package:curate/src/constants/api_constants.dart';
import 'package:curate/src/constants/app_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../data/manager/preferences_manager.dart';
import 'order_socket_state.dart';

class OrderSocketCubit extends Cubit<OrderSocketState> {
  IO.Socket? socket;

  final _preferences = GetIt.I<PreferencesManager>();
  dynamic data;
  OrderSocketCubit() : super(OrderSocketState(data: null)) {
    checkOrderPending();
  }

  runSocket() async {
    try {
      final token = await _preferences.getUserToken();
      var baseUrl = AppConstants.socketBaseUrlDev;
      socket = IO.io(
          '$baseUrl?token=$token',
          IO.OptionBuilder()
              .setTransports(['websocket']) // for Flutter or Dart VM
              .disableAutoConnect() // disable auto-connection
              .build());
      socket!.connect();
      socket!.onConnect((data) {
        print("socket data");
        print(data);
      });
      socket!.on("notification", (data) {
        print("notification data");
        print(data);
        checkForOrderStatus(data);
      });
    } catch (e) {
      print("socket error");
      print(e);
    }
  }

  checkForOrderStatus(data) async {
    try {
      if (data.containsKey("status")) {
        if (data["status"] != null) {
          if (data["status"] == ApiConstants.paymentStatusSuccess ||
              data["status"] == ApiConstants.paymentStatusFailed) {
            _preferences.removeOrderData();
            if (socket != null) {
              socket!.disconnect();
            }
            emit(OrderSocketState(isDataLoaded: true, data: data));
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  checkOrderPending() async {
    try {
      Map<String, dynamic>? prefOrderData = await _preferences.getOrderStatus();
      if (prefOrderData != null) {
        DateTime time =
            DateTime.fromMicrosecondsSinceEpoch(prefOrderData['time']);
        if (time.add(const Duration(minutes: 5)).isAfter(DateTime.now())) {
          if (socket != null) {
            if (!socket!.connected) {
              runSocket();
            }
          }
        } else {
          _preferences.removeOrderData();
        }
      }
    } catch (e) {
      print("e");
      print(e);
    }
  }

  updateCount(dynamic data) {
    this.data = data;
    emit(OrderSocketState(data: data));
  }
/*

  increaseCount(){
    data = (data ?? 0)+1;
    emit(NotificationCountState(data: data));
  }
*/
}
