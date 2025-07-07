import 'dart:math';

class Util {
  static String generarContrasena({int longitud = 10}) {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#\$%^&*';
    final rand = Random.secure();
    return List.generate(
      longitud,
      (index) => chars[rand.nextInt(chars.length)],
    ).join();
  }

  static bool esEmailValido(String email) {
    final regex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }
}
