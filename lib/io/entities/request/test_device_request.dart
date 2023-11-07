part of 'request.dart';

@freezed
class TestDeviceRequest with _$TestDeviceRequest {
  const factory TestDeviceRequest({
    required String serial,
    required String brand,
    required String name,
    required String location,
    required String sublocation,
    required String systemVersion,
    required String inventoryNumber,
    required String inventoryUrl,
  }) = _TestDeviceRequest;

  factory TestDeviceRequest.fromJson(Map<String, dynamic> json) => _$TestDeviceRequestFromJson(json);
}

/// OR
class TestDeviceRequest2 {
  String serial;
  String brand;
  String name;
  String location;
  String sublocation;
  String systemVersion;
  String inventoryNumber;
  String inventoryUrl;

  TestDeviceRequest2({
    required this.serial,
    required this.brand,
    required this.name,
    required this.location,
    required this.sublocation,
    required this.systemVersion,
    required this.inventoryNumber,
    required this.inventoryUrl,
  });

  TestDeviceRequest2 copyWith({
    String? serial,
    String? brand,
    String? name,
    String? location,
    String? sublocation,
    String? systemVersion,
    String? inventoryNumber,
    String? inventoryUrl,
  }) {
    return TestDeviceRequest2(
      serial: serial ?? this.serial,
      brand: brand ?? this.brand,
      name: name ?? this.name,
      location: location ?? this.location,
      sublocation: sublocation ?? this.sublocation,
      systemVersion: systemVersion ?? this.systemVersion,
      inventoryNumber: inventoryNumber ?? this.inventoryNumber,
      inventoryUrl: inventoryUrl ?? this.inventoryUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'serial': serial,
      'brand': brand,
      'name': name,
      'location': location,
      'sublocation': sublocation,
      'systemVersion': systemVersion,
      'inventoryNumber': inventoryNumber,
      'inventoryUrl': inventoryUrl,
    };
  }

  factory TestDeviceRequest2.fromMap(Map<String, dynamic> map) {
    return TestDeviceRequest2(
      serial: map['serial'] ?? '',
      brand: map['brand'] ?? '',
      name: map['name'] ?? '',
      location: map['location'] ?? '',
      sublocation: map['sublocation'] ?? '',
      systemVersion: map['systemVersion'] ?? '',
      inventoryNumber: map['inventoryNumber'] ?? '',
      inventoryUrl: map['inventoryUrl'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TestDeviceRequest2.fromJson(String source) => TestDeviceRequest2.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TestDeviceRequest2(serial: $serial, brand: $brand, name: $name, location: $location, sublocation: $sublocation, systemVersion: $systemVersion, inventoryNumber: $inventoryNumber, inventoryUrl: $inventoryUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TestDeviceRequest2 &&
        other.serial == serial &&
        other.brand == brand &&
        other.name == name &&
        other.location == location &&
        other.sublocation == sublocation &&
        other.systemVersion == systemVersion &&
        other.inventoryNumber == inventoryNumber &&
        other.inventoryUrl == inventoryUrl;
  }

  @override
  int get hashCode {
    return serial.hashCode ^
        brand.hashCode ^
        name.hashCode ^
        location.hashCode ^
        sublocation.hashCode ^
        systemVersion.hashCode ^
        inventoryNumber.hashCode ^
        inventoryUrl.hashCode;
  }
}
