import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shaudan_b2b/features/retailer/home/controller/product_contoller/product_controller.dart';
import 'package:shaudan_b2b/features/retailer/home/data/models/product_model.dart';
import 'package:shaudan_b2b/features/retailer/home/view/home/widgets/product_widgets.dart';
import 'package:shaudan_b2b/features/retailer/liked/controller/liked_controller.dart';
import 'package:shaudan_b2b/res/colors/AppColors.dart';
import 'package:shaudan_b2b/res/components/app_button.dart';
import 'package:shaudan_b2b/utils/utils.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductController());

    final Size size = MediaQuery.of(context).size;
    final width = size.width;
    //IMg List for Colum(),

    return Scaffold(
      bottomSheet: size.width > 865
          ? const SizedBox()
          : Container(
              height: 100,
              color: AppColors.whiteColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppButtonOutlined(
                    title: "Add to Cart",
                    onPress: () {
                      productController.addToCart();
                    },
                    width: size.width * 0.45,
                  ),
                ],
              ),
            ),
      backgroundColor: AppColors.primaryColor50,
      appBar: AppBar(
        title: const Text("Product Detail"),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 865) {
          return SingleChildScrollView(
            child: Column(
              children: [
                ProductDetailBlock(
                  size: size,
                  product: productController.product.value,
                  addToCard: () {
                    productController.addToCart();
                  },
                  buyNow: () {},
                ),
                const SizedBox(
                  height: 20,
                ),
                ProductDiscription(
                    width: width,
                    product: productController.product.value,
                    size: size),
              ],
            ),
          );
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.5,
                width: size.width,
                child: ImgViewSwiper(product: productController.product.value),
              ),
              const SizedBox(
                height: 20,
              ),
              ProductData(
                width: width,
                product: productController.product.value,
                size: size,
                addToCard: () {
                  productController.addToCart();
                },
                buyNow: () {},
              ),
              ProductDiscription(
                  width: width,
                  product: productController.product.value,
                  size: size),
            ],
          ),
        );
      }),
    );
  }
}

class ProductDiscription extends StatelessWidget {
  const ProductDiscription({
    super.key,
    required this.width,
    required this.product,
    required this.size,
  });

  final double width;
  final ProductModel product;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Product Description",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              Container(
                color: Colors.white,
                child: Text(
                  product.description!,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              for (int i = 0; i < product.images!.length; i++)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: SizedBox(
                      height: size.height * 0.3,
                      width: size.width * 0.8,
                      child: Image.network(
                        product.images![i].url!,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              SizedBox(
                height: size.height * 0.1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductDetailBlock extends StatelessWidget {
  const ProductDetailBlock({
    super.key,
    required this.size,
    required this.product,
    required this.addToCard,
    required this.buyNow,
    this.width = 0.0,
  });

  final Size size;
  final ProductModel product;
  final double width;
  final Function() addToCard;
  final Function() buyNow;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 700,
      child: Row(
        mainAxisAlignment: size.width > 1003
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SwiperImage(size: size, product: product),
          ProductData(
            //TODO:
            width: width,
            size: size,
            product: product,
            addToCard: addToCard,
            buyNow: buyNow,
          ),
          // Spacer(),
          size.width < 1004 ? const SizedBox() : const SideView(),
        ],
      ),
    );
  }
}

class ProductData extends StatelessWidget {
  const ProductData({
    super.key,
    this.width = 0.0,
    required this.size,
    required this.product,
    required this.addToCard,
    required this.buyNow,
  });

  final double width;
  final Size size;
  final ProductModel product;
  final Function() addToCard;
  final Function() buyNow;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width == 0.0
          ? size.width > 1003
              ? size.width * 0.37
              : size.width * 0.68
          : width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Headerinformation(),

          FlexibleText(title: product.title!),
          // row with 5 start icons
          GetBuilder<LikedController>(
            init: LikedController(),
            initState: (_) {},
            builder: (_) {
              return RatingShareLikeWidget(
                isLiked: _.checkinList(product),
                onPressed: () {
                  _.onLikePressed(product);
                },
              );
            },
          ),
          // Store Name
          const ProductStore(title: "Shaudan"),
          Utils.divider(),
          PriceAndDiscountWidget(price: "${product.price}", discount: "33"),
          // round boarder box with text
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // size.width < 360
              //     ? const SizedBox()
              //     : const Chiptile(title: "Exclusive Offer"),
              Chiptile(title: "Super Deal"),
              Chiptile(title: "FYP Special"),
            ],
          ),
          Utils.divider(),
          // Avalaibke Quntity(
          size.width < 865
              ? const SizedBox()
              : Column(
                  children: [
                    QuantityWidget(title: "${product.quantity}"),
                    // Add to Cart amd Buy Now Buttons, Outinme and Elivatexd()
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          AppButtonOutlined(
                            title: "Add to Cart",
                            onPress: addToCard,
                            width: size.width * 0.17,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

class SwiperImage extends StatelessWidget {
  const SwiperImage({
    super.key,
    required this.size,
    required this.product,
  });

  final Size size;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: size.width > 1130
                ? 400
                : size.width > 1004
                    ? 300
                    : 250,
            maxHeight: size.width > 1130
                ? 400
                : size.width > 1004
                    ? 300
                    : 250,
          ),

          // all width,
          child: ImgViewSwiper(product: product),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}

class ImgViewSwiper extends StatelessWidget {
  const ImgViewSwiper({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Swiper(
      control: const SwiperControl(
        color: AppColors.primaryColor,
      ),
      pagination: const SwiperPagination(
        margin: EdgeInsets.only(bottom: 10),
      ),
      itemCount: product.images!.length,
      itemBuilder: (BuildContext context, int index) {
        return Image.network(
          product.images![index].url!,
          fit: BoxFit.contain,
        );
      },
    );
  }
}

class SideView extends StatelessWidget {
  const SideView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Container(
        color: AppColors.primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const Row(
                children: [
                  Text(
                    "Delivery",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.whiteColor),
                  ),
                  Spacer(),
                  Icon(Icons.local_shipping_outlined,
                      color: AppColors.whiteColor),
                ],
              ),
              //leftSide
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(Icons.location_on_outlined,
                        color: AppColors.whiteColor),
                  ),
                  const Flexible(
                      child: Text(
                    "Sindh, Karachi - Gulshan-e-Iqbal, Block 15",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.whiteColor),
                  )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Change",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.whiteColor),
                        )),
                  ),
                ],
              ),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(LineIcons.box, color: Colors.white),
                  ),
                  Flexible(
                    child: Text(
                      "Free Delivery ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.whiteColor),
                    ),
                  ),
                  Text(
                    "31May-5Jun",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.whiteColor),
                  ),
                  Spacer(),
                  Text(
                    "Free",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.whiteColor),
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: SizedBox(),
                  ),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                              "Enjoy free shipping promotion with \nminimum spend of Rs. 2,000 from"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(LineIcons.wavyMoneyBill, color: Colors.white),
                  ),
                  Flexible(
                      child: Text(
                    "Cash on Delivery available",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.whiteColor),
                  )),
                ],
              ),
              const Divider(
                height: 20,
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
              const Row(
                children: [
                  Text("Services",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.whiteColor)),
                  Spacer(),
                  Icon(Icons.info_outline, color: AppColors.whiteColor),
                ],
              ),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.check_circle_outline,
                        color: AppColors.whiteColor),
                  ),
                  Text(
                    "7 Days Easy Return",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.whiteColor),
                  ),
                ],
              ),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(LineIcons.starOfLife, color: Colors.white),
                  ),
                  Text(
                    "Genuine Product",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.whiteColor),
                  ),
                ],
              ),
              // no Waarnty()
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(LineIcons.alternateShield, color: Colors.white),
                  ),
                  Flexible(
                    child: Text(
                      "Warranty not available",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.whiteColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Headerinformation extends StatelessWidget {
  const Headerinformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Icon(
          //Sale
          LineIcons.tag,
          color: AppColors.primaryColor,
          size: 30,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 100,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text(
                "New",
                style: TextStyle(
                    color: AppColors.whiteColor, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 100,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text(
                " 33% OFF ",
                style: TextStyle(
                    color: AppColors.whiteColor, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
