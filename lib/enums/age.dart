enum Age {
  baby("BABY", "영아", "~1세"),
  toddler("TODDLER", "영유아", "2~3세"),
  kindergarten("KINDERGARTEN", "유치원생", "4~6세"),
  lowerElementary("LOWER_ELEMENTARY", "초등 저학년", "7~9세"),
  higherElementary("HIGHER_ELEMENTARY", "초등 고학년", "10~12세");

  final String json;

  final String title;

  final String description;

  const Age(this.json, this.title, this.description);

  @override
  String toString() {
    return title;
  }

  String toJson() {
    return json;
  }

  factory Age.fromJson(String json) {
    return Age.values.firstWhere((element) => element.toJson() == json);
  }
}