import 'package:cached_network_image/cached_network_image.dart';
import 'package:floward_task/generated/l10n.dart';
import 'package:floward_task/providers/main_provider.dart';
import 'package:floward_task/utils/app_styles.dart';
import 'package:floward_task/utils/arg_keys.dart';
import 'package:floward_task/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserWidget extends StatefulWidget {
  final int index;
  const UserWidget({Key? key, required this.index}) : super(key: key);

  @override
  State<UserWidget> createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  late MainProvider _mainProvider;

  @override
  void didChangeDependencies() {
    _mainProvider = Provider.of<MainProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.postsRoute, arguments: {
          ArgumentKeys.userId: _mainProvider.users[widget.index].userId!
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        elevation: 4,
        margin: EdgeInsetsDirectional.only(
            top: widget.index == 0 ? 16 : 8,
            bottom: widget.index == _mainProvider.users.length - 1 ? 16 : 8,
            start: 16,
            end: 16),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey,
                foregroundImage: CachedNetworkImageProvider(
                    _mainProvider.users[widget.index].thumbnailUrl!),
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _mainProvider.users[widget.index].name!,
                    style: AppStyles.bold(fontSize: 18),
                  ),
                  RichText(
                    text: TextSpan(
                      text: '${S.of(context).postsCount} ',
                      style: AppStyles.bold(),
                      children: [
                        TextSpan(
                          text:
                              '${_mainProvider.getUserPostCount(_mainProvider.users[widget.index].userId!).toString()} ${S.of(context).posts}',
                          style: AppStyles.regular(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
