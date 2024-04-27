import 'package:neighbour_app/core/resources/data_state.dart';
import 'package:neighbour_app/core/usecase/usecase.dart';
import 'package:neighbour_app/domain/repository/notifications_repository.dart';

class DeleteNotificationsParms {
  DeleteNotificationsParms({
    required this.isNeighbr,
    required this.token,
    required this.notificationId,
  });

  bool isNeighbr;
  String token;
  String notificationId;
}

class DeleteNotificationUseCase
    implements UseCase<DataState<String?>, DeleteNotificationsParms> {
  DeleteNotificationUseCase(this._notificationsRepository);

  final NotificationRepository _notificationsRepository;

  @override
  Future<DataState<String?>> call(
    DeleteNotificationsParms parms,
  ) {
    return _notificationsRepository.deleteNotification(
      isNeighbr: parms.isNeighbr,
      token: parms.token,
      notificationId: parms.notificationId,
    );
  }
}
