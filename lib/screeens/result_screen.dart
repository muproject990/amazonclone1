import 'package:dogmart/utils/constants.dart';
import 'package:dogmart/widgets/loding_widget.dart';
import 'package:dogmart/widgets/result_widget.dart';
import 'package:dogmart/widgets/search_bar_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/product_model.dart';

class ResultScreen extends StatelessWidget {
  final String query;
  const ResultScreen({Key? key, required this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SearchBarWidget(
          isReadOnly: false,
          hasBackButton: true,
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: RichText(
              text: TextSpan(children: [
                const TextSpan(
                    text: "Showing Result for ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    )),
                TextSpan(
                    text: query,
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.black38)),
              ]),
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: firebaseFirestore
                .collection('products')
                .where("productName", isEqualTo: query)
                .get(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingWidget();
              } else {
                return GridView.builder(
                    itemCount: snapshot.data!.docs.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, childAspectRatio: 2 / 3.5),
                    itemBuilder: (context, index) {
                      ProductModel productModel = ProductModel.getModelFromJson(
                          json: snapshot.data!.docs[index].data());
                      return ResultsWidget(
                        product: productModel,
                      );
                    });
              }
            },
          ))
        ]),
      ),
    );
  }
}
