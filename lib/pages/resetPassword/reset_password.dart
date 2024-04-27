// ignore_for_file: unused_field, unnecessary_raw_strings, lines_longer_than_80_chars
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/global/authBloc/auth_bloc.dart';
import 'package:neighbour_app/global/authBloc/auth_event.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/pages/SignIn/sign_in.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/regex_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/app_button.dart';
import 'package:neighbour_app/widgets/app_input.dart';
import 'package:neighbour_app/widgets/backbutton_appbar.dart';
import 'package:neighbour_app/widgets/circular_loader.dart';
import 'package:neighbour_app/widgets/gap.dart';
import 'package:neighbour_app/widgets/snackbar.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({
    required this.email,
    super.key,
  });

  final String email;
  static const routeName = '/reset-password';

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  String password = '';
  String otpCode = '';
  String passwordConfirm = '';
  bool showPassword = true;
  bool showPasswordTwo = true;
  bool resendCode = false;

  final _formKey = GlobalKey<FormState>();

  void _setOtp(String text) => setState(() => otpCode = text);
  void _setPassword(String text) => setState(() => password = text);
  void _setConfirmPassword(String text) =>
      setState(() => passwordConfirm = text);

  void _onResetPassword() {
    if (_formKey.currentState!.validate()) {
      if (password == passwordConfirm) {
        sl<AuthBloc>().add(
          AuthResetPassword(
            email: widget.email,
            otp: otpCode,
            newPassword: passwordConfirm,
          ),
        );
        return;
      }
      snackBarComponent(
        context,
        color: Colors.red,
        message: 'Passwords do not match.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateResetPasswordSuccessfully) {
          snackBarComponent(
            context,
            color: chateauGreen,
            message: 'Password changed successfully',
          );
          context.go(SignInPage.routeName);
          return;
        }
        if (state is AuthStateResetPasswordError) {
          snackBarComponent(
            context,
            color: Colors.red,
            message: state.error,
          );
        }
        if (state is AuthStateForgotPasswordResendCodeSuccessfully) {
          snackBarComponent(
            context,
            color: chateauGreen,
            message: 'Verification Code sent to your email',
          );
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthStateResetPasswordInProgress) {
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
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              body: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: SizeHelper.moderateScale(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(gap: 20),
                        Text(
                          'Reset Password',
                          style: TextStyle(
                            fontSize: SizeHelper.moderateScale(22),
                            fontFamily: interSemibold,
                          ),
                        ),
                        const Gap(gap: 10),
                        Text(
                          '''Please enter the code sent to you, and enter your new password''',
                          style: TextStyle(
                            fontSize: SizeHelper.moderateScale(16),
                            fontFamily: interRegular,
                            color: subTextColor,
                            height: 1.5,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Gap(gap: 25),
                            AppInput(
                              horizontalMargin: 0,
                              label: 'Otp Verification',
                              placeHolder: 'Enter otp code here...',
                              maxLenght: 6,
                              keyboardType: TextInputType.number,
                              onChanged: _setOtp,
                              validator: ProjectRegex.otpInputValidator,
                            ),
                            Align(
                              child: InkWell(
                                onTap: resendCode
                                    ? null
                                    : () {
                                        setState(() {
                                          resendCode = true;
                                        });
                                        sl<AuthBloc>().add(
                                          AuthForgotPasswordResendCodeEvent(
                                            email: widget.email,
                                          ),
                                        );
                                      },
                                child: Text(
                                  'Resend code',
                                  style: TextStyle(
                                    fontSize: SizeHelper.moderateScale(18),
                                    color: resendCode
                                        ? Colors.grey
                                        : cornflowerBlue,
                                    fontFamily: interMedium,
                                  ),
                                ),
                              ),
                            ),
                            const Gap(gap: 20),
                            AppInput(
                              horizontalMargin: 0,
                              label: 'New Password',
                              placeHolder: 'New Password...',
                              obscureText: showPassword,
                              onTap: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              },
                              showPasswordIcon: true,
                              onChanged: _setPassword,
                              validator: ProjectRegex.passwordValidator,
                            ),
                            AppInput(
                              horizontalMargin: 0,
                              label: 'Confirm Password',
                              placeHolder: 'Confirm Password...',
                              obscureText: showPasswordTwo,
                              onTap: () {
                                setState(() {
                                  showPasswordTwo = !showPasswordTwo;
                                });
                              },
                              showPasswordIcon: true,
                              onChanged: _setConfirmPassword,
                              validator: ProjectRegex.passwordValidator,
                            ),
                            const Gap(gap: 30),
                            AppButton(
                              horizontalMargin: 0,
                              onPress: _onResetPassword,
                              text: 'Submit',
                            ),
                          ],
                        ),
                      ],
                    ),
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
