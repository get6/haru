import 'package:flutter/material.dart';
import 'package:haru/common/color/custom_color.dart';

class AnimatedClockIcon extends StatelessWidget {
  const AnimatedClockIcon({
    Key? key,
    required this.unit,
    required this.icon,
  }) : super(key: key);

  final double unit;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1.5 * unit),
      child: Center(
        child: ClipOval(
          child: AspectRatio(
            aspectRatio: 1,
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Transform.translate(
                offset: Offset(7 * unit, 3 * unit),
                child: Center(
                  child: AnimatedSwitcher(
                      duration: Duration(seconds: 2),
                      switchInCurve: Curves.easeInOut,
                      switchOutCurve: Curves.easeInOut,
                      transitionBuilder: (child, anim) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(1, 0),
                            end: Offset.zero,
                          ).animate(anim),
                          child: FadeTransition(
                            opacity: anim,
                            child: child,
                          ),
                        );
                      },
                      child: Icon(
                        icon,
                        size: 17 * unit,
                        color: Colors.grey[400]!.withOpacity(0.1),
                        // color: button_color,
                        key: ValueKey(icon),
                      )),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
