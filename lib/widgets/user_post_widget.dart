import 'package:floward_task/model/post.dart';
import 'package:floward_task/providers/main_provider.dart';
import 'package:floward_task/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserPostWidget extends StatefulWidget {
  final int index;
  final Post post;
  const UserPostWidget({Key? key, required this.index, required this.post})
      : super(key: key);

  @override
  State<UserPostWidget> createState() => _UserPostWidgetState();
}

class _UserPostWidgetState extends State<UserPostWidget> {
  late MainProvider _mainProvider;

  @override
  void didChangeDependencies() {
    _mainProvider = Provider.of<MainProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsetsDirectional.only(
          top: widget.index == 0 ? 16 : 8,
          bottom: widget.index == _mainProvider.users.length - 1 ? 16 : 8,
          start: 16,
          end: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.post.title!,
              style: AppStyles.bold(fontSize: 18),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              widget.post.body!,
              style: AppStyles.regular(),
            ),
          ],
        ),
      ),
    );
  }
}
