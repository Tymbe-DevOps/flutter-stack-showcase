import 'package:corp_devices/common/localization/locale_finder.dart';
import 'package:corp_devices/common/localization/localization.dart';
import 'package:corp_devices/common/router/router.dart';
import 'package:corp_devices/common/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CorpApp extends ConsumerWidget {
  const CorpApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'CORPDEV',
      themeMode: ThemeMode.light,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      debugShowCheckedModeBanner: false,
      localeListResolutionCallback: (
        List<Locale>? locales,
        Iterable<Locale> supportedLocales,
      ) {
        return findSupportedLanguage(
          phoneLocales: locales ?? [],
          supportedLocales: supportedLocales.toList(),
          defaultLocale: const Locale("en"),
        );
      },
      builder: (context, Widget? child) {
        return MediaQuery(
          // Ignore font scaling in the device to not break UI
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: child ?? const SizedBox(),
        );
      },
      supportedLocales: localizedLabels.keys,
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}
