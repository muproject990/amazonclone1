import 'dart:developer';
import 'dart:ui';

import 'package:amazonclone/screeens/signin_screen.dart';
import 'package:amazonclone/utils/color_themes.dart';
import 'package:amazonclone/utils/constants.dart';
import 'package:amazonclone/utils/utils.dart';
import 'package:amazonclone/widgets/custom_main_button.dart';
import 'package:amazonclone/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SignUpScreen extends StatefulWidget {
 const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  amazonLogo,
                  height: screenSize.height * 0.10,
                ),
                SizedBox(
                  height: screenSize.height * 0.7,
                  child: Container(
                    height: screenSize.height * 0.8,
                    width: screenSize.width * 0.8,
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sign Up",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 33,
                          ),
                        ),
                        TextFieldWidget(
                          title: "Name",
                          controller: nameController,
                          obscureText: false,
                          hintText: "Enter Your Name",
                        ),
                        TextFieldWidget(
                          title: "Address",
                          controller: addresscontroller,
                          obscureText: false,
                          hintText: "Enter Your Address",
                        ),
                        TextFieldWidget(
                          title: "Email",
                          controller: emailController,
                          obscureText: false,
                          hintText: "Enter Your Email",
                        ),
                        TextFieldWidget(
                          title: "Password",
                          controller: passwordController,
                          obscureText: true,
                          hintText: "Enter Your Password",
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomMainButton(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                letterSpacing: 0.5,
                              ),
                            ),
                            color: yellowColor,
                            isLoading: false,
                            onPressed: () async {
                              String output =
                                  await authenticationMethods.signUpUser(
                                      name: nameController.text,
                                      address: addresscontroller.text,
                                      email: emailController.text,
                                      password: passwordController.text);
                              if (output == "success") {
                                // ignore: use_build_context_synchronously
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const SignInScreen()));
                              } else {
                                Utils().showSnackBar(
                                    context: context, content: output);
                              }
                            }),
                      ],
                    ),
                  ),
                ),
                CustomMainButton(
                    child: Text(
                      "Back",
                      style: TextStyle(letterSpacing: 0.6, color: Colors.black),
                    ),
                    color: Colors.grey,
                    isLoading: false,
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return const SignInScreen();
                      }));
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
