import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayer_times/src/api/apis.dart';
import 'package:prayer_times/src/model/models.dart';
import 'package:http/http.dart' as http;

final prayerTimesProvider = FutureProvider.autoDispose
    .family<TimesByCityModel, TimingsArgsModel>((ref, args) async {
  final response = await http.get(Uri.parse(
      '${AlAdhanApi.byCity}city=${args.city}&country=${args.country}&method=${args.method}'));

  if (response.statusCode != 200) {
    throw Exception('Failed to load');
  } else {
    final data = json.decode(response.body);

    return TimesByCityModel.fromJson(data);
  }
});
