import 'package:slost_only1/data/dolbom_notice_req.dart';
import 'package:slost_only1/model/address.dart';
import 'package:slost_only1/model/dolbom_location.dart';
import 'package:slost_only1/model/dolbom_notice.dart';
import 'package:slost_only1/model/enums/category.dart';
import 'package:slost_only1/model/enums/gender.dart';
import 'package:slost_only1/model/kid.dart';
import 'package:slost_only1/model/member.dart';
import 'package:slost_only1/repository/dolbom_notice_repository.dart';
import 'package:slost_only1/support/server_response.dart';

class DolbomNoticeRepositoryMock implements DolbomNoticeRepository {
  
  static final Member _testMember = Member(1, "01012341234");
  static final Kid _testKid = Kid(1, "조현빈", DateTime.now().subtract(const Duration(days: 720)), Gender.male, "test", "remark");
  static final Address _testAddress = Address("창원시 진해구", "경상남도", "창원시", "장천동", null);
  static final DolbomLocation _testLocation = DolbomLocation(1, _testAddress, "우리집");

  @override
  Future<PagedData<DolbomNotice>> getList(DolbomNoticeListReq req) {
    
    DateTime now = DateTime.now();
    
    return Future.value(
      PagedData([
        DolbomNotice(1, 100000, now, now.add(const Duration(days: 30)), _testMember, [_testKid], _testLocation, DolbomCategory.english)
      ], Pageable(1, 5), 1, 1)
    );
  }

  @override
  Future<DolbomNotice> create(DolbomNoticeCreateReq req) {
    // TODO: implement create
    throw UnimplementedError();
  }

}