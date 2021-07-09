import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TodayListView extends StatelessWidget {
  final length = 24;
  const TodayListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: length,
      itemBuilder: (context, index) {
        return TimelineTile(
          startChild: Center(child: Text('$index : 00')),
          alignment: TimelineAlign.manual,
          lineXY: 0.2,
          isFirst: index == 0,
          isLast: index == length - 1,
          indicatorStyle: IndicatorStyle(
            color: Theme.of(context).primaryColor,
            drawGap: true,
          ),
          beforeLineStyle: LineStyle(color: Theme.of(context).primaryColor),
          endChild: Text('data'),
        );
      },
    );
  }
}

class _IndicatorExample extends StatelessWidget {
  const _IndicatorExample({Key? key, required this.number}) : super(key: key);

  final String number;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.fromBorderSide(
          BorderSide(
            color: Colors.white.withOpacity(0.2),
            width: 4,
          ),
        ),
      ),
      child: Center(
        child: Text(
          number,
          style: const TextStyle(fontSize: 10),
        ),
      ),
    );
  }
}
