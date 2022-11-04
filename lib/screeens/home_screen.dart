import 'package:dogmart/model/user_details_models.dart';
import 'package:dogmart/resources/cloud_firestore.dart';
import 'package:dogmart/utils/constants.dart';
import 'package:dogmart/widgets/banner_ad_widget.dart';
import 'package:dogmart/widgets/categories_horizontal_list_view_bar.dart';
import 'package:dogmart/widgets/loding_widget.dart';
import 'package:dogmart/widgets/product_showcase_list_view.dart';
import 'package:dogmart/widgets/search_bar_widget.dart';
import 'package:dogmart/widgets/simple_product_widget.dart';
import 'package:dogmart/widgets/user_details_bar.dart';
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
  List<Widget>? discount50;
  List<Widget>? discount70;
  List<Widget>? discount60;
  List<Widget>? discount0;

  @override
  void initState() {
    super.initState();
    getData();
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

  void getData() async {
    List<Widget> temp70 =
        await CloudFirestoreClass().getProductsFromDiscount(70);
    List<Widget> temp60 =
        await CloudFirestoreClass().getProductsFromDiscount(60);
    List<Widget> temp50 =
        await CloudFirestoreClass().getProductsFromDiscount(50);
    List<Widget> temp0 = await CloudFirestoreClass().getProductsFromDiscount(0);
    setState(() {
      discount70 = temp70;
      discount60 = temp60;
      discount50 = temp50;
      discount0 = temp0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SearchBarWidget(
          hasBackButton: false,
          isReadOnly: true,
        ),
        body: discount70 != null &&
                discount60 != null &&
                discount50 != null &&
                discount0 != null
            ? Stack(
                children: [
                  SingleChildScrollView(
                      controller: controller,
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          const CategoriesHorizontalListViewBar(),
                          BannerAdWidget(),
                          ProductShowcaseListView(
                            title: "Upto 70% off",
                            children: discount70!,
                          ),
                          ProductShowcaseListView(
                            title: "Upto 60% off",
                            children: discount60!,
                          ),
                          ProductShowcaseListView(
                            title: "Upto 50% off",
                            children: discount50!,
                          ),
                          ProductShowcaseListView(
                            title: "Explore",
                            children: discount0!,
                          ),
                        ],
                      )),
                  UserDetailsBar(
                    offset: offset,
                  ),
                ],
              )
            : const LoadingWidget(),
      ),
    );
  }
}
