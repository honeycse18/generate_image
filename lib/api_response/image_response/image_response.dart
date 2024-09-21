import 'package:image_api_project/api_response/image_response/api_helper/api_helper.dart';

class ImageResponse {
  String caption;
  ImageEmotion imageEmotion;
  List<Sentiment> sentiment;

  ImageResponse(
      {this.caption = '',
      required this.imageEmotion,
      this.sentiment = const []});

  factory ImageResponse.fromJson(Map<String, dynamic> json) => ImageResponse(
        caption: APIHelper.getSafeString(json['caption']),
        imageEmotion:
            ImageEmotion.getAPIResponseObjectSafeValue(json['image_emotion']),
        sentiment: APIHelper.getSafeList(json['sentiment'])
            .map((e) => Sentiment.getAPIResponseObjectSafeValue(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'caption': caption,
        'image_emotion': imageEmotion.toJson(),
        'sentiment': sentiment.map((e) => e.toJson()).toList(),
      };

  factory ImageResponse.empty() => ImageResponse(imageEmotion: ImageEmotion());
  static ImageResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ImageResponse.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : ImageResponse.empty();
}

class Sentiment {
  String label;
  double score;

  Sentiment({this.label = '', this.score = 0});

  factory Sentiment.fromJson(Map<String, dynamic> json) => Sentiment(
        label: APIHelper.getSafeString(json['label']),
        score: APIHelper.getSafeDouble(json['score']),
      );

  Map<String, dynamic> toJson() => {
        'label': label,
        'score': score,
      };

  static Sentiment getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Sentiment.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Sentiment();
}

class ImageEmotion {
  String emotion;
  double score;

  ImageEmotion({this.emotion = '', this.score = 0});

  factory ImageEmotion.fromJson(Map<String, dynamic> json) => ImageEmotion(
        emotion: APIHelper.getSafeString(json['emotion']),
        score: APIHelper.getSafeDouble(json['score']),
      );

  Map<String, dynamic> toJson() => {
        'emotion': emotion,
        'score': score,
      };

  static ImageEmotion getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ImageEmotion.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : ImageEmotion();
}
