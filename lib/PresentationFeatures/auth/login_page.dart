import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_controller.dart';
import '../../widgets/animated_login_button.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  LoginState _loginState = LoginState.idle;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    ref.listen(authControllerProvider, (prev, next) {
      next.whenOrNull(
        data: (user) {
          if (user != null) {
            setState(() => _loginState = LoginState.success);
            Future.delayed(const Duration(seconds: 1), () {
              // TODO: Navegar a home
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Ingreso exitoso.')));
            });
          }
        },
        error: (error, _) {
          setState(() => _loginState = LoginState.error);
        },
        loading: () {
          setState(() => _loginState = LoginState.loading);
        },
      );
    });

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWide = constraints.maxWidth > 600;
          return Center(
            child: Container(
              padding: const EdgeInsets.all(24),
              width: isWide ? 400 : double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Iniciar Sesión', style: TextStyle(fontSize: 28)),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Contraseña'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 24),
                  AnimatedLoginButton(
                    onPressed: () {
                      ref
                          .read(authControllerProvider.notifier)
                          .login(
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                          );
                    },
                    state: _loginState,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
