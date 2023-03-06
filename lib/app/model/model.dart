class PegawaiModel {
  bool? status;
  String? message;
  List<TampilContent>? data;

  PegawaiModel({this.status, this.message, this.data});

  PegawaiModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TampilContent>[];
      json['data'].forEach((v) {
        data!.add(new TampilContent.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TampilContent {
  int? id;
  String? nama;
  String? posisi;
  String? gaji;
  String? alamat;
  String? createdAt;
  String? updatedAt;

  TampilContent(
      this.id,
      this.nama,
      this.posisi,
      this.gaji,
      this.alamat,
      this.createdAt,
      this.updatedAt);

  TampilContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    posisi = json['posisi'];
    gaji = json['gaji'];
    alamat = json['alamat'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['posisi'] = this.posisi;
    data['gaji'] = this.gaji;
    data['alamat'] = this.alamat;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
}
}