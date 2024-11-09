import 'package:flutter/material.dart';

class ButtonBase extends StatelessWidget {
  const ButtonBase({super.key, required this.onTap, required this.child});

  final void Function() onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,

      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: child,
      ),
    );
  }
}

class ButtonTemplate extends StatelessWidget {
  const ButtonTemplate({super.key, required this.title, required this.onTap, required this.isEnable});

  final String title;
  final void Function() onTap;
  final bool isEnable;

  @override
  Widget build(BuildContext context) {
    return ButtonBase(
      onTap: () {
        if (isEnable) {
          onTap();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isEnable ? Colors.blueAccent : Colors.black12
        ),
        alignment: Alignment.center,
        child: Text(title, style:  TextStyle(color: isEnable ? Colors.white : Colors.grey, fontSize: 18, fontWeight: FontWeight.w700),),
      ),
    );
  }
}
