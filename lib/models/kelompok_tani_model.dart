class KelompokPetani {
  String idKelompokTani;
  String namaKelompok;


  KelompokPetani({
    required this.idKelompokTani,
    required this.namaKelompok,

  });

  factory KelompokPetani.fromJson(Map<String, dynamic> json) => KelompokPetani(
        idKelompokTani: json["id_kelompok_tani"],
        namaKelompok: json["nama_kelompok"],
        
      );

  Map<String, dynamic> toJson() => {
        "id_kelompok_tani": idKelompokTani,
        "nama_kelompok": namaKelompok,
        
      };
}
