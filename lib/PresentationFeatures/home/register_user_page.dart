import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

import '../../../core/util/util.dart';

class RegisterUserPage extends StatefulWidget {
  const RegisterUserPage({super.key});

  @override
  State<RegisterUserPage> createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
  final _emailController = TextEditingController();
  final _nombreController = TextEditingController();
  String _rolSeleccionado = 'adquisidor';

  final _formKey = GlobalKey<FormState>();
  bool _enviando = false;
  String? _passwordGenerada;

  Future<void> _registrarUsuario() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _enviando = true;
      _passwordGenerada = null;
    });

    final email = _emailController.text.trim();
    final nombre = _nombreController.text.trim();
    final password = Util.generarContrasena();

    try {
      final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(cred.user!.uid)
          .set({
            'uid': cred.user!.uid,
            'email': email,
            'nombre': nombre,
            'rol': _rolSeleccionado,
          });

      setState(() => _passwordGenerada = password);
      showToast('✅ Usuario registrado');
    } catch (e) {
      showToast('❌ Error: $e');
    } finally {
      setState(() => _enviando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text('Registrar nuevo usuario', style: TextStyle(fontSize: 24)),
          const SizedBox(height: 16),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nombreController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  validator: (val) =>
                      val == null || val.isEmpty ? 'Ingrese nombre' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Correo'),
                  validator: (val) {
                    if (val == null || val.isEmpty) return 'Ingrese email';
                    if (!Util.esEmailValido(val)) return 'Email inválido';
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _rolSeleccionado,
                  items: const [
                    DropdownMenuItem(
                      value: 'adquisidor',
                      child: Text('Adquisidor'),
                    ),
                    DropdownMenuItem(
                      value: 'vendedor',
                      child: Text('Vendedor'),
                    ),
                  ],
                  onChanged: (val) {
                    setState(() => _rolSeleccionado = val!);
                  },
                  decoration: const InputDecoration(labelText: 'Rol'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _enviando ? null : _registrarUsuario,
            icon: const Icon(Icons.person_add),
            label: Text(_enviando ? 'Registrando...' : 'Registrar'),
          ),
          if (_passwordGenerada != null) ...[
            const SizedBox(height: 16),
            Text(
              'Contraseña generada: $_passwordGenerada',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ],
      ),
    );
  }
}
