import 'package:amazonclone/utils/constants.dart';
import 'package:amazonclone/widgets/categories_widget.dart';
import 'package:amazonclone/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SearchBarWidget(
          hasBackButton: false,
          isReadOnly: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 20,
              childAspectRatio: 2.2 / 3.5,
              mainAxisSpacing: 20,
            ),
            itemCount: categoriesList.length,
            itemBuilder: (context, index) => CategoryWidget(index: index),
          ),
        ),
      ),
    );
  }
}
