enum AuthServiceProvider {
  kakao("KAKAO");


  const AuthServiceProvider(this.json);

  final String json;

  String toJson() => json;
}