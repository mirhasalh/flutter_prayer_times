import 'package:flutter/material.dart';
import 'package:prayer_times/src/routes.dart';
import 'package:prayer_times/src/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prayer Times',
      theme: AppTheme().themeData,
      onGenerateRoute: Routes.generateRoute,
      initialRoute: '/',
    );
  }
}
