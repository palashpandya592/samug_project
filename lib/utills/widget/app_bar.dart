import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:samug_project/constant/app_colors.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Color? backgroundColor;
  final List<Widget>? action;
  final Widget? leading;
  final Color? containColor;
  final String? image;
  final String? image2;
  final VoidCallback? onPressed;
  final VoidCallback? onPressed2;
  final Color? color;
  final Color? color2;
  final bool? centerTitle;
  final double? horizontal;

  const CommonAppBar({
    Key? key,
    this.title,
    this.backgroundColor,
    this.leading,
    this.action,
    this.image,
    this.image2,
    this.onPressed,
    this.onPressed2,
    this.color,
    this.color2,
    this.containColor,
    this.centerTitle,
    this.horizontal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leadingWidth: 75,
      leading: InkWell(
        onTap: onPressed,
        child: leading ??
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                color: containColor ?? const Color.fromRGBO(0, 25, 33, 0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                onPressed: onPressed,
                icon: SvgPicture.asset(
                  image ?? '',
                  color: color,
                ),
              ),
            ),
      ),
      backgroundColor: backgroundColor ?? AppColors.white,
      centerTitle: centerTitle ?? true,
      actions: action ??
          [
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: horizontal ?? 20, vertical: 10),
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                  color: containColor ?? const Color.fromRGBO(0, 25, 33, 0.05),
                  borderRadius: BorderRadius.circular(8)),
              child: IconButton(
                onPressed: onPressed2,
                icon: SvgPicture.asset(
                  image2 ?? '',
                  color: color2,
                ),
              ),
            ),
          ],
      title: title ?? Container(),

    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(65);
}
