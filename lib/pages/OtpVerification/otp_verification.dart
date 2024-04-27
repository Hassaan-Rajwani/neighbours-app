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
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/app_button.dart';
import 'package:neighbour_app/widgets/app_pincode.dart';
import 'package:neighbour_app/widgets/backbutton_appbar.dart';
import 'package:neighbour_app/widgets/circular_loader.dart';
import 'package:neighbour_app/widgets/gap.dart';
import 'package:neighbour_app/widgets/snackbar.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({
    required this.email,
    super.key,
  });

  final String email;
  static const routeName = '/otp-verification';

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  TextEditingController otpController = TextEditingController();
  bool resendCode = false;

  @override
  Widget build(BuildContext context) {
    final displayText =
        'Enter code that we have sent to your email ${widget.email}';

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateEmailVerifiedSuccessfully) {
          snackBarComponent(
            context,
            color: chateauGreen,
            message: 'Email verified successfully',
          );
          context.go(SignInPage.routeName);
          return;
        }
        if (state is AuthStateEmailVerifiedError) {
          snackBarComponent(
            context,
            color: Colors.red,
            message: state.error,
          );
        }
        if (state is AuthStateResendEmailVerifiedSuccessfully) {
          snackBarComponent(
            context,
            color: chateauGreen,
            message: 'Verification Code sent to your email',
          );
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthStateEmailVerificationProgress) {
            return const CircularLoader();
          }
          return GestureDetector(
            onTap: () => keyboardDismissle(context: context),
            child: Scaffold(
              backgroundColor: scafColor,
              appBar: backButtonAppbar(
                context,
                icon: const Icon(Icons.arrow_back),
              ),
              body: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: SizeHelper.moderateScale(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email Verification Code',
                        style: TextStyle(
                          fontSize: SizeHelper.moderateScale(22),
                          fontFamily: interSemibold,
                        ),
                      ),
                      const Gap(gap: 10),
                      Text(
                        displayText,
                        style: TextStyle(
                          height: 1.5,
                          color: subTextColor,
                          fontFamily: interRegular,
                          fontSize: SizeHelper.moderateScale(16),
                        ),
                      ),
                      const Gap(gap: 50),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppPinCode(otpController: otpController),
                        ],
                      ),
                      const Gap(gap: 40),
                      Center(
                        child: GestureDetector(
                          onTap: resendCode
                              ? null
                              : () {
                                  setState(() {
                                    resendCode = true;
                                  });
                                  sl<AuthBloc>().add(
                                    AuthResendVerificationEmailEvent(
                                      email: widget.email,
                                    ),
                                  );
                                },
                          child: Text(
                            'Resend code',
                            style: TextStyle(
                              fontSize: SizeHelper.moderateScale(18),
                              fontFamily: interRegular,
                              color: resendCode ? Colors.grey : cornflowerBlue,
                            ),
                          ),
                        ),
                      ),
                      const Gap(gap: 120),
                      AppButton(
                        text: 'Submit',
                        horizontalMargin: 0,
                        onPress: () {
                          if (otpController.value.text.isNotEmpty &&
                              otpController.value.text.length == 6) {
                            sl<AuthBloc>().add(
                              AuthVerificationEmailEvent(
                                email: widget.email,
                                otp: otpController.value.text,
                              ),
                            );
                          } else {
                            snackBarComponent(
                              context,
                              color: Colors.red,
                              message: 'Please write correct code',
                            );
                          }
                        },
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
