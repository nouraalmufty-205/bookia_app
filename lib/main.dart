import 'package:bookia/core/networking/dio_factory.dart';
import 'package:bookia/features/bookiaapp.dart';
import 'package:bookia/services/local/local_helper.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await LocalHelper.init();
  DioFactory.init();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: BookiaApp(),
    ),
  );
}
