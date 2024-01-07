import 'package:flutter/material.dart';
import 'package:quote/resources/components/smallText.dart';
import 'package:quote/resources/locale.dart';
import 'package:quote/view_model/handleLocale.dart';

import '../view_model/handleTheme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
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
              title: BuildText(text: AppLocalizations.of(context)!.theme),
              children: [
                InkWell(
                  onTap: () {
                    HandleTheme().changeTheme("dark");
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child:
                          BuildText(text: AppLocalizations.of(context)!.dark)),
                ),
                InkWell(
                  onTap: () {
                    HandleTheme().changeTheme("light");
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child:
                          BuildText(text: AppLocalizations.of(context)!.light)),
                ),
                InkWell(
                    onTap: () {
                      HandleTheme().changeTheme("system");
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child:
                          BuildText(text: AppLocalizations.of(context)!.system),
                    )),
              ],
            ),
            ExpansionTile(
                maintainState: true,
                expandedAlignment: Alignment.centerLeft,
                childrenPadding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                title: BuildText(text: AppLocalizations.of(context)!.language),
                children: List.generate(locale.length, (index) {
                  return InkWell(
                    onTap: () {
                      HandleLocale().changeLocale(
                          locale[index]['code'], locale[index]['locale']);
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
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Quit",
                        style: Theme.of(context)
                            .primaryTextTheme
                            .titleSmall!
                            .copyWith(color: Colors.white),
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
