import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/news_controller.dart';
import 'package:news_app/screens/news_detail.dart';
import 'package:news_app/screens/tags_screen.dart';

class HeadlineScreen extends StatelessWidget {
  const HeadlineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(NewsController());
    controller.getNews();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Headlines"),
        actions: [
          IconButton(
            icon: const Icon(Icons.tag),
            onPressed: () {
              Get.to(() => const TagsScreen());
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              controller.getNews();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.news.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          } else {
            return ListView.builder(
              itemCount: controller.news.length,
              itemBuilder: (context, index) {
                var article = controller.news[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => NewsDetailScreen(article: article));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black.withOpacity(0.4),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              article.urlToImage,
                              fit: BoxFit.cover,
                              height: 150,
                              width: double.infinity,
                              errorBuilder:
                                  (context, error, stackTrace) => Container(
                                    height: 150,
                                    color: Colors.grey,
                                    child: const Center(
                                      child: Text('No Image'),
                                    ),
                                  ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 4,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  article.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                article.publishedAt.split("T")[0],
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }
}
