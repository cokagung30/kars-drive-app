import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SlideTransitionPage extends CustomTransitionPage<void> {
  SlideTransitionPage({
    required super.child,
  }) : super(
         transitionsBuilder: (c, animation, a2, child) {
           const begin = Offset(1, 0);

           const end = Offset.zero;

           final tween = Tween(begin: begin, end: end).chain(_curveTween);

           final offsetAnimation = animation.drive(tween);

           return SlideTransition(position: offsetAnimation, child: child);
         },
         transitionDuration: const Duration(milliseconds: 400),
       );

  static final _curveTween = CurveTween(curve: Curves.easeIn);
}

class SlideRightTransitionPage extends CustomTransitionPage<void> {
  SlideRightTransitionPage({
    required super.child,
  }) : super(
         transitionsBuilder: (c, animation, a2, child) {
           const begin = Offset(-1, 0);

           const end = Offset.zero;

           final tween = Tween(begin: begin, end: end).chain(_curveTween);

           final offsetAnimation = animation.drive(tween);

           return SlideTransition(position: offsetAnimation, child: child);
         },
         transitionDuration: const Duration(milliseconds: 400),
       );

  static final _curveTween = CurveTween(curve: Curves.easeIn);
}

class SlideUpTransitionPage extends CustomTransitionPage<void> {
  SlideUpTransitionPage({
    required super.child,
  }) : super(
         transitionsBuilder: (c, animation, a2, child) {
           const begin = Offset(0, 1);

           const end = Offset.zero;

           final tween = Tween(begin: begin, end: end).chain(_curveTween);

           final offsetAnimation = animation.drive(tween);

           return SlideTransition(position: offsetAnimation, child: child);
         },
         transitionDuration: const Duration(milliseconds: 400),
       );

  static final _curveTween = CurveTween(curve: Curves.easeOutBack);
}
