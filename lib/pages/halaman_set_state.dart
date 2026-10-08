// lib/pages/halaman_set_state.dart
import 'package:flutter/material.dart';

class HalamanSetState extends StatefulWidget {
  const HalamanSetState({super.key});

  @override
  State<HalamanSetState> createState() => _HalamanSetStateState();
}

class _HalamanSetStateState extends State<HalamanSetState> {
  int _jumlahPesanan = 0;
  bool _kantinBuka = true;

  void _tambahPesanan() {
    setState(() {
      _jumlahPesanan++;
    });
  }

  void _kurangiPesanan() {
    if (_jumlahPesanan == 0) return;
    setState(() {
      _jumlahPesanan--;
    });
  }

  void _ubahStatusKantin(bool nilaiBaru) {
    setState(() {
      _kantinBuka = nilaiBaru;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Latihan setState'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text('Jumlah pesanan hari ini'),
                    Text(
                      '$_jumlahPesanan',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: _kurangiPesanan,
                          icon: const Icon(Icons.remove_circle_outline),
                        ),
                        const SizedBox(width: 12),
                        FilledButton.icon(
                          onPressed: _tambahPesanan,
                          icon: const Icon(Icons.add),
                          label: const Text('Tambah'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Kantin buka'),
              subtitle: Text(
                _kantinBuka ? 'Menerima pesanan' : 'Sedang tutup',
              ),
              value: _kantinBuka,
              onChanged: _ubahStatusKantin,
            ),
          ],
        ),
      ),
    );
  }
}