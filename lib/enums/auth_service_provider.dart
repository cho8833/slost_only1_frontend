enum AuthServiceProvider {
  kakao("KAKAO"),

  apple("APPLE");

  const AuthServiceProvider(this.json);

  final String json;

  String toJson() => json;
}