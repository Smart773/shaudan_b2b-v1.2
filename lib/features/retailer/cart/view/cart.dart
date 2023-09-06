import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shaudan_b2b/features/retailer/cart/data/models/cart_model.dart';
import 'package:shaudan_b2b/res/colors/AppColors.dart';
import 'package:shaudan_b2b/res/localizations/app_Strings.dart';
import 'package:input_quantity/input_quantity.dart';

import '../controller/cart_controller.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final CartController cartController = Get.put(CartController());
    return Scaffold(
      backgroundColor: AppColors.grayColor10,
      appBar: AppBar(
        title: const Text(AppStrings.cart),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                cartController.onDeletePressed();
              },
              icon: const Icon(
                LineIcons.trash,
                color: AppColors.primaryColor,
              )),
        ],
      ),
      bottomSheet: Container(
        height: 100,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(() => TotalAmount(
                      size: size, price: cartController.amount.toString())),
                  SizedBox(
                    width: size.width > 400 ? 150 : 120,
                    height: size.width > 400 ? 50 : 40,
                    child: ElevatedButton(
                      onPressed: () {
                        //
                        cartController.onCheckOutPressed();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Checkout",
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: size.width > 400 ? 14 : 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder<List<CartModel>>(
          future: cartController.getCartList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Obx(() => 
              cartController.cartList.value.isEmpty?
              const Center(
                child: Text("No Products in Cart"),
              ):
              ListView.builder(
                  itemCount: cartController.cartList.value.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartController.cartList.value[index];
                    return CartItem(
                      size: size,
                      image: cartItem.product!.images![0].url!,
                      title: cartItem.product!.title!,
                      price: cartItem.product!.price!.toString(),
                      description: cartItem.product!.description!,
                      qty: cartItem.quantity!,
                      qtymax: cartItem.product!.quantity!,
                      qtymin: 1,
                      isSelected: cartItem.isProductSelectedBool!,
                      onQtyChanged: (value) {
                        cartController.onPressQty(value as int, cartItem.sId!);
                      },
                      onpressSelected: () {
                        cartController.onPressSelected(
                            !cartItem.isProductSelectedBool!, cartItem.sId!);
                      },
                    );
                  }));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

// F(
//           stream: cartController.cartListStream,
//           builder:
//               (BuildContext context, AsyncSnapshot<List<CartModel>> snapshot) {
//             if (snapshot.hasData) {
//               return ListView.builder(
//                   itemCount: snapshot.data?.length,
//                   itemBuilder: (context, index) {
//                     final cartItem = snapshot.data![index];
//                     return CartItem(
//                       size: size,
//                       image: cartItem.product!.images![0].url!,
//                       title: cartItem.product!.title!,
//                       price: cartItem.product!.price!.toString(),
//                       description: cartItem.product!.description!,
//                       qty: cartItem.quantity!,
//                       qtymax: cartItem.product!.quantity!,
//                       qtymin: 1,
//                       isSelected: cartItem.isProductSelectedBool!,
//                       onQtyChanged: (value) {
//                         cartController.onPressQty(value as int, cartItem.sId!);
//                       },
//                       onpressSelected: () {
//                         cartController.onPressSelected(
//                             !cartItem.isProductSelectedBool!, cartItem.sId!);
//                       },
//                     );
//                   });
//             } else {
//               return const Center(child: CircularProgressIndicator());
//             }
//           }),

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.size,
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    required this.qty,
    required this.qtymax,
    required this.qtymin,
    required this.isSelected,
    required this.onQtyChanged,
    required this.onpressSelected,
  });

  final Size size;
  final String image;
  final String title;
  final String description;
  final String price;
  final int qty;
  final int qtymax;
  final int qtymin;
  final bool isSelected;
  final Function? onQtyChanged;
  final Function? onpressSelected;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // const Icon(Icons.check_circle, color: AppColors.primaryColor),
            IconButton(
                onPressed: () {
                  onpressSelected!();
                },
                icon: Icon(
                  isSelected ? Icons.check_circle : Icons.circle_outlined,
                  color: AppColors.primaryColor,
                )),
            const SizedBox(width: 10),
            Container(
              width: size.width > 400 ? 100 : 75,
              height: size.width > 400 ? 100 : 75,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: size.width > 400 ? 18 : 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: size.width > 400 ? 14 : 10,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Rs. $price",
                        style: TextStyle(
                          fontSize: size.width > 400 ? 14 : 10,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(
                        child: InputQty(
                          maxVal: qtymax,
                          minVal: qtymin,
                          initVal: qty,
                          isIntrinsicWidth: true,
                          onQtyChanged: (value) {
                            onQtyChanged!(value);
                            print(value);
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TotalAmount extends StatelessWidget {
  const TotalAmount({
    super.key,
    required this.size,
    required this.price,
  });

  final Size size;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            "Total",
            style: TextStyle(
              fontSize: size.width > 400 ? 16 : 12,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            "Rs. ${price}",
            style: TextStyle(
              fontSize: size.width > 400 ? 16 : 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
