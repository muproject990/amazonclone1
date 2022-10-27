import 'package:amazonclone/utils/color_themes.dart';
import 'package:amazonclone/utils/constants.dart';
import 'package:amazonclone/utils/utils.dart';
import 'package:amazonclone/widgets/account_screen_appbar.dart';
import 'package:amazonclone/widgets/custom_main_button.dart';
import 'package:amazonclone/widgets/product_showcase_list_view.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Size screenSize = Utils().getScreenSize();
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AccountScreenAppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height,
          child: Column(
            children: [
              IntroductionAccountScreen(),
              SizedBox(
                height: 10,
              ),
              CustomMainButton(
                child: Text("Sign_in"),
                color: Colors.orangeAccent,
                isLoading: false,
                onPressed: () {},
              ),
              const SizedBox(
                height: 10,
              ),
              CustomMainButton(
                child: const Text("Sell"),
                color: Colors.blue.shade300,
                isLoading: false,
                onPressed: () {},
              ),
              ProductShowcaseListView(
                title: "Your Orders",
                children: testChildren,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Order Requests",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: const Text(
                            "Order: Black Dog ",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: const Text("Address:SomeWhere on the earth"),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.check),
                          ),
                        );
                      }))
            ],
          ),
        ),
      ),
    );
  }
}

class IntroductionAccountScreen extends StatelessWidget {
  const IntroductionAccountScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kAppBarHeight / 2,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: backgroundGradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Container(
        // height: kAppBarHeight / 2,
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [
        //       Colors.white,
        //       Colors.white.withOpacity(0.0000000000000001)
        //     ],
        //     begin: Alignment.bottomCenter,
        //     end: Alignment.topCenter,
        //   ),
        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "hello",
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 27,
                        )),
                    TextSpan(
                        text: " Aavash",
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 26,
                            fontWeight: FontWeight.bold))
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://m.media-amazon.com/images/I/11M0jYc-tRL._SX90_SY90_.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
