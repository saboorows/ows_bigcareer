import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ows_bigcareer/view/screens/auth/login.dart';
import 'package:ows_bigcareer/view/screens/bottom_tabs/bottom_nav_bar.dart';
import 'package:ows_bigcareer/view/screens/route.dart';
import 'package:ows_bigcareer/view/screens/splash_screen.dart';
import 'package:ows_bigcareer/view_model/media_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  final isLogin = preferences.getBool('isLogin') ?? false;
  final isFirst = preferences.getBool('onboarding') ?? true;
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp(
      isFirst: isFirst,
      isLogin: isLogin,
    ));
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, this.isFirst, this.isLogin, this.userType})
      : super(key: key);
  final isFirst, isLogin;
  final userType;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _MyAppState();
  bool displaySplashImage = true;
  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(seconds: 4), () => setState(() => displaySplashImage = false));
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: MediaViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Big Career',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(),
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
        ),
        home: displaySplashImage
            ? const SplashScreen()
            : widget.isLogin
            ? BottomNavBar()
            : const LoginScreen(),
        onGenerateRoute: (route) => RouteGenerator.generateRoute(route),
      ),
    );
  }
}
