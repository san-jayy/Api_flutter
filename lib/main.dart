import 'dart:convert';
// import 'dart:html';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchData() async {
  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/photos/8'),
    headers: {HttpHeaders.authorizationHeader: 'sdfgdhh'},
  );

  final responseJson = jsonDecode(response.body);

  return Album.fromjson(responseJson);
}

class Album {
  int? albumId;
  int? Id;
  String title;
  String url;
  String thumbUrl;

  Album({
    required this.Id,
    required this.albumId,
    required this.title,
    required this.url,
    required this.thumbUrl,
  });

  factory Album.fromjson(Map<String, dynamic> json) {
    return Album(
      Id: json['Id'],
      albumId: json['albumId'],
      title: json['title'],
      url: json['url'],
      thumbUrl: json['thumbnailUrl'],
    );
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Album> futuredata;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futuredata = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Fetch Data Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Fetch Data Example'),
          ),
          body: Center(
            child: FutureBuilder<Album>(
              future: futuredata,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(snapshot.data!.albumId.toString()),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(snapshot.data!.title),
                      ),
                      Text(snapshot.data!.url),
                      Text(snapshot.data!.url),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator(
                  color: Colors.blue,
                );
              },
            ),
          ),
        ));
  }
}
