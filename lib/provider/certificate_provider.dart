import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:slost_only1/data/certificate_req.dart';
import 'package:slost_only1/model/certificate.dart';
import 'package:slost_only1/repository/certificate_repository.dart';
import 'package:status_builder/status_builder.dart';

class CertificateProvider {
  CertificateProvider(this.repository);

  final CertificateRepository repository;

  List<Certificate> certificates = [];
  ValueNotifier<Status> getCertificateStatus = ValueNotifier(Status.loading);
  String getCertificateErrorMessage = "";

  ValueNotifier<Status> createCertificateStatus = ValueNotifier(Status.idle);

  Future<void> getMyCertificates() async {
    getCertificateStatus.value = Status.loading;
    await repository.getMyCertificate().then((data) {
      certificates = data;
      getCertificateStatus.value = Status.success;
    }).catchError((e) {
      getCertificateStatus.value = Status.fail;
      getCertificateErrorMessage = e.toString();
    });
  }

  Future<void> createCertificate({File? file, required String title}) async {
    createCertificateStatus.value = Status.loading;
    CreateCertificateReq req = CreateCertificateReq(title, file);
    await repository.createCertificate(req).then((_) {
      createCertificateStatus.value = Status.idle;
      getMyCertificates();
    }).catchError((e) {
      createCertificateStatus.value = Status.idle;
      throw e;
    });
  }
}