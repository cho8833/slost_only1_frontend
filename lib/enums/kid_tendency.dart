enum KidTendency {
  adhd("ADHD", "ADHD"),
  asd("ASD", "자폐 스펙트럼"),
  asperger("ASPERGER", "아스퍼거 증후군"),
  ptsd("PTSD", "외상 후 스트레스 장애"),
  ied("IED", "분노조절장애"),
  slowStarter("SLOW_STARTER", "단순 느린학습자"),
  other("OTHER", "기타");

  final String json;

  final String title;

  const KidTendency(this.json, this.title);

  @override
  String toString() {
    return title;
  }

  String toJson() {
    return json;
  }

  factory KidTendency.fromJson(String json) {
    return KidTendency.values.firstWhere((element) => element.toJson() == json);
  }
}