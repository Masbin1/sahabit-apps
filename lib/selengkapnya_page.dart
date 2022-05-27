// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sahabit_apps/detail/produkdetailpage.dart';
import 'package:sahabit_apps/konstant.dart';
import 'package:sahabit_apps/model/produk.dart';

class SelengkapnyaPage extends StatefulWidget {
  final String title, id, ids;

  const SelengkapnyaPage({Key key, this.title, this.id, this.ids})
      : super(key: key);
  @override
  State<SelengkapnyaPage> createState() => _SelengkapnyaPageState();
}

class _SelengkapnyaPageState extends State<SelengkapnyaPage> {
  List<Produk> produkList = [];
  String iUrl = Uri.http(sUrl, "/CodeIgniter3").toString();

  Future<List<Produk>> fetchProduk(
      String idkategori, String idsubkategori) async {
    List<Produk> usersList;
    var params = "/CodeIgniter3/produkbykategori";
    var url = Uri.http(sUrl, params,
        {"idkategori": idkategori, "idsubkategori": idsubkategori});
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final items = json.decode(response.body).cast<Map<String, dynamic>>();
        usersList = items.map<Produk>((json) {
          return Produk.fromJson(json);
        }).toList();
        setState(() {
          produkList = usersList;
        });
      }
    } catch (e) {
      usersList = produkList;
    }
    return usersList;
  }

  Icon icon = Icon(
    Icons.search,
    color: Colors.white,
  );
  final globalKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = TextEditingController();
  bool _isSearching;
  List<Produk> searchresult = [];

  _SelengkapnyaPageState() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _isSearching = false;
        });
      } else {
        setState(() {
          _isSearching = true;
        });
      }
    });
  }

  @override
  initState() {
    super.initState();
    _isSearching = false;
  }

  Future<void> _refresh() {
    return fetchProduk(widget.id.toString(), widget.ids.toString())
        .then((_kategori) {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context),
      // AppBar(
      //   backgroundColor: Colors.blue,
      //   title: Text(widget.title),
      // ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Container(
          height: size.height,
          margin: EdgeInsets.only(bottom: 7),
          child: FutureBuilder<List<Produk>>(
            future: fetchProduk(widget.id.toString(), widget.ids.toString()),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return searchresult.isNotEmpty || _controller.text.isNotEmpty
                  ? GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.7),
                      itemCount: searchresult.length,
                      itemBuilder: (context, i) => Card(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (context) => ProdukDetailPage(
                                  searchresult[i].id,
                                  searchresult[i].judul,
                                  searchresult[i].harga,
                                  searchresult[i].hargax,
                                  searchresult[i].thumbnail,
                                  searchresult[i].deskripsi,
                                  false,
                                  searchresult[i].satuan,
                                ),
                              ),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.network(
                                iUrl + "/" + searchresult[i].thumbnail,
                                fit: BoxFit.fill,
                              ),
                              Container(
                                  padding: EdgeInsets.only(top: 5, left: 5),
                                  alignment: Alignment.topLeft,
                                  child: Text(searchresult[i].judul)),
                              Container(
                                  padding: EdgeInsets.only(right: 5, bottom: 5),
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    searchresult[i].harga,
                                    style: TextStyle(color: Colors.red),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    )
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.7),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) => Card(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (context) => ProdukDetailPage(
                                  snapshot.data[i].id,
                                  snapshot.data[i].judul,
                                  snapshot.data[i].harga,
                                  snapshot.data[i].hargax,
                                  snapshot.data[i].thumbnail,
                                  snapshot.data[i].deskripsi,
                                  false,
                                  snapshot.data[i].satuan,
                                ),
                              ),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.network(
                                iUrl + "/" + snapshot.data[i].thumbnail,
                                fit: BoxFit.fill,
                              ),
                              Container(
                                  padding: EdgeInsets.only(top: 5, left: 5),
                                  alignment: Alignment.topLeft,
                                  child: Text(snapshot.data[i].judul)),
                              Container(
                                  padding: EdgeInsets.only(right: 5, bottom: 5),
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    snapshot.data[i].harga,
                                    style: TextStyle(color: Colors.red),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      title: InkWell(
        onTap: () {
          setState(() {
            if (icon.icon == Icons.search) {
              icon = Icon(
                Icons.close,
                color: Colors.white,
              );
              _handleSearchStart();
            } else {
              _handleSearchEnd();
            }
          });
        },
        child: SizedBox(
          height: 40,
          child: TextField(
            controller: _controller,
            style: TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,

              suffixIcon: Icon(Icons.search, color: Colors.blue),
              hintText: "Search " + widget.title,
              //hintStyle: TextStyle(color: Colors.white),
            ),
            onChanged: searchOperation,
          ),
        ),
      ),
    );
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      icon = Icon(
        Icons.search,
        color: Colors.white,
      );
      // appBarTitle = Text(
      //   widget.title,
      //   style: TextStyle(color: Colors.white),
      // );
      _isSearching = false;
      _controller.clear();
    });
  }

  void searchOperation(String searchText) {
    searchresult.clear();
    if (_isSearching != null) {
      for (var data in produkList) {
        if (data.judul.toLowerCase().contains(searchText.toLowerCase())) {
          searchresult.add(data);
        }
      }
    }
  }
}
