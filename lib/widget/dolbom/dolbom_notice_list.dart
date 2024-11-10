// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:slost_only1/model/address.dart';
// import 'package:slost_only1/model/dolbom_notice.dart';
// import 'package:slost_only1/model/kid.dart';
// import 'package:slost_only1/provider/dolbom_notice_provider.dart';
// import 'package:slost_only1/support/age_util.dart';
// import 'package:slost_only1/support/sigungu.dart';
// import 'package:slost_only1/widget/button_base.dart';
// import 'package:slost_only1/widget/dolbom_notice/create_dolbom_notice/select_kid_screen.dart';
// import 'package:status_builder/status_builder.dart';
//
// class DolbomNoticeList extends StatefulWidget {
//   const DolbomNoticeList({super.key});
//
//   @override
//   State<DolbomNoticeList> createState() => _DolbomNoticeListState();
// }
//
// class _DolbomNoticeListState extends State<DolbomNoticeList> {
//   late final DolbomNoticeProvider provider;
//
//   @override
//   void initState() {
//     super.initState();
//     provider = context.read<DolbomNoticeProvider>();
//     provider.getList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           color: Colors.white,
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       "돌봄 공고",
//                       style:
//                           TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
//                     ),
//                     ButtonBase(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) =>
//                                       const SelectKidScreen()));
//                         },
//                         child: const Text("방문 신청하기"))
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 8,
//                 ),
//                 Row(
//                   children: [
//                     ButtonBase(
//                       onTap: () {
//                         showModalBottomSheet(
//                             context: context,
//                             isScrollControlled: true,
//                             builder: (context) => const SelectSigunguModal());
//                       },
//                       child: Container(
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(24),
//                               border: Border.all(color: Colors.grey, width: 1)),
//                           padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
//                           child: Row(
//                             children: [
//                               ValueListenableBuilder(
//                                   valueListenable: provider.getNoticeSigungu,
//                                   builder: (context, value, _) =>
//                                       Text(value ?? "지역 선택")),
//                               const Icon(
//                                 Icons.keyboard_arrow_down,
//                                 color: Colors.grey,
//                               )
//                             ],
//                           )),
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Expanded(
//           child: StatusBuilder(
//             statusNotifier: provider.getNoticesStatus,
//             successBuilder: (context) => Padding(
//               padding: const EdgeInsets.all(16),
//               child: ListView.separated(
//                 itemCount: provider.notices.length,
//                 itemBuilder: (context, index) {
//                   DolbomNotice notice = provider.notices[index];
//                   return DolbomNoticeItem(notice: notice);
//                 },
//                 separatorBuilder: (BuildContext context, int index) =>
//                     const SizedBox(
//                   height: 8,
//                 ),
//               ),
//             ),
//             failBuilder: (context) => Text(provider.getNoticesErrorMessage),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class SelectSigunguModal extends StatefulWidget {
//   const SelectSigunguModal({super.key});
//
//   @override
//   State<SelectSigunguModal> createState() => _SelectSigunguModalState();
// }
//
// class _SelectSigunguModalState extends State<SelectSigunguModal> {
//   late DolbomNoticeProvider provider;
//
//   @override
//   void initState() {
//     super.initState();
//     provider = context.read<DolbomNoticeProvider>();
//   }
//
//   Sido selectedSido = sidoList.first;
//
//   late List<Sigungu> sigunguList;
//
//   @override
//   Widget build(BuildContext context) {
//     sigunguList = selectedSido.sigunguList;
//     return SizedBox(
//       height: MediaQuery.of(context).size.height * 0.8,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//               width: double.infinity,
//               padding: const EdgeInsets.fromLTRB(16, 24, 0, 16),
//               decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(24),
//                     topRight: Radius.circular(24)),
//                 color: Colors.white,
//               ),
//               child: const Text(
//                 "지역을 선택해주세요",
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
//               )),
//           Expanded(
//             child: Row(
//               children: [
//                 SizedBox(
//                     width: 100,
//                     child: ListView.builder(
//                         itemBuilder: (context, index) {
//                           Sido sido = sidoList[index];
//                           return ButtonBase(
//                             onTap: () {
//                               setState(() {
//                                 selectedSido = sido;
//                               });
//                             },
//                             child: Container(
//                               decoration: BoxDecoration(
//                                   color: selectedSido == sido
//                                       ? Colors.white
//                                       : null),
//                               padding: const EdgeInsets.all(16),
//                               alignment: Alignment.centerLeft,
//                               child: Text(sido.shortName),
//                             ),
//                           );
//                         },
//                         itemCount: sidoList.length)),
//                 Expanded(
//                   child: Container(
//                     color: Colors.white,
//                     child: ListView.builder(
//                         itemCount: sigunguList.length,
//                         itemBuilder: (context, index) {
//                           Sigungu sigungu = sigunguList[index];
//                           return ButtonBase(
//                             onTap: () {
//                               provider.getList(sigungu: sigungu.name);
//                               Navigator.pop(context);
//                             },
//                             child: Container(
//                               padding: const EdgeInsets.all(16),
//                               alignment: Alignment.centerLeft,
//                               child: Text(sigungu.name),
//                             ),
//                           );
//                         }),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class DolbomNoticeItem extends StatelessWidget {
//   const DolbomNoticeItem({super.key, required this.notice});
//
//   final DolbomNotice notice;
//
//   @override
//   Widget build(BuildContext context) {
//     final Address address = notice.dolbomLocation.address;
//     final List<Kid> kid = notice.kid;
//
//     return Container(
//         padding: const EdgeInsets.all(16),
//         decoration: const BoxDecoration(
//             borderRadius: BorderRadius.all(Radius.circular(24)),
//             color: Colors.white),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "${DateFormat("MM월 dd일").format(notice.startDateTime)}부터",
//               style: const TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//             Text(
//               "${DateFormat("hh:mm").format(notice.startDateTime)}~${DateFormat("hh:mm").format(notice.endDateTime)}",
//               style: const TextStyle(color: Colors.black45),
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             Row(
//               children: [
//                 const Icon(
//                   Icons.location_on_outlined,
//                   color: Colors.grey,
//                   size: 16,
//                 ),
//                 const SizedBox(
//                   width: 8,
//                 ),
//                 Text(
//                   "${address.sido} ${address.sigungu} ${address.bname}",
//                   style: const TextStyle(color: Colors.black54),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//             const Row(
//               children: [
//                 Icon(
//                   Icons.child_care_outlined,
//                   color: Colors.grey,
//                   size: 16,
//                 ),
//                 SizedBox(
//                   width: 8,
//                 ),
//                 // Text(
//                 //   "${AgeUtil.calKoreanAge(kid.birthday)}세, ${kid.gender}아",
//                 //   style: const TextStyle(color: Colors.black54),
//                 // )
//               ],
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//             Row(
//               children: [
//                 const Icon(
//                   Icons.paid_outlined,
//                   color: Colors.grey,
//                   size: 16,
//                 ),
//                 const SizedBox(
//                   width: 8,
//                 ),
//                 Text(
//                   "예상활동비 ${notice.pay}원",
//                   style: const TextStyle(fontWeight: FontWeight.w600),
//                 )
//               ],
//             )
//           ],
//         ));
//   }
// }
