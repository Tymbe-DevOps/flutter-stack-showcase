import 'package:corp_devices/common/extensions/extensions.dart';
import 'package:corp_devices/io/enums/qr_type.dart';
import 'package:flutter/widgets.dart';

@immutable
class QrScannerType {
  final QrType key;
  final String title;
  final String description;

  const QrScannerType(this.key, this.title, this.description);

  /// Texts with client scan instructions
  factory QrScannerType.client(BuildContext context) => QrScannerType(
        QrType.client,
        context.translate().scan.login.client.title,
        context.translate().scan.login.client.description,
      );

  /// Texts with service scan instructions
  factory QrScannerType.service(BuildContext context) => QrScannerType(
        QrType.service,
        context.translate().scan.login.service.title,
        context.translate().scan.login.service.description,
      );

  /// Texts with device scan instructions
  factory QrScannerType.device(BuildContext context) => QrScannerType(
        QrType.device,
        context.translate().scan.device.title,
        context.translate().scan.device.title,
      );

  static QrScannerType getByKey(String key, BuildContext context) {
    final enumKey = QrType.values.firstWhere((element) => element.name == key);

    switch (enumKey) {
      case QrType.client:
        return QrScannerType.client(context);
      case QrType.device:
        return QrScannerType.device(context);
      case QrType.service:
        return QrScannerType.service(context);
    }
  }
}
