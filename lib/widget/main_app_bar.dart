import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key, required this.appBarObj, this.trailingBuilder, this.leadingBuilder});

  final AppBar appBarObj;
  final Widget Function(BuildContext)? trailingBuilder;
  final Widget Function(BuildContext)? leadingBuilder;


  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16, statusBarHeight+16, 16, 16),
      height: preferredSize.height + statusBarHeight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0, child: leadingBuilder != null ? leadingBuilder!(context) :  Container(),
          ),
          const Text("슬로스트 온리원"),
          Positioned(
              right: 0,
              child: trailingBuilder != null ? trailingBuilder!(context) : Container()),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarObj.preferredSize.height);
}
