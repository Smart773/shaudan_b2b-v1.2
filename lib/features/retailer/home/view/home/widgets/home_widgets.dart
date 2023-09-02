import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shaudan_b2b/features/retailer/home/data/models/product_model.dart';
import 'package:shaudan_b2b/features/retailer/search/view/search.dart';
import 'package:shaudan_b2b/res/colors/AppColors.dart';
import 'package:shaudan_b2b/res/localizations/app_Strings.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class MockSearchProduct extends StatelessWidget {
  const MockSearchProduct({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.lightgray,
      ),
      child: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.search,
              color: AppColors.textColorLight,
              size: 20,
            ),
            Text(AppStrings.searchHint.tr,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: AppColors.textColorLight)),
          ],
        ),
      ),
    );
  }
}

class BannerWidgets extends StatelessWidget {
  const BannerWidgets({
    super.key,
    required this.size,
    required this.imageList,
  });

  final Size size;
  final List<String> imageList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.width > 750
          ? 250
          : size.width > 400
              ? 200
              : 150,
      child: Swiper(
        scrollDirection: Axis.horizontal,
        loop: true,
        autoplay: true,
        autoplayDelay: 3000,
        autoplayDisableOnInteraction: true,
        itemCount: imageList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset(
                imageList[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.size,
    required this.product,
  });

  final Size size;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: size.width > 750 ? 250 : 200,
          height: size.width > 750
              ? 250
              : size.width > 400
                  ? 200
                  : 150,
          constraints: BoxConstraints(
            minHeight: size.width > 750
                ? 250
                : size.width > 400
                    ? 200
                    : 150,
            minWidth: size.width > 750 ? 250 : 200,
          ),
          color: AppColors.whiteColor,
          // child: GridProduct(product: product),
          //product card design with product pic and title price and rating
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: GridProduct(product: product),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SmoothStarRating(
                        allowHalfRating: true,
                        starCount: 5,
                        rating: Random().nextInt(5).toDouble(),
                        size: 17.0,
                        color: AppColors.primaryColor,
                        borderColor: AppColors.primaryColor,
                        spacing: 0.0,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        product.title!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // discount ICone
                      const Icon(
                        Icons.local_offer,
                        color: AppColors.primaryColor,
                        size: 16,
                      ),
                      Text(
                        "Rs: ${product.price!.toString()}",
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
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

class GridProduct extends StatelessWidget {
  const GridProduct({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    // Stack a widget that positions its children relative to the edges of its box.
    // return GridTile(
    //   child: Image.network(
    //     product.images![0].url!,
    //     fit: BoxFit.cover,
    //   ),
    // );
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(product.images![0].url!),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 5,
          right: 5,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.whiteColor,
            ),
            child: const Padding(
              padding: EdgeInsets.all(3.0),
              child: Text(
                "%",
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
