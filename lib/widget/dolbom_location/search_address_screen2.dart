import 'package:daum_postcode_search/daum_postcode_search.dart';
import 'package:flutter/material.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';

class SearchAddressScreen2 extends StatefulWidget {
  const SearchAddressScreen2({super.key});

  @override
  State<SearchAddressScreen2> createState() => _SearchAddressScreen2State();
}

class _SearchAddressScreen2State extends State<SearchAddressScreen2> {
  bool _isError = false;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    DaumPostcodeSearch daumPostcodeSearch = DaumPostcodeSearch(
      onReceivedError: (controller, request, error) => setState(
            () {
          _isError = true;
          errorMessage = error.description;
        },
      ),
    );

    return Scaffold(
      appBar: SubPageAppBar(appBarObj: AppBar(), title: "주소 검색"),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 8,),
            Expanded(
              child: daumPostcodeSearch,
            ),
            Visibility(
              visible: _isError,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(errorMessage ?? ""),
                  ElevatedButton(
                    child: const Text("Refresh"),
                    onPressed: () {
                      daumPostcodeSearch.controller?.reload();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}