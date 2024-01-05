import 'package:flutter/material.dart';
import 'package:quote/resources/components/smallText.dart';
import 'package:quote/resources/locale.dart';
import 'package:quote/view_model/handleLocale.dart';

import '../view_model/handleTheme.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
          child: SingleChildScrollView(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            ExpansionTile(
              expandedAlignment: Alignment.centerLeft,
              childrenPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              maintainState: true,
              title: const Text("Theme"),
              children: [
                InkWell(
                  onTap: () {
                    ThemeController().changeThemeMode();
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const BuildText(text: "Dark")),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const BuildText(text: "Light")),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const BuildText(text: "System ")),
                ),
              ],
            ),
            ExpansionTile(
                maintainState: true,
                expandedAlignment: Alignment.centerLeft,
                childrenPadding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                title: const BuildText(text: "Language"),
                children: List.generate(locale.length, (index) {
                  return InkWell(
                    onTap: () {
                      HandleLocale().changeLocale(
                          locale[index]['language'], locale[index]['locale']);
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: BuildText(text: locale[index]['name'])),
                  );
                }).toList()),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  TextButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(Colors.red)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const BuildText(
                        text: "Quit App",
                        color: Colors.white,
                      )),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
