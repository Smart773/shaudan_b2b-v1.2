import 'package:flutter/material.dart';
import 'package:shaudan_b2b/res/colors/AppColors.dart';

class FlexibleText extends StatelessWidget {
  const FlexibleText({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      "${title}",
      maxLines: 6,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}

class RatingShareLikeWidget extends StatelessWidget {
  const RatingShareLikeWidget({
    super.key,
    required this.onPressed,
    required this.isLiked,
  });
  final Function() onPressed;
  final bool isLiked;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Rateings(),
          const Spacer(),
          Row(
            children: [
              const Icon(Icons.share_outlined, color: AppColors.primaryColor),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                  onPressed: onPressed,
                  icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border,
                      color: AppColors.primaryColor)),
            ],
          ),
        ],
      ),
    );
  }
}

class ProductStore extends StatelessWidget {
  const ProductStore({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Store | ${title}",
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class PriceAndDiscountWidget extends StatelessWidget {
  const PriceAndDiscountWidget({
    super.key,
    required this.price,
    required this.discount,
  });

  final String price;
  final String discount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Rs. ${(int.parse(price) * int.parse(discount)) / 100}",
            style: const TextStyle(
                color: AppColors.primaryColor,
                fontSize: 40,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                price,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Colors.black,
                ),
              ),
              Text(
                " -${discount}%",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class QuantityWidget extends StatelessWidget {
  const QuantityWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Text(
            "Available Quantity:",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class Chiptile extends StatelessWidget {
  const Chiptile({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Chip(
        backgroundColor: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
            color: AppColors.primaryColor,
          ),
        ),
        label: Text(
          title,
          style: const TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class Rateings extends StatelessWidget {
  const Rateings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(
          Icons.star,
          color: AppColors.primaryColor,
        ),
        Icon(
          Icons.star,
          color: AppColors.primaryColor,
        ),
        Icon(
          Icons.star,
          color: AppColors.primaryColor,
        ),
        Icon(
          Icons.star,
          color: AppColors.primaryColor,
        ),
        Icon(
          Icons.star_border,
          color: AppColors.primaryColor,
        ),
        Text(
          "4 (1000)",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
