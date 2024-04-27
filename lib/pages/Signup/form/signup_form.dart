import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/global/authBloc/auth_bloc.dart';
import 'package:neighbour_app/global/authBloc/auth_event.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/pages/SignIn/sign_in.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/regex_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/app_button.dart';
import 'package:neighbour_app/widgets/app_input.dart';
import 'package:neighbour_app/widgets/dont_have_account.dart';
import 'package:neighbour_app/widgets/gap.dart';
import 'package:neighbour_app/widgets/launcher.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  String _email = '';
  String _firstname = '';
  String _lastname = '';
  String _password = '';
  bool _showPassword = true;

  final _formKey = GlobalKey<FormState>();

  void _setEmail(String text) => setState(() => _email = text);
  void _setLastName(String text) => setState(() => _lastname = text);
  void _setPassword(String text) => setState(() => _password = text);
  void _setFirstName(String text) => setState(() => _firstname = text);
  void _toggleShowPassword() => setState(() => _showPassword = !_showPassword);

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      sl<AuthBloc>().add(
        AuthSignUpEvent(
          email: _email,
          lastName: _lastname,
          password: _password,
          firstName: _firstname,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildForm(),
        DontHaveAccount(
          text1: 'Already a member? ',
          text2: 'Sign in now',
          onPress: () {
            context.push(SignInPage.routeName);
          },
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Column(
            children: [
              Text(
                'Sign up',
                style: TextStyle(
                  fontFamily: interSemibold,
                  fontSize: SizeHelper.moderateScale(22),
                ),
              ),
              const Gap(gap: 20),
              AppInput(
                label: 'First Name',
                onChanged: _setFirstName,
                placeHolder: 'First name...',
                validator: ProjectRegex.firstNameValidator,
                maxLenght: 15,
              ),
              AppInput(
                label: 'Last Name',
                onChanged: _setLastName,
                placeHolder: 'Last name...',
                validator: ProjectRegex.lastNameValidator,
                maxLenght: 15,
              ),
              AppInput(
                label: 'Email',
                onChanged: _setEmail,
                placeHolder: 'Your email...',
                validator: ProjectRegex.emailValidator,
                keyboardType: TextInputType.emailAddress,
              ),
              AppInput(
                label: 'Password',
                showPasswordIcon: true,
                onChanged: _setPassword,
                placeHolder: 'Password...',
                obscureText: _showPassword,
                onTap: _toggleShowPassword,
                validator: ProjectRegex.passwordValidator,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: SizeHelper.moderateScale(25),
                ),
                child: Row(
                  children: [
                    Text(
                      'By signing up, you agree to our ',
                      style: TextStyle(
                        fontSize: SizeHelper.moderateScale(12),
                        fontFamily: interRegular,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await LaunchFunction().openLink(
                          link: 'https://www.neighbrs.com/termsofuse',
                          context: context,
                        );
                      },
                      child: Text(
                        'Terms',
                        style: TextStyle(
                          fontSize: SizeHelper.moderateScale(12),
                          fontFamily: interRegular,
                          color: cornflowerBlue,
                        ),
                      ),
                    ),
                    Text(
                      ' & ',
                      style: TextStyle(
                        fontSize: SizeHelper.moderateScale(12),
                        fontFamily: interRegular,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await LaunchFunction().openLink(
                          link: 'https://www.neighbrs.com/privacypolicy',
                          context: context,
                        );
                      },
                      child: Text(
                        'Privacy Policy',
                        style: TextStyle(
                          fontSize: SizeHelper.moderateScale(12),
                          fontFamily: interRegular,
                          color: cornflowerBlue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(gap: 40),
              AppButton(
                text: 'Register',
                onPress: _onSubmit,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
