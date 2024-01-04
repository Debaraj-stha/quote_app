import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quote/view/quotes.dart';
import 'package:quote/view_model/favouriteQuote.dart';
import 'package:quote/view_model/handleLocale.dart';
import 'package:quote/view_model/handleTheme.dart';
import 'package:quote/view_model/quoteViewModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'reposiory/themes.dart';
import 'package:http/http.dart' as http;

import 'view_model/account.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sp = await SharedPreferences.getInstance();
  final String language = sp.getString('locale') ?? "";

  runApp(MyApp(
    locale: language,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.locale});
  final String locale;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      locale: locale != "" ? Locale(locale) : const Locale('en'),
      supportedLocales: const [Locale('en'), Locale('np'), Locale('hi')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      theme: Themes().lightTheme,
      darkTheme: Themes().darkTheme,
      themeMode: ThemeController().getThemeMode(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

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
    const Account()
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
              items: const [
                BottomNavigationBarItem(
                  tooltip: "Home",
                  backgroundColor: Colors.red,
                  icon: Icon(Icons.home_filled),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  tooltip: "Favourite",
                  icon: Icon(Icons.favorite_outline_rounded),
                  label: "Favourite",
                ),
                BottomNavigationBarItem(
                  tooltip: "Account",
                  icon: Icon(Icons.person),
                  label: "Account",
                ),
              ],
            ),
          ),
        ));
  }
}
