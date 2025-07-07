import 'package:control_ventas/PresentationFeatures/auth/auth_controller.dart';
import 'package:control_ventas/PresentationFeatures/home/pages/edit_profile_page.dart';
import 'package:control_ventas/PresentationFeatures/home/register_user_page.dart';
import 'package:control_ventas/PresentationFeatures/sales/pages/sales_pages.dart';
import 'package:control_ventas/PresentationFeatures/sales/sales_form.dart';
//import 'package:control_ventas/features/purchases/pages/purchases_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeAdminPage extends ConsumerStatefulWidget {
  const HomeAdminPage({super.key});

  @override
  ConsumerState<HomeAdminPage> createState() => _HomeAdminPageState();
}

class _HomeAdminPageState extends ConsumerState<HomeAdminPage> {
  int selectedIndex = 0;

  final List<String> titles = [
    'Resumen',
    'Editar Perfil',
    'Registrar Usuario',
    'Ventas',
    'Compras',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titles[selectedIndex])),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menú Administrador',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Resumen'),
              onTap: () => _selectPage(0),
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Editar Perfil'),
              onTap: () => _selectPage(1),
            ),
            ListTile(
              leading: const Icon(Icons.person_add),
              title: const Text('Registrar Usuario'),
              onTap: () => _selectPage(2),
            ),
            ListTile(
              leading: const Icon(Icons.add_shopping_cart),
              title: const Text('Registrar venta'),
              onTap: () {
                Navigator.pop(context); // Cierra el drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const VentaForm()),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Compras'),
              onTap: () => _selectPage(4),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar Sesión'),
              onTap: () async {
                Navigator.of(context).pop();
                await ref.read(authControllerProvider.notifier).logout();
                Navigator.of(context).pushReplacementNamed('/login');
              },
            ),
          ],
        ),
      ),
      body: _buildPage(selectedIndex),
    );
  }

  void _selectPage(int index) {
    setState(() {
      selectedIndex = index;
    });
    Navigator.of(context).pop(); // Cierra el Drawer
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const Center(
          child: Text('Resumen general de compras y ventas del mes/año'),
        );
      case 1:
        return const EditProfilePage();
      case 2:
        return const RegisterUserPage();
      case 3:
        return const SalesPage();
      /* case 4:
        return const PurchasesPage();*/
      default:
        return const Center(child: Text('Página no encontrada'));
    }
  }
}
