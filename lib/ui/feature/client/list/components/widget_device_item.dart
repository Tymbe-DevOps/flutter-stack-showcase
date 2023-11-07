import 'package:corp_devices/common/extensions/extensions.dart';
import 'package:corp_devices/common/theme/colors.dart';
import 'package:corp_devices/common/theme/padding.dart';
import 'package:corp_devices/io/enums/device_state.dart';
import 'package:corp_devices/io/enums/device_type.dart';
import 'package:corp_devices/io/model/models.dart';
import 'package:corp_devices/ui/base/components/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

// Device widget representation
class DeviceItemView extends ConsumerWidget {
  final DeviceDataModel device;
  final VoidCallback? onTap;

  final _iconSize = 30.0;
  final _disabledOpacity = 0.3;

  const DeviceItemView({
    required this.device,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          ListTile(
            tileColor: Theme.of(context).colorScheme.background,
            onTap: onTap,
            leading: Padding(
              padding: const EdgeInsets.only(top: spacingS),
              child: Image.asset(
                device.brand.iconPath ?? "",
                width: _iconSize,
                height: _iconSize,
                errorBuilder: ((context, _, ___) => const SizedBox()),
              ),
            ),
            title: Text(
              device.name,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
            ),
            subtitle: _DeviceSubtitle(device: device),
            trailing: AdaptiveButtonOverlay(
              color: Colors.transparent,
              onTap: device.deviceState != DeviceState.booked ? () {} : null,
              child: Text(
                device.deviceState.buttonTitle(context),
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: 14,
                      color: AppColors.black.withOpacity(
                        device.deviceState == DeviceState.booked ? _disabledOpacity : 1,
                      ),
                    ),
              ),
            ),
          ),
          const _Divider()
        ],
      ),
    );
  }
}

/// StickyHeader library does not have separatorBuilder, so divider must be placed
/// in view :(
class _Divider extends StatelessWidget {
  const _Divider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 1,
      indent: 70,
      height: 1,
      color: AppColors.black.withOpacity(0.1),
    );
  }
}

/// Subtitle of [DeviceItemView]
class _DeviceSubtitle extends StatelessWidget {
  final DeviceDataModel device;

  const _DeviceSubtitle({
    required this.device,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.ideographic,
        children: [
          SvgPicture.asset(
            device.deviceType.iconPath,
            color: AppColors.metaGrey,
          ),
          const SizedBox(width: 4),
          Text(
            "${device.brand.system} ${device.system}",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.metaGrey,
                ),
          ),
          const SizedBox(width: spacingS),
          const _Circle(),
          const SizedBox(width: 4),
          Text(
            device.inventoryNumber,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.metaGrey,
                ),
          ),
        ],
      ),
    );
  }
}

/// Inner circle
class _Circle extends StatelessWidget {
  const _Circle({Key? key}) : super(key: key);
  final _size = 6.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Container(
        width: _size,
        height: _size,
        decoration: BoxDecoration(
          color: AppColors.metaGrey.withOpacity(0.8),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

// No devices widget representation
class NoDevicesItemView extends StatelessWidget {
  const NoDevicesItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          ListTile(
            tileColor: Theme.of(context).colorScheme.background,
            title: Text(
              context.translate().devices.noDevices.title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.gray2,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
