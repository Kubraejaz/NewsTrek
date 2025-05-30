import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:news_app/models/news_model.dart';

class NewsController extends GetxController {
  var news = <Article>[].obs;

 final String apiKey = 'f1146588faa247d192a0f6b2402d31b9';


  Future<void> getNews() async {
    try {
      var uri = Uri.parse(
       "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=$apiKey"
,
      );

      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final newsResponse = NewsResponse.fromJson(jsonResponse);
        news.value = newsResponse.articles;
      } else {
        debugPrint("Failed to load news: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void onClose() {
    void onInit() {
      getNews();
      super.onClose();
      super.onInit();
    }
  }
}
