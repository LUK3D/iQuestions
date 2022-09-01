import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_icon/svg_icon.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({
    Key? key,
    required this.icon,
    this.iconColor,
    required this.onClick,
    required this.tittle,
    required this.description,
    this.iconWidget,
    this.onDismiss,
    this.totaQuestions,
  }) : super(key: key);

  final String? icon;
  final Widget? iconWidget;
  final Color? iconColor;
  final Function onClick;
  final String tittle;
  final String description;
  final Function? onDismiss;
  final int? totaQuestions;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (val) {
        if (onDismiss != null) {
          onDismiss!();
        }
      },
      key: UniqueKey(),
      child: Container(
        height: 70,
        width: Get.width,
        margin: EdgeInsets.only(bottom: 20),
        child: TextButton.icon(
            onPressed: () {
              onClick();
            },
            style: TextButton.styleFrom(
                primary: Colors.white,
                alignment: Alignment.centerLeft,
                backgroundColor: Colors.white.withOpacity(0.2)),
            icon: iconWidget ??
                SvgIcon(
                  icon!,
                  width: 40,
                  height: 40,
                  color: iconColor ?? Colors.white,
                ),
            label: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tittle +
                    (totaQuestions != null ? ' (${totaQuestions})' : '')),
                Text(
                  description,
                  style: TextStyle(fontWeight: FontWeight.w300),
                )
              ],
            )),
      ),
    );
  }
}
