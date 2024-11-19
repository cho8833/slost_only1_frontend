enum DolbomCategory {
  sw("SW", "소프트웨어"),
  math("MATH", "수학"),
  experience("EXPERIENCE", "체험"),
  english("ENGLISH", "영어"),
  pictureBook("PICTURE_BOOK", "그림책"),
  play("PLAY", "놀이"),
  psychology("PSYCHOLOGY", "심리"),
  language("LANGUAGE", "언어"),
  art("ART", "미술"),
  history("HISTORY", "한국사");

  final String json;

  final String title;

  const DolbomCategory(this.json, this.title);

  @override
  String toString() {
    return title;
  }

  String toJson() {
    return json;
  }

  factory DolbomCategory.fromJson(String json) {
    return DolbomCategory.values.firstWhere((element) => element.toJson() == json);
  }
}