import 'package:amazonclone/model/user_details.dart';
import 'package:amazonclone/utils/constants.dart';
import 'package:amazonclone/widgets/banner_ad_widget.dart';
import 'package:amazonclone/widgets/categories_horizontal_list_view_bar.dart';
import 'package:amazonclone/widgets/product_showcase_list_view.dart';
import 'package:amazonclone/widgets/search_bar_widget.dart';
import 'package:amazonclone/widgets/simple_product_widget.dart';
import 'package:amazonclone/widgets/user_details_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController controller = ScrollController();
  double offset = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        offset = controller.position.pixels;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SearchBarWidget(
          hasBackButton: false,
          isReadOnly: true,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
                controller: controller,
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    CategoriesHorizontalListViewBar(),
                    BannerAdWidget(),
                    ProductShowcaseListView(
                      title: "Upto 70% off",
                      children: testChildren,
                    ),
                    ProductShowcaseListView(
                      title: "Upto 50% off",
                      children: testChildren,
                    ),
                    ProductShowcaseListView(
                      title: "Upto 30% off",
                      children: testChildren,
                    ),
                    ProductShowcaseListView(
                      title: "Explore",
                      children: testChildren,
                    ),
                  ],
                )),
            UserDetailsBar(
              offset: offset,
              userdDetails: UserDetailsModel(
                  address: 'Bansgadhi_5', name: 'Aavash Paudel'),
            )
          ],
        ),
      ),
    );
  }
}
