import 'package:flutter/material.dart';
import 'package:meditation_app/provider/auth_provider/create_account_provider.dart';
import 'package:meditation_app/provider/auth_provider/login_provider.dart';
import 'package:meditation_app/provider/next_song_provider.dart';
import 'package:meditation_app/provider/streack_provider/streack_provider.dart';
import 'package:meditation_app/provider/subscription_provider/subscription_provider.dart';
import 'package:meditation_app/provider/welcome_provider.dart';
import 'package:meditation_app/spalsh_screen.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginProvider>(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider<CreateAccountProvider>(
          create: (context) => CreateAccountProvider(),
        ),
        ChangeNotifierProvider<WelcomeProvider>(
          create: (context) => WelcomeProvider(),
        ),
        ChangeNotifierProvider<SubscriptionProvider>(
          create: (context) => SubscriptionProvider(),
        ),
        ChangeNotifierProvider<StreackCountProvider>(
          create: (context) => StreackCountProvider(),
        ),
        ChangeNotifierProvider<NextSongProvider>(
          create: (context) => NextSongProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        color: Colors.black,
        theme: ThemeData(
          fontFamily: 'FuturaMediumBT',
          colorScheme: ColorScheme.fromSwatch(accentColor: Colors.transparent),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
