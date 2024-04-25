class Petani {
  final String? idPenjual;
  final String? idKelompokTani;
  final String? nama;
  final String? nik;
  final String? alamat;
  final String? telp;
  final String? foto;
  final String? status;
  final String? namaKelompok;
  

  const Petani({
    this.idPenjual,
    this.idKelompokTani,
    this.nama,
    this.nik,
    this.alamat,
    this.telp,
    this.foto,
    this.status,
    this.namaKelompok,
  });

  factory Petani.fromJson(Map<String, dynamic> json) {
    return Petani(
      idPenjual: json['id_penjual'],
      idKelompokTani: json['id_kelompok_tani'],
      nama: json['nama'],
      nik: json['nik'],
      alamat: json['alamat'],
      telp: json['telp'],
      foto: json['foto'],
      status: json['status'],
      namaKelompok: json['nama_kelompok'],
    );
  }

}
