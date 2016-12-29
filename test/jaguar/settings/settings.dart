library test.jaguar.settings;

import 'dart:io';
import 'dart:async';
import 'package:test/test.dart';
import 'package:jaguar/jaguar.dart';
import 'package:jaguar/testing.dart';

part 'settings.g.dart';

void main() {
  group('settings', () {
    Map<String, String> localSettings = {
      "interval": "1",
      "secret": "fghfghfghtdry",
    };

    Settings.parse(
        <String>['-s', 'test/jaguar/settings/settings.yaml'], localSettings);

    test('from map', () async {
      expect(Settings.getString('interval'), "1");
    });

    test('from not found map', () async {
      expect(Settings.getString('notfound'), null);
    });

    test('from map default', () async {
      expect(
          Settings.getString('notfound', defaultValue: 'novalue'), 'novalue');
    });

    test('from yaml {filter: none}', () async {
      expect(Settings.getString('host'), 'localhost');
    });

    test('from yaml {filter: yaml}', () async {
      expect(
          Settings.getString('host', settingsFilter: SettingsFilter.Map), null);
      expect(
          Settings.getString('host', settingsFilter: SettingsFilter.Env), null);
      expect(Settings.getString('host', settingsFilter: SettingsFilter.Yaml),
          'localhost');
    });

    test('from not found yaml', () async {
      expect(
          Settings.getString('notfound', settingsFilter: SettingsFilter.Yaml),
          null);
    });

    test('from yaml default', () async {
      expect(
          Settings.getString('notfound',
              defaultValue: 'novalue', settingsFilter: SettingsFilter.Yaml),
          'novalue');
    });
  });
}
