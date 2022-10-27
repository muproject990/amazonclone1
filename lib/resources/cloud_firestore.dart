import 'package:amazonclone/model/user_details.dart';
import 'package:amazonclone/utils/constants.dart';
import 'package:amazonclone/widgets/user_details_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        UserDetailsModel.getModelFromJson(snap.data() as dynamic);
    return userModel;
  }
}
