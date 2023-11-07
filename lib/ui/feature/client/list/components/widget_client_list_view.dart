import 'package:collection/collection.dart';
import 'package:corp_devices/common/constants/routes.dart';
import 'package:corp_devices/common/extensions/extensions.dart';
import 'package:corp_devices/common/theme/colors.dart';
import 'package:corp_devices/common/theme/padding.dart';
import 'package:corp_devices/gen/assets.gen.dart';
import 'package:corp_devices/io/enums/device_state.dart';
import 'package:corp_devices/io/model/devices_list_view_vo.dart';
import 'package:corp_devices/ui/base/empty_screen.dart';
import 'package:corp_devices/ui/feature/client/list/components/widget_device_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:go_router/go_router.dart';

/// ListView with sticky header item [_StickyHeader]
///
/// Given [List<DeviceListView>] represents a category with all the items
class ClientListView extends StatefulWidget {
  final List<DeviceListView> deviceListView;

  const ClientListView({
    required this.deviceListView,
    Key? key,
  }) : super(key: key);

  @override
  State<ClientListView> createState() => _ClientListViewState();
}

class _ClientListViewState extends State<ClientListView> with AutomaticKeepAliveClientMixin {
  late final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return DefaultStickyHeaderController(
      child: CustomScrollView(
        controller: _scrollController,
        slivers: widget.deviceListView.mapIndexed((listIndex, itemDevices) {
          return SliverStickyHeader(
            header: _StickyHeader(
              header: itemDevices.deviceState.headerTitle(context),
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: itemDevices.devices.length,
                (context, index) {
                  final item = itemDevices.devices[index];

                  if (itemDevices.canShowEmptyScreen(item)) {
                    return EmptyScreen(
                      title: context.translate().empty.title,
                      description: context.translate().empty.description,
                      imagePath: Assets.images.glass.path,
                    );
                  }

                  return item.map(
                    noDevices: (_) => const NoDevicesItemView(),
                    data: (device) => DeviceItemView(
                        device: device.copyWith(takenByMe: itemDevices.takenByMe),
                        onTap: () {
                          context.pushNamed(
                            AppRoutes.clientDetail,
                            extra: item,
                          );
                        }),
                    empty: (_) => SizedBox(
                      height: listIndex == 0 ? spacingM : 70,
                    ),
                  );
                },
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}

/// Sticky header item
class _StickyHeader extends StatelessWidget {
  final String header;

  final _height = 25.0;

  const _StickyHeader({
    required this.header,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      color: AppColors.gray1,
      padding: const EdgeInsets.symmetric(horizontal: spacingM),
      alignment: Alignment.centerLeft,
      child: Text(
        header,
        style: TextStyle(
          color: AppColors.metaGrey,
          fontFamily: DefaultTextStyle.of(context).style.fontFamily,
        ),
      ),
    );
  }
}
