import 'package:flutter/foundation.dart';

@immutable
class Produk {
  const Produk({
    required this.nama,
    required this.harga,
    required this.ikon,
  });
  
  final String nama;
  final int harga;
  final String ikon;
}

class ItemKeranjang {
  ItemKeranjang({required this.produk, this.jumlah = 1});
  
  final Produk produk;
  int jumlah;
}

class KeranjangModel extends ChangeNotifier {
  final Map<String, ItemKeranjang> _items = {};

  List<ItemKeranjang> get items => List.unmodifiable(_items.values);

  int get totalItem {
    return _items.values.fold(0, (total, item) => total + item.jumlah);
  }

  int get totalHarga {
    return _items.values.fold(
      0,
      (total, item) => total + (item.produk.harga * item.jumlah),
    );
  }

  void tambah(Produk produk) {
    final itemLama = _items[produk.nama];
    if (itemLama == null) {
      _items[produk.nama] = ItemKeranjang(produk: produk);
    } else {
      itemLama.jumlah++;
    }
    notifyListeners();
  }

  void kurangi(Produk produk) {
    final itemLama = _items[produk.nama];
    if (itemLama == null) return;
    
    if (itemLama.jumlah == 1) {
      _items.remove(produk.nama);
    } else {
      itemLama.jumlah--;
    }
    notifyListeners();
  }

  void kosongkan() {
    if (_items.isEmpty) return;
    _items.clear();
    notifyListeners();
  }
}