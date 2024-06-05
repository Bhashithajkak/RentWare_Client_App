import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:rentware/firebase_options.dart';
import 'package:rentware/models/firebase_service.dart';
import 'package:rentware/view/Landing_page_view.dart';
import 'package:rentware/view/home_page_view.dart';
import 'package:rentware/view/login_view.dart';
import 'package:rentware/view/register_view.dart';
import 'package:rentware/view_model/home_page_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    webProvider:
        ReCaptchaV3Provider('6LeaFuopAAAAAFm8QunDZAfoiua7J2LI468Lh4_s'),
  );

  GetIt.instance.registerSingleton<FirebaseService>(
    FirebaseService(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomePageViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RentWare',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: 'login',
        routes: {
          'login': (context) => LoginPage(),
          'register': (context) => RegisterPage(),
          'home': (context) => HomePage(),
          'landing': (context) => LandingPage(),
        },
      ),
    );
  }
}
