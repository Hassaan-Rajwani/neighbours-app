import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:neighbour_app/core/constants/constants.dart';
import 'package:neighbour_app/data/repository/address_repository_impl.dart';
import 'package:neighbour_app/data/repository/auth_repository_impl.dart';
import 'package:neighbour_app/data/repository/cancel_job_repositoryimpl.dart';
import 'package:neighbour_app/data/repository/cards_repository_impl.dart';
import 'package:neighbour_app/data/repository/chat_repository_impl.dart';
import 'package:neighbour_app/data/repository/dispute_repository_impl.dart';
import 'package:neighbour_app/data/repository/get_helper_repository_impl.dart';
import 'package:neighbour_app/data/repository/helpers_bid_repository_impl.dart';
import 'package:neighbour_app/data/repository/helpers_count_job_repository_impl.dart';
import 'package:neighbour_app/data/repository/helpers_job_repository_impl.dart';
import 'package:neighbour_app/data/repository/helpers_package_repository_impl.dart';
import 'package:neighbour_app/data/repository/neighbor_bids_repository_impl.dart';
import 'package:neighbour_app/data/repository/neighbor_favorite_repository_impl.dart';
import 'package:neighbour_app/data/repository/neighbor_job_repository_impl.dart';
import 'package:neighbour_app/data/repository/neighbor_package_repository_impl.dart';
import 'package:neighbour_app/data/repository/notifications_repository_impl.dart';
import 'package:neighbour_app/data/repository/stripe_login_repository_impl.dart';
import 'package:neighbour_app/data/repository/user_repository_impl.dart';
import 'package:neighbour_app/data/sources/cancelApis/cancel_job_api.dart';
import 'package:neighbour_app/data/sources/cardApis/card_api.dart';
import 'package:neighbour_app/data/sources/disputeApis/dispute_api.dart';
import 'package:neighbour_app/data/sources/helperApis/helper_api.dart';
import 'package:neighbour_app/data/sources/neighborsApis/neighbor_api.dart';
import 'package:neighbour_app/data/sources/stripeApi/stripe_api.dart';
import 'package:neighbour_app/data/sources/userApis/user_api.dart';
import 'package:neighbour_app/domain/repository/address_repository.dart';
import 'package:neighbour_app/domain/repository/auth_repository.dart';
import 'package:neighbour_app/domain/repository/cancel_job_repository.dart';
import 'package:neighbour_app/domain/repository/card_repository.dart';
import 'package:neighbour_app/domain/repository/chat_repository.dart';
import 'package:neighbour_app/domain/repository/dispute_repository.dart';
import 'package:neighbour_app/domain/repository/helper_repository.dart';
import 'package:neighbour_app/domain/repository/helpers_bid_repository.dart';
import 'package:neighbour_app/domain/repository/helpers_count_job_repository.dart';
import 'package:neighbour_app/domain/repository/helpers_job_repository.dart';
import 'package:neighbour_app/domain/repository/helpers_package_repository.dart';
import 'package:neighbour_app/domain/repository/jobs_repository.dart';
import 'package:neighbour_app/domain/repository/neighbor_bids_repository.dart';
import 'package:neighbour_app/domain/repository/neighbor_favorite_repository.dart';
import 'package:neighbour_app/domain/repository/neighbor_package_repository.dart';
import 'package:neighbour_app/domain/repository/notifications_repository.dart';
import 'package:neighbour_app/domain/repository/stripe_login_repository.dart';
import 'package:neighbour_app/domain/repository/user_repository.dart';
import 'package:neighbour_app/domain/usecases/address/active_address.dart';
import 'package:neighbour_app/domain/usecases/address/create_address.dart';
import 'package:neighbour_app/domain/usecases/address/delete_address.dart';
import 'package:neighbour_app/domain/usecases/address/edit_address.dart';
import 'package:neighbour_app/domain/usecases/address/get_address.dart';
import 'package:neighbour_app/domain/usecases/auth/change_password.dart';
import 'package:neighbour_app/domain/usecases/auth/deactivate_account.dart';
import 'package:neighbour_app/domain/usecases/auth/email_verification.dart';
import 'package:neighbour_app/domain/usecases/auth/forgot_password.dart';
import 'package:neighbour_app/domain/usecases/auth/google_auth_usecase.dart';
import 'package:neighbour_app/domain/usecases/auth/logout.dart';
import 'package:neighbour_app/domain/usecases/auth/reset_password.dart';
import 'package:neighbour_app/domain/usecases/auth/signin.dart';
import 'package:neighbour_app/domain/usecases/auth/signup.dart';
import 'package:neighbour_app/domain/usecases/bids/get_neighbor_bids.dart';
import 'package:neighbour_app/domain/usecases/bids/neighbor_bid_accept.dart';
import 'package:neighbour_app/domain/usecases/bids/put_neighbor_bids_reject.dart';
import 'package:neighbour_app/domain/usecases/cancelJob/postCancelJob.dart';
import 'package:neighbour_app/domain/usecases/cards/add_card.dart';
import 'package:neighbour_app/domain/usecases/cards/delete_card.dart';
import 'package:neighbour_app/domain/usecases/cards/get_cards.dart';
import 'package:neighbour_app/domain/usecases/cards/update_card.dart';
import 'package:neighbour_app/domain/usecases/chat/get_chat_messages_usecase.dart';
import 'package:neighbour_app/domain/usecases/chat/get_chat_room_usecase.dart';
import 'package:neighbour_app/domain/usecases/dispute/create_dispute.dart';
import 'package:neighbour_app/domain/usecases/favorites/add_favorite.dart';
import 'package:neighbour_app/domain/usecases/favorites/delete_favorite.dart';
import 'package:neighbour_app/domain/usecases/favorites/get_favorites.dart';
import 'package:neighbour_app/domain/usecases/helper/get_all_helper_usecase.dart';
import 'package:neighbour_app/domain/usecases/helper/get_another_user.dart';
import 'package:neighbour_app/domain/usecases/helperBids/create_bid.dart';
import 'package:neighbour_app/domain/usecases/helperBids/reject_bid.dart';
import 'package:neighbour_app/domain/usecases/helperPackage/create_package.dart';
import 'package:neighbour_app/domain/usecases/helperPackage/get_package.dart';
import 'package:neighbour_app/domain/usecases/helpersJob/get_all_active_jobs.dart';
import 'package:neighbour_app/domain/usecases/helpersJob/get_all_closed_jobs.dart';
import 'package:neighbour_app/domain/usecases/helpersJob/get_helper_job_by_id.dart';
import 'package:neighbour_app/domain/usecases/helpersJob/get_job.dart';
import 'package:neighbour_app/domain/usecases/helpersJob/get_pending_jobs.dart';
import 'package:neighbour_app/domain/usecases/jobs/cancel_review.dart';
import 'package:neighbour_app/domain/usecases/jobs/create_job.dart';
import 'package:neighbour_app/domain/usecases/jobs/create_review.dart';
import 'package:neighbour_app/domain/usecases/jobs/edit_job.dart';
import 'package:neighbour_app/domain/usecases/jobs/get_active_job.dart';
import 'package:neighbour_app/domain/usecases/jobs/get_closed_job.dart';
import 'package:neighbour_app/domain/usecases/jobs/get_job_by_id.dart';
import 'package:neighbour_app/domain/usecases/jobs/get_job_history.dart';
import 'package:neighbour_app/domain/usecases/jobs/get_pending_job.dart';
import 'package:neighbour_app/domain/usecases/jobs/get_user_review.dart';
import 'package:neighbour_app/domain/usecases/jobs/post_close_job.dart';
import 'package:neighbour_app/domain/usecases/neighborsPacakge/get_neighbors_packages_usecase.dart';
import 'package:neighbour_app/domain/usecases/neighborsPacakge/give_tip_usecase.dart';
import 'package:neighbour_app/domain/usecases/neighborsPacakge/update_neighbor_package_usecase.dart';
import 'package:neighbour_app/domain/usecases/notification/post_fcm_usecase.dart';
import 'package:neighbour_app/domain/usecases/notificationUsecase/active_notification_usecase.dart';
import 'package:neighbour_app/domain/usecases/notificationUsecase/delete_notification_usecase.dart';
import 'package:neighbour_app/domain/usecases/notificationUsecase/get_notification_list_usecase.dart';
import 'package:neighbour_app/domain/usecases/stripe/add_card.dart';
import 'package:neighbour_app/domain/usecases/user/delete_account_usecase.dart';
import 'package:neighbour_app/domain/usecases/user/get_profile.dart';
import 'package:neighbour_app/domain/usecases/user/update_profile.dart';
import 'package:neighbour_app/global/authBloc/auth_bloc.dart';
import 'package:neighbour_app/global/networkBloc/network_bloc.dart';
import 'package:neighbour_app/presentation/bloc/address/address_bloc.dart';
import 'package:neighbour_app/presentation/bloc/bids/bids_bloc.dart';
import 'package:neighbour_app/presentation/bloc/cancelJob/cancel_job_bloc.dart';
import 'package:neighbour_app/presentation/bloc/cancelReviewBloc/cancel_review_bloc.dart';
import 'package:neighbour_app/presentation/bloc/cards/cards_bloc.dart';
import 'package:neighbour_app/presentation/bloc/chat/chat_bloc.dart';
import 'package:neighbour_app/presentation/bloc/dispute/dispute_bloc.dart';
import 'package:neighbour_app/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:neighbour_app/presentation/bloc/getAllHelpers/all_helper_bloc.dart';
import 'package:neighbour_app/presentation/bloc/getAnotherUser/get_another_user_bloc.dart';
import 'package:neighbour_app/presentation/bloc/getById/get_by_id_bloc.dart';
import 'package:neighbour_app/presentation/bloc/getHelperJobById/get_helper_job_by_id_bloc.dart';
import 'package:neighbour_app/presentation/bloc/helperBids/helper_bid_bloc.dart';
import 'package:neighbour_app/presentation/bloc/helperJobs/helper_jobs_bloc.dart';
import 'package:neighbour_app/presentation/bloc/helperPackage/helper_package_bloc.dart';
import 'package:neighbour_app/presentation/bloc/jobHistoryAndReviews/job_history_and_reviews_bloc.dart';
import 'package:neighbour_app/presentation/bloc/jobs/jobs_bloc.dart';
import 'package:neighbour_app/presentation/bloc/messages/messages_bloc.dart';
import 'package:neighbour_app/presentation/bloc/neighborsPackages/neighbors_packages_bloc.dart';
import 'package:neighbour_app/presentation/bloc/notification/notification_bloc.dart';
import 'package:neighbour_app/presentation/bloc/notificationFeedBloc/notification_feed_bloc.dart';
import 'package:neighbour_app/presentation/bloc/paymentIntents/payment_intents_bloc.dart';
import 'package:neighbour_app/presentation/bloc/profile/profile_bloc.dart';
import 'package:neighbour_app/presentation/bloc/stripe/stripe_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Local Database
  // final database =
  //     await $FloorAppDatabase.databaseBuilder('app_database').build();
  // sl.registerSingleton<AppDatabase>(database);

  // // dio

  sl
    ..registerSingleton<Dio>(Dio(BaseOptions(baseUrl: apiBaseUrl)))

    // // dependencies
    ..registerSingleton<UserApiService>(UserApiService(sl()))
    ..registerSingleton<NeighborApiService>(NeighborApiService(sl()))
    ..registerSingleton<HelperApiService>(HelperApiService(sl()))
    ..registerSingleton<DisputeApiService>(DisputeApiService(sl()))
    ..registerSingleton<CancelJobApiService>(CancelJobApiService(sl()))
    ..registerSingleton<CardApiService>(CardApiService(sl()))
    ..registerSingleton<StripeApiService>(StripeApiService(sl()))

    // repositories
    ..registerSingleton<UserRepository>(UserRepositoryImpl(sl()))
    ..registerSingleton<HelpersBidRepository>(HelpersBidRepositoryImpl(sl()))
    ..registerSingleton<AddressRepository>(AddressRepositoryImpl(sl()))
    ..registerSingleton<NeighborJobRepository>(
      NeighborJobRepositoryImpl(
        sl(),
      ),
    )
    ..registerSingleton<NeighborFavoriteRepository>(
      NeighborFavoriteRepositoryImpl(sl()),
    )
    ..registerSingleton<ChatRepository>(
      ChatRepositoryImpl(sl()),
    )
    ..registerSingleton<HelpersPackageRepository>(
      HelpersPackageRepositoryImpl(sl()),
    )
    ..registerSingleton<HelperRepository>(
      HelperRespositoryImpl(
        sl(),
        sl(),
      ),
    )
    ..registerSingleton<NeighborPackageRepository>(
      NeighborPackageRepositoryImpl(sl()),
    )
    ..registerSingleton<HelpersJobRepository>(
      HelpersJobRepositoryImpl(
        sl(),
        sl(),
      ),
    )
    ..registerSingleton<NeighborBidsRepository>(
      NeighborBidsRepositoryImpl(sl()),
    )
    ..registerSingleton<HelpersCountJobRepository>(
      HelpersCountJobRepositoryImpl(sl()),
    )
    ..registerSingleton<AuthenticationRepository>(
      AuthenticationRepositoryImpl(sl()),
    )
    ..registerSingleton<CardRepository>(
      CardsRepositoryImpl(sl()),
    )
    ..registerSingleton<CancelJobRepository>(
      CancelJobRepositoryImpl(sl()),
    )
    ..registerSingleton<StripeRepository>(
      StripeRepositoryImpl(sl()),
    )
    ..registerSingleton<DisputeRepository>(
      DisputeRepositoryImpl(sl()),
    )
    ..registerSingleton<NotificationRepository>(
      NotificationsRepositoryImpl(sl()),
    )

    // // use cases
    ..registerSingleton<SignInUseCase>(SignInUseCase(sl()))
    ..registerSingleton<GetHelperJobByIdUseCase>(GetHelperJobByIdUseCase(sl()))
    ..registerSingleton<SignUpUseCase>(SignUpUseCase(sl()))
    ..registerSingleton<EmailVerificationUseCase>(
      EmailVerificationUseCase(sl()),
    )
    ..registerSingleton<LogoutUseCase>(LogoutUseCase(sl()))
    ..registerSingleton<DeleteProfileUseCase>(DeleteProfileUseCase(sl()))
    ..registerSingleton<ChangePasswordUseCase>(ChangePasswordUseCase(sl()))
    ..registerSingleton<ForgotPasswordUseCase>(ForgotPasswordUseCase(sl()))
    ..registerSingleton<ForgotPasswordResendCodeUseCase>(
      ForgotPasswordResendCodeUseCase(sl()),
    )
    ..registerSingleton<ResetPasswordUseCase>(ResetPasswordUseCase(sl()))
    ..registerSingleton<ResendEmailVerificationUseCase>(
      ResendEmailVerificationUseCase(sl()),
    )
    ..registerSingleton<GetProfileUseCase>(GetProfileUseCase(sl()))
    ..registerSingleton<EditProfileUseCase>(EditProfileUseCase(sl()))
    ..registerSingleton<CreateAddressUseCase>(CreateAddressUseCase(sl()))
    ..registerSingleton<GetAddressUseCase>(GetAddressUseCase(sl()))
    ..registerSingleton<DeleteAddressUseCase>(DeleteAddressUseCase(sl()))
    ..registerSingleton<EditAddressUseCase>(EditAddressUseCase(sl()))
    ..registerSingleton<ActiveAddressUseCase>(ActiveAddressUseCase(sl()))
    ..registerSingleton<AddFavoriteUseCase>(AddFavoriteUseCase(sl()))
    ..registerSingleton<GetFavoritesUseCase>(GetFavoritesUseCase(sl()))
    ..registerSingleton<DeleteFavoriteUseCase>(DeleteFavoriteUseCase(sl()))
    ..registerSingleton<GiveTipUseCase>(GiveTipUseCase(sl()))
    ..registerSingleton<GetNotificationListUseCase>(
      GetNotificationListUseCase(sl()),
    )
    ..registerSingleton<UpdateNotificationListUseCase>(
      UpdateNotificationListUseCase(sl()),
    )
    ..registerSingleton<DeleteNotificationUseCase>(
      DeleteNotificationUseCase(sl()),
    )
    ..registerSingleton<GetNeighborPackageUseCase>(
      GetNeighborPackageUseCase(
        sl(),
      ),
    )
    ..registerSingleton<UpdateNeighborPackageUseCase>(
      UpdateNeighborPackageUseCase(
        sl(),
      ),
    )
    ..registerSingleton<GetAnotherUserUseCase>(
      GetAnotherUserUseCase(
        sl(),
      ),
    )
    ..registerSingleton<GetJobUseCase>(GetJobUseCase(sl()))
    ..registerSingleton<PostCancelJobUseCase>(PostCancelJobUseCase(sl()))
    ..registerSingleton<GetJobHistoryUseCase>(GetJobHistoryUseCase(sl()))
    ..registerSingleton<GetReviewUseCase>(GetReviewUseCase(sl()))
    ..registerSingleton<CreateCancelReviewUseCase>(
      CreateCancelReviewUseCase(sl()),
    )
    ..registerSingleton<GetAllPendingJobsUseCase>(
      GetAllPendingJobsUseCase(sl()),
    )
    ..registerSingleton<GetAllActiveJobsUseCase>(
      GetAllActiveJobsUseCase(sl()),
    )
    ..registerSingleton<GetAllClosedJobsUseCase>(
      GetAllClosedJobsUseCase(sl()),
    )
    ..registerSingleton<GetAtiveJobUseCase>(GetAtiveJobUseCase(sl()))
    ..registerSingleton<GetClosedJobUseCase>(GetClosedJobUseCase(sl()))
    ..registerSingleton<GetPendingJobUseCase>(GetPendingJobUseCase(sl()))
    ..registerSingleton<CreateJobUseCase>(CreateJobUseCase(sl()))
    ..registerSingleton<EditJobUseCase>(EditJobUseCase(sl()))
    ..registerSingleton<PostCloseJobUseCase>(PostCloseJobUseCase(sl()))
    ..registerSingleton<GetJobByIdUseCase>(GetJobByIdUseCase(sl()))
    ..registerSingleton<CreateReviewUseCase>(CreateReviewUseCase(sl()))
    ..registerSingleton<GetAllHelperUseCase>(GetAllHelperUseCase(sl()))
    ..registerSingleton<GetHelperPackageUseCase>(GetHelperPackageUseCase(sl()))
    ..registerSingleton<GetNeighborBidsUseCase>(GetNeighborBidsUseCase(sl()))
    ..registerSingleton<NeighborBidAcceptUseCase>(
      NeighborBidAcceptUseCase(sl()),
    )
    ..registerSingleton<NeighborBidRejectCase>(NeighborBidRejectCase(sl()))
    ..registerSingleton<GetCardListUseCase>(GetCardListUseCase(sl()))
    ..registerSingleton<DeleteCardUseCase>(DeleteCardUseCase(sl()))
    ..registerSingleton<UpdateCardUseCase>(UpdateCardUseCase(sl()))
    ..registerSingleton<AddCardUseCase>(AddCardUseCase(sl()))
    ..registerSingleton<CreatePackageUseCase>(CreatePackageUseCase(sl()))
    ..registerSingleton<CreateBidUseCase>(CreateBidUseCase(sl()))
    ..registerSingleton<RejectBidUseCase>(RejectBidUseCase(sl()))
    ..registerSingleton<DeactivateUseCase>(DeactivateUseCase(sl()))
    ..registerSingleton<GetChatRoomUseCase>(GetChatRoomUseCase(sl()))
    ..registerSingleton<GetChatMessagesUseCase>(GetChatMessagesUseCase(sl()))
    ..registerSingleton<AddStripeUseCase>(AddStripeUseCase(sl()))
    ..registerSingleton<CreateDisputeUseCase>(CreateDisputeUseCase(sl()))
    ..registerSingleton<GoogleAuthUseCase>(GoogleAuthUseCase(sl()))
    ..registerSingleton<PostFcmUseCase>(PostFcmUseCase(sl()))

    // // bloc
    ..registerSingleton<NetworkBloc>(NetworkBloc())
    ..registerSingleton<HelperBidBloc>(HelperBidBloc(sl(), sl()))
    ..registerSingleton<AllHelperBloc>(AllHelperBloc(sl()))
    ..registerSingleton<NotificationFeedBloc>(
      NotificationFeedBloc(
        sl(),
        sl(),
        sl(),
      ),
    )
    ..registerSingleton<ProfileBloc>(
      ProfileBloc(
        sl(),
        sl(),
        sl(),
      ),
    )
    ..registerSingleton<AddressBloc>(AddressBloc(sl(), sl(), sl(), sl(), sl()))
    ..registerSingleton<JobsBloc>(
      JobsBloc(
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
      ),
    )
    ..registerSingleton<CancelJobBloc>(
      CancelJobBloc(
        sl(),
      ),
    )
    ..registerSingleton<GetAnotherUserBloc>(
      GetAnotherUserBloc(
        sl(),
      ),
    )
    ..registerSingleton<GetHelperJobByIdBloc>(
      GetHelperJobByIdBloc(
        sl(),
      ),
    )
    ..registerSingleton<GetByIdBloc>(
      GetByIdBloc(
        sl(),
      ),
    )
    ..registerSingleton<JobHistoryAndReviewsBloc>(
      JobHistoryAndReviewsBloc(
        sl(),
        sl(),
      ),
    )
    ..registerSingleton<BidsBloc>(
      BidsBloc(
        sl(),
        sl(),
        sl(),
      ),
    )
    ..registerSingleton<HelperPackageBloc>(
      HelperPackageBloc(
        sl(),
        sl(),
      ),
    )
    ..registerSingleton<HelperJobsBloc>(
      HelperJobsBloc(
        sl(),
        sl(),
        sl(),
      ),
    )
    ..registerSingleton<FavoriteBloc>(
      FavoriteBloc(
        sl(),
        sl(),
        sl(),
      ),
    )
    ..registerSingleton<CardsBloc>(
      CardsBloc(
        sl(),
        sl(),
        sl(),
      ),
    )
    ..registerSingleton<StripeBloc>(
      StripeBloc(
        sl(),
      ),
    )
    ..registerSingleton<DisputeBloc>(
      DisputeBloc(
        sl(),
      ),
    )
    ..registerSingleton<PaymentIntentsBloc>(
      PaymentIntentsBloc(
        sl(),
      ),
    )
    ..registerSingleton<NeighborsPackagesBloc>(
      NeighborsPackagesBloc(sl(), sl(), sl()),
    )
    ..registerSingleton<AuthBloc>(
      AuthBloc(
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
        sl(),
      ),
    )
    ..registerSingleton<ChatBloc>(
      ChatBloc(sl()),
    )
    ..registerSingleton<NotificationBloc>(
      NotificationBloc(sl()),
    )
    ..registerSingleton<MessagesBloc>(
      MessagesBloc(sl()),
    )
    ..registerSingleton<CancelReviewBloc>(
      CancelReviewBloc(sl()),
    );
}
