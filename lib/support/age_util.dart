class AgeUtil {
  // 일반 나이 계산
  static int calKoreanAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    return currentDate.year - birthDate.year + 1;
  }

  // 만 나이 계산
  static int calInternationalAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;

    // 생일이 지나지 않았다면 나이를 1 감소시킴
    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month && currentDate.day < birthDate.day)) {
      age--;
    }

    return age;
  }
}