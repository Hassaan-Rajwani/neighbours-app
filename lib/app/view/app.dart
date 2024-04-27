import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neighbour_app/config/router.dart';
import 'package:neighbour_app/theme/light_theme.dart';
import 'package:neighbour_app/utils/helper.dart';
import 'package:sizer/sizer.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  final nav = AppNavigation();
  ThemeMode _themeMode = ThemeMode.system;

  void setThemeMode(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  // @override
  // void initState() {
  //   signOutCurrentUser();
  //   super.initState();
  // }

  // Future<void> signOutCurrentUser() async {
  //   await deleteDataFromStorage(
  //     StorageKeys.userToken,
  //   );
  //   final result = await Amplify.Auth.signOut();
  //   if (result is CognitoCompleteSignOut) {
  //     safePrint('Sign out completed successfully');
  //   } else if (result is CognitoFailedSignOut) {
  //     safePrint('Error signing user out: ${result.exception.message}');
  //   }
  // }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _hideStatusBar();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed ||
        state == AppLifecycleState.inactive) {
      _hideStatusBar();
    }
  }

  void _hideStatusBar() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (_, orientation, deviceType) {
        return GestureDetector(
          onTap: () {
            keyboardDismissle(context: context);
          },
          child: MaterialApp.router(
            themeMode: _themeMode,
            theme: lightTheme(),
            title: 'Neighbrs',
            darkTheme: lightTheme(),
            routerConfig: nav.router,
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}
