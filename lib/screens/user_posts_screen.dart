import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:floward_task/model/post.dart';
import 'package:floward_task/providers/connectivity_provider.dart';
import 'package:floward_task/providers/language_provider.dart';
import 'package:floward_task/providers/main_provider.dart';
import 'package:floward_task/utils/app_colors.dart';
import 'package:floward_task/utils/app_styles.dart';
import 'package:floward_task/utils/arg_keys.dart';
import 'package:floward_task/widgets/no_connection_widget.dart';
import 'package:floward_task/widgets/user_post_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserPostsScreen extends StatefulWidget {
  const UserPostsScreen({Key? key}) : super(key: key);

  @override
  State<UserPostsScreen> createState() => _UserPostsScreenState();
}

class _UserPostsScreenState extends State<UserPostsScreen> {
  late MainProvider _mainProvider;
  late LanguageProvider _languageProvider;
  late ConnectivityProvider _connectivityProvider;
  late int _userId;

  @override
  void didChangeDependencies() async {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _userId = arguments[ArgumentKeys.userId];
    log('User ID -> $_userId');
    _mainProvider = Provider.of<MainProvider>(context);
    _languageProvider = Provider.of<LanguageProvider>(context);
    _connectivityProvider = Provider.of<ConnectivityProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            _connectivityProvider.isConnected ? 180 : kToolbarHeight),
        child: AppBar(
          title: Text(
            _mainProvider.users
                    .where((element) => element.userId! == _userId)
                    .first
                    .name ??
                '',
            style: AppStyles.bold(color: AppColors.white),
          ),
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
          flexibleSpace: FlexibleSpaceBar(
            background: _connectivityProvider.isConnected
                ? CachedNetworkImage(
                    imageUrl: _mainProvider.users
                        .where((element) => element.userId! == _userId)
                        .first
                        .thumbnailUrl!,
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover)
                : Container(),
          ),
        ),
      ),
      body: _connectivityProvider.isConnected
          ? FutureBuilder<List<Post>>(
              future: _mainProvider.getUserPosts(_userId),
              builder: (context, snapshot) {
                return snapshot.connectionState == ConnectionState.waiting
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        primary: true, physics: const BouncingScrollPhysics(),
                        // itemCount: snapshot.data!.userPosts!.length,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return UserPostWidget(
                            index: index,
                            post: snapshot.data![index],
                          );
                        },
                      );
              },
            )
          : const NoConnectionWidget(),
    );
  }
}
