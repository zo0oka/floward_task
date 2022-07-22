import 'dart:developer';

import 'package:floward_task/generated/l10n.dart';
import 'package:floward_task/providers/connectivity_provider.dart';
import 'package:floward_task/providers/language_provider.dart';
import 'package:floward_task/providers/main_provider.dart';
import 'package:floward_task/utils/app_colors.dart';
import 'package:floward_task/utils/app_styles.dart';
import 'package:floward_task/widgets/no_connection_widget.dart';
import 'package:floward_task/widgets/user_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MainProvider _mainProvider;
  late LanguageProvider _languageProvider;
  late ConnectivityProvider _connectivityProvider;

  @override
  void didChangeDependencies() async {
    _mainProvider = Provider.of<MainProvider>(context);
    _languageProvider = Provider.of<LanguageProvider>(context);
    _connectivityProvider = Provider.of<ConnectivityProvider>(context);
    log('Home Connection -> ${_connectivityProvider.isConnected}');
    if (_connectivityProvider.isConnected) {
      await _mainProvider.init();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).home,
          style: AppStyles.bold(color: AppColors.white),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              _languageProvider.changeLocale();
            },
            child: Row(
              children: [
                Text(
                  _languageProvider.locale.languageCode == 'ar'
                      ? 'English'
                      : 'العربية',
                  style: AppStyles.semiBold(color: AppColors.white),
                ),
                const SizedBox(
                  width: 6,
                ),
                const Icon(
                  Icons.language_outlined,
                  color: AppColors.white,
                ),
              ],
            ),
          ),
        ],
      ),
      body: _connectivityProvider.isConnected
          ? ListView.builder(
              itemCount: _mainProvider.users.length,
              itemBuilder: (context, index) {
                return UserWidget(index: index);
              },
            )
          : const NoConnectionWidget(),
    );
  }
}
