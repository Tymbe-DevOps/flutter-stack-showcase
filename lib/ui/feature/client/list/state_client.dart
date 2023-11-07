import 'package:corp_devices/common/extensions/extensions.dart';
import 'package:corp_devices/common/result/result.dart';
import 'package:corp_devices/io/model/devices_list_view_vo.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state_client.freezed.dart';

/// Indicates tabs in [Client] page
enum ClientTab {
  all(0),
  myBookings(1);

  final int tabIndex;
  const ClientTab(this.tabIndex);
}

extension ClientTabExt on ClientTab {
  /// Returns localizer title from given [ClientTab]
  String title(BuildContext context) {
    return this == ClientTab.all ? context.translate().devices.all : context.translate().devices.myBookings;
  }
}

/// State of the [ClientHomePage]
@freezed
class ClientState with _$ClientState {
  const factory ClientState({
    required Result<void> status,
    required bool searchShown,
    required String? query,
    required ClientTab currentTab,
    required List<List<DeviceListView>> clientListView,
    required List<List<DeviceListView>> copyClientListView,
    String? deviceName,
  }) = _ClientState;

  factory ClientState.initial() => ClientState(
        status: Result.loading(),
        query: null,
        searchShown: false,
        currentTab: ClientTab.all,
        clientListView: const [[]],
        copyClientListView: const [[]],
      );
}
