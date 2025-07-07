import 'package:control_ventas/data/remote/firebase_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<User?>>((ref) {
      return AuthController();
    });

class AuthController extends StateNotifier<AsyncValue<User?>> {
  AuthController() : super(const AsyncValue.data(null));

  final _auth = FirebaseAuth.instance;

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseService()
          .syncDesdeFirestore(); // sincronizar luego del login
      state = AsyncValue.data(result.user);
    } on FirebaseAuthException catch (e) {
      state = AsyncValue.error(
        e.message ?? 'Error desconocido',
        StackTrace.current,
      );
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    state = const AsyncValue.data(null);
  }
}
