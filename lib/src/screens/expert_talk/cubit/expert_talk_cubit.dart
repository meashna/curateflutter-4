import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../constants/network_check.dart';
import '../../../data/models/ConsultantsProductResponse.dart';
import '../../../data/models/apis/UIResponse.dart';
import '../../../data/repository/user_repo/user_repository.dart';
import 'package:meta/meta.dart';

import '../../../utils/app_utils.dart';
part 'expert_talk_state.dart';

class ExpertTalkCubit extends Cubit<ExpertTalkState> {
  final _userRepository = GetIt.I<UserRepository>();
  ConsultantsProductResponse? consultantsProductResponse;

  ExpertTalkCubit() : super(ExpertTalkStateLoading()) {
    // emit(ExpertTalkStateLoading());
    Future.delayed(const Duration(milliseconds: 50), () {
      emit(ExpertTalkStateLoading());
      getConsultantProduct();
    });
    // getConsultantProduct();
    //emit(ExpertTalkStateLoading());
    //getConsultantProduct();
  }

  Future<void> getConsultantProduct() async {
    var checkNetwork = await NetworkCheck.check();
    if (checkNetwork) {
      try {
        var response = await _userRepository.getConsultantProduct();
        if (response.status == Status.COMPLETED) {
          consultantsProductResponse = response.data;
          emit(ExpertTalkStateSuccess());
        } else {
          emit(ExpertTalkStateError(response.message));
        }
      } catch (e) {
        emit(ExpertTalkStateError(e.toString()));
      }
    } else {
      AppUtils.showToast("Internet not received");
      Future.delayed(Duration(milliseconds: 100), () {
        emit(ExpertTalkStateNoInternet());
      });
    }
  }

  Future<Map<String, dynamic>> getOrderId(
      {num? id, required String upiID}) async {
    // Future.delayed(Duration(milliseconds: 100),(){emit(ChoosePackageLoading());});
    var chekcNetwork = await NetworkCheck.check();
    if (chekcNetwork) {
      try {
        var response =
            await _userRepository.createUpiPaymentRequest(id ?? 0, upiID);
        if (response.status == Status.COMPLETED) {
          return {"status": 5, "value": response.data["data"]["id"]};
        } else {
          AppUtils.showToast(response.message);
          return {"status": 4, "value": response.message};
        }
      } catch (e) {
        AppUtils.showToast(e.toString());
        return {"status": 4, "value": e.toString()};
      }
    } else {
      AppUtils.showToast("No internet");
      return {"status": 4, "value": "No internet"};
    }
  }
}
