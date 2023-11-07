import 'dart:async';

import 'package:corp_devices/common/logger/state_logger.dart';
import 'package:corp_devices/corp_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:loggy/loggy.dart';

import 'io/services/local/storage/hive_storage_service.dart';

Future<void> main() async {
  /// Splash setup
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  _initLogging();
  await _initHive();

  /// Storage initialization
  final localStorage = HiveStorageService();
  await localStorage.init();

  runApp(
    ProviderScope(
      observers: [StateLogger()],
      overrides: [
        storageServiceProvider.overrideWithValue(localStorage),
      ],
      child: const CorpApp(),
    ),
  );
}

void _initLogging() {
  Loggy.initLoggy(logPrinter: const PrettyPrinter());
}

Future<void> _initHive() async => await Hive.initFlutter();