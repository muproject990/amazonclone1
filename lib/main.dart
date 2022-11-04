import 'package:dogmart/layout/screen_layout.dart';
import 'package:dogmart/model/product_model.dart';
import 'package:dogmart/provider/userdetails_provider.dart';
import 'package:dogmart/screeens/product_screen.dart';
import 'package:dogmart/screeens/result_screen.dart';
import 'package:dogmart/screeens/sell_screen.dart';
import 'package:dogmart/screeens/sign_up_screen.dart';
import 'package:dogmart/screeens/signin_screen.dart';
import 'package:dogmart/utils/color_themes.dart';
import 'package:dogmart/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDTHHt8JMyxpjH9cXs8FcIkFJebjNG-yA8",
            authDomain: "dogstore-a66a0.firebaseapp.com",
            projectId: "dogstore-a66a0",
            storageBucket: "dogstore-a66a0.appspot.com",
            messagingSenderId: "787905943780",
            appId: "1:787905943780:web:ce237378a16c5f83de34f1"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const dogmart());
}

class dogmart extends StatelessWidget {
  const dogmart({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserDetailsProvider(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: backgroundColor,
          ),
          home:
              //  Scaffold(
              //   body: const SignInScreen(),
              // ),
              StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, AsyncSnapshot<User?> user) {
              if (user.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                );
              } else if (user.hasData) {
                // firebaseAuth.signOut();

                // return const SellScreen();
                return const ScreenLayout();
              } else {
                return SignInScreen();
              }
            },
          )),
    );
  }
}
