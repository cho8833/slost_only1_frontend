import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/model/dolbom_location.dart';
import 'package:slost_only1/provider/dolbom_location_provider.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/widget/dolbom_location/edit_colbom_location_screen.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';
import 'package:status_builder/status_builder.dart';

class ManageDolbomLocationScreen extends StatefulWidget {
  const ManageDolbomLocationScreen({super.key});

  @override
  State<ManageDolbomLocationScreen> createState() =>
      _ManageDolbomLocationScreenState();
}

class _ManageDolbomLocationScreenState
    extends State<ManageDolbomLocationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(appBarObj: AppBar(), title: "돌봄 장소 관리"),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            DolbomLocationList(),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}

class DolbomLocationList extends StatefulWidget {
  const DolbomLocationList(
      {super.key, this.onTap, this.onSelect, this.isMultiSelect});

  final void Function(DolbomLocation)? onTap;

  final void Function(List<DolbomLocation>)? onSelect;

  final bool? isMultiSelect;

  @override
  State<DolbomLocationList> createState() => _DolbomLocationListState();
}

class _DolbomLocationListState extends State<DolbomLocationList> {
  late final DolbomLocationProvider provider;

  List<DolbomLocation> selectedList = [];

  @override
  void initState() {
    provider = context.read<DolbomLocationProvider>();
    provider.getMyLocations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StatusBuilder(
            statusNotifier: provider.getMyLocationStatus,
            successBuilder: (context) {
              return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    DolbomLocation dolbomLocation = provider.myLocations[index];
                    return DolbomLocationItem(
                      isSelected: selectedList.contains(dolbomLocation),
                      dolbomLocation: dolbomLocation,
                      onTap: widget.onTap,
                      onSelect: (selectedLocation) {
                        if (widget.isMultiSelect == true) {
                          if (selectedList.contains(dolbomLocation)) {
                            setState(() {
                              selectedList.remove(dolbomLocation);
                            });
                          } else {
                            setState(() {
                              selectedList.add(dolbomLocation);
                            });
                          }
                        } else {
                          if (selectedList.contains(dolbomLocation)) {
                            setState(() {
                              selectedList = [];
                            });
                          } else {
                            setState(() {
                              selectedList = [dolbomLocation];
                            });
                          }
                          widget.onSelect?.call(selectedList);
                        }
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 8,
                    );
                  },
                  itemCount: provider.myLocations.length);
            }),
        const SizedBox(height: 16,),
        ButtonBase(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const EditDolbomLocationScreen()));
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.blueAccent),
            child: const Text(
              "돌봄 장소 추가",
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

class DolbomLocationItem extends StatelessWidget {
  const DolbomLocationItem(
      {super.key,
      required this.dolbomLocation,
      this.onTap,
      this.onSelect,
      required this.isSelected});

  final DolbomLocation dolbomLocation;

  final void Function(DolbomLocation)? onTap;

  final void Function(DolbomLocation)? onSelect;

  final bool isSelected;

  Future<void> showDeleteDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: const Text("주소 삭제"),
            content: const Text("정말 주소 정보를 삭제하시겠습니까?"),
            actions: [
              TextButton(
                  onPressed: () {
                    context
                        .read<DolbomLocationProvider>()
                        .deleteLocation(dolbomLocation.id)
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
        onTap?.call(dolbomLocation);
        onSelect?.call(dolbomLocation);
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
                  dolbomLocation.name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    ButtonBase(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditDolbomLocationScreen(
                                    dolbomLocation: dolbomLocation))),
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
                        onTap: () => showDeleteDialog(context),
                        child: const Text('삭제')),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              dolbomLocation.address.address,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              dolbomLocation.address.details ?? "",
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
