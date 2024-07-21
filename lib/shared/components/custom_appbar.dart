import 'package:flutter/material.dart';
import 'package:toyota/utils/colors.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    this.title,
    this.bottom,
    this.actions,
    this.leading,
    this.onSearch,
    this.haveNotification,
    this.hasPresident = false,
  });

  final Widget? title;
  final Widget? leading;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;
  final VoidCallback? onSearch;
  final bool? haveNotification;
  final bool hasPresident;

  @override
  get preferredSize => bottom != null ? Size.fromHeight(hasPresident ? 90 : 60 + bottom!.preferredSize.height) : Size.fromHeight(hasPresident ? 90 : 60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: GeneralColors.primaryBGColor,
      centerTitle: true,
      elevation: 0,
      titleSpacing: 0,
      leading: leading,
      title: title ??
          Image.asset(
            "assets/images/logo.png",
            width: 150,
          ),
      actions: actions ?? [],
      bottom: PreferredSize(
        preferredSize: Size(100, 5),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 1,
          color: GeneralColors.grayColor,
        ),
      ),
    );
  }
}
