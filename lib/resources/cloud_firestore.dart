import 'dart:convert';
import 'dart:typed_data';

import 'package:dogmart/model/order_req_model.dart';
import 'package:dogmart/model/product_model.dart';
import 'package:dogmart/model/review_model.dart';
import 'package:dogmart/model/user_details_models.dart';
import 'package:dogmart/utils/constants.dart';
import 'package:dogmart/utils/utils.dart';
import 'package:dogmart/widgets/simple_product_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class CloudFirestoreClass {
  Future uploadNameAndAddressToDatabase({
    required UserDetailsModel user,
  }) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .set(
          user.getJson(),
        );
  }

  Future getNameAndAddress() async {
    DocumentSnapshot snap = await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .get();
    UserDetailsModel userModel =
        UserDetailsModel.getModelFromJson(snap.data()! as dynamic);
    return userModel;
  }

  Future<String> uploadProductToDatabase({
    required Uint8List? image,
    required String productName,
    required String rawCost,
    required int discount,
    required String sellerName,
    required String sellerUid,
  }) async {
    productName.trim();
    rawCost.trim();
    String output = "Something went wrong";
    if (image != null && productName != "" && rawCost != "") {
      try {
        String uid = Utils().getUid();
        String url = await uploadImageToDatabase(image: image, uid: uid);
        double cost = double.parse(rawCost);
        cost = cost - (cost * discount) / 100;
        ProductModel productModel = ProductModel(
            url: url,
            productName: productName,
            cost: cost,
            discount: discount,
            uid: uid,
            sellerName: sellerName,
            sellerUid: sellerUid,
            rating: 5,
            noOfRating: 0);
        firebaseFirestore
            .collection('products')
            .doc(uid)
            .set(productModel.getJson());
        output = 'success';
      } catch (e) {
        output = e.toString();
        output = e.toString();
      }
    } else {
      output = "Please makes usre all field are not empty";
    }
    return output;
  }

  Future<String> uploadImageToDatabase(
      {required Uint8List image, required String uid}) async {
    Reference storageRef =
        FirebaseStorage.instance.ref().child('products').child(uid);
    UploadTask uploadTask = storageRef.putData(image);
    TaskSnapshot task = await uploadTask;
    return task.ref.getDownloadURL();
  }

  Future<List<Widget>> getProductsFromDiscount(int discount) async {
    List<Widget> children = [];
    QuerySnapshot<Map<String, dynamic>> snapshot = await firebaseFirestore
        .collection('products')
        .where('discount', isEqualTo: discount)
        .get();
    for (var i = 0; i < snapshot.docs.length; i++) {
      DocumentSnapshot documentSnapshot = snapshot.docs[i];
      ProductModel model = ProductModel.getModelFromJson(
          json: (documentSnapshot.data() as dynamic));
      children.add(SimpleProductWidget(productModel: model));
    }
    return children;
  }

  Future uploadReviewToDatabase({
    required String productUid,
    required ReviewModel reviewModel,
  }) async {
    await firebaseFirestore
        .collection('products')
        .doc(productUid)
        .collection('reviews')
        .add(reviewModel.getJson());
  }

  Future addProductToCart({required ProductModel productModel}) async {
    await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('cart')
        .doc(productModel.uid)
        .set(productModel.getJson());
  }

  Future deleteProductFromCart({required String uid}) async {
    // print(' uid is');
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("cart")
        .doc(uid)
        .delete();
  }

  Future buyAllItemsInCart({required UserDetailsModel userDetailsModel}) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('cart')
        .get();

    for (var i = 0; i < snapshot.docs.length; i++) {
      ProductModel productModel =
          ProductModel.getModelFromJson(json: snapshot.docs[i].data());
      addProductToOrdres(
          productModel: productModel, userDetailsModel: userDetailsModel);
      await deleteProductFromCart(uid: productModel.uid);
    }
  }

  Future addProductToOrdres(
      {required ProductModel productModel,
      required UserDetailsModel userDetailsModel}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection('orders')
        .add(productModel.getJson());

    await sendOrderRequest(
        productModel: productModel, userDetailsModel: userDetailsModel);
  }

  Future sendOrderRequest(
      {required ProductModel productModel,
      required UserDetailsModel userDetailsModel}) async {
    OrderRequestModel orderRequestModel = OrderRequestModel(
        buyerAddress: userDetailsModel.address,
        orderName: userDetailsModel.name);
    await firebaseFirestore
        .collection('users')
        .doc(productModel.sellerUid)
        .collection('orderRequest')
        .add(orderRequestModel.getJson());
  }
}
