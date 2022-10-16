import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  static const String routeName = '/about';

  const AboutPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 18.0,
        ),
        child: RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyText1,
            text: 'A minimalist lightweight mobile app. Built with ',
            children: <TextSpan>[
              TextSpan(
                text: 'Flutter',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).primaryColor),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => _launchUrl(Urls.flutter),
              ),
              TextSpan(
                text: ' by the hand of ',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              TextSpan(
                text: 'myself',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).primaryColor),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => _launchUrl(Urls.me),
              ),
              TextSpan(
                text: ' and help of open source ',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              TextSpan(
                text: 'Al Adhan APIs.\n',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).primaryColor),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => _launchUrl(Urls.alAdhan),
              ),
              TextSpan(
                text: '\nA resources related to this this project:\n\n- ',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              TextSpan(
                text: 'Al Adhan: RESTful prayer times APIs\n',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).primaryColor),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => _launchUrl(Urls.alAdhan),
              ),
              TextSpan(
                text: '- ',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              TextSpan(
                text: 'Riverpod: A Reactive Caching and Data-binding Framework',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Theme.of(context).primaryColor),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => _launchUrl(Urls.riverpod),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchUrl(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
      webViewConfiguration: const WebViewConfiguration(
        enableJavaScript: true,
        enableDomStorage: true,
      ),
    )) {
      throw 'couldn\'t launch $url';
    }
  }
}

class Urls {
  static const flutter = 'https://flutter.dev/';
  static const me = 'https://github.com/mirhasalh';
  static const alAdhan = 'https://aladhan.com/prayer-times-api';
  static const riverpod = 'https://riverpod.dev/';
}

class AboutArgs {
  AboutArgs(this.title);

  final String title;
}
