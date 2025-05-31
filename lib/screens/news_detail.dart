import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/news_detail_controller.dart';
import 'package:news_app/models/news_model.dart';

class NewsDetailScreen extends StatelessWidget {
  final NewsDetailController controller = Get.put(NewsDetailController());
  NewsDetailScreen({super.key, required Article article}) {
    controller.setArticle(article);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var article = controller.article.value;
      if (article == null) {
        return Scaffold(
          appBar: AppBar(title: const Text('Loading...')),
          body: const Center(child: CircularProgressIndicator()),
        );
      }

      return Scaffold(
        appBar: AppBar(
          title: Text(
            article.source.name ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          elevation: 2,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  article.urlToImage ?? '',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) => Container(
                        height: 200,
                        color: Colors.grey[300],
                        child: const Center(child: Text('No Image')),
                      ),
                ),
              ),
              const SizedBox(height: 16),

              Text(
                article.title ?? '',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      "By: ${article.author == null || article.author.isEmpty ? 'Unknown' : article.author}",
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    article.publishedAt != null
                        ? article.publishedAt.split("T")[0]
                        : '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const Divider(height: 30),

              Text(
                article.description ?? '',
                style: const TextStyle(fontSize: 16),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),

              Text(
                article.content ?? '',
                style: const TextStyle(fontSize: 14, color: Colors.black54),
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      );
    });
  }
}
