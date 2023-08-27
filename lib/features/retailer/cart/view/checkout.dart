import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaudan_b2b/features/retailer/cart/controller/cart_controller.dart';
import 'package:shaudan_b2b/features/retailer/cart/controller/checkout_controller.dart';
import 'package:shaudan_b2b/features/retailer/cart/data/models/cart_model.dart';
import 'package:shaudan_b2b/res/colors/AppColors.dart';
import 'package:shaudan_b2b/utils/utils.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({super.key});

  @override
  Widget build(BuildContext context) {
    final checkOutController = Get.put(CheckoutController());
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.grayColor10,
      appBar: AppBar(
        title: const Text('CheckOut'),
        backgroundColor: AppColors.primaryColor,
      ),
      bottomSheet: size.width > 600 ? const SizedBox() : PlaceOrderButton(size: size, checkOutController: checkOutController),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 600) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // product Item
                SizedBox(
                  width: size.width > 940 ? size.width * 0.1 : 0,
                ),

                Expanded(
                  flex: size.width > 920 ? 2 : 1,
                  child: ListView.builder(
                    itemCount: checkOutController.cartList.length,
                    itemBuilder: (context, index) {
                      CartModel cartModel = checkOutController.cartList[index];
                      return ProductItemCard(
                        size: size,
                        imageUrl: cartModel.product!.images![0].url!,
                        productName: cartModel.product!.title!,
                        productDescription: cartModel.product!.description!,
                        productPrice: cartModel.product!.price!.toString(),
                        productQty: cartModel.quantity.toString(),
                        productSubTotal:
                            (cartModel.product!.price! * cartModel.quantity!)
                                .toString(),
                      );
                    },
                  ),
                ),
                // User Info and Order Summery
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        UserInfoCard(
                            checkOutController: checkOutController, size: size),
                        OrderSummeryBlock(
                            size: size, checkOutController: checkOutController),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: PlaceOrderButton(size: size, checkOutController: checkOutController),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  width: size.width > 940 ? size.width * 0.1 : 0,
                ),
              ],
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  // User Info
                  UserInfoCard(
                      checkOutController: checkOutController, size: size),
                  for (int i = 0; i < checkOutController.cartList.length; i++)
                    ProductItemCard(
                      size: size,
                      imageUrl: checkOutController
                          .cartList[i].product!.images![0].url!,
                      productName:
                          checkOutController.cartList[i].product!.title!,
                      productDescription:
                          checkOutController.cartList[i].product!.description!,
                      productPrice: checkOutController
                          .cartList[i].product!.price!
                          .toString(),
                      productQty:
                          checkOutController.cartList[i].quantity.toString(),
                      productSubTotal:
                          (checkOutController.cartList[i].product!.price! *
                                  checkOutController.cartList[i].quantity!)
                              .toString(),
                    ),
                  OrderSummeryBlock(
                      size: size, checkOutController: checkOutController),
                  SizedBox(height: 50),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class UserInfoCard extends StatelessWidget {
  const UserInfoCard({
    super.key,
    required this.checkOutController,
    required this.size,
  });

  final CheckoutController checkOutController;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      name: checkOutController.user.name!,
      size: size,
      address: checkOutController.user.address!.toString(),
      phone: checkOutController.user.contact!.phoneNumber!,
      email: checkOutController.user.account!.email!,
    );
  }
}

class OrderSummeryBlock extends StatelessWidget {
  const OrderSummeryBlock({
    super.key,
    required this.size,
    required this.checkOutController,
  });

  final Size size;
  final CheckoutController checkOutController;

  @override
  Widget build(BuildContext context) {
    return OrderSummery(
      size: size,
      totalItemPrice: checkOutController.totalItemAmount.toString(),
      deliveryCharges: checkOutController.deleveryCharges.toString(),
      discount: checkOutController.discount.toString(),
      totalPayable: checkOutController.totalAmount.toString(),
    );
  }
}

class PlaceOrderButton extends StatelessWidget {
  const PlaceOrderButton({
    super.key,
    required this.size,
    required this.checkOutController,
  });

  final Size size;
  final CheckoutController checkOutController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          checkOutController.placeOrder();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Text(
          "Place Order",
          style: TextStyle(
            fontSize: size.width > 400 ? 16 : 14,
            fontWeight: FontWeight.w600,
            color: AppColors.whiteColor,
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.name,
    required this.size,
    required this.address,
    required this.phone,
    required this.email,
  });

  final String name;
  final Size size;
  final String address;
  final String phone;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            ListTile(
                title: Text(
              "Deliver to : $name",
              style: TextStyle(
                fontSize: size.width > 400 ? 16 : 14,
                fontWeight: FontWeight.w700,
              ),
            )),
            //bodered box with text "Shop"
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              child: ShopPlaceHolder(size: size),
            ),
            const SizedBox(height: 10),
            ListTile(
              title: Text(
                address,
                style: TextStyle(
                  fontSize: size.width > 400 ? 14 : 12,
                ),
              ),
              trailing: Icon(
                // >
                Icons.arrow_forward_ios,
                color: AppColors.primaryColor,
                size: size.width > 400 ? 18 : 16,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    phone,
                    style: TextStyle(
                      fontSize: size.width > 400 ? 14 : 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  Utils.divider2(),
                ],
              ),
            ),
            ListTile(
              title: Text(
                email,
                style: TextStyle(
                  fontSize: size.width > 400 ? 14 : 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: Icon(
                // >
                Icons.arrow_forward_ios,
                color: AppColors.primaryColor,
                size: size.width > 400 ? 18 : 16,
              ),
            ),
            Utils.divider2(),
            // terms and conditions applied
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "ℹ️ Terms and conditions applied",
                    style: TextStyle(
                      fontSize: size.width > 400 ? 10 : 8,
                      color: Colors.grey[600],
                    ),
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

class ShopPlaceHolder extends StatelessWidget {
  const ShopPlaceHolder({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.primaryColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            child: Text(
              "Shop",
              style: TextStyle(
                fontSize: size.width > 400 ? 14 : 12,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class OrderSummery extends StatelessWidget {
  const OrderSummery({
    super.key,
    required this.size,
    required this.totalItemPrice,
    required this.deliveryCharges,
    required this.discount,
    required this.totalPayable,
  });

  final Size size;
  final String totalItemPrice;
  final String deliveryCharges;
  final String discount;
  final String totalPayable;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: Row(
              children: [
                Text(
                  "Order Summary",
                  style: TextStyle(
                    fontSize: size.width > 400 ? 16 : 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          PriceItem(
            size: size,
            title: "Item Total",
            price: totalItemPrice,
          ),
          PriceItem(
            size: size,
            title: "Delivery Charges",
            price: deliveryCharges,
          ),
          PriceItem(
            size: size,
            title: "Discount",
            price: discount,
          ),
          PriceItem(
            size: size,
            title: "Total Payable",
            price: totalPayable,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class PriceItem extends StatelessWidget {
  const PriceItem({
    super.key,
    required this.size,
    required this.title,
    required this.price,
  });

  final Size size;
  final String title;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$title",
            style: TextStyle(
              fontSize: size.width > 400 ? 14 : 12,
            ),
          ),
          Text(
            "Rs. $price",
            style: TextStyle(
              fontSize: size.width > 400 ? 14 : 12,
            ),
          ),
        ],
      ),
    );
  }
}

class ProductItemCard extends StatelessWidget {
  const ProductItemCard({
    super.key,
    required this.size,
    required this.imageUrl,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.productQty,
    required this.productSubTotal,
  });

  final Size size;
  final String imageUrl;
  final String productName;
  final String productDescription;
  final String productPrice;
  final String productQty;
  final String productSubTotal;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 10),
                  Container(
                    width: size.width > 400 ? 100 : 75,
                    height: size.width > 400 ? 100 : 75,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          imageUrl,
                        ),
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
                          productName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: size.width > 400 ? 18 : 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          productDescription,
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
                              // Rs . price
                              "Rs. $productPrice",
                              style: TextStyle(
                                fontSize: size.width > 400 ? 14 : 10,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            Text(
                              "Qty: $productQty",
                              style: TextStyle(
                                fontSize: size.width > 400 ? 14 : 10,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // DotterLine(),
            Utils.divider(),
            // Border box with text Standard Dilevey
            Container(
              height: 65,
              width: size.width > 400 ? 250 : 200,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Standard Delivery (Free)",
                        style: TextStyle(
                          fontSize: size.width > 400 ? 14 : 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      Text(
                        "| Rs. 0",
                        style: TextStyle(
                          fontSize: size.width > 400 ? 14 : 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Receved by ",
                        style: TextStyle(
                          fontSize: size.width > 400 ? 14 : 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        //now Date + 10 days
                        "${DateTime.now().add(Duration(days: 10)).day}-${DateTime.now().add(Duration(days: 10)).month}-${DateTime.now().add(Duration(days: 10)).year}",
                        style: TextStyle(
                          fontSize: size.width > 400 ? 14 : 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Utils.divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "$productQty Item(s).",
                  style: TextStyle(
                    fontSize: size.width > 400 ? 14 : 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Sub Total:",
                  style: TextStyle(
                    fontSize: size.width > 400 ? 14 : 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Rs. $productSubTotal",
                  style: TextStyle(
                    fontSize: size.width > 400 ? 14 : 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
