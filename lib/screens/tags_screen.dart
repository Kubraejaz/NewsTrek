import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/tag_controller.dart';
import 'package:news_app/screens/news_detail.dart';

class TagsScreen extends StatelessWidget {
  const TagsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(TagController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tags", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: Obx(() {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: controller.tags.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var category = controller.tags[index];
                  return InkWell(
                    onTap: () {
                      controller.getTags(category);
                    },
                    child: Obx(
                      () => Container(
                        margin: const EdgeInsets.all(10),
                        height: 50,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:
                              controller.selectedTag.value == category
                                  ? Colors.grey
                                  : Colors.blueGrey,
                        ),
                        child: Center(
                          child: Text(
                            category,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          Obx(() {
            if (controller.isLoading.value) {
              return const Expanded(
                child: Center(
                  child: CircularProgressIndicator(color: Colors.black),
                ),
              );
            } else if (controller.tagNews.isEmpty) {
              return const Expanded(
                child: Center(
                  child: Text(
                    "No News available",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              );
            }
            return Expanded(
              child: ListView.builder(
                itemCount: controller.tagNews.length,
                itemBuilder: (context, index) {
                  var article = controller.tagNews[index];
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
                                article.urlToImage ?? '',
                                fit: BoxFit.cover,
                                height: 150,
                                width: double.infinity,
                                errorBuilder:
                                    (context, error, stackTrace) => Container(
                                      height: 150,
                                      color: Colors.grey,
                                      child: const Center(
                                        child: Text(
                                          'No Image',
                                          style: TextStyle(color: Colors.black),
                                        ),
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
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  article.publishedAt.split("T")[0],
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
