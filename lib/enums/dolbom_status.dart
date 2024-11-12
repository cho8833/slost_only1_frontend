enum DolbomStatus {
  matching("MATCHING", "찾는중"),
  reserved("RESERVED", "예약됨"),
  done("DONE", "완료됨"),
  cancel("CANCEL", "취소됨");

  final String json;

  final String title;

  const DolbomStatus(this.json, this.title);

  @override
  String toString() {
    return title;
  }

  String toJson() {
    return json;
  }

  factory DolbomStatus.fromJson(String json) {
    return DolbomStatus.values.firstWhere((element) => element.toJson() == json);
  }
}