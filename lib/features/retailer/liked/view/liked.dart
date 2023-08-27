import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shaudan_b2b/res/localizations/app_Strings.dart';

import '../controller/liked_controller.dart';

class Liked extends StatelessWidget {
  const Liked({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final likedController = LikedController.to;
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.liked),
        centerTitle: true,
        actions: [
          Obx(() => likedController.likedList.isEmpty
              ? const SizedBox()
              : IconButton(
                  icon: const Icon(LineIcons.trash),
                  onPressed: () {
                    likedController.removeAll();
                  })),
        ],
      ),
      body: likedController.likedList.isEmpty
          ? const Center(
              child: Text(
                "No Liked Products",
                style: TextStyle(fontSize: 20),
              ),
            )
          : Obx(
              () => ListView.builder(
                  itemCount: likedController.likedList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        contentPadding: const EdgeInsets.all(8.0),
                        title: Text(likedController.likedList[index].title!),
                        subtitle:
                            Text("${likedController.likedList[index].price}!"),
                        leading: Image.network(
                          likedController.likedList[index].images![0].sId!,
                          fit: BoxFit.cover,
                        ),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              // delete
                              IconButton(
                                  icon: const Icon(LineIcons.trash),
                                  onPressed: () {
                                    likedController.removeItem(
                                        likedController.likedList[index]);
                                  }),
                              // add to cart
                              IconButton(
                                  icon: const Icon(LineIcons.shoppingCart),
                                  onPressed: () {}),
                            ],
                          ),
                        ));
                  }),
            ),
    );
  }
}
