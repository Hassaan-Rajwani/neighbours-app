import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/data/models/notification_feed_model.dart';
import 'package:neighbour_app/domain/usecases/notificationUsecase/active_notification_usecase.dart';
import 'package:neighbour_app/domain/usecases/notificationUsecase/delete_notification_usecase.dart';
import 'package:neighbour_app/domain/usecases/notificationUsecase/get_notification_list_usecase.dart';
import 'package:neighbour_app/utils/storage.dart';

part 'notification_feed_event.dart';
part 'notification_feed_state.dart';

class NotificationFeedBloc
    extends Bloc<NotificationFeedEvent, NotificationFeedState> {
  NotificationFeedBloc(
    this._getNotificationListUseCase,
    this._updateNotificationListUseCase,
    this._deleteNotificationUseCase,
  ) : super(NotificationInitial()) {
    on<GetNotificationEvent>(_getNotificationList);
    on<MarkAsReadNotification>(_markAsReadNotification);
    on<DeleteNotification>(_deleteNotification);
  }

  final GetNotificationListUseCase _getNotificationListUseCase;
  final UpdateNotificationListUseCase _updateNotificationListUseCase;
  final DeleteNotificationUseCase _deleteNotificationUseCase;

  Future<void> _getNotificationList(
    GetNotificationEvent event,
    Emitter<NotificationFeedState> emit,
  ) async {
    emit(GetNotificationListInProgress());
    final token = await getDataFromStorage(StorageKeys.userToken);
    if (token != null) {
      final params = GetNotificationsParms(
        isNeighbr: event.isNeighbr,
        token: token,
      );
      final dataState = await _getNotificationListUseCase(params);
      if (dataState.data != null) {
        emit(GetNotificationListState(list: dataState.data!));
      } else {
        emit(GetNotificationListError(error: dataState.error!.message!));
      }
    }
  }

  Future<void> _markAsReadNotification(
    MarkAsReadNotification event,
    Emitter<NotificationFeedState> emit,
  ) async {
    final token = await getDataFromStorage(StorageKeys.userToken);
    if (token != null) {
      final params = UpdateNotificationsParms(
        isNeighbr: event.isNeighbr,
        token: token,
        notificationId: event.notificationId,
      );
      await _updateNotificationListUseCase(params);
    }
  }

  Future<void> _deleteNotification(
    DeleteNotification event,
    Emitter<NotificationFeedState> emit,
  ) async {
    final token = await getDataFromStorage(StorageKeys.userToken);
    if (token != null) {
      final params = DeleteNotificationsParms(
        isNeighbr: event.isNeighbr,
        token: token,
        notificationId: event.notificationId,
      );
      await _deleteNotificationUseCase(params);
    }
  }
}
