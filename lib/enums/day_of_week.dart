enum DayOfWeek {
  mon("MONDAY", "월"),
  tue("TUESDAY", "화"),
  wed("WEDNESDAY", "수"),
  thu("THURSDAY", "목"),
  fri("FRIDAY", "금"),
  sat("SATURDAY", "토"),
  sun("SUNDAY", "일");

  final String json;

  final String title;

  const DayOfWeek(this.json, this.title);

  @override
  String toString() {
    return title;
  }

  String toJson() {
    return json;
  }

  factory DayOfWeek.fromJson(String json) {
    return DayOfWeek.values.firstWhere((element) => element.toJson() == json);
  }
}