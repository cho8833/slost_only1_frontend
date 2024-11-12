import 'package:flutter/material.dart';
import 'package:slost_only1/support/sigungu.dart';
import 'package:slost_only1/widget/button_base.dart';


class SelectBnameModal extends StatefulWidget {
  const SelectBnameModal({super.key, required this.onSelect});

  final void Function(Sigungu sigungu) onSelect;

  @override
  State<SelectBnameModal> createState() => _SelectBnameModalState();
}

class _SelectBnameModalState extends State<SelectBnameModal> {

  @override
  void initState() {
    super.initState();
  }

  Sido selectedSido = sidoList.first;

  late List<Sigungu> sigunguList;

  @override
  Widget build(BuildContext context) {
    sigunguList = selectedSido.sigunguList;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 24, 0, 16),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24)),
                color: Colors.white,
              ),
              child: const Text(
                "지역을 선택해주세요",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              )),
          Expanded(
            child: Row(
              children: [
                SizedBox(
                    width: 100,
                    child: ListView.builder(
                        itemBuilder: (context, index) {
                          Sido sido = sidoList[index];
                          return ButtonBase(
                            onTap: () {
                              setState(() {
                                selectedSido = sido;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: selectedSido == sido
                                      ? Colors.white
                                      : null),
                              padding: const EdgeInsets.all(16),
                              alignment: Alignment.centerLeft,
                              child: Text(sido.shortName),
                            ),
                          );
                        },
                        itemCount: sidoList.length)),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: ListView.builder(
                        itemCount: sigunguList.length,
                        itemBuilder: (context, index) {
                          Sigungu sigungu = sigunguList[index];
                          return ButtonBase(
                            onTap: () {
                              widget.onSelect(sigungu);
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              alignment: Alignment.centerLeft,
                              child: Text(sigungu.name),
                            ),
                          );
                        }),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}