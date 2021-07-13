import 'package:flutter/material.dart';
import 'package:haru/home/widgets/today_add_page.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool _isHome;
  @override
  final Size preferredSize;
  MyAppBar({Key? key, bool? isHome})
      : preferredSize = const Size.fromHeight(50.0),
        _isHome = isHome ?? false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // leading: Icon(Icons.menu_book),
      backgroundColor: Colors.white,
      actions: [
        if (_isHome)
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context, builder: (context) => TodayAddModal());
            },
            icon: const Icon(Icons.add),
            splashRadius: Material.defaultSplashRadius / 2,
          )
      ],
      elevation: 0,
    );
  }
}
