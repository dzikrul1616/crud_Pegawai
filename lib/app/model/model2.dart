class User {
  final String id;
  final String nama;
  final String posisi;
  final String gaji;
  final String alamat;
  final String create_at;
  final String update_at;

  User({
    required this.id,
    required this.nama,
    required this.posisi,
    required this.gaji,
    required this.alamat,
    required this.create_at,
    required this.update_at,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nama: json['nama'],
      posisi: json['posisi'],
      gaji: json['gaji'],
      alamat: json['alamat'],
      create_at: json['create_at'],
      update_at: json['update_at'],
    );
  }
}
