//package imports
import 'package:Todos/screens/WelcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

//screens import
import './providers/todo_provider.dart';
import './screens/HomePage.dart';
import './screens/BirthdayRemainder.dart';
import './screens/BmiCalculator.dart';
import './screens/MathCalculator.dart';
import './navigation_service.dart';

void main() async {
  await GetStorage.init();
  runApp((MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //     DeviceOrientation.portraitUp,
    //   ]);
    return ChangeNotifierProvider(
      create: (context) {
        return TodoProvider(isDarkModeOn: true);
      },
      child: Consumer<TodoProvider>(
        builder: (context, themeState, child) {
          return GetMaterialApp(
            navigatorKey: NavService.navKey,
            debugShowCheckedModeBanner: false,
            title: 'Todos',
            theme: themeState.getTheme,
            home: InitialScreen(),
            routes: {
              HomePage.routeName: (ctx) => HomePage(),
              BmiCalculator.routeName: (ctx) => BmiCalculator(),
              MathCalculator.routeName: (ctx) => MathCalculator(),
              BirthdayRemainder.routeName: (ctx) => BirthdayRemainder(),
            },
          );
        },
      ),
    );
  }
}

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key key}) : super(key: key);

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final userLoggedInStatus = GetStorage();
  @override
  void initState() {
    userLoggedInStatus.writeIfNull("isLogged", false);
    Future.delayed(Duration.zero, () async {
      loginCheck();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CircularProgressIndicator(),
    );
  }

  void loginCheck() {
    userLoggedInStatus.read("isLogged")
        ? Get.offAll(HomePage())
        : Get.offAll(WelcomeScreen());
  }
}
