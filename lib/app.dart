import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:employee/helper/db_helper.dart';
import 'package:employee/helper/internet_helper.dart';
import 'package:employee/models/employ_model.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  late Future<List<Employ>> employss;
  late DBHelper dbHelper;

  void _loadEmploy() async {
    String employ = await InternetHelper.getEmploy();
    List<dynamic> data = jsonDecode(employ);
    data.forEach((element) {
      Employ emplyModel = Employ.fromMap(element);
      dbHelper.add(emplyModel);
    });
  }

  getEmployList() async {
    setState(() {
      employss = dbHelper.getEmploy();
    });
  }

  @override
  void initState() {
    dbHelper = DBHelper();
    _loadEmploy();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: SafeArea(
          child: Container(
        child: FutureBuilder<List<Employ>>(
            future: dbHelper.getEmploy(),
            builder: (context, snap) {
              if (snap.hasData) {
                return ListView.builder(
                  itemCount: snap.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CachedNetworkImage(
                        imageUrl: snap.data![index].profileImg ?? "",
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      title: Text(snap.data![index].name),
                      subtitle: Text(jsonDecode(snap.data![index].company)),
                    );
                  },
                );
              }
              if (snap.data == null) {
                return Text('No Data Found');
              }
              return CircularProgressIndicator();
            }),
      )),
    ));
  }
}
