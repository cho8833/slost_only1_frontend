import 'package:daum_postcode_search/data_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart' as kakao;
import 'package:provider/provider.dart';
import 'package:slost_only1/data/dolbom_location_req.dart';
import 'package:slost_only1/model/dolbom_location.dart';
import 'package:slost_only1/provider/dolbom_location_provider.dart';
import 'package:slost_only1/widget/base_text_field.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/widget/dolbom_location/search_address_screen.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';
import 'package:slost_only1/model/address.dart';

class EditDolbomLocationScreen extends StatefulWidget {
  const EditDolbomLocationScreen({super.key, this.dolbomLocation});

  final DolbomLocation? dolbomLocation;

  @override
  State<EditDolbomLocationScreen> createState() =>
      _EditDolbomLocationScreenState();
}

class _EditDolbomLocationScreenState extends State<EditDolbomLocationScreen> {
  late kakao.KakaoMapController mapController;

  Address? address;
  String detailAddress = "";
  String name = "";

  @override
  void initState() {
    address = widget.dolbomLocation?.address;
    super.initState();
  }

  String? validate() {
    if (address == null) {
      return "주소를 선택해주세요";
    }
    if (name.isEmpty) {
      return "이름을 설정해주세요";
    }
    return null;
  }

  Address convert(DataModel search) {
    return Address(
        search.address, search.sido, search.sigungu, search.bname, null);
  }

  Widget inputTitle(String text, bool isRequired) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        isRequired
            ? const Text(
                "*",
                style: TextStyle(fontSize: 16, color: Colors.red),
              )
            : Container()
      ],
    );
  }

  void moveMap(Address address) {
    mapController
        .addressSearch(kakao.AddressSearchRequest(
        addr: address.address))
        .then((response) {
      if (response.list.isNotEmpty) {
        mapController.setCenter(kakao.LatLng(
            double.parse(response.list.first.y!),
            double.parse(response.list.first.x!)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SubPageAppBar(
            appBarObj: AppBar(),
            title: widget.dolbomLocation != null ? "돌봄 장소 수정" : "돌봄 장소 추가"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                inputTitle("주소명", true),
                BaseTextField(
                  onChange: (text) {
                    name = text;
                  },
                  initValue: widget.dolbomLocation?.name,
                ),
                const SizedBox(
                  height: 16,
                ),
                inputTitle("주소", true),
                ButtonBase(
                    onTap: () async {
                      DataModel? searchResult = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SearchAddressScreen()));
                      if (searchResult != null) {
                        setState(() {
                          address = convert(searchResult);
                        });
                        moveMap(address!);
                      }
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                          address != null ? address!.address : "주소를 선택해주세요"),
                    )),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 200,
                  child: kakao.KakaoMap(
                    onMapCreated: (controller) {
                      mapController = controller;
                      if (address != null) {
                        moveMap(address!);
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                inputTitle("상세 주소", false),
                BaseTextField(
                  onChange: (text) {
                    detailAddress = text;
                  },
                  initValue: widget.dolbomLocation?.address.details,
                ),
                const SizedBox(height: 16,),
                ButtonBase(
                    onTap: () {
                      String? validation = validate();
                      if (validation != null) {
                        Fluttertoast.showToast(msg: validation);
                        return;
                      }
                      address!.details = detailAddress;
                      context
                          .read<DolbomLocationProvider>()
                          .addLocation(DolbomLocationCreateReq(address!, name))
                          .then((_) {
                        Navigator.pop(context);
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.blueAccent),
                      alignment: Alignment.center,
                      child: Text(
                        widget.dolbomLocation != null ? "주소 수정하기" : "주소 추가하기",
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    )),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ));
  }
}
