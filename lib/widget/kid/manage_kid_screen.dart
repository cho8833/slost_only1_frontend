import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/model/kid.dart';
import 'package:slost_only1/provider/kid_provider.dart';
import 'package:slost_only1/support/age_util.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/widget/kid/edit_kid_screen.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';
import 'package:status_builder/status_builder.dart';

class ManageKidScreen extends StatelessWidget {
  const ManageKidScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(
        appBarObj: AppBar(),
        title: '아이 정보 관리',
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: KidList(),
      ),
    );
  }
}

class KidList extends StatefulWidget {
  const KidList({
    super.key,
    this.onItemSelect,
    this.onItemTap,
  });

  // onItemSelect 가 null 이 아니면, Item 을 탭 했을 때 Border color 가 변하고
  // callback 작동
  final void Function(Kid)? onItemSelect;

  // onItemTap 이 null 이 아니면, Item 을 탭 했을 때 Border color 가 바뀌지 않지만
  // callback 은 작동
  final void Function(Kid)? onItemTap;

  @override
  State<KidList> createState() => _KidListState();
}

class _KidListState extends State<KidList> {
  late final KidProvider kidProvider;

  @override
  void initState() {
    super.initState();
    kidProvider = context.read<KidProvider>();
    kidProvider.getMyKids();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StatusBuilder(
            statusNotifier: kidProvider.getMyKidsStatus,
            successBuilder: (context) {
              return ListView.separated(
                shrinkWrap: true,
                itemCount: kidProvider.myKids.length,
                itemBuilder: (context, index) {
                  Kid kid = kidProvider.myKids[index];
                  return KidItem(
                    kid: kid,
                    onSelect: widget.onItemSelect,
                    onTap: widget.onItemTap,
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 8,
                ),
              );
            }),
        const SizedBox(height: 16,),
        ButtonBase(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const EditKidScreen()));
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.blueAccent),
            child: const Text(
              "아이 정보 추가",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}

class KidItem extends StatefulWidget {
  const KidItem({
    super.key,
    required this.kid,
    this.onSelect,
    this.onTap,
  });

  final Kid kid;

  final void Function(Kid)? onSelect;

  final void Function(Kid)? onTap;

  @override
  State<KidItem> createState() => _KidItemState();
}

class _KidItemState extends State<KidItem> {
  bool isSelected = false;

  Future<void> showDeleteDialog() async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: const Text("아이 정보 삭제"),
            content: const Text("정말 아이 정보를 삭제하시겠습니까?"),
            actions: [
              TextButton(
                  onPressed: () {
                    context
                        .read<KidProvider>()
                        .deleteKid(widget.kid.id)
                        .then((e) {
                      Navigator.pop(context);
                    });
                  },
                  child: const Text("예")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("아니오"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ButtonBase(
      onTap: () {
        if (widget.onSelect != null) {
          setState(() {
            isSelected = !isSelected;

          });
        }
        widget.onSelect?.call(widget.kid);
        widget.onTap?.call(widget.kid);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: isSelected ? Colors.blueAccent : Colors.black12,
                width: 1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.kid.name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    ButtonBase(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EditKidScreen(kid: widget.kid)));
                        },
                        child: const Text("수정")),
                    const SizedBox(
                      width: 8,
                    ),
                    const SizedBox(
                        height: 10,
                        child: VerticalDivider(
                          width: 1,
                          color: Colors.grey,
                        )),
                    const SizedBox(
                      width: 8,
                    ),
                    ButtonBase(
                        onTap: () => showDeleteDialog(),
                        child: const Text('삭제')),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "${AgeUtil.calKoreanAge(widget.kid.birthday)}세(만 ${AgeUtil.calInternationalAge(widget.kid.birthday)}세)",
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              widget.kid.remark ?? "아이에 대해 말씀해 주세요.",
              style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
