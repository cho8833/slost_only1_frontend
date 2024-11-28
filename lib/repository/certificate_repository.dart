import 'package:slost_only1/data/certificate_req.dart';
import 'package:slost_only1/model/certificate.dart';

abstract interface class CertificateRepository {
  Future<List<Certificate>> getMyCertificate();

  Future<Certificate> createCertificate(CreateCertificateReq req);

  Future<Certificate> editCertificate(int id, CreateCertificateReq req);
}