import '../../core/cache/user_cache.dart';

class OnBoardingResponse {
  List<OnBoardingModel>? onBoarding;

  OnBoardingResponse({this.onBoarding});

  OnBoardingResponse.fromJson(Map<String, dynamic> json) {
    if (json['on-boarding'] != null) {
      onBoarding = <OnBoardingModel>[];
      json['on-boarding'].forEach((v) {
        onBoarding!.add(OnBoardingModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (onBoarding != null) {
      data['on-boarding'] = onBoarding!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OnBoardingModel {
  int? index;
  TitleModel? title;
  TitleModel? subTitle;
  TitleModel? content;
  TitleModel? actionContent;
  String? languageImage;
  String? image;

  OnBoardingModel(
      {this.index,
      this.title,
      this.subTitle,
      this.content,
      this.actionContent,
      this.languageImage,
      this.image});

  OnBoardingModel.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    title = json['title'] != null ? TitleModel.fromJson(json['title']) : null;
    subTitle = json['sub_title'] != null
        ? TitleModel.fromJson(json['sub_title'])
        : null;
    content =
        json['content'] != null ? TitleModel.fromJson(json['content']) : null;
    actionContent = json['action_content'] != null
        ? TitleModel.fromJson(json['action_content'])
        : null;
    languageImage = json['language_image'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['index'] = index;
    if (title != null) {
      data['title'] = title!.toJson();
    }
    if (subTitle != null) {
      data['sub_title'] = subTitle!.toJson();
    }
    if (content != null) {
      data['content'] = content!.toJson();
    }
    if (actionContent != null) {
      data['action_content'] = actionContent!.toJson();
    }
    data['language_image'] = languageImage;
    data['image'] = image;
    return data;
  }

  String getTitle() {
    return title?.getValue() ?? "";
  }

  String getSubTitle() {
    return subTitle?.getValue() ?? "";
  }

  String getContent() {
    return content?.getValue() ?? "";
  }

  String getActionContent() {
    return actionContent?.getValue() ?? "";
  }
}

class TitleModel {
  String? ar;
  String? en;

  TitleModel({this.ar, this.en});

  TitleModel.fromJson(Map<String, dynamic> json) {
    ar = json['ar'];
    en = json['en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ar'] = ar;
    data['en'] = en;
    return data;
  }

  String getValue() {
    if (UserCache.instance.isArabic()) {
      return ar ?? "";
    }
    return en ?? "";
  }
}
