import 'package:flutter/material.dart';

class SubPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SubPageAppBar(
      {super.key,
      required this.appBarObj,
      required this.title,
      this.trailingBuilder,
      this.backgroundColor});

  final String title;
  final AppBar appBarObj;
  final Widget Function(BuildContext)? trailingBuilder;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
      color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.fromLTRB(16, statusBarHeight, 16, 0),
      height: preferredSize.height + statusBarHeight,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.chevron_left,
                color: Theme.of(context).colorScheme.primary,
                size: 30,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(title,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: trailingBuilder != null
                ? trailingBuilder!(context)
                : Container(),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarObj.preferredSize.height);
}
