
class NewsArticle {

    final String title;
    final String descrption;
    final String urlToImage;

    NewsArticle({this.title, this.descrption, this.urlToImage});

    factory NewsArticle.fromJson(Map<String,dynamic> json) {
        return NewsArticle(
            title: json['title'],
            descrption: json['description'],
         //   urlToImage: json['urlToImage'] ?? Constants.NEWS_PLACEHOLDER_IMAGE_ASSET_URL
        );
    }
}
