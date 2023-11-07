import 'package:corp_devices/io/repository/device_repository.dart';
import 'package:corp_devices/io/repository/repository_providers.dart';
import 'package:corp_devices/ui/feature/client/list/client_home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Notifier provider for [ClientNotifier]
final clientHomeNotifierProvider = StateNotifierProvider<ClientPageNotifier, ClientState>((ref) {
  final deviceRepo = ref.read(deviceRepoProvider);
  return ClientPageNotifier(deviceRepo);
});

/// StateNotifier for [ClientHomePage]
class ClientPageNotifier extends StateNotifier<ClientState> {
  final DeviceRepository _deviceRepository;
  ClientPageNotifier(DeviceRepository deviceRepository)
      : _deviceRepository = deviceRepository,
        super(ClientState.initial());

  static const firstTab = 0;
  static const secondTab = 1;

  void search(String query) {}

  void closeSearch() {}

  void selectTab(ClientTab value) {}

  void refreshTabs() {}
}
