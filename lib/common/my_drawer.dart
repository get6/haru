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
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => Navigator.pushNamed(context, Routes.home)),
        ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Histories'),
            onTap: () => Navigator.pushNamed(context, Routes.histories)),
        ListTile(
          leading: const Icon(Icons.timer),
          title: const Text('Timer'),
          onTap: () => Navigator.pushNamed(context, Routes.timer),
        ),
        ListTile(
          leading: const Icon(Icons.note),
          title: const Text('Note'),
          onTap: () => Navigator.pushNamed(context, Routes.notes),
        ),
        const Divider(thickness: 1),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () => Navigator.pushNamed(context, Routes.settings),
        )
      ],
    ));
  }
}
