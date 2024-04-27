import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/global/authBloc/auth_bloc.dart';
import 'package:neighbour_app/pages/Home/home.dart';
import 'package:neighbour_app/pages/OtpVerification/otp_verification.dart';
import 'package:neighbour_app/pages/SignIn/form/signin_form.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/widgets/backbutton_appbar.dart';
import 'package:neighbour_app/widgets/circular_loader.dart';
import 'package:neighbour_app/widgets/snackbar.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({
    required this.deviceId,
    super.key,
  });

  final String deviceId;
  static const routeName = '/signin';

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateSignInProgress) {
          setState(() {
            isLoading = true;
          });
        }
        if (state is AuthStateSignInSuccessful) {
          setState(() {
            isLoading = false;
          });
          context.go(HomePage.routeName);
          return;
        }
        if (state is ConfirmEmailOnLoginState) {
          setState(() {
            isLoading = false;
          });
          snackBarComponent(
            context,
            color: Colors.red,
            message: 'Please verify your email',
          );
          context.push(OtpVerificationPage.routeName, extra: state.email);
          return;
        }
        if (state is AuthStateSignInError) {
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
                    height: SizeHelper.getDeviceHeight(90),
                    child: SignInForm(
                      deviceId: widget.deviceId,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
