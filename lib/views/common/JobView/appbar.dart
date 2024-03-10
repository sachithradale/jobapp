import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class JAppBar extends StatelessWidget implements PreferredSizeWidget {
  const JAppBar({
    Key? key,
    this.title,
    required this.showBackArrow,
    this.leadingIcon,
    this.actions,
    this.leadingOnpressed,
  }) : super(key: key);

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnpressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.0),
      child: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: showBackArrow
            ? IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Iconsax.arrow_left),
        )
            : IconButton(
          onPressed: leadingOnpressed,
          icon: Icon(leadingIcon),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start, // Align to the start
          children: [
            Expanded(child: title ?? Container()), // Use Expanded to ensure the title takes up remaining space
          ],
        ),
        actions: actions,

      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
