import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neighbour_app/config/storage.dart';
import 'package:neighbour_app/global/authBloc/auth_bloc.dart';
import 'package:neighbour_app/global/authBloc/auth_event.dart';
import 'package:neighbour_app/injection_container.dart';
import 'package:neighbour_app/pages/Home/home.dart';
import 'package:neighbour_app/pages/MainAuth/widget/custom_button.dart';
import 'package:neighbour_app/pages/MainAuth/widget/icon_button.dart';
import 'package:neighbour_app/pages/SignIn/sign_in.dart';
import 'package:neighbour_app/pages/Signup/sign_up.dart';
import 'package:neighbour_app/utils/color_constants.dart';
import 'package:neighbour_app/utils/font_constants.dart';
import 'package:neighbour_app/utils/size_helper.dart';
import 'package:neighbour_app/utils/storage.dart';
import 'package:neighbour_app/utils/svg_constants.dart';
import 'package:neighbour_app/widgets/circular_loader.dart';
import 'package:neighbour_app/widgets/gap.dart';
import 'package:neighbour_app/widgets/snackbar.dart';

class MainAuthPage extends StatefulWidget {
  const MainAuthPage({super.key});

  static const routeName = '/auth';

  @override
  State<MainAuthPage> createState() => _MainAuthPageState();
}

class _MainAuthPageState extends State<MainAuthPage> {
  String deviceId = '';

  @override
  void initState() {
    initPlatformState();
    super.initState();
  }

  Future<void> initPlatformState() async {
    try {
      if (Platform.isIOS || Platform.isAndroid) {
        deviceId = (await FirebaseMessaging.instance.getToken())!;
        await setDataToStorage(StorageKeys.fcm, deviceId);
      }
    } on PlatformException {
      deviceId = '';
    }
    setState(() {
      deviceId = deviceId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is GoogleAuthSuccessful) {
          context.go(HomePage.routeName);
          return;
        }
        if (state is GoogleAuthError) {
          snackBarComponent(
            context,
            color: Colors.red,
            message: state.error == 'The user cancelled the sign-in flow'
                ? 'Signup flow cancelled'
                : state.error,
          );
          return;
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is GoogleAuthInProgress) {
            return const CircularLoader();
          }
          return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                        top: SizeHelper.moderateScale(140),
                        left: SizeHelper.moderateScale(30),
                        right: SizeHelper.moderateScale(30),
                      ),
                      child: Text(
                        'Sign in or Sign up',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: interSemibold,
                          fontSize: SizeHelper.moderateScale(22),
                        ),
                      ),
                    ),
                    const Gap(gap: 10),
                    Container(
                      padding: EdgeInsets.only(
                        left: SizeHelper.moderateScale(30),
                        right: SizeHelper.moderateScale(43),
                      ),
                      child: Text(
                        '''Create an account, or login as a Neighbor or Helper''',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: SizeHelper.moderateScale(14),
                          fontFamily: interRegular,
                          height: 1.5,
                          color: subTextColor,
                        ),
                      ),
                    ),
                    const Gap(gap: 73),
                    CustomButton(
                      label: 'Sign In with Google',
                      backgroundColor: Colors.white,
                      textColor: doveGray,
                      onTap: () {
                        sl<AuthBloc>().add(GoogleAuthEvent());
                      },
                      icon: IconWithGesture(
                        svgAsset: googleIcon,
                        label: '',
                        onTap: () {},
                      ),
                    ),
                    const Gap(gap: 20),
                    CustomButton(
                      label: 'Sign up with email',
                      backgroundColor: cornflowerBlue,
                      textColor: Colors.white,
                      onTap: () => context.push(SignupPage.routeName),
                    ),
                    const Gap(gap: 20),
                    CustomButton(
                      label: 'Login',
                      backgroundColor: fern,
                      textColor: Colors.white,
                      onTap: () {
                        final query = Uri(
                          queryParameters: {
                            'deviceId': deviceId,
                          },
                        ).query;
                        context.push('${SignInPage.routeName}?$query');
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
