import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/keranjang_model.dart';
import 'pages/halaman_keranjang.dart';
import 'pages/halaman_produk.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      // KeranjangModel dibuat sekali di root aplikasi
      create: (context) => KeranjangModel(),
      child: const AplikasiKantin(),
    ),
  );
}

class AplikasiKantin extends StatelessWidget {
  const AplikasiKantin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kantin Kampus',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),
        useMaterial3: true,
      ),
      home: const KerangkaUtama(),
    );
  }
}

class KerangkaUtama extends StatefulWidget {
  const KerangkaUtama({super.key});

  @override
  State<KerangkaUtama> createState() => _KerangkaUtamaState();
}

class _KerangkaUtamaState extends State<KerangkaUtama> {
  // State lokal untuk menentukan halaman yang aktif
  int _indeks = 0;

  static const _halaman = [
    HalamanProduk(),
    HalamanKeranjang(),
  ];

  @override
  Widget build(BuildContext context) {
    // Membaca jumlah item dari Provider
    final totalItem = context.select<KeranjangModel, int>(
      (model) => model.totalItem,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _indeks == 0
              ? 'Menu Kantin'
              : 'Keranjang ($totalItem)',
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      // Menampilkan halaman sesuai menu yang dipilih
      body: IndexedStack(
        index: _indeks,
        children: _halaman,
      ),

      // Navbar bagian bawah
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.green,
        indicatorColor: Colors.white,

        selectedIndex: _indeks,

        // Mengatur warna tulisan Produk dan Keranjang
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(
            color: Colors.white,
          ),
        ),

        onDestinationSelected: (nilaiBaru) {
          // Mengubah halaman menggunakan setState
          setState(() {
            _indeks = nilaiBaru;
          });
        },

        destinations: const [
          NavigationDestination(
            icon: Icon(
              Icons.restaurant_menu,
              color: Colors.white,
            ),
            selectedIcon: Icon(
              Icons.restaurant_menu,
              color: Colors.green,
            ),
            label: 'Produk',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
            ),
            selectedIcon: Icon(
              Icons.shopping_cart,
              color: Colors.green,
            ),
            label: 'Keranjang',
          ),
        ],
      ),
    );
  }
}