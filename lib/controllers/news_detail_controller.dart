import 'package:get/get.dart';
import 'package:news_app/models/news_model.dart';

class NewsDetailController extends GetxController {
  var article = Rxn<Article>();
  void setArticle(Article newArticle) {
    article.value = newArticle;
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is Article) {
      article.value = Get.arguments as Article;
    }
  }
}
