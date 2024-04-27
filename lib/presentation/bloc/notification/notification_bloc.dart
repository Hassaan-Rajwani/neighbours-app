import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/domain/usecases/notification/post_fcm_usecase.dart';
import 'package:neighbour_app/utils/storage.dart';
part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc(this._postFcmUseCase) : super(NotificationInitial()) {
    on<PostFcmTokenEvent>(_postFcmToken);
  }

  final PostFcmUseCase _postFcmUseCase;

  Future<String?> _postFcmToken(
    PostFcmTokenEvent event,
    Emitter<NotificationState> emit,
  ) async {
    final token = await getDataFromStorage(StorageKeys.userToken);
    if (token != null) {
      final params = PostFcmParms(
        body: event.body,
        token: token,
      );
      await _postFcmUseCase(params);
    }
    return null;
  }
}
