import 'package:flutter/widgets.dart';

/// Skeleton animation for for data loading
class Skeleton extends StatefulWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;
  final Color baseColor;
  final Color highlightColor;

  /// Retangular skeleton animation with default color
  const Skeleton.rectangular({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.baseColor = const Color(0xFFE0E0E0),
    this.highlightColor = const Color(0xFFF2F2F2),
    ShapeBorder? shapeBorder,
  }) : shapeBorder = shapeBorder ?? const RoundedRectangleBorder();

  /// Circular skeleton animation with default color
  const Skeleton.circular({
    super.key,
    required this.width,
    required this.height,
    this.shapeBorder = const CircleBorder(),
    this.baseColor = const Color(0xFFE0E0E0),
    this.highlightColor = const Color(0xFFF2F2F2),
  });

  @override
  State<Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
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
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: ShapeDecoration(
            shape: widget.shapeBorder,
            gradient: LinearGradient(
              begin: const Alignment(-1.0, -0.8),
              end: const Alignment(1.0, 0.8),
              colors: [
                widget.baseColor,
                widget.highlightColor,
                widget.baseColor,
              ],
              stops: [
                _controller.value - 0.3,
                _controller.value,
                _controller.value + 0.3,
              ],
            ),
          ),
        );
      },
    );
  }
}
