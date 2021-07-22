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
      child: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 1.8,
          child: Column(
            children: [
              Image.asset(
                'assets/images/nothing.png',
                fit: BoxFit.cover,
              ),
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
        ),
      ),
    );
  }
}
