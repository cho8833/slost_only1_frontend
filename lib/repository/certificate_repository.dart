import 'package:slost_only1/data/certificate_req.dart';
import 'package:slost_only1/model/certificate.dart';

abstract interface class CertificateRepository {
  Future<List<Certificate>> getMyCertificate();

  Future<void> createCertificate(CreateCertificateReq req);

}