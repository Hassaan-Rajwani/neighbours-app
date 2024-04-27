import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/data/models/notification_feed_model.dart';
import 'package:neighbour_app/domain/repository/notifications_repository.dart';

class GetNotificationsParms {
  GetNotificationsParms({
    required this.isNeighbr,
    required this.token,
  });

  bool isNeighbr;
  String token;
}

class GetNotificationListUseCase
    implements
        UseCase<DataState<NotificationFeedModel>, GetNotificationsParms> {
  GetNotificationListUseCase(this._notificationsRepository);

  final NotificationRepository _notificationsRepository;

  @override
  Future<DataState<NotificationFeedModel>> call(GetNotificationsParms parms) {
    return _notificationsRepository.getNotificationList(
      isNeighbr: parms.isNeighbr,
      token: parms.token,
    );
  }
}
