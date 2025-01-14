import 'package:flutter/material.dart';
import 'package:travelapp_project/Features/core/theme/utils_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final TextStyle? style;
  final List<Widget>? actions;
  final Widget? leading;
  final Color backgroundColor;
  final double elevation;
  final double toolbarHeight;
  final double titleSpacing;
  final bool automaticallyImplyLeading;

  const CustomAppBar({
    required this.title,
    this.style,
    this.actions,
    this.leading,
    this.backgroundColor = App2,
    this.elevation = 4.0,
    this.toolbarHeight = 80.0,
    this.titleSpacing = 20.0,
    this.automaticallyImplyLeading = false,
    Key? key,
    required IconThemeData iconTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: style ??
            const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
      ),
      actions: actions,
      leading: leading,
      backgroundColor: backgroundColor,
      elevation: elevation,
      toolbarHeight: toolbarHeight,
      titleSpacing: titleSpacing,
      automaticallyImplyLeading: automaticallyImplyLeading,
      iconTheme: IconThemeData(
        color: whitecolor, // Change this to your desired color
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}
