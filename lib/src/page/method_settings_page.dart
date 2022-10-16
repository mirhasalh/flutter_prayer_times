import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayer_times/src/palette.dart';
import 'package:prayer_times/src/provider/providers.dart';

class MethodSettingsPage extends ConsumerStatefulWidget {
  static const String routeName = '/method';

  const MethodSettingsPage({
    super.key,
    required this.title,
    required this.method,
  });

  final String title;
  final int method;

  @override
  MethodSettingsPageState createState() => MethodSettingsPageState();
}

class MethodSettingsPageState extends ConsumerState<MethodSettingsPage> {
  late Method _method;

  @override
  void initState() {
    super.initState();
    _method = _getMethod(widget.method);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Palette.beauBlue,
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 18.0,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: Palette.blueNcs,
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Text(
                      'Please note that prayer timings might not always match your local mosque or government authority.',
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: Palette.blueNcs),
                    ),
                  ),
                ],
              ),
            ),
            _MethodTile(
              title: 'University of Islamic Sciences, Karachi',
              trailing: Radio<Method>(
                  value: Method.karachi,
                  groupValue: _method,
                  onChanged: (value) {
                    ref.read(timingsArgsProvider).setTimingsArgs(
                          ref.read(timingsArgsProvider).timingsArgs.city,
                          ref.read(timingsArgsProvider).timingsArgs.country,
                          '1',
                        );
                    setState(() => _method = value!);
                    Navigator.of(context).pushNamed('/');
                  }),
            ),
            const Divider(height: 0.0),
            _MethodTile(
              title: 'Islamic Society of North America',
              trailing: Radio<Method>(
                  value: Method.northAmerica,
                  groupValue: _method,
                  onChanged: (value) {
                    ref.read(timingsArgsProvider).setTimingsArgs(
                          ref.read(timingsArgsProvider).timingsArgs.city,
                          ref.read(timingsArgsProvider).timingsArgs.country,
                          '2',
                        );
                    setState(() => _method = value!);
                    Navigator.of(context).pushNamed('/');
                  }),
            ),
            const Divider(height: 0.0),
            _MethodTile(
              title: 'Muslim World League',
              trailing: Radio<Method>(
                  value: Method.muslimWorldLeague,
                  groupValue: _method,
                  onChanged: (value) {
                    ref.read(timingsArgsProvider).setTimingsArgs(
                          ref.read(timingsArgsProvider).timingsArgs.city,
                          ref.read(timingsArgsProvider).timingsArgs.country,
                          '3',
                        );
                    setState(() => _method = value!);
                    Navigator.of(context).pushNamed('/');
                  }),
            ),
            const Divider(height: 0.0),
            _MethodTile(
              title: 'Umm Al-Qura University, Makkah',
              trailing: Radio<Method>(
                  value: Method.alQuraMakkah,
                  groupValue: _method,
                  onChanged: (value) {
                    ref.read(timingsArgsProvider).setTimingsArgs(
                          ref.read(timingsArgsProvider).timingsArgs.city,
                          ref.read(timingsArgsProvider).timingsArgs.country,
                          '4',
                        );
                    setState(() => _method = value!);
                    Navigator.of(context).pushNamed('/');
                  }),
            ),
            const Divider(height: 0.0),
            _MethodTile(
              title: 'Egyptian General Authority of Survey',
              trailing: Radio<Method>(
                  value: Method.egyptian,
                  groupValue: _method,
                  onChanged: (value) {
                    ref.read(timingsArgsProvider).setTimingsArgs(
                          ref.read(timingsArgsProvider).timingsArgs.city,
                          ref.read(timingsArgsProvider).timingsArgs.country,
                          '5',
                        );
                    setState(() => _method = value!);
                    Navigator.of(context).pushNamed('/');
                  }),
            ),
            const Divider(height: 0.0),
            _MethodTile(
              title: 'Institute of Geophysics, University of Tehran',
              trailing: Radio<Method>(
                  value: Method.tehran,
                  groupValue: _method,
                  onChanged: (value) {
                    ref.read(timingsArgsProvider).setTimingsArgs(
                          ref.read(timingsArgsProvider).timingsArgs.city,
                          ref.read(timingsArgsProvider).timingsArgs.country,
                          '7',
                        );
                    setState(() => _method = value!);
                    Navigator.of(context).pushNamed('/');
                  }),
            ),
            const Divider(height: 0.0),
            _MethodTile(
              title: 'Gulf Region',
              trailing: Radio<Method>(
                  value: Method.gulfRegion,
                  groupValue: _method,
                  onChanged: (value) {
                    ref.read(timingsArgsProvider).setTimingsArgs(
                          ref.read(timingsArgsProvider).timingsArgs.city,
                          ref.read(timingsArgsProvider).timingsArgs.country,
                          '8',
                        );
                    setState(() => _method = value!);
                    Navigator.of(context).pushNamed('/');
                  }),
            ),
            const Divider(height: 0.0),
            _MethodTile(
              title: 'Kuwait',
              trailing: Radio<Method>(
                  value: Method.kuwait,
                  groupValue: _method,
                  onChanged: (value) {
                    ref.read(timingsArgsProvider).setTimingsArgs(
                          ref.read(timingsArgsProvider).timingsArgs.city,
                          ref.read(timingsArgsProvider).timingsArgs.country,
                          '9',
                        );
                    setState(() => _method = value!);
                    Navigator.of(context).pushNamed('/');
                  }),
            ),
            const Divider(height: 0.0),
            _MethodTile(
              title: 'Qatar',
              trailing: Radio<Method>(
                  value: Method.qatar,
                  groupValue: _method,
                  onChanged: (value) {
                    ref.read(timingsArgsProvider).setTimingsArgs(
                          ref.read(timingsArgsProvider).timingsArgs.city,
                          ref.read(timingsArgsProvider).timingsArgs.country,
                          '10',
                        );
                    setState(() => _method = value!);
                    Navigator.of(context).pushNamed('/');
                  }),
            ),
            const Divider(height: 0.0),
            _MethodTile(
              title: 'Majlis Ugama Islam Singapura, Singapore',
              trailing: Radio<Method>(
                  value: Method.muiSingapore,
                  groupValue: _method,
                  onChanged: (value) {
                    ref.read(timingsArgsProvider).setTimingsArgs(
                          ref.read(timingsArgsProvider).timingsArgs.city,
                          ref.read(timingsArgsProvider).timingsArgs.country,
                          '11',
                        );
                    setState(() => _method = value!);
                    Navigator.of(context).pushNamed('/');
                  }),
            ),
            const Divider(height: 0.0),
            _MethodTile(
              title: 'Union Organization islamic de France',
              trailing: Radio<Method>(
                  value: Method.france,
                  groupValue: _method,
                  onChanged: (value) {
                    ref.read(timingsArgsProvider).setTimingsArgs(
                          ref.read(timingsArgsProvider).timingsArgs.city,
                          ref.read(timingsArgsProvider).timingsArgs.country,
                          '12',
                        );
                    setState(() => _method = value!);
                    Navigator.of(context).pushNamed('/');
                  }),
            ),
            const Divider(height: 0.0),
            _MethodTile(
              title: 'Diyanet İşleri Başkanlığı, Turkey',
              trailing: Radio<Method>(
                  value: Method.turkey,
                  groupValue: _method,
                  onChanged: (value) {
                    ref.read(timingsArgsProvider).setTimingsArgs(
                          ref.read(timingsArgsProvider).timingsArgs.city,
                          ref.read(timingsArgsProvider).timingsArgs.country,
                          '13',
                        );
                    setState(() => _method = value!);
                    Navigator.of(context).pushNamed('/');
                  }),
            ),
            const Divider(height: 0.0),
            _MethodTile(
              title: 'Spiritual Administration of Muslims of Russia',
              trailing: Radio<Method>(
                  value: Method.russia,
                  groupValue: _method,
                  onChanged: (value) {
                    ref.read(timingsArgsProvider).setTimingsArgs(
                          ref.read(timingsArgsProvider).timingsArgs.city,
                          ref.read(timingsArgsProvider).timingsArgs.country,
                          '14',
                        );
                    setState(() => _method = value!);
                    Navigator.of(context).pushNamed('/');
                  }),
            ),
            const Divider(height: 0.0),
            const SizedBox(height: kToolbarHeight),
          ],
        ),
      ),
    );
  }

  Method _getMethod(int method) {
    switch (method) {
      case 1:
        return Method.karachi;
      case 2:
        return Method.northAmerica;
      case 3:
        return Method.muslimWorldLeague;
      case 4:
        return Method.alQuraMakkah;
      case 5:
        return Method.egyptian;
      case 6:
        return Method.egyptian;
      case 7:
        return Method.tehran;
      case 8:
        return Method.gulfRegion;
      case 9:
        return Method.kuwait;
      case 10:
        return Method.qatar;
      case 11:
        return Method.muiSingapore;
      case 12:
        return Method.france;
      case 13:
        return Method.turkey;
      case 14:
        return Method.russia;
      default:
        return Method.egyptian;
    }
  }
}

enum Method {
  karachi,
  northAmerica,
  muslimWorldLeague,
  alQuraMakkah,
  egyptian,
  tehran,
  gulfRegion,
  kuwait,
  qatar,
  muiSingapore,
  france,
  turkey,
  russia,
}

class _MethodTile extends StatelessWidget {
  const _MethodTile({required this.title, required this.trailing});

  final String title;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 12.0,
      ),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Palette.eerieBlack),
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}

class MethodArgs {
  MethodArgs(this.title, this.method);

  final String title;
  final int method;
}
