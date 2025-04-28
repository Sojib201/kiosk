import 'package:flutter/material.dart';

import '../../../constants/app_constants.dart';

class AnimatedWidgetShower extends StatelessWidget {
  const AnimatedWidgetShower({
    super.key,
    required this.child,
    required this.size,
    this.padding = 6.0,
    this.color,
  });

  final Widget child;
  final double size;
  final double padding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: roundedRectangleBorder15,
      color: color ?? Colors.white,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: SizedBox(
          height: size,
          width: size,
          child: TweenAnimationBuilder(
            curve: Curves.easeOut,
            duration: kAnimationDuration(0.4),
            tween: Tween<double>(begin: 0, end: size),
            builder: (_, double x, __) {
              return Center(
                child: SizedBox(
                  height: x,
                  width: x,
                  child: child,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
