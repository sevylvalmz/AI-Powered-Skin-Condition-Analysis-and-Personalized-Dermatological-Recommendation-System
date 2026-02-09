import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('tr')],
      path: 'assets/langs',
      fallbackLocale: const Locale('tr'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'baslik'.tr(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFFEC407A),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFEC407A),
          primary: const Color(0xFFEC407A),
        ),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
