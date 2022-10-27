import 'package:amazonclone/screeens/result_screen.dart';
import 'package:amazonclone/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoriesHorizontalListViewBar extends StatelessWidget {
  const CategoriesHorizontalListViewBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kAppBarHeight,
      width: double.infinity,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoriesList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => ResultScreen(
                        query: categoriesList[index],
                      )),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      categoryLogos[index],
                    ),
                  ),
                  Text(
                    categoriesList[index],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
