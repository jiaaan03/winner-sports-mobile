
import 'package:flutter/material.dart';
import 'package:winner_sports/models/products_entry.dart';
import 'package:winner_sports/widgets/products_entry_card.dart';
import 'package:winner_sports/widgets/left_drawer.dart';
import 'package:winner_sports/screens/products_detail.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ProductsEntryListPage extends StatefulWidget {
  final bool isMyProducts;
  const ProductsEntryListPage({super.key, this.isMyProducts = false});

  @override
  State<ProductsEntryListPage> createState() => _ProductsEntryListPageState();
}

class _ProductsEntryListPageState extends State<ProductsEntryListPage> {
  Future<List<ProductsEntry>> fetchProducts(CookieRequest request) async {
    // URL disesuaikan berdasarkan isMyProducts
    String url;

    if (widget.isMyProducts) {
      // Endpoint Django untuk My Products (Membutuhkan Sesi Login)
      url = 'http://127.0.0.1:8000/my-json/'; 
    } else {
      // Endpoint Django untuk All Products
      url = 'http://127.0.0.1:8000/json/';
    }
    
    // Melakukan GET request. CookieRequest secara otomatis membawa cookie sesi.
    final response = await request.get(url);
    
    // Decode response to json format
    var data = response;
    
    // Convert json data to ProductsEntry objects
    List<ProductsEntry> listProducts = [];
    for (var d in data) {
      if (d != null) {
        // Menggunakan ProductsEntry.fromJson untuk mapping data
        listProducts.add(ProductsEntry.fromJson(d));
      }
    }
    return listProducts;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        // Judul disesuaikan untuk kejelasan
        title: Text(widget.isMyProducts ? 'My Products List' : 'All Products List'),
        backgroundColor: Color.fromARGB(255, 156, 14, 116),
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchProducts(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      widget.isMyProducts 
                        ? 'You have not created any products yet.' 
                        : 'There are no products available yet.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20, color: Color(0xff59A5D8)),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => ProductsEntryCard(
                  products: snapshot.data![index],
                  onTap: () {
                    // Navigasi ke ProductsDetailPage saat kartu diklik
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductsDetailPage(
                          products: snapshot.data![index],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }
        },
      ),
    );
  }
}