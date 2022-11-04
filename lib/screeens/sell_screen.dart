import 'dart:typed_data';

import 'package:dogmart/provider/userdetails_provider.dart';
import 'package:dogmart/resources/cloud_firestore.dart';
import 'package:dogmart/utils/color_themes.dart';
import 'package:dogmart/utils/constants.dart';
import 'package:dogmart/utils/utils.dart';
import 'package:dogmart/widgets/custom_main_button.dart';
import 'package:dogmart/widgets/loding_widget.dart';
import 'package:dogmart/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({Key? key}) : super(key: key);

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  bool isLoading = false;
  int selected = 1;
  Uint8List? image;
  TextEditingController nameController = TextEditingController();
  TextEditingController costController = TextEditingController();
  List<int> keysForDiscount = [0, 70, 60, 50];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: !isLoading
            ? SingleChildScrollView(
                child: SizedBox(
                  height: screenSize.height,
                  width: screenSize.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      image == null
                          ? Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Image.network(
                                    'https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg',
                                    height: screenSize.height / 10,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () async {
                                      Uint8List? temp =
                                          await Utils().pickImage();
                                      if (temp != null) {
                                        setState(() {
                                          image = temp;
                                        });
                                      }
                                    },
                                    icon: const Icon(Icons.file_upload))
                              ],
                            )
                          : Image.memory(
                              image!,
                              height: screenSize.height / 10,
                            ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 35, vertical: 10),
                        height: screenSize.height * 0.7,
                        width: screenSize.width * 0.7,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFieldWidget(
                                title: "Name",
                                controller: nameController,
                                obscureText: false,
                                hintText: "Enter the name of the item"),
                            TextFieldWidget(
                                title: "Cost",
                                controller: costController,
                                obscureText: false,
                                hintText: "Enter the cost of the item"),
                            const Text(
                              "Discount",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            ListTile(
                              title: Text("None"),
                              leading: Radio(
                                value: 1,
                                groupValue: selected,
                                onChanged: (int? i) {
                                  setState(() {
                                    selected = i!;
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              title: Text("70%"),
                              leading: Radio(
                                value: 2,
                                groupValue: selected,
                                onChanged: (int? i) {
                                  setState(() {
                                    selected = i!;
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              title: Text("60%"),
                              leading: Radio(
                                value: 3,
                                groupValue: selected,
                                onChanged: (int? i) {
                                  setState(() {
                                    selected = i!;
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              title: Text("50%"),
                              leading: Radio(
                                value: 4,
                                groupValue: selected,
                                onChanged: (int? i) {
                                  setState(() {
                                    selected = i!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomMainButton(
                        child: const Text(
                          "Sell",
                          style: TextStyle(color: Colors.black),
                        ),
                        color: yellowColor,
                        isLoading: isLoading,
                        // onPressed: () async {
                        //   String output = await CloudFirestoreClass()
                        //       .uploadProductToDatabase(
                        //           image: image,
                        //           productName: nameController.text,
                        //           rawCost: costController.text,
                        //           discount: keysForDiscount[selected - 1],
                        //           sellerName:
                        //               Provider.of<UserDetailsProvider>(
                        //                       context,
                        //                       listen: false)
                        //                   .userDetails
                        //                   .name,
                        //           sellerUid:
                        //               FirebaseAuth.instance.currentUser!.uid);
                        //   if (output == "success") {
                        //     Utils().showSnackBar(
                        //         context: context, content: "Posted Product");
                        //   } else {
                        //     Utils().showSnackBar(
                        //         context: context, content: output);
                        //   }
                        // }),
                        onPressed: () async {
                          String output = await CloudFirestoreClass()
                              .uploadProductToDatabase(
                            image: image,
                            productName: nameController.text,
                            rawCost: costController.text,
                            discount: keysForDiscount[selected - 1],
                            sellerName: Provider.of<UserDetailsProvider>(
                                    context,
                                    listen: false)
                                .userDetails
                                .name,
                            sellerUid: firebaseAuth.currentUser!.uid,
                          );

                          if (output == "success") {
                            Utils().showSnackBar(
                                context: context, content: "Posted Content");
                          } else {
                            Utils().showSnackBar(
                                context: context, content: output);
                          }
                        },
                      ),
                      CustomMainButton(
                          child: const Text(
                            "Back",
                            style: TextStyle(color: Colors.black),
                          ),
                          color: Colors.grey[300]!,
                          isLoading: false,
                          onPressed: () {
                            Navigator.pop(context);
                          })
                    ],
                  ),
                ),
              )
            : LoadingWidget(),
      ),
    );
  }
}
