// ignore_for_file: inference_failure_on_function_invocation

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/global/authBloc/auth_bloc.dart';
import 'package:neighbour_app/global/authBloc/auth_event.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/pages/Changepassword/change_password.dart';
import 'package:neighbour_app/pages/MainAuth/main_auth.dart';
import 'package:neighbour_app/pages/Settings/widget/tappable.dart';
import 'package:neighbour_app/pages/accountDelete/account_delete.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:neighbour_app/widgets/backbutton_appbar.dart';
import 'package:neighbour_app/widgets/circular_loader.dart';
import 'package:neighbour_app/widgets/custom_dialog_box.dart';
import 'package:neighbour_app/widgets/gap.dart';
import 'package:neighbour_app/widgets/launcher.dart';
import 'package:neighbour_app/widgets/snackbar.dart';

class MenuSettingsPage extends StatefulWidget {
  const MenuSettingsPage({super.key});

  static const routeName = '/menu-settings';

  @override
  State<MenuSettingsPage> createState() => _MenuSettingsPageState();
}

class _MenuSettingsPageState extends State<MenuSettingsPage> {
  void _logoutDialog(BuildContext context) {
    showDialog(
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            context.pop();
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              GlassContainer(
                blur: 5,
                child: Container(
                  height: SizeHelper.getDeviceHeight(100),
                  width: SizeHelper.getDeviceWidth(100),
                  color: Colors.transparent,
                ),
              ),
              CustomDialogBox(
                onConfirmPressed: () {
                  context.pop();
                  sl<AuthBloc>().add(
                    AuthLogoutEvent(),
                  );
                },
                onCancelPressed: context.pop,
                confirmText: 'Log Out',
                cancelText: 'Cancel',
                confirmTextColor: Colors.white,
                cancelTextColor: doveGray,
                confirmBtnBackgroundColor: cornflowerBlue,
                cancelBtnBackgroundColor: silver,
                heading: 'Log Out',
                verticalHeight: Platform.isAndroid ? 36 : 33,
                description: '''Are you sure you want to log out?''',
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateSignedOut) {
          snackBarComponent(
            context,
            color: chateauGreen,
            message: 'Logout successfully',
          );
          context.go(MainAuthPage.routeName);
          return;
        }
        if (state is AuthStateSignedOutError) {
          snackBarComponent(
            context,
            color: Colors.red,
            message: 'Cannot Logout. Please try again later.',
          );
        }
      },

      // Builder
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthStateSignedOutInProgress) {
            return const CircularLoader();
          }
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: backButtonAppbar(
              context,
              icon: const Icon(Icons.arrow_back),
              backgroundColor: Colors.white,
              text: 'Settings',
            ),
            body: Column(
              children: [
                const Gap(gap: 10),
                Tappable(
                  svgIconPath: lock,
                  text: 'Password Reset',
                  onTap: () => context.push(ChangePasswordPage.routeName),
                ),
                Tappable(
                  svgIconPath: terms,
                  text: 'Terms & Conditions',
                  onTap: () async {
                    await LaunchFunction().openLink(
                      link: 'https://www.neighbrs.com/termsofuse',
                      context: context,
                    );
                  },
                ),
                Tappable(
                  svgIconPath: privacy,
                  text: 'Privacy Policy',
                  onTap: () async {
                    await LaunchFunction().openLink(
                      link: 'https://www.neighbrs.com/privacypolicy',
                      context: context,
                    );
                  },
                ),
                Tappable(
                  svgIconPath: deleteRedIcon,
                  text: 'Account Delete',
                  onTap: () => context.push(AccountDelete.routeName),
                ),
                const Gap(gap: 26),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    indent: 0,
                    endIndent: 0,
                    color: silver,
                    thickness: 1.5,
                    height: SizeHelper.moderateScale(0),
                  ),
                ),
                Tappable(
                  text: 'Logout',
                  svgIconPath: logout,
                  onTap: () => _logoutDialog(context),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
