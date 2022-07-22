import 'package:floward_task/generated/l10n.dart';
import 'package:floward_task/utils/app_colors.dart';
import 'package:floward_task/utils/app_styles.dart';
import 'package:flutter/material.dart';

class NoConnectionWidget extends StatelessWidget {
  const NoConnectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.wifi_off_outlined,
            color: AppColors.grey,
            size: 120,
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            S.of(context).noInternetConnection,
            style: AppStyles.regular(fontSize: 18, color: AppColors.grey),
          ),
        ],
      ),
    );
  }
}
