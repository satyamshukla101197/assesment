import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supdup/core/config/localization.dart';
import 'package:supdup/core/config/navigation.dart';
import 'package:supdup/core/utils/constants.dart';
import 'package:supdup/core/utils/routes.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 5), ()=>Navigation.intent(context, AppRoutes.signin_screen));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: AppColors.white,
        child: Center(
          child: Text(
            MyLocalizations.of(context).getString("splash_text"),
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
