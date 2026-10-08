import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/keranjang_model.dart';

class HalamanKeranjang extends StatelessWidget {
  const HalamanKeranjang({super.key});

  String rupiah(int nilai) {
    return 'Rp${nilai.toString()}';
  }

  @override
  Widget build(BuildContext context) {
    // Consumer akan membangun ulang (rebuild) bagian UI ini 
    // setiap kali ada pemanggilan notifyListeners() di KeranjangModel
    return Consumer<KeranjangModel>(
      builder: (context, keranjang, child) {
        // Kondisi jika keranjang kosong
        if (keranjang.items.isEmpty) {
          return const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.shopping_cart_outlined, size: 64),
                SizedBox(height: 12),
                Text('Keranjang masih kosong'),
              ],
            ),
          );
        }

        // Kondisi jika keranjang ada isinya
        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: keranjang.items.length,
                separatorBuilder: (context, indeks) => const Divider(),
                itemBuilder: (context, indeks) {
                  final item = keranjang.items[indeks];
                  
                  return ListTile(
                    title: Text(item.produk.nama),
                    subtitle: Text(
                      '${item.jumlah} x ${rupiah(item.produk.harga)}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => keranjang.kurangi(item.produk),
                          icon: const Icon(Icons.remove_circle_outline),
                        ),
                        Text('${item.jumlah}'),
                        IconButton(
                          onPressed: () => keranjang.tambah(item.produk),
                          icon: const Icon(Icons.add_circle_outline),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Total: ${rupiah(keranjang.totalHarga)}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    OutlinedButton.icon(
                      onPressed: keranjang.kosongkan,
                      icon: const Icon(Icons.delete_outline),
                      label: const Text('Kosongkan Keranjang'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}