enum ReviewReportReason {
  policyViolation("POLICY_VIOLATION", "정책 위반"),
  pornography("PORNOGRAPHY", "음란물");
  final String json;

  final String title;

  const ReviewReportReason(this.json, this.title);

  @override
  String toString() {
    return title;
  }

  String toJson() {
    return json;
  }

  factory ReviewReportReason.fromJson(String json) {
    return ReviewReportReason.values.firstWhere((element) => element.toJson() == json);
  }
}