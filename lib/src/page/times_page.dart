import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayer_times/src/gradients.dart';
import 'package:prayer_times/src/model/models.dart';
import 'package:prayer_times/src/page/pages.dart';
import 'package:prayer_times/src/palette.dart';
import 'package:prayer_times/src/provider/providers.dart';
import 'package:prayer_times/src/shared/shared.dart';
import 'package:intl/intl.dart';
import 'package:prayer_times/src/sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TimesPage extends ConsumerStatefulWidget {
  static const String routeName = '/times';

  const TimesPage({super.key, required this.initialPage});

  final int initialPage;

  @override
  TimesPageState createState() => TimesPageState();
}

class TimesPageState extends ConsumerState<TimesPage> {
  BuildContext? _showCaseContext;
  bool show = false;

  final GlobalKey _allTimings = GlobalKey();

  late PageController _pageController;

  late DateTime nextDay;
  late int _pageIndex;
  final int _maxPageIndex = 4;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.getBool('showTimings') == true) {
        return ShowCaseWidget.of(_showCaseContext!)
            .startShowCase([_allTimings]);
      }
    });

    setState(() => _pageIndex = widget.initialPage);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);

    _pageController = PageController(initialPage: widget.initialPage);
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue<TimesByCityModel> times = ref
        .watch(prayerTimesProvider(ref.read(timingsArgsProvider).timingsArgs));
    return ShowCaseWidget(
      onFinish: () async {
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('showTimings', false);
      },
      builder: Builder(
        builder: (context) {
          _showCaseContext = context;
          return times.when(
            data: (data) => Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: _getBrightness(_pageIndex),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                centerTitle: true,
                title: Text(
                  ref.read(timingsArgsProvider).timingsArgs.city,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: _getTitleColor(_pageIndex),
                      ),
                ),
                actions: [
                  PopupMenuButton(
                    tooltip: 'Menu',
                    splashRadius: Sizes.actionSplashRadius,
                    icon: Icon(
                      Icons.more_vert,
                      color: _pageIndex == 0 || _pageIndex == _maxPageIndex
                          ? Colors.white
                          : Palette.eerieBlack,
                    ),
                    itemBuilder: (context) => <PopupMenuItem>[
                      const PopupMenuItem(
                        value: 0,
                        child: Text('About'),
                      ),
                      const PopupMenuItem(
                        value: 1,
                        child: Text('Other informations'),
                      ),
                      const PopupMenuItem(
                        value: 2,
                        child: Text('Reload'),
                      ),
                    ],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    onSelected: (value) {
                      switch (value) {
                        case 0:
                          Navigator.of(context).pushNamed(AboutPage.routeName,
                              arguments: AboutArgs('About'));
                          return;
                        case 1:
                          Navigator.of(context).pushNamed(
                            MetadataPage.routeName,
                            arguments: MetadataArgs(data),
                          );
                          return;
                        case 2:
                          Navigator.of(context).pushNamed('/');
                          return;
                        default:
                          return;
                      }
                    },
                  ),
                ],
              ),
              body: Stack(
                alignment: Alignment.center,
                children: [
                  PageView(
                    controller: _pageController,
                    onPageChanged: (index) =>
                        setState(() => _pageIndex = index),
                    children: const [
                      _Gradient(gradient: Gradients.fajr),
                      _Gradient(gradient: Gradients.dhuhr),
                      _Gradient(gradient: Gradients.asr),
                      _Gradient(gradient: Gradients.maghrib),
                      _Gradient(gradient: Gradients.isha),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(height: kToolbarHeight + 36.0),
                      Text(
                        '${data.data!.date!.readable!} / ${data.data!.date!.hijri!.day!} ${data.data!.date!.hijri!.month!.en!} ${data.data!.date!.hijri!.year!}',
                        style: _getTimeStyle(_pageIndex).copyWith(
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const Spacer(),
                      Showcase(
                        key: _allTimings,
                        description: 'Tap to see all timings.',
                        shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        radius: BorderRadius.circular(20.0),
                        child: RawMaterialButton(
                          onPressed: () => _showTodayTimes(
                            data.data!.timings!.fajr!,
                            data.data!.timings!.sunrise!,
                            data.data!.timings!.dhuhr!,
                            data.data!.timings!.asr!,
                            data.data!.timings!.maghrib!,
                            data.data!.timings!.isha!,
                            _pageIndex == _maxPageIndex || _pageIndex == 0
                                ? Colors.white
                                : Palette.eerieBlack,
                            _pageIndex == _maxPageIndex
                                ? Palette.lightCyan.withAlpha(20)
                                : Palette.richBlack.withAlpha(20),
                          ),
                          elevation: 6.0,
                          padding: const EdgeInsets.fromLTRB(
                            18.0,
                            8.0,
                            18.0,
                            2.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            children: [
                              Text(
                                _getTimeTitle(_pageIndex),
                                style: _getTimeStyle(_pageIndex).copyWith(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                _getTime(_pageIndex, data),
                                style: _getTimeStyle(_pageIndex).copyWith(
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      SmoothPageIndicator(
                        controller: _pageController,
                        count: _maxPageIndex + 1,
                        effect: ScrollingDotsEffect(
                            fixedCenter: true,
                            activeDotScale: 1.5,
                            dotColor:
                                _pageIndex == 0 || _pageIndex == _maxPageIndex
                                    ? Colors.white
                                    : Palette.eerieBlack,
                            activeDotColor:
                                _pageIndex == 0 || _pageIndex == _maxPageIndex
                                    ? Colors.white
                                    : Palette.eerieBlack),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height > 360.0
                              ? kToolbarHeight
                              : 18.0),
                    ],
                  ),
                  StreamBuilder(
                    stream: Stream.periodic(const Duration(seconds: 1)),
                    builder: (context, snapshot) {
                      DateTime now = DateTime.now();
                      DateTime other =
                          DateTime(now.year, now.month, now.day, 0, 0);
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  DateFormat.Hm().format(DateTime.now()),
                                  style: _getTimeStyle(_pageIndex).copyWith(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 40.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 7.0, left: 6.0),
                                  child: Text(
                                    DateFormat.s().format(DateTime.now()),
                                    style: _getTimeStyle(_pageIndex).copyWith(
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: BackdropFilter(
                                filter: ui.ImageFilter.blur(
                                  sigmaX: 5.0,
                                  sigmaY: 5.0,
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 18.0,
                                    vertical: 4.0,
                                  ),
                                  decoration: const BoxDecoration(
                                      color: Colors.transparent,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Palette.lightCyan,
                                          blurRadius: 6.0,
                                          blurStyle: BlurStyle.outer,
                                        )
                                      ]),
                                  child: Text(
                                    _getTimeRemaining(data, now, other),
                                    style: _getTimeStyle(_pageIndex).copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            error: (error, stackTrace) => Scaffold(
              body: Stack(
                children: [
                  RefreshIndicator(
                      onRefresh: () async => ref.refresh(prayerTimesProvider(
                          ref.read(timingsArgsProvider).timingsArgs)),
                      child: ListView()),
                  const ErrorPage()
                ],
              ),
            ),
            loading: () => Scaffold(
              body: Stack(
                children: [
                  RefreshIndicator(
                      onRefresh: () async => ref.refresh(prayerTimesProvider(
                          ref.read(timingsArgsProvider).timingsArgs)),
                      child: ListView()),
                  const LoadingPage(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getTitleColor(int index) {
    if (index == _maxPageIndex || index == 0) {
      return Colors.white;
    }
    return Palette.eerieBlack;
  }

  String _getTimeTitle(int index) {
    switch (index) {
      case 0:
        return 'Fajr';
      case 1:
        return 'Dhuhr';
      case 2:
        return 'Asr';
      case 3:
        return 'Maghrib';
      case 4:
        return 'Isha';
      default:
        return 'n/a';
    }
  }

  TextStyle _getTimeStyle(int index) {
    if (index == _maxPageIndex || index == 0) {
      return const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );
    }
    return const TextStyle(
      color: Palette.eerieBlack,
      fontWeight: FontWeight.bold,
    );
  }

  String _getTime(int index, TimesByCityModel data) {
    if (index == 0) {
      return data.data!.timings!.fajr!;
    }
    if (index == 1) {
      return data.data!.timings!.dhuhr!;
    }
    if (index == 2) {
      return data.data!.timings!.asr!;
    }
    if (index == 3) {
      return data.data!.timings!.maghrib!;
    }
    if (index == 4) {
      return data.data!.timings!.isha!;
    }
    return 'n/a';
  }

  Brightness _getBrightness(int index) {
    if (index == _maxPageIndex || index == 0) {
      return Brightness.light;
    }
    return Brightness.dark;
  }

  void _showTodayTimes(
    String fajr,
    String sunrise,
    String dhuhr,
    String asr,
    String maghrib,
    String isha,
    Color color,
    Color backgroundColor,
  ) =>
      showGeneralDialog(
        barrierLabel: 'Times',
        barrierDismissible: true,
        barrierColor: Colors.transparent,
        context: context,
        transitionDuration: const Duration(milliseconds: 320),
        pageBuilder: (ctx, anim, secAnim) => Center(
          child: ClipRRect(
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(
                sigmaX: 5.0,
                sigmaY: 5.0,
              ),
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18.0,
                    vertical: 18.0,
                  ),
                  width: MediaQuery.of(context).size.width <= 360.0
                      ? MediaQuery.of(context).size.width * 0.85
                      : MediaQuery.of(context).size.width * 0.55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: backgroundColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _TimeListTile(title: 'Fajr', time: fajr, color: color),
                      _TimeListTile(
                          title: 'Sunrise', time: sunrise, color: color),
                      _TimeListTile(title: 'Dhuhr', time: dhuhr, color: color),
                      _TimeListTile(title: 'Asr', time: asr, color: color),
                      _TimeListTile(
                          title: 'Maghrib', time: maghrib, color: color),
                      _TimeListTile(title: 'Isha', time: isha, color: color),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        transitionBuilder: (context, anim, secAnim, child) => FadeTransition(
          opacity: anim,
          child: child,
        ),
      );

  String _getTimeRemaining(
      TimesByCityModel data, DateTime now, DateTime other) {
    int timingsIndex = 0;

    DateTime other = DateTime(now.year, now.month, now.day, 0, 0, 0, 0);

    if (now
        .difference(other.add(Duration(
            hours:
                int.parse(data.data!.timings!.isha!.toString().substring(0, 2)),
            minutes: int.parse(
                data.data!.timings!.isha!.toString().substring(3, 5)))))
        .isNegative) {
      timingsIndex = 4;
    }

    if (now
        .difference(other.add(Duration(
            hours: int.parse(
                data.data!.timings!.maghrib!.toString().substring(0, 2)),
            minutes: int.parse(
                data.data!.timings!.maghrib!.toString().substring(3, 5)))))
        .isNegative) {
      timingsIndex = 3;
    }

    if (now
        .difference(other.add(Duration(
            hours:
                int.parse(data.data!.timings!.asr!.toString().substring(0, 2)),
            minutes: int.parse(
                data.data!.timings!.asr!.toString().substring(3, 5)))))
        .isNegative) {
      timingsIndex = 2;
    }

    if (now
        .difference(other.add(Duration(
            hours: int.parse(
                data.data!.timings!.dhuhr!.toString().substring(0, 2)),
            minutes: int.parse(
                data.data!.timings!.dhuhr!.toString().substring(3, 5)))))
        .isNegative) {
      timingsIndex = 1;
    }

    if (now
        .difference(other.add(Duration(
            hours:
                int.parse(data.data!.timings!.fajr!.toString().substring(0, 2)),
            minutes: int.parse(
                data.data!.timings!.fajr!.toString().substring(3, 5)))))
        .isNegative) {
      timingsIndex = 0;
    }

    if (now.isAfter(other.add(Duration(
        hours: int.parse(data.data!.timings!.isha!.toString().substring(0, 2)),
        minutes: int.parse(
            data.data!.timings!.isha!.toString().substring(3, 5)))))) {
      timingsIndex = 5;
    }

    switch (timingsIndex) {
      case 0:
        return '${_timeRemainingFormat('${DateTime(other.year, other.month, other.day, int.parse(data.data!.timings!.fajr!.toString().substring(0, 2)), int.parse(data.data!.timings!.fajr!.toString().substring(3, 5))).difference(now)}')} Fajr';
      case 1:
        return '${_timeRemainingFormat('${DateTime(other.year, other.month, other.day, int.parse(data.data!.timings!.dhuhr!.toString().substring(0, 2)), int.parse(data.data!.timings!.dhuhr!.toString().substring(3, 5))).difference(now)}')} Dhuhr';
      case 2:
        return '${_timeRemainingFormat('${DateTime(other.year, other.month, other.day, int.parse(data.data!.timings!.asr!.toString().substring(0, 2)), int.parse(data.data!.timings!.asr!.toString().substring(3, 5))).difference(now)}')} Asr';
      case 3:
        return '${_timeRemainingFormat('${DateTime(other.year, other.month, other.day, int.parse(data.data!.timings!.maghrib!.toString().substring(0, 2)), int.parse(data.data!.timings!.maghrib!.toString().substring(3, 5))).difference(now)}')} Maghrib';
      case 4:
        return '${_timeRemainingFormat('${DateTime(other.year, other.month, other.day, int.parse(data.data!.timings!.isha!.toString().substring(0, 2)), int.parse(data.data!.timings!.isha!.toString().substring(3, 5))).difference(now)}')} Isha';
      case 5:
        return '${_timeRemainingFormat('${DateTime(other.year, other.month, other.day, int.parse(data.data!.timings!.fajr!.toString().substring(0, 2)), int.parse(data.data!.timings!.fajr!.toString().substring(3, 5))).add(const Duration(days: 1)).difference(now)}')} Fajr';
      default:
        return 'n/a';
    }
  }

  String _timeRemainingFormat(String text) {
    var split = text.split('.');
    var hms = split[0];
    var splitHms = hms.split(':');

    String h = splitHms[0];
    String m = splitHms[1];

    if (h == '0' && m == '00') {
      return 'Now is the time of';
    } else if (h == '0') {
      return '${_mNumberFormat(m)} to';
    } else {
      return '${_hNumberFormat(h)} ${_mNumberFormat(m)} to';
    }
  }

  String _hNumberFormat(String h) {
    if (h == '0') {
      return '';
    } else {
      if (h == '1') {
        return '$h hour';
      } else {
        return '$h hours';
      }
    }
  }

  String _mNumberFormat(String m) {
    if (m == '00') {
      return '';
    } else {
      if (m.substring(0, 1) == '0') {
        return '${m.substring(1)} ${_mTextFormat(m)}';
      } else {
        return '$m ${_mTextFormat(m)}';
      }
    }
  }

  String _mTextFormat(String m) {
    if (m == '00' || m == '01') {
      return 'minute';
    } else {
      return 'minutes';
    }
  }

  String _getTextBody(String text) {
    final split = text.split(' ');
    if (split.length < 5) {
      return 'n/a';
    } else {
      return 'Time for ${split[5]}';
    }
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}

class _Gradient extends StatelessWidget {
  const _Gradient({required this.gradient});

  final LinearGradient gradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: gradient,
      ),
      alignment: Alignment.center,
    );
  }
}

class _TimeListTile extends StatelessWidget {
  const _TimeListTile({
    required this.title,
    required this.time,
    required this.color,
  });

  final String title;
  final String time;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(title, style: TextStyle(fontSize: 18.0, color: color)),
          const Spacer(),
          Text(time, style: TextStyle(fontSize: 18.0, color: color)),
        ],
      ),
    );
  }
}

class TimesPageArgs {
  TimesPageArgs(this.initialPage);

  final int initialPage;
}
