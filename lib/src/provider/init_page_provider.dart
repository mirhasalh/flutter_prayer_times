import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prayer_times/src/api/apis.dart';
import 'package:prayer_times/src/model/timings_args_model.dart';

class InitPageProvider {
  Future<int> determinePage(TimingsArgsModel args) async {
    int initialPage = 4;

    List<String> timings = <String>['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'];

    DateTime now = DateTime.now();

    DateTime other = DateTime(now.year, now.month, now.day, 0, 0, 0, 0);

    final response = await http.get(Uri.parse(
        '${AlAdhanApi.byCity}city=${args.city}&country=${args.country}&method=${args.method}'));

    if (response.statusCode != 200) {
      throw Exception('Failed to load');
    } else {
      final data = json.decode(response.body);
      for (int i = 0; i < timings.length; i++) {
        var time = timings[i];
        if (now
            .difference(other.add(Duration(
                hours: int.parse(
                    data['data']['timings'][time].toString().substring(0, 2)),
                minutes: int.parse(
                    data['data']['timings'][time].toString().substring(3, 5)))))
            .isNegative) {
          initialPage = i;
          break;
        }
      }

      return initialPage;
    }
  }
}
