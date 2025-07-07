import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _nombre = TextEditingController();
  bool _registrando = false;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Registrar nuevo usuario')),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('usuarios')
            .doc(user!.uid)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return const Center(child: CircularProgressIndicator());

          final data = snapshot.data!.data() as Map<String, dynamic>;
          if (data['rol'] != 'admin') {
            return const Center(child: Text('Acceso denegado'));
          }

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: _nombre,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                ),
                TextField(
                  controller: _email,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: _password,
                  decoration: const InputDecoration(labelText: 'Contraseña'),
                ),
                const SizedBox(height: 20),
                _registrando
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          setState(() => _registrando = true);
                          try {
                            final cred = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                  email: _email.text.trim(),
                                  password: _password.text.trim(),
                                );
                            await FirebaseFirestore.instance
                                .collection('usuarios')
                                .doc(cred.user!.uid)
                                .set({
                                  'uid': cred.user!.uid,
                                  'email': _email.text.trim(),
                                  'nombre': _nombre.text.trim(),
                                  'rol': 'usuario',
                                });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Usuario registrado correctamente',
                                ),
                              ),
                            );
                            _email.clear();
                            _password.clear();
                            _nombre.clear();
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: $e')),
                            );
                          }
                          setState(() => _registrando = false);
                        },
                        child: const Text('Registrar usuario'),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
