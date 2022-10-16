import 'package:flutter/material.dart';
import 'package:prayer_times/src/page/pages.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const AuthPage());
      case '/about':
        final args = settings.arguments as AboutArgs;
        return FastPageRoute(
          builder: (_) => AboutPage(title: args.title),
        );
      case '/metadata':
        final args = settings.arguments as MetadataArgs;
        return FastPageRoute(
          builder: (_) => MetadataPage(times: args.times),
        );
      case '/method':
        final args = settings.arguments as MethodArgs;
        return FastPageRoute(
          builder: (_) => MethodSettingsPage(
            title: args.title,
            method: args.method,
          ),
        );
      case '/times':
        final args = settings.arguments as TimesPageArgs;
        return SlowPageRoute(
            builder: (_) => TimesPage(initialPage: args.initialPage));
      default:
        return MaterialPageRoute(builder: (_) => const AuthPage());
    }
  }
}

// Custom page transition duration
class FastPageRoute extends MaterialPageRoute {
  FastPageRoute({builder}) : super(builder: builder);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 820);
}

class SlowPageRoute extends MaterialPageRoute {
  SlowPageRoute({builder}) : super(builder: builder);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 1024);
}
