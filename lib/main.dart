import 'package:flutter/material.dart';
import 'package:popi/Screens/Account_Creation/account_creation_screen.dart';
import 'package:popi/Screens/Home/home_screen.dart';
import 'package:popi/Screens/Login/login_screen.dart';
import 'package:popi/Screens/Password_Recovery/passowrd_recovery_screen.dart';
import 'package:popi/api/AuthProvider.dart';
import 'package:popi/api/DataProvider.dart';
import 'package:popi/constraints.dart';
import 'package:popi/providers/UserProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => DataProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    //var user = context.watch<UserProvider>();

    return Consumer<UserProvider>(builder:
        (BuildContext context, UserProvider userProvider, Widget child) {
      return MaterialApp(
        // App title
        title: 'POPI app',

        // Remove debug banner
        debugShowCheckedModeBanner: false,

        // App launch screen
        home: userProvider.user == null ? LoginScreen() : HomeScreen(),

        // App routes
        routes: {
          '/login': (context) => LoginScreen(),
          '/recoverPassword': (context) => PasswordRecoveryScreen(),
          '/accountCreation': (context) => AccountCreationScreen(),
          '/home': (context) => HomeScreen()
        },

        // Default theme styles
        theme: ThemeData(
          // Default font family
          fontFamily: 'OpenSans',

          // Setting the default fontSizes
          textTheme: TextTheme(
              bodyText2: TextStyle(fontSize: 18.0, color: Colors.white)),

          // Setting the default colors
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: kPrimaryColor,
        ),
      );
    });
  }
}
