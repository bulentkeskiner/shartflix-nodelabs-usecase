import 'package:flutter/material.dart';

class ShimmerPlaceholder extends StatefulWidget {
  final double width;
  final double height;

  const ShimmerPlaceholder({this.width = double.infinity, this.height = 200, super.key});

  @override
  _ShimmerPlaceholderState createState() => _ShimmerPlaceholderState();
}

class _ShimmerPlaceholderState extends State<ShimmerPlaceholder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1500))
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment(-1.0 - 0.3 + _controller.value * 2, 0),
              end: Alignment(1.0 + 0.3 + _controller.value * 2, 0),
              colors: [Colors.grey.shade300, Colors.grey.shade100, Colors.grey.shade300],
              stops: [0.1, 0.5, 0.9],
            ).createShader(rect);
          },
          blendMode: BlendMode.srcATop,
          child: Container(
            width: widget.width,
            height: widget.height,
            color: Colors.grey.shade300,
          ),
        );
      },
    );
  }
}
