import 'package:flutter/material.dart';

/// A wrapper that animates its child into view with a fade and slide effect.
class FadeInSlide extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final double offset;

  const FadeInSlide({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
    this.offset = 30.0,
  }) : super(key: key);

  @override
  _FadeInSlideState createState() => _FadeInSlideState();
}

class _FadeInSlideState extends State<FadeInSlide>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _translateY;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _translateY = Tween<double>(begin: widget.offset, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
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
        return Opacity(
          opacity: _opacity.value,
          child: Transform.translate(
            offset: Offset(0, _translateY.value),
            child: widget.child,
          ),
        );
      },
    );
  }
}

/// A wrapper that adds a bouncy scale effect when pressed.
class BouncyWrapper extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;

  const BouncyWrapper({
    Key? key,
    required this.child,
    this.onTap,
  }) : super(key: key);

  @override
  _BouncyWrapperState createState() => _BouncyWrapperState();
}

class _BouncyWrapperState extends State<BouncyWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));

    _scale = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap?.call();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scale.value,
            child: widget.child,
          );
        },
      ),
    );
  }
}
