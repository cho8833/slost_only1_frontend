import 'package:flutter/material.dart';
import 'package:slost_only1/support/sigungu.dart';
import 'package:slost_only1/widget/button_base.dart';

class SelectAddressModal extends StatefulWidget {
  const SelectAddressModal({super.key, this.multiSelect = false});

  final bool multiSelect;

  @override
  State<SelectAddressModal> createState() => _SelectAddressModalState();
}

class _SelectAddressModalState extends State<SelectAddressModal> {
  @override
  void initState() {
    super.initState();
  }

  List<_Selected> selected = [];

  Sido selectedSido = sidoList.first;

  late List<Sigungu> sigunguList;

  List<SelectedSigungu> returnValue(List<_Selected> data) {
    return data.map((s) => SelectedSigungu.from(s)).toList();
  }

  @override
  Widget build(BuildContext context) {
    sigunguList = selectedSido.sigunguList;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        if (selected.isEmpty) {
          Navigator.pop(context);
          return;
        }
        Navigator.pop(context, returnValue(selected));
      },
      child: SizedBox(
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
                            bool isSelected = selected.indexWhere((s) => s.sigungu == sigungu) != -1;
                            return ButtonBase(
                              onTap: () {
                                setState(() {
                                  selected.add(_Selected(
                                      selectedSido, sigungu));
                                });
                                if (widget.multiSelect) {

                                } else {
                                  Navigator.pop(context, returnValue(selected));
                                }
                              },
                              child: Container(
                                color: isSelected ? Colors.blueAccent.withOpacity(0.2) : Colors.transparent,
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
      ),
    );
  }
}

class _Selected {
  Sido sido;
  Sigungu sigungu;

  _Selected(this.sido, this.sigungu);
}

class SelectedSigungu {
  String sido;
  String sigungu;

  SelectedSigungu(this.sido, this.sigungu);

  factory SelectedSigungu.from(_Selected s) {
    return SelectedSigungu(s.sido.shortName, s.sigungu.name);
  }
}
