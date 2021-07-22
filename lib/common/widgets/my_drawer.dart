import 'package:flutter/material.dart';
import 'package:haru/routes/routes.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        SizedBox(
          height: 100,
          child: DrawerHeader(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Stack(
              children: const <Widget>[
                Positioned(
                  bottom: 12.0,
                  left: 16.0,
                  child: Text(
                    "하루, Haru",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text('Home'),
          onTap: () => ModalRoute.of(context)!.settings.name == Routes.home
              ? Navigator.of(context).pop()
              : Navigator.popAndPushNamed(context, Routes.home),
        ),
        ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Histories'),
            onTap: () => Navigator.popAndPushNamed(context, Routes.histories)),
        ListTile(
          leading: const Icon(Icons.timer),
          title: const Text('Timer'),
          onTap: () => Navigator.popAndPushNamed(context, Routes.timer),
        ),
        ListTile(
          leading: const Icon(Icons.sticky_note_2_outlined),
          title: const Text('Note'),
          onTap: () => Navigator.popAndPushNamed(context, Routes.notes),
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('About Us'),
          onTap: () => Navigator.popAndPushNamed(context, Routes.about),
        ),
        const Divider(thickness: 1),
        ListTile(
          leading: const Icon(Icons.settings_outlined),
          title: const Text('Settings'),
          onTap: () => Navigator.popAndPushNamed(context, Routes.settings),
        )
      ],
    ));
  }
}
