import 'dart:convert';

import 'package:crud_pegawai/app/constant/color.dart';
import 'package:crud_pegawai/app/dynamic/content.dart';
import 'package:crud_pegawai/app/dynamic/contentView.dart';
import 'package:crud_pegawai/app/model/model.dart';
import 'package:crud_pegawai/app/modules/Content/views/editdata.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../controllers/content_controller.dart';

class ContentView extends StatefulWidget {
  const ContentView({Key? key}) : super(key: key);

  @override
  State<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  final list = <TampilContent>[];
  var loading = false;
  bool _refreshing = false;
  Future<void> _onRefresh() async {
    await _lihatdata();
  }

  _delete(String id) async {
    final url = Uri.parse(
        'https://pegawai.indonesiafintechforum.org/api/deletePegawai');
    final response = await http.post(url, body: {"id": id});
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['messege'];
    if (value == 1) {
      _lihatdata();
    } else {
      print(pesan);
    }
  }

  _dialogdelete(String id) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: ListView(
              padding: EdgeInsets.all(20),
              shrinkWrap: true,
              children: <Widget>[
                Text(
                  'Apakaha anda yakin ingin menghapus file?',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('No'),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _delete(id);
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Ya',
                        style: const TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  Future _lihatdata() async {
    list.clear();
    setState(() {
      loading = true;
    });

    try {
      final url = Uri.parse(
          'https://pegawai.indonesiafintechforum.org/api/getDataPegawai');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
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
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
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
    final url = 'http://192.168.1.15/elevated/upload/';
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.abc),
                        InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.search,
                            color: appPrimary,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Text(
                          "Special",
                          style: TextStyle(
                            color: appGreen,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    bannerWidget(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Text(
                          "Recomended",
                          style: TextStyle(
                            color: appGreen,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1.0,
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                      ),
                      itemCount: list.length,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (_, index) {
                        final item = list[index];
                        return InkWell(
                          onDoubleTap: () {},
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditContent(item)));
                          },
                          onLongPress: () {
                            _dialogdelete('${item.id}');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xffF2F2F2),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    child: Icon(Icons.person),
                                  ),
                                  Text(
                                    item.nama!.length > 15
                                        ? '${item.nama!.substring(0, 15)}...'
                                        : item.nama!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    item.alamat!.length > 15
                                        ? '${item.alamat!.substring(0, 15)}...'
                                        : item.alamat!,
                                  ),
                                  Text(
                                    item.gaji!.length > 15
                                        ? '${item.gaji!.substring(0, 15)}...'
                                        : item.gaji!,
                                  ),
                                  Text(
                                    item.posisi!.length > 15
                                        ? '${item.posisi!.substring(0, 15)}...'
                                        : item.posisi!,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class bannerWidget extends StatelessWidget {
  const bannerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        List items = [
          {
            "id": 1,
            "photo":
                "https://i.ibb.co/6NZ8dGk/Holiday-Travel-Agent-Promotion-Banner-Landscape.png",
            "onTap": (item) {},
          },
          {
            "id": 2,
            "photo": "https://i.ibb.co/5xfjdy9/Blue-Modern-Discount-Banner.png",
            "onTap": (item) {},
          },
          {
            "id": 3,
            "photo":
                "https://i.ibb.co/6Rvjyy1/Brown-Yellow-Free-Furniture-Promotion-Banner.png",
            "onTap": (item) {},
          }
        ];

        return SizedBox(
          height: 120.0,
          child: ListView.builder(
            itemCount: items.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              var item = items[index];
              return Container(
                height: 100.0,
                width: MediaQuery.of(context).size.width * 0.7,
                margin: const EdgeInsets.only(right: 16.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      item["photo"],
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      16.0,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
