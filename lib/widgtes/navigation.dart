import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void navigationPageTransition(
    {required BuildContext context, required Widget screen}) {
  Navigator.push(
    context,
    PageTransition(
        duration: const Duration(milliseconds: 300),
        type: PageTransitionType.fade,
        child: screen),
  );
}
