//  Label StoreMAX
//
//  Created by Anthony Gordon.
//  Copyright © 2019 WooSignal. All rights reserved.
//

//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nylo_framework/config/config_manager.dart';

class AppLocalizations {
  Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
  _AppLocalizationsDelegate();

  Map<String, String> _localizedStrings;

  Future load() async {
    String jsonString =
    await rootBundle.loadString('../lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((k, v) {
      return MapEntry(k, v.toString());
    });
  }

  String trans(String key) {
    return _localizedStrings[key];
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => NyConfigManager.instance.nyConfig
      .supportedLocales
      .map((e) => e.languageCode)
      .contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;

  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = new AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }
}

String trans(BuildContext context, String key) =>
    AppLocalizations.of(context).trans(key);

reloadLocale(BuildContext context, Locale locale) {
  AppLocalizations.of(context).locale = locale;
  AppLocalizations.of(context).load();
}