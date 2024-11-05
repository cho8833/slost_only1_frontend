import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/model/address.dart';
import 'package:slost_only1/model/dolbom_notice.dart';
import 'package:slost_only1/model/kid.dart';
import 'package:slost_only1/provider/dolbom_notice_provider.dart';
import 'package:status_builder/status_builder.dart';

class DolbomNoticeList extends StatefulWidget {
  const DolbomNoticeList({super.key});

  @override
  State<DolbomNoticeList> createState() => _DolbomNoticeListState();
}

class _DolbomNoticeListState extends State<DolbomNoticeList> {

  late final DolbomNoticeProvider provider;

  @override
  void initState() {
    super.initState();
    provider = context.read<DolbomNoticeProvider>();
    provider.getList();
  }


  @override
  Widget build(BuildContext context) {
    return StatusBuilder(
        statusNotifier: provider.getNoticesStatus,
        successBuilder: (context) => Container(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              DolbomNoticeItem(notice: provider.notices[0])
            ],
          ),
        ),
    );
  }
}

class DolbomNoticeItem extends StatelessWidget {
  const DolbomNoticeItem({super.key, required this.notice});

  final DolbomNotice notice;

  @override
  Widget build(BuildContext context) {
    final Address address = notice.dolbomLocation.address;
    final Kid kid = notice.kid;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(24)),
        color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${DateFormat("MM월 dd일").format(notice.startDateTime)}부터", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700,),),
          Text("${DateFormat("hh:mm").format(notice.startDateTime)}~${DateFormat("hh:mm").format(notice.endDateTime)}", style: const TextStyle(color: Colors.black45),),
          const SizedBox(height: 16,),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, color: Colors.grey, size: 16,),
              const SizedBox(width: 8,),
              Text("${address.sido} ${address.sigungu} ${address.bname}", style: const TextStyle(color: Colors.black54),),
            ],
          ),
          const SizedBox(height: 8,),
          Row(
            children: [
              const Icon(Icons.child_care_outlined, color: Colors.grey, size: 16,),
              const SizedBox(width: 8,),
              Text("${kid.age}세, ${kid.gender}아", style: const TextStyle(color: Colors.black54),)
            ],
          ),
          const SizedBox(height: 8,),
          Row(
            children: [
              const Icon(Icons.paid_outlined, color: Colors.grey, size: 16,),
              const SizedBox(width: 8,),
              Text("예상활동비 ${notice.pay}원", style: const TextStyle(fontWeight: FontWeight.w600),)
            ],
          )
        ],
      )
    );
  }
}

