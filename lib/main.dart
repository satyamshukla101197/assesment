import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supdup/core/config/localization.dart';
import 'package:supdup/features/presentation/pages/second_screen/second_screen.dart';
import 'package:supdup/features/presentation/pages/splash_screen/splash_screen.dart';

import 'core/utils/constants.dart';
import 'core/utils/routes.dart';
import 'features/presentation/pages/homescreen_screen/homescreen_screen.dart';
import 'features/presentation/pages/second_screen/second_screen_bloc.dart';
import 'features/presentation/pages/signin_screen/signin_screen.dart';
import 'features/presentation/pages/signup_screen/signup_screen.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  ); // To turn off landscape mode

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.light,
    // this will change the brightness of the icons
    statusBarColor: Colors.transparent,
    // or any color you want
    systemNavigationBarIconBrightness:
        Brightness.light, //navigation bar icons' color
  ));

  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.APP_NAME,
      locale: Locale('en', 'IND'),
      localizationsDelegates: [const MyLocalizationsDelegate()],
      supportedLocales: [Locale('en')],
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      routes: _registerRoutes(),
    );
  }

  Map<String, WidgetBuilder> _registerRoutes() {
    return <String, WidgetBuilder>{
      AppRoutes.splash: (context) => SplashScreen(),
      AppRoutes.homescreen: (context) => HomeScreen(),
      AppRoutes.signin_screen: (context) => SignInScreen(),
      AppRoutes.signup_screen: (context) => SignUpScreen(),
      AppRoutes.second_screen: (context) => BlocProvider<SecondScreenBloc>(
    create: (context) => sl<SecondScreenBloc>(),
    child:  SecondScreen()),
    };
  }
}
/* AppRoutes.customer_screen: (context) => BlocProvider<CustomerScreenBloc>(
        create: (context) => sl<CustomerScreenBloc>(),
        child:  CustomerScreen(),
      ),*/