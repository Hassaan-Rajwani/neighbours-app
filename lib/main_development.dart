// ignore_for_file: unused_local_variable
import 'dart:convert';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:neighbour_app/app/app.dart';
import 'package:neighbour_app/config/aws_config.dart';
import 'package:neighbour_app/firebase_options.dart';
import 'package:neighbour_app/global/authBloc/auth_bloc.dart';
import 'package:neighbour_app/global/authBloc/auth_event.dart';
import 'package:neighbour_app/global/networkBloc/network_bloc.dart';
import 'package:neighbour_app/injection_container.dart';
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
import 'package:neighbour_app/utils/envs.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Handling a background message: ${message.messageId}');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    dotenv.load(fileName: '.env.dev'),
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom],
    ),
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  Stripe.publishableKey = dotenv.env[EnvKeys.stripeKey]!;
  await Stripe.instance.applySettings();
  await initializeDependencies();
  await _configureAmplify();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final messaging = FirebaseMessaging.instance;
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  final settings = await messaging.requestPermission(
    announcement: true,
    carPlay: true,
    criticalAlert: true,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => sl<AuthBloc>()..add(AuthSplashEvent()),
        ),
        BlocProvider<NetworkBloc>(
          create: (_) => sl<NetworkBloc>()..add(NetworkEventConnected()),
        ),
        BlocProvider<ProfileBloc>(
          create: (_) => sl<ProfileBloc>(),
        ),
        BlocProvider<AddressBloc>(
          create: (_) => sl<AddressBloc>(),
        ),
        BlocProvider<CardsBloc>(
          create: (_) => sl<CardsBloc>(),
        ),
        BlocProvider<JobsBloc>(
          create: (_) => sl<JobsBloc>(),
        ),
        BlocProvider<BidsBloc>(
          create: (_) => sl<BidsBloc>(),
        ),
        BlocProvider<HelperJobsBloc>(
          create: (_) => sl<HelperJobsBloc>(),
        ),
        BlocProvider<FavoriteBloc>(
          create: (_) => sl<FavoriteBloc>(),
        ),
        BlocProvider<AllHelperBloc>(
          create: (_) => sl<AllHelperBloc>(),
        ),
        BlocProvider<ChatBloc>(
          create: (_) => sl<ChatBloc>(),
        ),
        BlocProvider<MessagesBloc>(
          create: (_) => sl<MessagesBloc>(),
        ),
        BlocProvider<NeighborsPackagesBloc>(
          create: (_) => sl<NeighborsPackagesBloc>(),
        ),
        BlocProvider<HelperPackageBloc>(
          create: (_) => sl<HelperPackageBloc>(),
        ),
        BlocProvider<HelperBidBloc>(
          create: (_) => sl<HelperBidBloc>(),
        ),
        BlocProvider<CancelJobBloc>(
          create: (_) => sl<CancelJobBloc>(),
        ),
        BlocProvider<StripeBloc>(
          create: (_) => sl<StripeBloc>(),
        ),
        BlocProvider<DisputeBloc>(
          create: (_) => sl<DisputeBloc>(),
        ),
        BlocProvider<JobHistoryAndReviewsBloc>(
          create: (_) => sl<JobHistoryAndReviewsBloc>(),
        ),
        BlocProvider<PaymentIntentsBloc>(
          create: (_) => sl<PaymentIntentsBloc>(),
        ),
        BlocProvider<NotificationBloc>(
          create: (_) => sl<NotificationBloc>(),
        ),
        BlocProvider<GetByIdBloc>(
          create: (_) => sl<GetByIdBloc>(),
        ),
        BlocProvider<GetHelperJobByIdBloc>(
          create: (_) => sl<GetHelperJobByIdBloc>(),
        ),
        BlocProvider<GetAnotherUserBloc>(
          create: (_) => sl<GetAnotherUserBloc>(),
        ),
        BlocProvider<NotificationFeedBloc>(
          create: (_) => sl<NotificationFeedBloc>(),
        ),
        BlocProvider<CancelReviewBloc>(
          create: (_) => sl<CancelReviewBloc>(),
        ),
      ],
      child: const App(),
    ),
  );
}

Future<void> _configureAmplify() async {
  final auth = AmplifyAuthCognito();
  await Amplify.addPlugins([auth]);
  await Amplify.configure(jsonEncode(awsConfig));
}
