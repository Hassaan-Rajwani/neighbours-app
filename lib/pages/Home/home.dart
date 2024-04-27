// ignore_for_file: constant_identifier_names, camel_case_types
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/data/mappers/notification.dart';
import 'package:neighbour_app/data/models/notification_model.dart';
import 'package:neighbour_app/global/authBloc/auth_bloc.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/pages/Chat/chats.dart';
import 'package:neighbour_app/pages/Home/widgets/home_appbar.dart';
import 'package:neighbour_app/pages/Home/widgets/new_home_helper.dart';
import 'package:neighbour_app/pages/Home/widgets/new_home_neighbrs.dart';
import 'package:neighbour_app/presentation/bloc/helperJobs/helper_jobs_bloc.dart';
import 'package:neighbour_app/presentation/bloc/jobs/jobs_bloc.dart';
import 'package:neighbour_app/presentation/bloc/notificationFeedBloc/notification_feed_bloc.dart';
import 'package:neighbour_app/utils/color_constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static String routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

enum homeScreenType { Neighbor, Helper }

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  PushNotification? _notificationInfo;
  final LocalNotification _localNotification = LocalNotification();

  Future<void> onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse,
  ) async {
    final notificationUrlQuote = notificationResponse.payload!.split(',');
    if (notificationUrlQuote[0] == '/neighbor-job-details' ||
        notificationUrlQuote[0] == '/helper-job-details') {
      final query = Uri(
        queryParameters: {
          'jobId': notificationUrlQuote[1],
        },
      ).query;
      await context.push(
        '${notificationUrlQuote[0]}?$query',
      );
    } else if (notificationUrlQuote[0] == '/bid-page') {
      final query = Uri(
        queryParameters: {
          'jobId': notificationUrlQuote[1],
        },
      ).query;
      await context
          .push(
            '${notificationUrlQuote[0]}?$query',
          )
          .then(
            (value) => {
              if (value == null)
                {
                  sl<JobsBloc>().add(
                    const GetPendingJobEvent(),
                  ),
                },
            },
          );
    } else if (notificationUrlQuote[0] == '/helper-new-jobs') {
      await context.push(notificationUrlQuote[0]).then(
            (value) => {
              if (value == null)
                {
                  sl<HelperJobsBloc>().add(const GetHelperAllJobsEvent()),
                },
            },
          );
    } else if (notificationUrlQuote[0] == '/chat') {
      await context.push(ChatsPage.routeName);
    } else {
      await context.push(notificationUrlQuote[0]);
    }
  }

  Future<void> _handleMessage(RemoteMessage message) async {
    if (message.data['url'] == '/neighbor-job-details' ||
        message.data['url'] == '/helper-job-details') {
      final query = Uri(
        queryParameters: {
          'jobId': message.data['jobId'],
        },
      ).query;
      await context.push(
        '${message.data['url']}?$query',
      );
    } else if (message.data['url'] == '/bid-page') {
      final query = Uri(
        queryParameters: {
          'jobId': message.data['jobId'],
        },
      ).query;
      await context
          .push(
            '${message.data['url']}?$query',
          )
          .then(
            (value) => {
              if (value == null)
                {
                  sl<JobsBloc>().add(
                    const GetPendingJobEvent(),
                  ),
                },
            },
          );
    } else if (message.data['url'] == '/helper-new-jobs') {
      await context.push('${message.data['url']}').then(
            (value) => {
              if (value == null)
                {
                  sl<HelperJobsBloc>().add(const GetHelperAllJobsEvent()),
                },
            },
          );
    } else if (message.data['url'] == '/chat') {
      await context.push(ChatsPage.routeName);
    } else {
      await context.push('${message.data['url']}');
    }
  }

  Future<void> setupInteractedMessage() async {
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      await _handleMessage(initialMessage);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    _localNotification.initialize(
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
    setupInteractedMessage();
    if (Platform.isAndroid) {
      FirebaseMessaging.onMessage.listen(
        (RemoteMessage message) {
          final userState = BlocProvider.of<AuthBloc>(context).state;
          final userType = userState is AuthStateUserType &&
              userState.userType == homeScreenType.Neighbor.name;
          sl<NotificationFeedBloc>().add(
            GetNotificationEvent(
              isNeighbr: userType,
            ),
          );
          debugPrint('Got a message whilst in the foreground!');
          debugPrint('Message data: ${message.data}');

          final notification = PushNotification(
            title: message.notification?.title,
            body: message.notification?.body,
            url: message.data['url'].toString(),
            jobId: message.data['jobId'].toString(),
            image: message.data['image'].toString(),
            name: message.data['name'].toString(),
            recipientId: message.data['recipientUserId'].toString(),
            roomId: message.data['roomId'].toString(),
            senderId: message.data['senderUserId'].toString(),
          );
          if (message.notification != null) {
            setState(() {
              _notificationInfo = notification;
            });
          }
          if (_notificationInfo != null) {
            _localNotification.showNotification(
              title: _notificationInfo!.title!,
              body: _notificationInfo!.body!,
              payload:
                  '''${_notificationInfo!.url},${_notificationInfo!.jobId},${_notificationInfo!.image},${_notificationInfo!.name},${_notificationInfo!.recipientId},${_notificationInfo!.senderId},${_notificationInfo!.roomId}''',
            );
          }
        },
      );
    }

    checkForInitialMessage();
  }

  Future<void> checkForInitialMessage() async {
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      final notification = PushNotification(
        title: initialMessage.notification?.title,
        body: initialMessage.notification?.body,
        url: initialMessage.data['url'].toString(),
        jobId: initialMessage.data['jobId'].toString(),
        image: initialMessage.data['image'].toString(),
        name: initialMessage.data['name'].toString(),
        recipientId: initialMessage.data['recipientUserId'].toString(),
        roomId: initialMessage.data['roomId'].toString(),
        senderId: initialMessage.data['senderUserId'].toString(),
      );

      setState(() {
        _notificationInfo = notification;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateUserType) {
          return Scaffold(
            backgroundColor: bottombarScafoldColor,
            appBar: HomeAppbar(state: state),
            body: SafeArea(
              child: state.userType == homeScreenType.Neighbor.name
                  ? const NewHomeNeighbr()
                  : const NewHomeHelper(),
            ),
          );
        }
        return Container();
      },
    );
  }
}
