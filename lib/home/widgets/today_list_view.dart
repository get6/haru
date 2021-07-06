import 'package:flutter/material.dart';

class TodayListView extends StatelessWidget {
  const TodayListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(index.toString()),
          subtitle: Text(index.toString()),
          onTap: () => {},
        );
      },
    );
  }
}
