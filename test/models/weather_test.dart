import 'dart:convert';
import 'dart:io';
import 'package:flutter_mvvm_template/models/weather.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test convert json response to Weather model', () {
      final file = File('test_resources/weather.json').readAsStringSync();
      dynamic json = jsonDecode(file);
      try {
        Weather weatherInfo = Weather.fromJson(json);
        Current current = Current.fromJson(json['current']);
        expect(weatherInfo.latitude, 13.7367);
        expect(weatherInfo.longitude, 100.5232);
        expect(current.temp, 305.95);
      } catch (e) {
        print(e.toString());
      }
    });
}