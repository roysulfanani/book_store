import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:book_store/models/book_list_response.dart';
import 'package:http/http.dart' as http;

import '../models/book_detail_response.dart';

class BookController extends ChangeNotifier {
  BookListResponse? BookList;
  fetchBookApi() async {
    var url = Uri.https('api.itbook.store', '1.0/new');
    var response = await http.get(
      url,
    );

    if (response.statusCode == 200) {
      final jsonBookList = jsonDecode(response.body);
      BookList = BookListResponse.fromJson(jsonBookList);
      // setState(() {});
      notifyListeners();
    }
    // print(await http.read(Uri.https('example.com', 'foobar.txt')));
  }

  BookDetailRespone? detailBook;
  fetchDetailBookApi(isbn) async {
    // print(widget.isbn);
    var url = Uri.https('api.itbook.store', '1.0/books/$isbn');
    var response = await http.get(
      url,
    );

    if (response.statusCode == 200) {
      final jsonDetail = jsonDecode(response.body);
      detailBook = BookDetailRespone.fromJson(jsonDetail);
      notifyListeners();
      fetchSimiliarBookApi(detailBook!.title!);
    }

    // print(await http.read(Uri.https('example.com', 'foobar.txt')));
  }

  BookListResponse? similiarBooks;
  fetchSimiliarBookApi(String title) async {
    // print(widget.isbn);
    var url = Uri.https('api.itbook.store', '1.0/search/$title');
    var response = await http.get(
      url,
    );

    if (response.statusCode == 200) {
      final jsonDetail = jsonDecode(response.body);
      similiarBooks = BookListResponse.fromJson(jsonDetail);
      notifyListeners();
    }

    // print(await http.read(Uri.https('example.com', 'foobar.txt')));
  }
}
