import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:slost_only1/widget/base_text_field.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';

class SearchAddressScreen extends StatefulWidget {
  const SearchAddressScreen({super.key, required this.controller});

  final KakaoMapController controller;

  @override
  State<SearchAddressScreen> createState() => _SearchAddressScreenState();
}

class _SearchAddressScreenState extends State<SearchAddressScreen> {
  List<SearchAddress> searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(appBarObj: AppBar(), title: "주소 검색"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            BaseTextField(
              onSubmitted: (text) {
                widget.controller
                    .addressSearch(AddressSearchRequest(size: 10, addr: text, analyzeType: AnalyzeType.similar))
                    .then((response) {
                  setState(() {
                    searchResults = response.list;
                  });
                });
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(child: AddressList(searchResult: searchResults))
          ],
        ),
      ),
    );
  }
}

class AddressList extends StatelessWidget {
  const AddressList({super.key, required this.searchResult});

  final List<SearchAddress> searchResult;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: searchResult.length,
        itemBuilder: (context, index) {
          SearchAddress address = searchResult[index];

          return ButtonBase(
            onTap: () {
              Navigator.pop(context, address);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  address.roadAddress?.zoneNo != null
                      ? Text(
                          address.roadAddress!.zoneNo,
                          style: const TextStyle(fontSize: 16, color: Colors.red),
                        )
                      : Container(),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.blueAccent),
                        ),
                        child: const Text(
                          "도로명",
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      address.roadAddress?.addressName != null
                          ? Text(address.roadAddress!.addressName)
                          : Container()
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.blueAccent),
                        ),
                        child: const Text(
                          "지번",
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      address.address?.addressName != null
                          ? Text(address.address!.addressName)
                          : Container()
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
