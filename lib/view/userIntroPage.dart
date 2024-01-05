import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quote/resources/appColor.dart';
import 'package:quote/resources/components/buildImage.dart';
import 'package:quote/view_model/homeViewMOdel.dart';

class UserIntroPage extends StatelessWidget {
  const UserIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: null,
      body: PageView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BuildImage(assetURL: "assets/quote_right.png"),
                SizedBox(
                  height: size.height * 0.03,
                ),
                const Text(
                  "Gets 100 of quotes and get Motivated",
                  style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                const BuildImage(assetURL: "assets/quote_left.png"),
                SizedBox(
                  height: size.height * 0.03,
                ),
                const Divider(
                  thickness: 2,
                  color: Colors.black,
                )
              ],
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    constraints: const BoxConstraints(
                        maxHeight: 80,
                        maxWidth: 200,
                        minHeight: 80,
                        minWidth: 180),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      color: AppColors.colorBlack,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: (){
                        QuoteViewModel.handleGetStarted(context);
                     
                      },
                      child: const Text(
                        "Lets Go",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontFamily: "Roboto"),
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
