import 'package:amazonclone/model/user_details.dart';
import 'package:amazonclone/resources/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../model/user_details.dart';

class UserDetailsProvider with ChangeNotifier {
  UserDetailsModel? userDetails;
  UserDetailsProvider()
      : userDetails = UserDetailsModel(
            name: "Load hudai xa", address: "Abey ekxin rukh na");

  Future<void> getData() async {
    userDetails = await CloudFirestoreClass().getNameAndAddress();
    notifyListeners();
  }
}
