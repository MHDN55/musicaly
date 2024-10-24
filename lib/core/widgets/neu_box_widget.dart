// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class NeuBox extends StatelessWidget {
  final double? height;
  final Widget? child;
  final double? width;
  
  const NeuBox({
    super.key,
    required this.child,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.tertiary,
            blurRadius: 10,
            offset: const Offset(4, 4),
          ),
          // BoxShadow(
          //   color: Theme.of(context).colorScheme.tertiaryContainer,
          //   blurRadius: 10,
          //   offset: const Offset(-4, -4),
          // ),
        ],
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: child,
    );
  }
}
