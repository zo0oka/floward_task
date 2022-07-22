import 'dart:developer';

import 'package:floward_task/data/network_repo.dart';
import 'package:floward_task/model/post.dart';
import 'package:floward_task/model/responses/api_response.dart';
import 'package:floward_task/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MainProvider with ChangeNotifier {
  List<User> users = [];
  List<Post> posts = [];
  bool _init = false;

  Future<void> init() async {
    if (!_init) {
      EasyLoading.show();
      await getUsers();
      await getPosts();
      EasyLoading.dismiss();
      _init = true;
      notifyListeners();
    }
  }

  int getUserPostCount(int userId) {
    return posts.where((element) => element.userId! == userId).toList().length;
  }

  Future<List<Post>> getUserPosts(int userId) async {
    return Future.value(
        posts.where((element) => element.userId! == userId).toList());
  }

  Future<void> getUsers() async {
    if (users.isEmpty) {
      final ApiResponse apiResponse = await NetworkRepo().getUsers();
      if (apiResponse.response != null &&
          apiResponse.response!.statusCode == 200) {
        users = (apiResponse.response!.data as List<dynamic>)
            .map((e) => User.fromJson(e as Map<String, dynamic>))
            .toList();
        log('Users Count -> ${users.length}');
      } else {
        users = [];
      }
    }
  }

  Future<void> getPosts() async {
    if (posts.isEmpty) {
      final ApiResponse apiResponse = await NetworkRepo().getPosts();
      if (apiResponse.response != null &&
          apiResponse.response!.statusCode == 200) {
        posts = (apiResponse.response!.data as List<dynamic>)
            .map((e) => Post.fromJson(e as Map<String, dynamic>))
            .toList();
        log('Posts Count -> ${posts.length}');
      } else {
        posts = [];
      }
    }
  }
}
