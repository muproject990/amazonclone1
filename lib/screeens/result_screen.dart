import 'package:amazonclone/widgets/result_widget.dart';
import 'package:amazonclone/widgets/search_bar_widget.dart';
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
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: 2 / 3),
                itemBuilder: (context, index) {
                  return ResultsWidget(
                    product: ProductModel(
                        url:
                            "https://m.media-amazon.com/images/I/11M0jYc-tRL._SX90_SY90_.png",
                        productName:
                            "aavash a  a  aaaaa                aaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaadddddddddddd  dddddddda",
                        cost: 100.5,
                        discount: 10,
                        uid: 'uid',
                        sellerName: 'sellerName',
                        sellerUid: 'sellerUid',
                        rating: 4,
                        noOfRating: 10),
                  );
                }),
          )
        ]),
      ),
    );
  }
}
