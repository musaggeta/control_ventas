import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:oktoast/oktoast.dart';
import 'firebase_options.dart';
import 'app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: OKToast(child: MyApp())));
}

//Correr solo la primera vez para crear al administrador, luego comentarlo todo
/*
Future<void> crearAdmin() async {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  try {
    final cred = await auth.createUserWithEmailAndPassword(
      email: 'admin@control.com',
      password: 'admin123',
    );
    await firestore.collection('usuarios').doc(cred.user!.uid).set({
      'uid': cred.user!.uid,
      'email': cred.user!.email,
      'nombre': 'Administrador',
      'rol': 'admin',
    });
    print('✅ Admin creado exitosamente');
  } catch (e) {
    print('⚠️ Error creando admin: $e');
  }
}
*/
