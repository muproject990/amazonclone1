import 'package:amazonclone/model/product_model.dart';
import 'package:amazonclone/model/user_details.dart';
import 'package:amazonclone/utils/constants.dart';
import 'package:amazonclone/widgets/cart_item_widget.dart';
import 'package:amazonclone/widgets/custom_main_button.dart';
import 'package:amazonclone/widgets/search_bar_widget.dart';
import 'package:amazonclone/widgets/user_details_bar.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SearchBarWidget(
          hasBackButton: false,
          isReadOnly: true,
        ),
        body: Center(
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: kAppBarHeight / 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomMainButton(
                        child: Text("Proceed to buy"),
                        color: Colors.amber.shade400,
                        isLoading: false,
                        onPressed: () {}),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return CartItemWidget(
                            product: ProductModel(
                                url:
                                    "https://m.media-amazon.com/images/I/11M0jYc-tRL._SX90_SY90_.png",
                                productName: "aavash",
                                cost: 100.5,
                                discount: 10,
                                uid: 'uid',
                                sellerName: 'Aavash',
                                sellerUid: 'sellerUid',
                                rating: 10,
                                noOfRating: 3),
                          );
                        }),
                  )
                ],
              ),
              UserDetailsBar(
                offset: 0,
                userdDetails: UserDetailsModel(address: "some", name: "Aavash"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
