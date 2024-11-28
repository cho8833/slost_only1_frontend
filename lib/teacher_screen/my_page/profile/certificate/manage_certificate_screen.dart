import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/model/certificate.dart';
import 'package:slost_only1/provider/certificate_provider.dart';
import 'package:slost_only1/teacher_screen/my_page/profile/certificate/save_certificate_screen.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/widget/certificate/certificate_card.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';
import 'package:status_builder/status_builder.dart';

class ManageCertificateScreen extends StatefulWidget {
  const ManageCertificateScreen({super.key});

  @override
  State<ManageCertificateScreen> createState() =>
      _ManageCertificateScreenState();
}

class _ManageCertificateScreenState extends State<ManageCertificateScreen> {
  late CertificateProvider certificateProvider;

  @override
  void initState() {
    certificateProvider = context.read<CertificateProvider>();
    certificateProvider.getMyCertificates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SubPageAppBar(
          appBarObj: AppBar(),
          title: "자격증 관리",
          trailingBuilder: (context) => IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SaveCertificateScreen()));
              },
              icon: const Icon(Icons.add)),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: StatusBuilder(
              statusNotifier: certificateProvider.getCertificateStatus,
              successBuilder: (context) {
                return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    Certificate certificate =
                        certificateProvider.certificates[index];
                    return ButtonBase(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SaveCertificateScreen(
                                        certificate: certificate,
                                      )));
                        },
                        child: CertificateCard(certificate: certificate));
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    height: 8,
                  ),
                  itemCount: certificateProvider.certificates.length,
                );
              },
            )));
  }
}
