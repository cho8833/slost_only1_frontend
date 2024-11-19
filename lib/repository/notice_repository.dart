abstract interface class NoticeRepository {
  Future<String> getFAQUrl();

  Future<String> getAnnouncementUrl();

  Future<String> getPolicyUrl();
}