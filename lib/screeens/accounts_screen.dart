import 'package:dogmart/model/order_req_model.dart';
import 'package:dogmart/model/product_model.dart';
import 'package:dogmart/model/user_details_models.dart';
import 'package:dogmart/screeens/sell_screen.dart';
import 'package:dogmart/utils/color_themes.dart';
import 'package:dogmart/utils/constants.dart';
import 'package:dogmart/utils/utils.dart';
import 'package:dogmart/widgets/account_screen_appbar.dart';
import 'package:dogmart/widgets/custom_main_button.dart';
import 'package:dogmart/widgets/product_showcase_list_view.dart';
import 'package:dogmart/widgets/simple_product_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/userdetails_provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  List<Widget>? yourOrders;

  @override
  Size screenSize = Utils().getScreenSize();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AccountScreenAppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height,
          child: Column(
            children: [
              IntroductionAccountScreen(),
              SizedBox(
                height: 10,
              ),
              CustomMainButton(
                child: Text("Sign Out"),
                color: Colors.orangeAccent,
                isLoading: false,
                onPressed: () {
                  firebaseAuth.signOut();
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomMainButton(
                child: const Text("Sell"),
                color: Colors.blue.shade300,
                isLoading: false,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return SellScreen();
                  }));
                },
              ),
              FutureBuilder(
                future: firebaseFirestore
                    .collection('users')
                    .doc(firebaseAuth.currentUser!.uid)
                    .collection('orders')
                    .get(),
                builder: (
                  context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container();
                  } else {
                    List<Widget> children = [];
                    for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      ProductModel productModel = ProductModel.getModelFromJson(
                          json: snapshot.data!.docs[i].data());

                      children
                          .add(SimpleProductWidget(productModel: productModel));
                    }
                    return ProductShowcaseListView(
                        title: "Your orders", children: children);
                  }
                },
              ),
              // ProductShowcaseListView(
              //   title: "Your Orders",
              //   children: testChildren,
              // ),
              const Padding(
                padding: const EdgeInsets.all(18.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Order Requests",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                  child: StreamBuilder(
                stream: firebaseFirestore
                    .collection('users')
                    .doc(firebaseAuth.currentUser!.uid)
                    .collection('orderRequest')
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container();
                    print('yes');
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        OrderRequestModel orderRequestModel =
                            OrderRequestModel.getModelFromJson(
                                json: snapshot.data!.docs[index].data());

                        return ListTile(
                          title: Text(
                            "Order: ${orderRequestModel.orderName}",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(
                              "Address: ${orderRequestModel.buyerAddress}"),
                          trailing: IconButton(
                              onPressed: () async {
                                FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(firebaseAuth.currentUser!.uid)
                                    .collection("orderRequest")
                                    .doc(snapshot.data!.docs[index].id)
                                    .delete();
                              },
                              icon: Icon(Icons.check)),
                        );
                      },
                    );
                  }
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class IntroductionAccountScreen extends StatelessWidget {
  const IntroductionAccountScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserDetailsModel? userDetailsModel =
        Provider.of<UserDetailsProvider>(context, listen: false).userDetails;

    return Container(
      height: kAppBarHeight / 2,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: backgroundGradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Container(
        // height: kAppBarHeight / 2,
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [
        //       Colors.white,
        //       Colors.white.withOpacity(0.0000000000000001)
        //     ],
        //     begin: Alignment.bottomCenter,
        //     end: Alignment.topCenter,
        //   ),
        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                        text: "Hello",
                        style: TextStyle(
                          color: Color.fromARGB(255, 254, 255, 255),
                          fontSize: 25,
                        )),
                    TextSpan(
                        text: "  ${userDetailsModel.name}  ",
                        style: const TextStyle(
                            color: Color.fromARGB(255, 254, 253, 253),
                            fontSize: 21,
                            fontWeight: FontWeight.bold))
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://cdn.britannica.com/35/233235-050-8DED07E3/Pug-dog.jpg"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
