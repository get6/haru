import 'package:flutter/material.dart';

import 'color/custom_color.dart';

class EmptyPage extends StatelessWidget {
  static const routeName = '/empty';
  final String title;
  final String subtitle;

  const EmptyPage({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: empty_color),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/nothing.png',
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.black54),
              ),
              Text(
                subtitle,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: Colors.black54),
              ),
            ],
          ),
          const SizedBox(height: 200),
        ],
      ),
    );
  }
}
