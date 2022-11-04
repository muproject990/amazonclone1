// import 'dart:js';

import 'package:dogmart/model/product_model.dart';
import 'package:dogmart/model/user_details_models.dart';
import 'package:dogmart/provider/userdetails_provider.dart';
import 'package:dogmart/resources/authentication_method.dart';
import 'package:dogmart/screeens/accounts_screen.dart';
import 'package:dogmart/utils/utils.dart';
import 'package:dogmart/widgets/simple_product_widget.dart';
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

const String amazonLogoUrl = "assets/img/logo.png";

Size screenSize = Utils().getScreenSize();

const List<Widget> screens = [
  HomeScreen(),
  AccountScreen(),
  CartScreen(),
  MoreScreen(),
  // Center(child: Text('Home')),
  // Center(child: Text('Account')),
  // Center(child: Text('More Screen')),
];
const List<String> categoriesList = [
  "Labrador Retriever",
  "German Shepherd",
  "Golden Retriever",
  "Pug",
  "Beagle",
  "Boxer",
  "Rottweiler",
  "Poodle",
  "Cocker Spaniel"
];
const List<String> categoryLogos = [
  "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F47%2F2021%2F06%2F25%2Flabrador-retriever-yellow-sitting-275580695-2000.jpg",
  "https://upload.wikimedia.org/wikipedia/commons/d/d0/German_Shepherd_-_DSC_0346_%2810096362833%29.jpg",
  "https://www.thefamilypethospital.com/sites/default/files/styles/large/public/golden-retriever-dog-breed-info.jpg?itok=5g5ejXaU",
  "https://cdn.britannica.com/35/233235-050-8DED07E3/Pug-dog.jpg",
  "https://www.akc.org/wp-content/uploads/2017/11/Beagles-standing-in-a-frosty-field-on-a-cold-morning.jpg",
  "https://media-be.chewy.com/wp-content/uploads/2021/04/16140537/Boxer_Feature-Image-1024x615.jpg",
  "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F47%2F2020%2F08%2F06%2Frottweiler-headshot-678833089-2000.jpg",
  "https://media-be.chewy.com/wp-content/uploads/2021/05/21102059/Poodle-FeaturedImage-1024x615.jpg",
  "https://media-be.chewy.com/wp-content/uploads/2021/05/05180433/Cocker-Spaniel_FeaturedImage-1024x615.jpg",
];

const List<String> largeAds = [
  "https://www.akc.org/wp-content/uploads/2017/11/Cocker-Spaniel-running-in-the-yard.jpg",
  "https://www.hundeo.com/wp-content/uploads/2019/09/Amerikanischer-Cocker-Spaniel-kleiner-Welpe.jpg",
  "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/golden-retriever-royalty-free-image-506756303-1560962726.jpg?crop=0.672xw:1.00xh;0.166xw,0&resize=640:*",
  "https://i.pinimg.com/736x/bb/02/43/bb024355d8e885fa68032f83126de853.jpg",
  "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/dog-puppy-on-garden-royalty-free-image-1586966191.jpg?crop=1.00xw:0.669xh;0,0.190xh&resize=640:*",
];

//Dont even attemp to scroll to the end of this manually lmao
const String DogmartLogo = "assets/img/logo.png";

List<String> keysOfRating = [
  "Very bad",
  "Poor",
  "Average",
  "Good",
  "Excellent"
];

// provider
