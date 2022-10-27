import 'package:amazonclone/model/user_details.dart';
import 'package:amazonclone/utils/color_themes.dart';
import 'package:flutter/material.dart';

class UserDetailsBar extends StatelessWidget {
  final double offset;
  final UserDetailsModel userdDetails;
  const UserDetailsBar(
      {Key? key, required this.offset, required this.userdDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Positioned(
      top: -offset / 3,
      child: Container(
        width: screenSize.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: lightBackgroundaGradient,
                begin: Alignment.centerRight,
                end: Alignment.centerRight)),
        // ignore: prefer_const_constructors
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 3,
            horizontal: 20,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.location_on_outlined,
                  color: Colors.grey[900],
                ),
              ),
              SizedBox(
                width: screenSize.width * .7,
                child: Text(
                  "Deliver To ${userdDetails.name} -${userdDetails.address}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey[900],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
