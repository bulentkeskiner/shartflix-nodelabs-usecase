import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:shartflix/core/network/network_service.dart';
import 'package:shartflix/di_helper.dart';
import 'package:shartflix/support/bloc_observer.dart';

@immutable
final class ApplicationInitialize {
  Future<void> make() async {
    await dotenv.load(fileName: "assets/release.env");
    WidgetsFlutterBinding.ensureInitialized();

    await runZonedGuarded<Future<void>>(_initialize, (error, stack) {
      FirebaseCrashlytics.instance.log("runZonedGuarded Error");
      FirebaseCrashlytics.instance.crash();
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      Logger().e(error);
    });
  }

  Future<void> _initialize() async {
    Bloc.observer = const AppBlocObserver();

    await setupLocator();
    await sl<NetworkService>().initial();

    // Firebase
    await Firebase.initializeApp();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    await EasyLocalization.ensureInitialized();
  }
}
