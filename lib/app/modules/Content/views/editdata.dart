import 'dart:convert';
import 'dart:io';
import 'package:crud_pegawai/app/constant/color.dart';
import 'package:crud_pegawai/app/model/model.dart';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:shared_preferences/shared_preferences.dart';

class EditContent extends StatefulWidget {
  final TampilContent tampilcontent;

  EditContent(this.tampilcontent);

  @override
  State<EditContent> createState() => _EditContentState();
}

class _EditContentState extends State<EditContent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String nama, alamat, posisi, gaji, id;
  late TextEditingController txtnama, txtalamat, txtposisi;

  check() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      _submitForm();
    } else {}
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    final url =
        Uri.parse('https://pegawai.indonesiafintechforum.org/api/editPegawai');
    final request = http.MultipartRequest('POST', url);

    request.fields.addAll({
      'nama': nama,
      'alamat': alamat,
      'posisi': posisi,
      'gaji': gaji,
      'id': id,
      'updated_at': DateTime.now().toString(),
    });

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final responseJson = json.decode(responseString);

      print(responseJson);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(responseJson.toString()),
          backgroundColor: appPrimary,
        ),
      );
      Navigator.pop(context);
    } else {
      print('Error: ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final url = 'http://192.168.8.101/elevated/upload/';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appPrimary,
        title: Text('Update Item'),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: check,
            child: Text('Update Data'),
            style: ElevatedButton.styleFrom(primary: appPrimary),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  initialValue: widget.tampilcontent.nama,
                  onSaved: (value) => nama = value!,
                  decoration: InputDecoration(
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Color(0xffF2F2F2),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.none)),
                    hintText: 'nama',
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Harap isi nama';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  initialValue: widget.tampilcontent.posisi,
                  onSaved: (value) => posisi = value!,
                  decoration: InputDecoration(
                    hintText: 'Posisi',
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Color(0xffF2F2F2),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.none)),
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Harap isi posisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  initialValue: widget.tampilcontent.alamat,
                  onSaved: (value) => alamat = value!,
                  decoration: InputDecoration(
                    hintText: 'alamat',
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Color(0xffF2F2F2),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.none)),
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Harap isi alamat';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  initialValue: widget.tampilcontent.gaji,
                  onSaved: (value) => gaji = value!,
                  decoration: InputDecoration(
                    hintText: 'gaji',
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Color(0xffF2F2F2),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.none)),
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Harap isi gaji';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  enabled: false,
                  initialValue: widget.tampilcontent.id.toString(),
                  onSaved: (value) => id = value!,
                  decoration: InputDecoration(
                    hintText: 'id',
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Color(0xffF2F2F2),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.none)),
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Harap isi id';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
