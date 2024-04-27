import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/global/authBloc/auth_bloc.dart';
import 'package:neighbour_app/global/authBloc/auth_event.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/regex_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/app_button.dart';
import 'package:neighbour_app/widgets/app_input.dart';
import 'package:neighbour_app/widgets/backbutton_appbar.dart';
import 'package:neighbour_app/widgets/circular_loader.dart';
import 'package:neighbour_app/widgets/gap.dart';
import 'package:neighbour_app/widgets/snackbar.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({
    super.key,
  });

  static const routeName = '/change-password';

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  bool showPassword = true;
  bool showPasswordTwo = true;
  bool showPasswordThree = true;

  final _formKey = GlobalKey<FormState>();

  Future<void> _onChangePassword() async {
    if (_formKey.currentState!.validate()) {
      final oldPassword = oldPasswordController.value.text;
      final newPassword = newPasswordController.value.text;
      final confirmPassword = confirmNewPasswordController.value.text;
      if (newPassword == confirmPassword) {
        sl<AuthBloc>().add(
          AuthChangePassword(
            oldPassword: oldPassword,
            newPassword: newPassword,
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
        if (state is AuthStateChangePasswordSuccessfully) {
          context.pop();
          snackBarComponent(
            context,
            color: chateauGreen,
            message: 'Password changed successfully',
          );
          return;
        }
        if (state is AuthStateChangePasswordError) {
          snackBarComponent(
            context,
            color: Colors.red,
            message: state.error,
          );
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthStateChangePasswordInProgress) {
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
                backgroundColor: Colors.white,
                text: 'Reset Password',
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              body: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: SizeHelper.moderateScale(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(gap: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppInput(
                              horizontalMargin: 0,
                              label: 'Old Password',
                              placeHolder: 'Password...',
                              obscureText: showPassword,
                              controller: oldPasswordController,
                              validator: ProjectRegex.passwordValidator,
                              onTap: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              },
                              showPasswordIcon: true,
                            ),
                            AppInput(
                              horizontalMargin: 0,
                              label: 'New Password',
                              placeHolder: 'Password...',
                              obscureText: showPasswordTwo,
                              controller: newPasswordController,
                              validator: ProjectRegex.passwordValidator,
                              onTap: () {
                                setState(() {
                                  showPasswordTwo = !showPasswordTwo;
                                });
                              },
                              showPasswordIcon: true,
                            ),
                            AppInput(
                              horizontalMargin: 0,
                              label: 'Confirm Password',
                              placeHolder: 'Password...',
                              obscureText: showPasswordThree,
                              controller: confirmNewPasswordController,
                              validator: ProjectRegex.passwordValidator,
                              onTap: () {
                                setState(() {
                                  showPasswordThree = !showPasswordThree;
                                });
                              },
                              showPasswordIcon: true,
                            ),
                            const Gap(gap: 30),
                            AppButton(
                              horizontalMargin: 0,
                              onPress: _onChangePassword,
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
