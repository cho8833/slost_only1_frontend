enum DolbomTimeSlotStatus {
  reserved("RESERVED", "예약됨"),
  done("DONE", "완료됨"),
  cancel("CANCEL", "취소됨");

  final String json;

  final String title;

  const DolbomTimeSlotStatus(this.json, this.title);

  @override
  String toString() {
    return title;
  }

  String toJson() {
    return json;
  }

  factory DolbomTimeSlotStatus.fromJson(String json) {
    return DolbomTimeSlotStatus.values.firstWhere((element) => element.toJson() == json);
  }
}