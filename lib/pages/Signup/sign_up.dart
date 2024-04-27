import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/global/authBloc/auth_bloc.dart';
import 'package:neighbour_app/pages/OtpVerification/otp_verification.dart';
import 'package:neighbour_app/pages/Signup/form/signup_form.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/backbutton_appbar.dart';
import 'package:neighbour_app/widgets/circular_loader.dart';
import 'package:neighbour_app/widgets/snackbar.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  static const routeName = '/signup';

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateSignUpInProgress) {
          setState(() {
            isLoading = true;
          });
        }
        if (state is AuthStateSignUpSuccessful) {
          setState(() {
            isLoading = false;
          });
          snackBarComponent(
            context,
            color: chateauGreen,
            message: 'Verification Code sent to your email',
          );
          context.push(OtpVerificationPage.routeName, extra: state.email);
          return;
        }

        if (state is AuthStateSignUpError) {
          setState(() {
            isLoading = false;
          });
          snackBarComponent(
            context,
            color: Colors.red,
            message: state.error,
          );
        }
      },
      child: SizedBox(
        child: GestureDetector(
          onTap: () => keyboardDismissle(context: context),
          child: isLoading
              ? const CircularLoader()
              : Scaffold(
                  backgroundColor: Colors.white,
                  appBar: backButtonAppbar(
                    context,
                    icon: const Icon(Icons.arrow_back),
                  ),
                  body: SingleChildScrollView(
                    child: SizedBox(
                      height: SizeHelper.getDeviceHeight(
                        Platform.isAndroid ? 90 : 82,
                      ),
                      child: const SignupForm(),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
