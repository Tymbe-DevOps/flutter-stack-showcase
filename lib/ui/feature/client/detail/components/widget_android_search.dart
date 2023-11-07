import 'package:corp_devices/common/extensions/extensions.dart';
import 'package:corp_devices/common/theme/colors.dart';
import 'package:corp_devices/ui/feature/client/list/notifier_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Android specific [AppBar]
class AndroidSearchWidget extends ConsumerWidget {
  const AndroidSearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextField(
        onChanged: (String query) {
          ref.read(clientHomeNotifierProvider.notifier).search(query);
        },
        maxLength: 80,
        autofocus: true,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 19),
        decoration: InputDecoration(
          counterText: "",
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 17, color: AppColors.gray3),
          hintText: context.translate().devices.search.placeholder,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
