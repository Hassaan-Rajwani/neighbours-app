// ignore_for_file: inference_failure_on_function_invocation
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/global/authBloc/auth_bloc.dart';
import 'package:neighbour_app/global/authBloc/auth_event.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/pages/MainAuth/main_auth.dart';
import 'package:neighbour_app/presentation/bloc/profile/profile_bloc.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/storage.dart';
import 'package:neighbour_app/widgets/app_button.dart';
import 'package:neighbour_app/widgets/backbutton_appbar.dart';
import 'package:neighbour_app/widgets/circular_loader.dart';
import 'package:neighbour_app/widgets/custom_dialog_box.dart';
import 'package:neighbour_app/widgets/gap.dart';
import 'package:neighbour_app/widgets/launcher.dart';
import 'package:neighbour_app/widgets/snackbar.dart';

class AccountDelete extends StatefulWidget {
  const AccountDelete({super.key});

  static const routeName = '/account-delete';

  @override
  State<AccountDelete> createState() => _AccountDeleteState();
}

class _AccountDeleteState extends State<AccountDelete> {
  TextEditingController passwordController = TextEditingController();
  bool showDeactivationInfo = false;
  bool showPassword = true;
  bool auto = false;

  int reasonCharacterCount = 0;

  void _showConfirmationDialog({
    required BuildContext context,
    required VoidCallback onDelete,
  }) {
    showDialog(
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
                onConfirmPressed: onDelete,
                onCancelPressed: context.pop,
                confirmText: 'Delete',
                cancelText: 'Cancel',
                confirmTextColor: Colors.white,
                cancelTextColor: doveGray,
                confirmBtnBackgroundColor: persimmon,
                cancelBtnBackgroundColor: silver,
                heading: 'Delete Account',
                verticalHeight: Platform.isAndroid ? 36 : 35,
                description:
                    '''Are you sure you want to delete your account?''',
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is DeleteAccountSuccessfull) {
          context.go(MainAuthPage.routeName);
          deleteDataFromStorage(StorageKeys.userToken);
          sl<AuthBloc>().add(AuthLogoutEvent());
          snackBarComponent(
            context,
            color: chateauGreen,
            message: 'Account deleted successfully',
          );
          return;
        }
        if (state is DeleteAccountError) {
          snackBarComponent(
            context,
            color: Colors.red,
            message: state.error,
          );
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is DeleteAccountInProgress) {
            return const CircularLoader();
          }
          return GestureDetector(
            onTap: () {
              keyboardDismissle(context: context);
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: backButtonAppbar(
                context,
                icon: const Icon(Icons.arrow_back),
                backgroundColor: Colors.white,
                text: 'Account Delete',
              ),
              body: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeHelper.moderateScale(20),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: SizeHelper.getDeviceHeight(
                          Platform.isAndroid ? 83 : 75,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Gap(gap: 25),
                              Text(
                                'Your account will be deleted',
                                style: TextStyle(
                                  fontFamily: interBold,
                                  fontSize: SizeHelper.moderateScale(14),
                                ),
                              ),
                              const Gap(gap: 20),
                              InkWell(
                                onTap: () async {
                                  await LaunchFunction().openLink(
                                    link:
                                        'https://www.neighbrs.com/privacypolicy',
                                    context: context,
                                  );
                                },
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontFamily: interRegular,
                                      fontSize: SizeHelper.moderateScale(12),
                                      color: doveGray,
                                      height: SizeHelper.moderateScale(2),
                                    ),
                                    children: [
                                      const TextSpan(
                                        text:
                                            '''Please see our terms and conditions for details about account deactivation HERE.''',
                                      ),
                                      TextSpan(
                                        text:
                                            ' https://www.neighbrs.com/privacypolicy',
                                        style: TextStyle(
                                          fontFamily: interRegular,
                                          fontSize:
                                              SizeHelper.moderateScale(12),
                                          color: Colors.blue,
                                          height: SizeHelper.moderateScale(2),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      AppButton(
                        horizontalMargin: 0,
                        backgroundColor: cinnabar,
                        onPress: () {
                          setState(() {
                            _showConfirmationDialog(
                              context: context,
                              onDelete: () {
                                sl<ProfileBloc>().add(
                                  DeleteProfileEvent(),
                                );
                              },
                            );
                          });
                        },
                        text: 'Delete Account',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
