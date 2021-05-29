import 'package:dekcare_frontend/Screens/landingScreen.dart';
import 'package:dekcare_frontend/Screens/loginScreen.dart';
import 'package:dekcare_frontend/Screens/splashScreen.dart';
import 'package:dekcare_frontend/provider/authenticateProvider.dart';
import 'package:dekcare_frontend/provider/forumProvider.dart';
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
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AuthenticateProvider()),
        ChangeNotifierProxyProvider<AuthenticateProvider, ForumProvider>(
          create: (ctx) => ForumProvider("", []),
          update: (ctx, auth, prev) =>
              ForumProvider(auth.token, prev == null ? [] : prev.forums),
        ),
      ],
      child: Consumer<AuthenticateProvider>(
        builder: (ctx, auth, child) => MaterialApp(
          title: 'DekCare',
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
