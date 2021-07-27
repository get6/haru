import 'package:flutter/material.dart';

import 'animated_page_flip_builder.dart';

class PageFlipBuilder extends StatefulWidget {
  final WidgetBuilder frontBuilder;
  final WidgetBuilder backBuilder;
  final Duration nonInteractiveAnimationDuration;
  final bool interactiveFlipEnabled;
  final Axis flipAxis;
  final double maxTilt;
  final double maxScale;

  const PageFlipBuilder({
    Key? key,
    required this.frontBuilder,
    required this.backBuilder,
    this.nonInteractiveAnimationDuration = const Duration(milliseconds: 500),
    this.interactiveFlipEnabled = true,
    this.flipAxis = Axis.horizontal,
    this.maxTilt = 0.003,
    this.maxScale = 0.2,
  }) : super(key: key);

  @override
  PageFlipBuilderState createState() => PageFlipBuilderState();
}

class PageFlipBuilderState extends State<PageFlipBuilder>
    with SingleTickerProviderStateMixin {
  bool _showFrontSide = true;
  bool _wasFrontSide = true;
  late final AnimationController _controller;

  void _handleDragStart(DragStartDetails details) {
    _wasFrontSide = _showFrontSide;
  }

  void _handleDragUpdate(DragUpdateDetails details, double crossAxisLength) {
    _controller.value += details.primaryDelta! / crossAxisLength;
  }

  void _handleDragEnd(DragEndDetails details, double crossAxisLength) {
    if (_controller.isAnimating ||
        _controller.status == AnimationStatus.completed ||
        _controller.status == AnimationStatus.dismissed) return;

    const velocityThreshold = 2.0;
    final velocity = widget.flipAxis == Axis.horizontal
        ? details.velocity.pixelsPerSecond.dx
        : details.velocity.pixelsPerSecond.dy;
    final flingVelocity = velocity / crossAxisLength;

    // if value and velocity are 0, the gesture was a tap so we return early
    if (_controller.value == 0.0 && flingVelocity == 0.0) {
      return;
    }

    if (_controller.value > 0.5 ||
        _controller.value > 0.0 && flingVelocity > velocityThreshold) {
      _controller.fling(velocity: velocityThreshold);
    } else if (_controller.value < -0.5 ||
        _controller.value < 0.0 && flingVelocity < -velocityThreshold) {
      _controller.fling(velocity: -velocityThreshold);
    } else if (_controller.value > 0.0 ||
        _controller.value > 0.5 && flingVelocity < -velocityThreshold) {
      // controller can't fling to 0.0 because the lowerBound is -1.0
      // so we decrement the value by 1.0 and toggle the state to get the same effect
      _controller.value -= 1.0;
      setState(() => _showFrontSide = !_showFrontSide);
      _controller.fling(velocity: -velocityThreshold);
    } else if (_controller.value > -0.5 ||
        _controller.value < -0.5 && flingVelocity > velocityThreshold) {
      // controller can't fling to 0.0 because the upperBound is 1.0
      // so we increment the value by 1.0 and toggle the state to get the same effect
      _controller.value += 1.0;
      setState(() => _showFrontSide = !_showFrontSide);
      _controller.fling(velocity: velocityThreshold);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      // lowerBound of -1.0 is needed for the back flip
      lowerBound: -1.0,
      // upperBound of 1.0 is needed for the front flip
    );
    _controller.value = 0.0;
    _controller.addStatusListener(_updateStatus);
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_updateStatus);
    _controller.dispose();
    super.dispose();
  }

  void _updateStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed ||
        status == AnimationStatus.dismissed) {
      _controller.value = 0.0;
      setState(() => _showFrontSide = !_showFrontSide);
      if (_wasFrontSide != _showFrontSide) {
        _wasFrontSide = _showFrontSide;
      }
    }
  }

  void flip() {
    if (_showFrontSide) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isHorizontal = widget.flipAxis == Axis.horizontal;
    return LayoutBuilder(
      builder: (_, constraints) {
        final crossAxisLength =
            isHorizontal ? constraints.maxWidth : constraints.maxHeight;
        return GestureDetector(
          onHorizontalDragStart: widget.interactiveFlipEnabled && isHorizontal
              ? (details) => _handleDragStart(details)
              : null,
          onHorizontalDragUpdate: widget.interactiveFlipEnabled && isHorizontal
              ? (details) => _handleDragUpdate(details, crossAxisLength)
              : null,
          onHorizontalDragEnd: widget.interactiveFlipEnabled && isHorizontal
              ? (details) => _handleDragEnd(details, crossAxisLength)
              : null,
          child: AnimatedPageFlipBuilder(
              animation: _controller,
              frontBuilder: widget.frontBuilder,
              backBuilder: widget.backBuilder,
              showFrontSide: _showFrontSide,
              flipAxis: widget.flipAxis,
              maxTilt: widget.maxTilt,
              maxScale: widget.maxScale),
        );
      },
    );
  }
}
