import 'package:flutter/material.dart';

enum LoginState { idle, loading, success, error }

class AnimatedLoginButton extends StatefulWidget {
  final VoidCallback onPressed;
  final LoginState state;

  const AnimatedLoginButton({
    super.key,
    required this.onPressed,
    required this.state,
  });

  @override
  State<AnimatedLoginButton> createState() => _AnimatedLoginButtonState();
}

class _AnimatedLoginButtonState extends State<AnimatedLoginButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scale = Tween<double>(
      begin: 1,
      end: 1.3,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
    _rotation = Tween<double>(begin: 0, end: 3).animate(_controller);
  }

  @override
  void didUpdateWidget(covariant AnimatedLoginButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.state == LoginState.success) {
      _controller.forward(from: 0);
    } else if (widget.state == LoginState.error) {
      _controller.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = switch (widget.state) {
      LoginState.idle => Colors.blue,
      LoginState.loading => Colors.grey,
      LoginState.success => Colors.green,
      LoginState.error => Colors.red,
    };

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double rotationValue = widget.state == LoginState.error
            ? _rotation.value
            : 0;
        return Transform.scale(
          scale: _scale.value,
          child: Transform.rotate(
            angle: rotationValue,
            child: ElevatedButton(
              onPressed: widget.state == LoginState.loading
                  ? null
                  : widget.onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                widget.state == LoginState.loading
                    ? 'Ingresando...'
                    : widget.state == LoginState.success
                    ? '¡Bienvenido!'
                    : widget.state == LoginState.error
                    ? 'Error'
                    : 'Ingresar',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
