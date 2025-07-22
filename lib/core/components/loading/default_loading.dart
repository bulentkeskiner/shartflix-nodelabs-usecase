import 'package:flutter/material.dart';

class DefaultLoading extends StatelessWidget {
  final double? size;

  const DefaultLoading({this.size = 40, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: size,
          height: size,
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
