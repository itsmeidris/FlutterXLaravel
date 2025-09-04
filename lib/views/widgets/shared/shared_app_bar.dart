import 'package:flutter/material.dart';

class SharedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SharedAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: SizedBox.shrink(),
      title: Text("S T U D E N T S    A P I", style: TextStyle(fontSize: 27)),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(85);
}
