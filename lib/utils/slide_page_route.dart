import 'package:flutter/material.dart';

class SlidePageRoute extends PageRouteBuilder {
  final Widget page;

  SlidePageRoute({required this.page})
    : super(
        transitionDuration: const Duration(milliseconds: 250),
        reverseTransitionDuration: const Duration(milliseconds: 250),
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final inTween = Tween<Offset>(
            begin: const Offset(1.0, 0.0), // full right
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeOutCubic));

          final outTween = Tween<Offset>(
            begin: Offset.zero,
            end: const Offset(-0.3, 0.0),
          ).chain(CurveTween(curve: Curves.easeOutCubic));

          return SlideTransition(
            position: animation.drive(inTween),
            child: SlideTransition(
              position: secondaryAnimation.drive(outTween),
              child: child,
            ),
          );
        },
      );
}
