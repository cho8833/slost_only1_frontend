import 'package:slost_only1/data/kid_req.dart';
import 'package:slost_only1/model/kid.dart';

abstract interface class KidRepository {

  Future<List<Kid>> getMyKidList();

  Future<Kid> addKid(KidCreateReq req);

  Future<Kid> editKid(KidEditReq req);

  Future<void> deleteKid(int id);
}