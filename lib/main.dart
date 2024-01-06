import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quote/resources/appColor.dart';
import 'package:quote/resources/constraints.dart';
import 'package:quote/view/quotes.dart';
import 'package:quote/view/favouriteQuote.dart';

import 'package:quote/view_model/handleTheme.dart';
import 'package:quote/view_model/homeViewMOdel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'reposiory/themes.dart';

import 'view/setting.dart';
import 'view/userIntroPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sp = await SharedPreferences.getInstance();
  final String language = sp.getString(Constraints.localeKey) ?? "";
  final String theme = sp.getString(Constraints.themeKey) ?? "default";
  final ThemeMode themeMode = await HandleTheme().getThemeMode();
  final bool isAlreadyOpenApp =
      sp.getBool(Constraints.isAlreadyOpenApp) ?? false;
  runApp(MyApp(
      locale: language,
      isAlreadyOpenApp: isAlreadyOpenApp,
      themeMode: themeMode));
}

class MyApp extends StatelessWidget {
  const MyApp(
      {super.key,
      required this.locale,
      required this.isAlreadyOpenApp,
      required this.themeMode});
  final String locale;
  final bool isAlreadyOpenApp;
  final ThemeMode themeMode;
  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("my locale$locale");
    }
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        locale: locale != "" ? Locale(locale) : const Locale('en'),
        supportedLocales: const [Locale('en'), Locale('ne'), Locale('hi')],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        theme: Themes().lightTheme,
        darkTheme: Themes().darkTheme,
        themeMode: themeMode,
        home: isAlreadyOpenApp ? const MyHomePage() : const UserIntroPage()
        // const MyHomePage(title: 'Flutter Demo Home Page'),
        );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  final List<Widget> _tabs = [
    const Quotes(),
    const FavouriteQuote(),
    const Setting()
  ];

  @override
  Widget build(BuildContext context) {
    QuoteViewModel quoteViewModel = Get.put(QuoteViewModel());
    quoteViewModel.getQuote();
    return Scaffold(
        appBar: null,
        body: Obx(() => SafeArea(child: _tabs[quoteViewModel.index.value])),
        bottomNavigationBar: Obx(
          () => Container(
            child: BottomNavigationBar(
              onTap: (int value) {
                quoteViewModel.changeTab(value);
              },
              currentIndex: quoteViewModel.index.value,
              selectedFontSize: 16,
              elevation: 0,
              showUnselectedLabels: false,
              selectedIconTheme: const IconThemeData(color: Colors.black),
              selectedItemColor: Colors.black,
              unselectedItemColor: const Color.fromARGB(178, 2, 1, 1),
              items: [
                BottomNavigationBarItem(
                  tooltip: "Home",
                  backgroundColor: Colors.red,
                  icon: const Icon(Icons.home_filled),
                  label: AppLocalizations.of(context)!.home,
                ),
                BottomNavigationBarItem(
                  tooltip: "Favourite",
                  icon: const Icon(Icons.favorite_outline_rounded),
                  label: AppLocalizations.of(context)!.favourite,
                ),
                BottomNavigationBarItem(
                  tooltip: "Setting",
                  icon: const Icon(Icons.person),
                  label: AppLocalizations.of(context)!.settings,
                ),
              ],
            ),
          ),
        ));
  }
}
