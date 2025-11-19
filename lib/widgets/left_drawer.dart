import 'package:flutter/material.dart';
import 'package:winner_sports/screens/menu.dart';
import 'package:winner_sports/screens/productslist_form.dart';
import 'package:winner_sports/screens/products_entry_list.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 156, 14, 116),
            ),
            child: Column(
              children: [
                Text(
                  'Winner Sports',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text("Seluruh produk terbaru ada di sini!",
                    // TODO: Tambahkan gaya teks dengan center alignment, font ukuran 15, warna putih, dan weight biasa
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                ),
              ],
            ),
          ),
          // TODO: Bagian routing
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            // Bagian redirection ke MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.post_add),
            title: const Text('Add Products'),
            // Bagian redirection ke ProductsFormPage
            onTap: () {
              /*
              TODO: Buatlah routing ke ProductsFormPage di sini,
              setelah halaman ProductsFormPage sudah dibuat.
              */
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductsFormPage(),
                  ));
            },
          ),
          // Add this ListTile in your drawer
          ListTile(
              leading: const Icon(Icons.add_reaction_rounded),
              title: const Text('Products List'),
              onTap: () {
                  // Route to products list page
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProductsEntryListPage()),
                  );
              },
          ),
        ],
      ),
    );
  }
}