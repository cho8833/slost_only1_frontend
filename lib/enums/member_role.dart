enum MemberRole {

  parent("PARENT", "부모님"),
  teacher("TEACHER", "선생님");

  final String json;

  final String title;

  const MemberRole(this.json, this.title);

  @override
  String toString() {
    return title;
  }

  String toJson() {
    return json;
  }

  factory MemberRole.fromJson(String json) {
    return MemberRole.values.firstWhere((element) => element.toJson() == json);
  }
}