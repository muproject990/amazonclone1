// import 'dart:js';

import 'package:amazonclone/model/product_model.dart';
import 'package:amazonclone/model/user_details_models.dart';
import 'package:amazonclone/provider/userdetails_provider.dart';
import 'package:amazonclone/resources/authentication_method.dart';
import 'package:amazonclone/screeens/accounts_screen.dart';
import 'package:amazonclone/utils/utils.dart';
import 'package:amazonclone/widgets/simple_product_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screeens/cart_screen.dart';
import '../screeens/home_screen.dart';
import '../screeens/more_screen.dart';

const double kAppBarHeight = 80;
AuthenticationMethods authenticationMethods = AuthenticationMethods();
FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
// Size screenSize = MediaQuery.of(context).size;

const String dogMartLogo = 'assets/img/logo.png';

Size screenSize = Utils().getScreenSize();
// List<Widget> testChildren = [
//   SimpleProductWidget(
//     productModel: ProductModel(
//         url: "https://m.media-amazon.com/images/I/115yueUc1aL._SX90_SY90_.png",
//         productName: "aavash",
//         cost: 120.5,
//         discount: 10,
//         uid: 'uid',
//         sellerName: 'Aavash',
//         sellerUid: 'sellerUid',
//         rating: 10,
//         noOfRating: 3),
//   ),
//   SimpleProductWidget(
//     productModel: ProductModel(
//         url: "https://m.media-amazon.com/images/I/11M0jYc-tRL._SX90_SY90_.png",
//         productName: "aavash",
//         cost: 100.5,
//         discount: 10,
//         uid: 'uid',
//         sellerName: 'Aavash',
//         sellerUid: 'sellerUid',
//         rating: 10,
//         noOfRating: 3),
//   ),
//   SimpleProductWidget(
//     productModel: ProductModel(
//         url: "https://m.media-amazon.com/images/I/115yueUc1aL._SX90_SY90_.png",
//         productName: "aavash",
//         cost: 100.5,
//         discount: 10,
//         uid: 'uid',
//         sellerName: 'Aavash',
//         sellerUid: 'sellerUid',
//         rating: 10,
//         noOfRating: 3),
//   ),
// ];

const List<String> categoriesList = [
  "Prime",
  "Mobiles",
  "Fashion",
  "Electronics",
  "Home",
  "Fresh",
  "Appliances",
  "Books, Toys",
  "Essential"
];

const List<Widget> screens = [
  HomeScreen(),
  AccountScreen(),
  CartScreen(),
  MoreScreen(),
  // Center(child: Text('Home')),
  // Center(child: Text('Account')),
  // Center(child: Text('More Screen')),
];

const List<String> categoryLogos = [
  "https://m.media-amazon.com/images/I/11uufjN3lYL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/116KbsvwCRL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/115yueUc1aL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/11qyfRJvEbL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/11BIyKooluL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/11CR97WoieL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/01cPTp7SLWL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/11yLyO9f9ZL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/11M0jYc-tRL._SX90_SY90_.png",
];

const List<String> largeAds = [
  "https://m.media-amazon.com/images/I/51QISbJp5-L._SX3000_.jpg",
  "https://m.media-amazon.com/images/I/61jmYNrfVoL._SX3000_.jpg",
  "https://m.media-amazon.com/images/I/612a5cTzBiL._SX3000_.jpg",
  "https://m.media-amazon.com/images/I/61fiSvze0eL._SX3000_.jpg",
  "https://m.media-amazon.com/images/I/61PzxXMH-0L._SX3000_.jpg",
];

const List<String> smallAds = [
  "https://m.media-amazon.com/images/I/11M5KkkmavL._SS70_.png",
  "https://m.media-amazon.com/images/I/11iTpTDy6TL._SS70_.png",
  "https://m.media-amazon.com/images/I/11dGLeeNRcL._SS70_.png",
  "https://m.media-amazon.com/images/I/11kOjZtNhnL._SS70_.png",
];

const List<String> adItemNames = [
  "Amazon Pay",
  "Recharge",
  "Rewards",
  "Pay Bills"
];

//Dont even attemp to scroll to the end of this manually lmao
const String amazonLogo =
    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Amazon_logo.svg/2560px-Amazon_logo.svg.png";

List<String> keysOfRating = [
  "Very bad",
  "Poor",
  "Average",
  "Good",
  "Excellent"
];

// provider
