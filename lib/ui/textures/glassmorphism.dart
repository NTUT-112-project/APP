import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GlassMorphism extends StatelessWidget{
  const GlassMorphism({
    Key? key,
    required this.blur,
    required this.opacity,
    required this.child
  }):super(key: key);

  final double blur;
  final double opacity;
  final Widget child;

  @override
  Widget build(BuildContext context){
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),

      child:BackdropFilter(
        filter: ImageFilter.,
      ),
    );
  }
}