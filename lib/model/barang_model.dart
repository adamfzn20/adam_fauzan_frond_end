class Barang {
  final int? id;
  final String namaBarang;
  final int kategoriId;
  final int stok;
  final String kelompokBarang;
  final double harga;

  Barang({
    this.id,
    required this.namaBarang,
    required this.kategoriId,
    required this.stok,
    required this.kelompokBarang,
    required this.harga,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama_barang': namaBarang,
      'kategori_id': kategoriId,
      'stok': stok,
      'kelompok_barang': kelompokBarang,
      'harga': harga,
    };
  }
}
