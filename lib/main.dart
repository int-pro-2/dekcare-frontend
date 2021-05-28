import 'package:dekcare_frontend/Screens/landingScreen.dart';
import 'package:dekcare_frontend/Screens/loginScreen.dart';
import 'package:dekcare_frontend/Screens/splashScreen.dart';
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
          // navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          home: auth.isAuth
              ? LandingScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : LoginScreen(),
                ),
        ),
      ),
    );
  }
}
