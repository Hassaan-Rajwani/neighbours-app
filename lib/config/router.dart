// ignore_for_file: avoid_redundant_argument_values

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/global/authBloc/auth_bloc.dart';
import 'package:neighbour_app/layout/layout.dart';
import 'package:neighbour_app/layout/layout_with_bottom_nav.dart';
import 'package:neighbour_app/pages/AddAddress/add_address.dart';
import 'package:neighbour_app/pages/Addresses/add_new_address.dart';
import 'package:neighbour_app/pages/Addresses/new_addresses.dart';
import 'package:neighbour_app/pages/Addresses/search_new_address.dart';
import 'package:neighbour_app/pages/AllJobs/helper_new_jobs.dart';
import 'package:neighbour_app/pages/AllJobs/neighbor_all_jobs.dart';
import 'package:neighbour_app/pages/Bids/bids.dart';
import 'package:neighbour_app/pages/Changepassword/change_password.dart';
import 'package:neighbour_app/pages/Chat/chat.dart';
import 'package:neighbour_app/pages/Chat/chats.dart';
import 'package:neighbour_app/pages/EditProfile/edit_profile.dart';
import 'package:neighbour_app/pages/Favorites/favorites.dart';
import 'package:neighbour_app/pages/Helper/helper.dart';
import 'package:neighbour_app/pages/HelperJobDetail/helper_job_detail.dart';
import 'package:neighbour_app/pages/Home/home.dart';
import 'package:neighbour_app/pages/MainAuth/main_auth.dart';
import 'package:neighbour_app/pages/NeighborJobDetail/neighbor_job_detail.dart';
import 'package:neighbour_app/pages/OtpVerification/otp_verification.dart';
import 'package:neighbour_app/pages/Settings/menu_setting.dart';
import 'package:neighbour_app/pages/Settings/settings.dart';
import 'package:neighbour_app/pages/SignIn/sign_in.dart';
import 'package:neighbour_app/pages/Signup/sign_up.dart';
import 'package:neighbour_app/pages/Splash/splash.dart';
import 'package:neighbour_app/pages/accountDelete/account_delete.dart';
import 'package:neighbour_app/pages/allPendingJobs/all_pending_jobs.dart';
import 'package:neighbour_app/pages/cancelReviewPage/cancel_review_page.dart';
import 'package:neighbour_app/pages/forgotPassword/forgot_password.dart';
import 'package:neighbour_app/pages/helperProfile/helper_profile.dart';
import 'package:neighbour_app/pages/jobsHistory/jobs_history.dart';
import 'package:neighbour_app/pages/neighborGiveTip/neighbor_give_tip.dart';
import 'package:neighbour_app/pages/neighborsGiveRating/neighbor_give_rating.dart';
import 'package:neighbour_app/pages/newJobDetail/new_job_detail.dart';
import 'package:neighbour_app/pages/notificationPage/notification_page.dart';
import 'package:neighbour_app/pages/onboarding/onboarding.dart';
import 'package:neighbour_app/pages/openJobs/open_jobs.dart';
import 'package:neighbour_app/pages/payment/add_card.dart';
import 'package:neighbour_app/pages/payment/payment.dart';
import 'package:neighbour_app/pages/postNewJob/post_new_job.dart';
import 'package:neighbour_app/pages/resetPassword/reset_password.dart';
import 'package:neighbour_app/pages/stripe/add_stripe.dart';

final _parentKey = GlobalKey<NavigatorState>();

class AppNavigation {
  AppNavigation();

  GoRouter router = GoRouter(
    navigatorKey: _parentKey,
    debugLogDiagnostics: kDebugMode,
    overridePlatformDefaultLocation: true,
    initialLocation: SplashPage.routeName,
    routes: [
      GoRoute(
        path: SplashPage.routeName,
        builder: (context, state) {
          return BlocListener<AuthBloc, AuthState>(
            child: const SplashPage(),
            listener: (context, state) {
              Timer(const Duration(seconds: 4), () {
                if (state is AuthStateOnboarding) {
                  context.go(OnboardingPage.routeName);
                  return;
                }
                if (state is AuthStateUserType) {
                  context.go(HomePage.routeName);
                  return;
                }
                if (state is AuthStateSignedOut) {
                  context.go(MainAuthPage.routeName);
                  return;
                }
              });
            },
          );
        },
      ),
      GoRoute(
        path: OnboardingPage.routeName,
        builder: (context, state) => const Layout(child: OnboardingPage()),
      ),
      GoRoute(
        path: MainAuthPage.routeName,
        builder: (context, state) => const Layout(child: MainAuthPage()),
      ),
      GoRoute(
        path: SignInPage.routeName,
        builder: (context, state) {
          final deviceId = state.uri.queryParameters['deviceId'].toString();
          return Layout(
            child: SignInPage(
              deviceId: deviceId,
            ),
          );
        },
      ),
      GoRoute(
        path: SignupPage.routeName,
        builder: (context, state) => const Layout(child: SignupPage()),
      ),
      GoRoute(
        path: OtpVerificationPage.routeName,
        builder: (context, state) {
          final email = state.extra.toString();
          return Layout(
            child: OtpVerificationPage(email: email),
          );
        },
      ),
      GoRoute(
        path: ForgotPasswordPage.routeName,
        builder: (context, state) {
          return const Layout(child: ForgotPasswordPage());
        },
      ),
      GoRoute(
        path: ResetPasswordPage.routeName,
        builder: (context, state) {
          final email = state.uri.queryParameters['email'].toString();
          return Layout(child: ResetPasswordPage(email: email));
        },
      ),
      GoRoute(
        path: LayoutWithBottomNav.routeName,
        builder: (context, state) {
          final pageIndex = state.uri.queryParameters['pageIndex'];
          return Layout(
            child: LayoutWithBottomNav(
              pageIndex: pageIndex != null ? int.parse(pageIndex) : 0,
            ),
          );
        },
      ),
      GoRoute(
        path: HomePage.routeName,
        builder: (context, state) => const LayoutWithBottomNav(pageIndex: 0),
      ),
      GoRoute(
        path: HelperPage.routeName,
        builder: (context, state) => const LayoutWithBottomNav(pageIndex: 1),
      ),
      GoRoute(
        path: ChatsPage.routeName,
        builder: (context, state) => const LayoutWithBottomNav(pageIndex: 2),
      ),
      GoRoute(
        path: SettingsPage.routeName,
        builder: (context, state) => const LayoutWithBottomNav(pageIndex: 3),
      ),
      GoRoute(
        parentNavigatorKey: _parentKey,
        path: NeighborAllJobsPage.routeName,
        builder: (context, state) => const Layout(child: NeighborAllJobsPage()),
      ),
      GoRoute(
        parentNavigatorKey: _parentKey,
        path: AllPendingJobsPage.routeName,
        builder: (context, state) => const Layout(child: AllPendingJobsPage()),
      ),
      GoRoute(
        parentNavigatorKey: _parentKey,
        path: PostNewJobPage.routeName,
        builder: (context, state) {
          final map = state.uri.queryParameters;
          return Layout(
            child: PostNewJobPage(data: map),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _parentKey,
        path: EditProfilePage.routeName,
        builder: (context, state) => const Layout(child: EditProfilePage()),
      ),
      GoRoute(
        parentNavigatorKey: _parentKey,
        path: HelperProfilePage.routeName,
        builder: (context, state) {
          final helperData = state.uri.queryParameters;
          return Layout(
            child: HelperProfilePage(
              helperdata: helperData,
            ),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _parentKey,
        path: ChatPage.routeName,
        builder: (context, state) {
          final map = state.uri.queryParameters;
          return Layout(
            child: ChatPage(data: map),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _parentKey,
        path: NewAddresses.routeName,
        builder: (context, state) {
          final isFromJobPage = state.uri.queryParameters['isFromJobPage'];

          return Layout(
            child: NewAddresses(isFromJobPage: isFromJobPage!),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _parentKey,
        path: SearchNewAddress.routeName,
        builder: (context, state) {
          final isFromJobPage = state.uri.queryParameters['isFromJobPage'];
          return Layout(
            child: SearchNewAddress(isFromJobPage: isFromJobPage!),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _parentKey,
        path: AddNewAddress.routeName,
        builder: (context, state) {
          final map = state.uri.queryParameters;
          return Layout(
            child: AddNewAddress(data: map),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _parentKey,
        path: AddAddressPage.routeName,
        builder: (context, state) {
          final map = state.uri.queryParameters;
          return Layout(
            child: AddAddressPage(addressData: map),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _parentKey,
        path: ChangePasswordPage.routeName,
        builder: (context, state) => const Layout(child: ChangePasswordPage()),
      ),
      GoRoute(
        parentNavigatorKey: _parentKey,
        path: SettingsPage.routeName,
        builder: (context, state) => const Layout(child: SettingsPage()),
      ),
      GoRoute(
        parentNavigatorKey: _parentKey,
        path: MenuSettingsPage.routeName,
        builder: (context, state) => const Layout(child: MenuSettingsPage()),
      ),
      GoRoute(
        parentNavigatorKey: _parentKey,
        path: BidsPage.routeName,
        builder: (context, state) {
          final map = state.uri.queryParameters;
          return Layout(
            child: BidsPage(bidData: map),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _parentKey,
        path: HelperNewJobsPage.routeName,
        builder: (context, state) => const Layout(child: HelperNewJobsPage()),
      ),
      GoRoute(
        parentNavigatorKey: _parentKey,
        path: JobsHistoryPage.routeName,
        builder: (context, state) {
          final tab =
              state.uri.queryParameters['currentTab'].toString() == 'null'
                  ? 'Active Jobs'
                  : state.uri.queryParameters['currentTab'].toString();
          return Layout(
            child: JobsHistoryPage(currentTab: tab),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _parentKey,
        path: PaymentPage.routeName,
        builder: (context, state) {
          final isFromJobPage = state.uri.queryParameters['isFromJobPage'];
          return Layout(
            child: PaymentPage(isFromJobPage: isFromJobPage!),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _parentKey,
        path: AddCard.routeName,
        builder: (context, state) {
          final isFromJobPage = state.uri.queryParameters['isFromJobPage'];
          return Layout(
            child: AddCard(isFromJobPage: isFromJobPage!),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _parentKey,
        path: FavoritesPage.routeName,
        builder: (context, state) => const Layout(child: FavoritesPage()),
      ),
      GoRoute(
        parentNavigatorKey: _parentKey,
        path: NewJobDetailPage.routeName,
        builder: (context, state) {
          final map = state.uri.queryParameters;
          return Layout(
            child: NewJobDetailPage(
              jobInfo: map,
            ),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _parentKey,
        path: NeighborJobDetailPage.routeName,
        builder: (context, state) {
          final map = state.uri.queryParameters;
          return Layout(
            child: NeighborJobDetailPage(
              activeItem: map,
            ),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _parentKey,
        path: NeighborGiveRatingPage.routeName,
        builder: (context, state) {
          final map = state.uri.queryParameters;
          return Layout(
            child: NeighborGiveRatingPage(
              data: map,
            ),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _parentKey,
        path: CancelReviewPage.routeName,
        builder: (context, state) {
          final map = state.uri.queryParameters;
          return Layout(
            child: CancelReviewPage(
              data: map,
            ),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _parentKey,
        path: NeighborGiveTipPage.routeName,
        builder: (context, state) {
          final map = state.uri.queryParameters;
          return Layout(
            child: NeighborGiveTipPage(
              data: map,
            ),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _parentKey,
        path: HelperJobDetailPage.routeName,
        builder: (context, state) {
          final map = state.uri.queryParameters;
          return Layout(
            child: HelperJobDetailPage(helperData: map),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _parentKey,
        path: HelperOpenJobs.routeName,
        builder: (context, state) => const Layout(child: HelperOpenJobs()),
      ),
      GoRoute(
        parentNavigatorKey: _parentKey,
        path: AccountDelete.routeName,
        builder: (context, state) => const Layout(child: AccountDelete()),
      ),
      GoRoute(
        parentNavigatorKey: _parentKey,
        path: NotificationPage.routeName,
        builder: (context, state) {
          final map = state.uri.queryParameters['isNeighbr'].toString();
          return Layout(
            child: NotificationPage(isNeighbr: map == 'true'),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _parentKey,
        path: AddStripe.routeName,
        builder: (context, state) {
          final map = state.uri.queryParameters;
          return Layout(
            child: AddStripe(
              stripeData: map,
            ),
          );
        },
      ),
    ],
  );
}
