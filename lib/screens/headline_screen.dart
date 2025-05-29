import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/news_controller.dart';

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
            icon: const Icon(Icons.refresh),
            onPressed: () {
              controller.getNews();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(
          () {
            if (controller.news.isEmpty) {
              return const Center(child: CircularProgressIndicator(color: Colors.black));
            } else {
              return ListView.builder(
                itemCount: controller.news.length,
                itemBuilder: (context, index) {
                  return Container(
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
                              controller.news[index].urlToImage ?? '',
                              fit: BoxFit.cover,
                              height: 150,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) => Container(
                                height: 150,
                                color: Colors.grey,
                                child: const Center(child: Text('No Image')),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  controller.news[index].title.length > 20
                                      ? "${controller.news[index].title.substring(0, 20)}..."
                                      : controller.news[index].title,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(controller.news[index].publishedAt),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
