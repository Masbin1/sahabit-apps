class Produk {
  final int id, idkategori;
  final String judul, harga, hargax, thumbnail, deskripsi, satuan;

  Produk(
      {this.id,
      this.idkategori,
      this.judul,
      this.harga,
      this.hargax,
      this.thumbnail,
      this.deskripsi,
      this.satuan});
  factory Produk.fromJson(Map<String, dynamic> json) {
    return Produk(
        id: json['id'] as int,
        idkategori: json['idkategori'] as int,
        judul: json['judul'] as String,
        harga: json['harga'] as String,
        hargax: json['hargax'] as String,
        thumbnail: json['thumbnail'] as String,
        deskripsi: json['deskripsi'] as String,
        satuan: json['satuan'] as String);
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['idkategori'] = idkategori;
    map['judul'] = judul;
    map['harga'] = harga;
    map['hargax'] = hargax;
    map['thumbnail'] = thumbnail;
    map['deskripsi'] = deskripsi;
    map['satuan'] = satuan;
    return map;
  }
}
