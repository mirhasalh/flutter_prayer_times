import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayer_times/src/model/models.dart';
import 'package:prayer_times/src/page/pages.dart';
import 'package:prayer_times/src/palette.dart';
import 'package:prayer_times/src/provider/providers.dart';

class MetadataPage extends ConsumerWidget {
  static const String routeName = '/metadata';

  const MetadataPage({super.key, required this.times});

  final TimesByCityModel times;

  final _tileColor = Colors.white;
  final _subtitleColor = Palette.darkGray;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(times.data!.date!.readable!),
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () {},
            title: Text(times.data!.date!.hijri!.date!),
            subtitle: Text(
              'Hijri date.',
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: _subtitleColor),
            ),
            tileColor: _tileColor,
          ),
          const Divider(height: 0.0),
          ListTile(
            onTap: () {},
            title: Text(times.data!.date!.hijri!.month!.ar!),
            subtitle: Text(
              '${times.data!.date!.hijri!.month!.en!}.',
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: _subtitleColor),
            ),
            tileColor: _tileColor,
          ),
          const Divider(height: 0.0),
          ListTile(
            onTap: () {},
            title: Text(times.data!.meta!.timezone!),
            subtitle: Text(
              'Timezone.',
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: _subtitleColor),
            ),
            tileColor: _tileColor,
          ),
          const Divider(height: 0.0),
          _MethodTile(
            onPressed: () => Navigator.of(context).pushNamed(
              MethodSettingsPage.routeName,
              arguments: MethodArgs(
                'Method Settings',
                int.parse(ref.read(timingsArgsProvider).timingsArgs.method),
              ),
            ),
            title: times.data!.meta!.method!.name!,
            subtitle: 'A prayer times calculation method.',
            color: _tileColor,
          ),
          const Divider(height: 0.0),
        ],
      ),
    );
  }
}

class _MethodTile extends StatelessWidget {
  const _MethodTile({
    required this.onPressed,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  final VoidCallback onPressed;
  final String title;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      fillColor: color,
      elevation: 0.0,
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0,
      ),
      constraints: const BoxConstraints(
        minWidth: 0.0,
        minHeight: 0.0,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 2.0),
            Text(
              subtitle,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: Palette.darkGray),
            ),
            const SizedBox(height: 2.0),
          ],
        ),
      ),
    );
  }
}

class MetadataArgs {
  MetadataArgs(this.times);

  final TimesByCityModel times;
}
