enum DeviceBrand {
  apple(brand: "Apple", system: "iOS", iconPath: "assets/images/apple.png"),
  samsung(brand: "Samsung", iconPath: "assets/images/samsung.png"),
  sony(brand: "Sony", iconPath: "assets/images/sony.png"),
  huawei(brand: "Huawei", iconPath: "assets/images/huawei.png"),
  xiaomi(brand: "Xiaomi", iconPath: "assets/images/xiaomi.png"),
  redmi(brand: "Redmi", iconPath: "assets/images/xiaomi.png"),
  realme(brand: "Realme 2"),
  asus(brand: "Asus"),
  htc(brand: "HTC"),
  google(brand: "Google"),
  lg(brand: "LG"),
  onePlus(brand: "OnePlus"),
  unknown(brand: "Unknown");

  final String brand;
  final String? iconPath;
  final String? system;

  const DeviceBrand({
    required this.brand,
    this.system = "Android",
    this.iconPath,
  });

  static DeviceBrand parseFromText(String brand) {
    final clearedText = brand.replaceAll(" ", "").trim();

    return DeviceBrand.values.firstWhere(
      (element) => element.brand == clearedText,
      orElse: () => DeviceBrand.unknown,
    );
  }
}
