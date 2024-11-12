import 'package:flutter/material.dart';
import 'package:slost_only1/model/certificate.dart';
import 'package:slost_only1/widget/item_container.dart';

class CertificateCard extends StatelessWidget {
  const CertificateCard({super.key, required this.certificate});

  final Certificate certificate;

  @override
  Widget build(BuildContext context) {
    return ItemContainer(
        child: Text(certificate.title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),));
  }
}
