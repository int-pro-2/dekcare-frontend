import 'package:dekcare_frontend/Screens/landing.dart';
import 'package:dekcare_frontend/Screens/login.dart';
import 'package:dekcare_frontend/Screens/splashScrees.dart';
import 'package:dekcare_frontend/provider/authenticateProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(DekCare());
}

class DekCare extends StatelessWidget {
  Widget build(BuildContext) {
    final navigatorKey = GlobalKey<NavigatorState>();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AuthenticateProvider())
      ],
      child: Consumer<AuthenticateProvider>(
        builder: (ctx, auth, child) => MaterialApp(
          title: 'DekCare',
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          home: auth.isAuth
              ? Landing()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : Login(),
                ),
        ),
      ),
    );
  }
}
