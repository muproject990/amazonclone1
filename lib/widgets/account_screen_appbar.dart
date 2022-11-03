import 'package:amazonclone/utils/color_themes.dart';
import 'package:amazonclone/utils/constants.dart';
import 'package:amazonclone/utils/utils.dart';
import 'package:flutter/material.dart';

class AccountScreenAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  AccountScreenAppBar({Key? key})
      : preferredSize = const Size.fromHeight(kAppBarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return SafeArea(
      child: Container(
        height: kAppBarHeight,
        width: screenSize.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: backgroundGradient,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Image(
                  image: AssetImage(dogMartLogo),
                  height: kAppBarHeight * .9,
                )),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.notifications_outlined),
                  color: Colors.black,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search_outlined),
                  color: Colors.black,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
