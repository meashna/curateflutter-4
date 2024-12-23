import 'package:flutter_bloc/flutter_bloc.dart';

import 'notification_count_state.dart';

class NotificationCountCubit extends Cubit<NotificationCountState> {
  int? count;
  NotificationCountCubit() : super(NotificationCountState(count: 0));

  updateCount(int count) {
    this.count = count;
    emit(NotificationCountState(count: count));
  }

  increaseCount() {
    count = (count ?? 0) + 1;
    emit(NotificationCountState(count: count));
  }
}
