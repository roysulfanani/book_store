import 'dart:convert';

import 'package:book_store/models/book_list_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  BookListResponse? BookList;
  fetchBookApi() async {
    var url = Uri.https('api.itbook.store', '1.0/new');
    var response = await http.get(
      url,
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonBookList = jsonDecode(response.body);
      BookList = BookListResponse.fromJson(jsonBookList);
      setState(() {});
    }
    // print(await http.read(Uri.https('example.com', 'foobar.txt')));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchBookApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Catalog"),
      ),
      body: Container(
        child: BookList == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: BookList!.books!.length,
                itemBuilder: (context, index) {
                  final currentBook = BookList!.books![index];
                  return Row(
                    children: [
                      Image.network(
                        currentBook.image!,
                        height: 100,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(currentBook.title!),
                              Text(currentBook.subtitle!),
                              Align(
                                  alignment: Alignment.topRight,
                                  child: Text(currentBook.price!)),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
      ),
    );
  }
}