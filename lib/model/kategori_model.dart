class Kategori {
  final int? id;
  final String namaKategori;

  Kategori({
    this.id,
    required this.namaKategori,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama_kategori': namaKategori,
    };
  }
}
