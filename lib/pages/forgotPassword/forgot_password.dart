import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/global/authBloc/auth_bloc.dart';
import 'package:neighbour_app/global/authBloc/auth_event.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/pages/resetPassword/reset_password.dart';
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

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  static const routeName = '/forgot-password';

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  String email = '';

  final _formKey = GlobalKey<FormState>();

  void setEmail(String text) => setState(() => email = text);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateForgotPasswordSuccessfully) {
          snackBarComponent(
            context,
            color: chateauGreen,
            message: 'Verification Code sent to your email',
          );
          context.push('${ResetPasswordPage.routeName}?email=$email');
          return;
        }
        if (state is AuthStateForgotPasswordError) {
          snackBarComponent(
            context,
            color: Colors.red,
            message: state.error,
          );
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthStateForgotPasswordInProgress) {
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
                        'Forgot Password',
                        style: TextStyle(
                          fontSize: SizeHelper.moderateScale(22),
                          fontFamily: interSemibold,
                        ),
                      ),
                      const Gap(gap: 10),
                      Text(
                        '''Please add your email address and click submit to reset your password''',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: SizeHelper.moderateScale(16),
                          fontFamily: interRegular,
                          color: subTextColor,
                          height: 1.5,
                        ),
                      ),
                      const Gap(gap: 55),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppInput(
                              horizontalMargin: 0,
                              label: 'Email',
                              onChanged: setEmail,
                              validator: ProjectRegex.emailValidator,
                              placeHolder: 'Your email...',
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const Gap(gap: 110),
                            AppButton(
                              text: 'Submit',
                              horizontalMargin: 0,
                              onPress: () {
                                if (_formKey.currentState!.validate()) {
                                  sl<AuthBloc>().add(
                                    AuthForgotPasswordEvent(
                                      email: email,
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      const Gap(gap: 200),
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
