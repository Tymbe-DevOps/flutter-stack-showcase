import 'package:corp_devices/common/constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sheet_localization/flutter_sheet_localization.dart';

part 'localization.g.dart';

/// Localization based on Google Sheets
///
/// I don't recommend this package as it's not maintained anymore
/// You can have a look at https://pub.dev/packages/slang
@SheetLocalization(LocalizationConstants.sheetId, "0", 1)
class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizationsData> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => localizedLabels.containsKey(locale);

  @override
  Future<AppLocalizationsData> load(Locale locale) => SynchronousFuture<AppLocalizationsData>(localizedLabels[locale]!);
  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
