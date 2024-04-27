import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/global/authBloc/auth_bloc.dart';
import 'package:neighbour_app/global/authBloc/auth_event.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/pages/Signup/sign_up.dart';
import 'package:neighbour_app/pages/forgotPassword/forgot_password.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/regex_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/app_button.dart';
import 'package:neighbour_app/widgets/app_input.dart';
import 'package:neighbour_app/widgets/dont_have_account.dart';
import 'package:neighbour_app/widgets/gap.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    required this.deviceId,
    super.key,
  });

  final String deviceId;
  static const routeName = '/signin';

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';
  bool _showPassword = true;

  void setEmail(String text) => setState(() => _email = text);
  void setPassword(String text) => setState(() => _password = text);
  void _toggleShowPassword() => setState(() => _showPassword = !_showPassword);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: SizeHelper.getDeviceHeight(82),
                child: Column(
                  children: [
                    Text(
                      'Sign in',
                      style: TextStyle(
                        fontFamily: interSemibold,
                        fontSize: SizeHelper.moderateScale(22),
                      ),
                    ),
                    const Gap(gap: 10),
                    Text(
                      'Sign in to continue',
                      style: TextStyle(
                        fontFamily: interRegular,
                        fontSize: SizeHelper.moderateScale(16),
                      ),
                    ),
                    const Gap(gap: 40),
                    AppInput(
                      label: 'Email',
                      onChanged: setEmail,
                      placeHolder: 'Your email...',
                      validator: ProjectRegex.emailValidator,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    AppInput(
                      label: 'Password',
                      onChanged: setPassword,
                      showPasswordIcon: true,
                      obscureText: _showPassword,
                      onTap: _toggleShowPassword,
                      placeHolder: 'Password...',
                      validator: ProjectRegex.passwordValidator,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      width: SizeHelper.getDeviceWidth(100),
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeHelper.moderateScale(20),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          context.push(ForgotPasswordPage.routeName);
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: cornflowerBlue,
                            fontFamily: interBold,
                            fontSize: SizeHelper.moderateScale(14),
                          ),
                        ),
                      ),
                    ),
                    const Gap(gap: 40),
                    AppButton(
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          sl<AuthBloc>().add(
                            AuthSignInEvent(
                              email: _email,
                              password: _password,
                            ),
                          );
                        }
                      },
                      text: 'Sign in',
                    ),
                    const Gap(gap: 10),
                  ],
                ),
              ),
              DontHaveAccount(
                text1: 'Not a member! ',
                text2: 'Sign up now',
                onPress: () {
                  context.push(SignupPage.routeName);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
