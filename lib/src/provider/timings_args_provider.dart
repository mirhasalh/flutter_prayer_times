import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayer_times/src/model/models.dart';

final timingsArgsProvider =
    ChangeNotifierProvider((ref) => TimingsArgsProvider());

class TimingsArgsProvider extends ChangeNotifier {
  TimingsArgsModel _timingsArgs = TimingsArgsModel(
    'Kota Bandung',
    'Indonesia',
    '5',
  );

  TimingsArgsModel get timingsArgs => _timingsArgs;

  void setTimingsArgs(String city, String country, String method) {
    _timingsArgs = TimingsArgsModel(city, country, method);
    notifyListeners();
  }
}
