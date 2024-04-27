import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/domain/repository/notifications_repository.dart';

class UpdateNotificationsParms {
  UpdateNotificationsParms({
    required this.isNeighbr,
    required this.token,
    required this.notificationId,
  });

  bool isNeighbr;
  String token;
  String notificationId;
}

class UpdateNotificationListUseCase
    implements UseCase<DataState<String?>, UpdateNotificationsParms> {
  UpdateNotificationListUseCase(this._notificationsRepository);

  final NotificationRepository _notificationsRepository;

  @override
  Future<DataState<String?>> call(
    UpdateNotificationsParms parms,
  ) {
    return _notificationsRepository.updateNotification(
      isNeighbr: parms.isNeighbr,
      token: parms.token,
      notificationId: parms.notificationId,
    );
  }
}
