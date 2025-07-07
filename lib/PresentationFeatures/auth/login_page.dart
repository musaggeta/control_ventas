import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control_ventas/PresentationFeatures/home/pages/home_admin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oktoast/oktoast.dart';
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
            Future.delayed(const Duration(milliseconds: 800), () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const HomeAdminPage()),
              );
            });
            ;
          }
        },
        error: (error, _) {
          setState(() => _loginState = LoginState.error);

          showToast(
            "❗ Intenta de nuevo",
            position: ToastPosition.top,
            backgroundColor: Colors.black.withOpacity(0.7),
            radius: 8.0,
            textPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 10.0,
            ),
          );
          ;

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error.toString())));

          Future.delayed(const Duration(seconds: 2), () {
            setState(() => _loginState = LoginState.idle);
          });
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

      // Creamos un boton de apoyo para crear el usuario admin, luego de implementarlo, comentar esta seccion
      /*floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final auth = FirebaseAuth.instance;
          final firestore = FirebaseFirestore.instance;

          try {
            final cred = await auth.createUserWithEmailAndPassword(
              email: 'admin@control.com',
              password: 'admin123',
            );
            await firestore.collection('usuarios').doc(cred.user!.uid).set({
              'uid': cred.user!.uid,
              'email': 'admin@control.com',
              'nombre': 'Administrador',
              'rol': 'admin',
            });
            showToast("✅ Admin creado correctamente");
          } catch (e) {
            showToast("❌ Error al crear admin: $e");
          }
        },
        child: const Icon(Icons.admin_panel_settings),
      ),*/
    );
  }
}
