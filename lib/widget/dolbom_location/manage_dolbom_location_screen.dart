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
  late final DolbomLocationProvider provider;

  @override
  void initState() {
    provider = context.read<DolbomLocationProvider>();

    provider.getMyLocations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(appBarObj: AppBar(), title: "돌봄 장소 관리"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(child: StatusBuilder(
              statusNotifier: provider.getMyLocationStatus,
              successBuilder: (context) {
                return DolbomLocationList(dataList: provider.myLocations);
              }
            )),
            const SizedBox(
              height: 8,
            ),
            ButtonBase(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const EditDolbomLocationScreen()));
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
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}

class DolbomLocationList extends StatelessWidget {
  const DolbomLocationList({super.key, required this.dataList});

  final List<DolbomLocation> dataList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          DolbomLocation dolbomLocation = dataList[index];
          return DolbomLocationItem(dolbomLocation: dolbomLocation);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 8,
          );
        },
        itemCount: dataList.length);
  }
}

class DolbomLocationItem extends StatefulWidget {
  const DolbomLocationItem({super.key, required this.dolbomLocation});

  final DolbomLocation dolbomLocation;

  @override
  State<DolbomLocationItem> createState() => _DolbomLocationItemState();
}

class _DolbomLocationItemState extends State<DolbomLocationItem> {
  Future<void> showDeleteDialog() async {
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
                        .deleteLocation(widget.dolbomLocation.id)
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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black12, width: 1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.dolbomLocation.name,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  ButtonBase(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EditDolbomLocationScreen(dolbomLocation: widget.dolbomLocation))),
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
                      onTap: () => showDeleteDialog(), child: const Text('삭제')),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            widget.dolbomLocation.address.address,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            widget.dolbomLocation.address.details ?? "",
            style: const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 16),
          )
        ],
      ),
    );
  }
}
