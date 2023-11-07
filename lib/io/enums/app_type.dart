/// The app can serve as [client] where Applifters can borrow test devices and
/// return them or as [service] where a device sends periodically info about
/// itself
///
/// When BE register unknown device, it's automatically added to CORP system
enum AppType {
  service,
  client;

  static AppType? getByName(String? name) {
    if (name == AppType.client.name) return AppType.client;
    if (name == AppType.service.name) return AppType.service;
    return null;
  }
}
