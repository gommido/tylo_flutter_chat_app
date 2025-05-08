import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'localization.dart';

Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates = [
  AppLocale.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate
];