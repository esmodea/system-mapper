import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class TextWithBlank extends StatefulWidget {
  final bool isBlank;
  final Color blankColor;
  final String text;
  final TextStyle? style;
  final Color shimmerColor;
  final double shimmerColorOpacity;
  final Duration shimmerDuration;
  final Duration shimmerInterval;
  final ShimmerDirection shimmerDirection;
  const TextWithBlank({
    super.key,
    required this.text,
    this.isBlank = false,
    this.blankColor = Colors.transparent,
    this.style,
    this.shimmerColor = Colors.white,
    this.shimmerColorOpacity = 0.3,
    this.shimmerDuration = const Duration(seconds: 1),
    this.shimmerInterval = const Duration(seconds: 0),
    this.shimmerDirection = const ShimmerDirection.fromLTRB(),
  });

  @override
  State<TextWithBlank> createState() => _TextWithBlankState();
}

class _TextWithBlankState extends State<TextWithBlank> {
  @override
  Widget build(BuildContext context) {
    if (widget.isBlank) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: widget.blankColor,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Shimmer(
            color: widget.shimmerColor,
            colorOpacity: widget.shimmerColorOpacity,
            duration: widget.shimmerDuration,
            interval: widget.shimmerInterval,
            direction: widget.shimmerDirection,
            child: Opacity(
              opacity: 0,
              child: Text(widget.text, style: widget.style),
            ),
          ),
        ),
      );
    }
    return Text(widget.text, style: widget.style);
  }
}
