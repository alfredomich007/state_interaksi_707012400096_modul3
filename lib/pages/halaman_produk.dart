import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/keranjang_model.dart';

class HalamanProduk extends StatelessWidget {
  const HalamanProduk({super.key});

  static const daftarProduk = [
    Produk(nama: 'Nasi Goreng', harga: 15000, ikon: '🍲'), // Saya tambahkan emoji agar lebih menarik, sesuaikan jika perlu
    Produk(nama: 'Mie Ayam', harga: 13000, ikon: '🍜'),
    Produk(nama: 'Es Teh', harga: 5000, ikon: '🥤'),
  ];

  String rupiah(int nilai) {
    return 'Rp${nilai.toString()}';
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: daftarProduk.length,
      separatorBuilder: (context, indeks) => const SizedBox(height: 8),
      itemBuilder: (context, indeks) {
        final produk = daftarProduk[indeks];
        
        return Card(
          child: ListTile(
            leading: Text(
              produk.ikon,
              style: const TextStyle(fontSize: 32),
            ),
            title: Text(produk.nama),
            subtitle: Text(rupiah(produk.harga)),
            trailing: FilledButton(
              onPressed: () {
                // Penggunaan context.read() yang sangat tepat!
                context.read<KeranjangModel>().tambah(produk);
              },
              child: const Text('Tambah'),
            ),
          ),
        );
      },
    );
  }
}