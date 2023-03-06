import 'dart:convert';

import 'package:crud_pegawai/app/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path/path.dart' as path;

class ContentViewData extends StatefulWidget {
  const ContentViewData({Key? key}) : super(key: key);

  @override
  State<ContentViewData> createState() => _ContentViewDataState();
}

class _ContentViewDataState extends State<ContentViewData> {
  final list = <TampilContent>[];
  var loading = false;
  bool _refreshing = false;
  Future<void> _onRefresh() async {
    await _lihatdata();
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future _lihatdata() async {
    list.clear();
    setState(() {
      loading = true;
    });
    final url = Uri.parse(
        'https://pegawai.indonesiafintechforum.org/api/getDataPegawai');
    final response = await http.get(url);

    if (response.contentLength == 2) {
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new TampilContent(
          api['id'],
          api['nama'],
          api['posisi'],
          api['gaji'],
          api['alamat'],
          api['create_at'],
          api['update_at'],
        );
        list.add(ab);
      });
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _lihatdata();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: Column(
        children: [
          GridView.builder(
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1.0,
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                mainAxisExtent: 290),
            itemCount: list.length,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemBuilder: (_, index) {
              final item = list[index];
              return InkWell(
                onDoubleTap: () {},
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => ContentData(
                  //               description: item.descripton,
                  //               price: item.price,
                  //               title: item.title,
                  //               image: url + item.image,
                  //             )));
                },
                onLongPress: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => EditContent(item)));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffF2F2F2),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          item.nama!.length > 15
                              ? '${item.nama!.substring(0, 15)}...'
                              : item.nama!,
                        ),
                        subtitle: Text(
                          item.alamat!.length > 15
                              ? '${item.alamat!.substring(0, 15)}...'
                              : item.alamat!,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text(''), Text(item.createdAt!)],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text(item.gaji!), Text('${item.id}')],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
