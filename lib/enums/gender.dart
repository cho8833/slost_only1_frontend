enum Gender {
  male("MALE", "남"),
  female("FEMALE", "여");

  final String json;

  final String title;

  const Gender(this.json, this.title);

  @override
  String toString() {
    return title;
  }

  String toJson() {
    return json;
  }

  factory Gender.fromJson(String json) {
    return Gender.values.firstWhere((element) => element.toJson() == json);
  }
}