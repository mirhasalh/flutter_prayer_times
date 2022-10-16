import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayer_times/src/page/pages.dart';
import 'package:prayer_times/src/shared/shared.dart';
import 'package:prayer_times/src/page/times_page.dart';
import 'package:prayer_times/src/provider/providers.dart';
import 'package:prayer_times/src/service/location_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthState { loading, offline }

class AuthPage extends ConsumerStatefulWidget {
  static const String routeName = '/';

  const AuthPage({super.key});

  @override
  AuthPageState createState() => AuthPageState();
}

class AuthPageState extends ConsumerState<AuthPage> {
  AuthState _state = AuthState.loading;

  @override
  void initState() {
    super.initState();
    _obtainPrefs();
    _fetchLocThenGo();
  }

  @override
  Widget build(BuildContext context) {
    return _state == AuthState.loading
        ? const LoadingPage()
        : const ErrorPage();
  }

  void _goToTimesPage(int initialPage) {
    Navigator.of(context).popUntil((route) => route.isFirst);

    Navigator.of(context).pushReplacementNamed(
      TimesPage.routeName,
      arguments: TimesPageArgs(initialPage),
    );
  }

  void _fetchLocThenGo() {
    try {
      LocationServices()
          .determinePosition()
          .then((p) {
            LocationServices()
                .determinePlacemark(p.latitude, p.longitude)
                .then((p) {
              ref.read(timingsArgsProvider).setTimingsArgs(
                    p[0].subAdministrativeArea!,
                    p[0].country!,
                    ref.read(timingsArgsProvider).timingsArgs.method,
                  );

              if (kDebugMode) {
                print(
                    'Timings arguments: ${ref.read(timingsArgsProvider).timingsArgs.city}, ${ref.read(timingsArgsProvider).timingsArgs.country}, ${ref.read(timingsArgsProvider).timingsArgs.method}');
              }
            });
          })
          .then((_) => InitPageProvider()
              .determinePage(ref.read(timingsArgsProvider).timingsArgs))
          .then((index) => _goToTimesPage(index));
    } catch (e) {
      setState(() => _state = AuthState.offline);
      throw Exception('Failed to load');
    }
  }

  void _obtainPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getBool('showTimings') == null) {
      await prefs.setBool('showTimings', true);
    }
  }
}
