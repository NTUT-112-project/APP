import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GlassMorphism extends StatelessWidget{
  const GlassMorphism({
    Key? key,
    required this.color,
    required this.blur,
    required this.opacity,
    required this.child
  }):super(key: key);

  final Color color;
  final double blur;
  final double opacity;
  final Widget child;

  @override
  Widget build(BuildContext context){
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),

      child:BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur,sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            color: color.withOpacity(opacity),
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            border: Border.all(
              width: 1.5,
              color: color.withOpacity(0.2),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}