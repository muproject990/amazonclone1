import 'package:dogmart/utils/color_themes.dart';
import 'package:dogmart/utils/constants.dart';
import 'package:flutter/material.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({Key? key}) : super(key: key);

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  int currentAd = 0;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onHorizontalDragEnd: (_) {
        if (currentAd == largeAds.length - 1) {
          currentAd = -1;
        }
        setState(() {
          currentAd++;
        });
      },
      child: Stack(
        children: [
          SizedBox(
            width: screenSize.width,
            height: 200,
            child: Image.network(
              largeAds[currentAd],
              fit: BoxFit.fill,
              width: double.infinity,
            ),
          )
        ],
      ),
    );
  }
}
