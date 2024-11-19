import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1/enums/dolbom_category.dart';
import 'package:slost_only1/widget/button_base.dart';
import 'package:slost_only1/parent_screen/create_dolbom/create_dolbom_context.dart';
import 'package:slost_only1/parent_screen/create_dolbom/input_pay_screen.dart';
import 'package:slost_only1/widget/sub_page_app_bar.dart';

class SelectCategoryScreen extends StatefulWidget {
  const SelectCategoryScreen({super.key});

  @override
  State<SelectCategoryScreen> createState() => _SelectCategoryScreenState();
}

class _SelectCategoryScreenState extends State<SelectCategoryScreen> {
  late CreateDolbomContext createContext;

  List<DolbomCategory> categories = DolbomCategory.values;

  DolbomCategory? selected;

  @override
  void initState() {
    createContext = context.read<CreateDolbomContext>();
    selected = createContext.category;
    super.initState();
  }

  Widget titleText(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubPageAppBar(appBarObj: AppBar(), title: "돌봄 신청하기"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleText("수업 유형"),
            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  DolbomCategory category = categories[index];
                  return ButtonBase(
                    onTap: () {
                      setState(() {
                        selected = category;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: const Color(0xF2F2F2FF),
                          border: Border.all(
                              color: category == selected
                                  ? Colors.blueAccent
                                  : const Color(0xF2F2F2FF))),
                      child: Text(
                        category.title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 48,
            ),
            ButtonTemplate(
                title: "다음",
                onTap: () {
                  createContext.category = selected;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider.value(
                              value: createContext,
                              child: const InputPayScreen())));
                },
                isEnable: selected != null)
          ],
        ),
      ),
    );
  }
}
