import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaudan_b2b/res/colors/AppColors.dart';
import 'package:shaudan_b2b/utils/utils.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.order,
    required this.date,
    required this.size,
    required this.image,
    required this.title,
    required this.amount,
    required this.status,
    required this.qty,
    required this.onPressed,
    required this.onPressed2,
  });

  final String order;
  final String date;
  final Size size;
  final String image;
  final String title;
  final String amount;
  final String status;
  final String qty;
  final Function() onPressed;
  final Function() onPressed2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Order No: $order',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: size.width > 400 ? 16 : 14,
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Placed on $date'),
                  const Text('COD'),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //image
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          image,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: size.width > 400 ? 16 : 14,
                          ),
                        ),
                        Text('Rs $amount',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: size.width > 400 ? 16 : 14,
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('x $qty'),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                child: Text(
                                  status,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.width > 400 ? 14 : 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    '1 Item, Total: ',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  Text('Rs. $amount',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor)),
                ],
              ),
              status == 'pending'
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          OutlinedButton(
                            onPressed: () {
                              onPressed();
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Cancel Order'),
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              onPressed2();
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Delivered'),
                            ),
                          ),
                        ])
                  : const SizedBox(),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderWebCard extends StatelessWidget {
  const OrderWebCard({
    super.key,
    required this.order,
    required this.date,
    required this.size,
    required this.image,
    required this.title,
    required this.qty,
    required this.amount,
    required this.status,
    required this.onPressed,
    required this.onPressed2,
  });

  final String order;
  final String date;
  final Size size;
  final String image;
  final String qty;
  final String title;
  final String amount;
  final String status;
  final Function() onPressed;
  final Function() onPressed2;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Order No: $order',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: size.width > 400 ? 16 : 14,
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Placed on $date'),
                  const Text('COD'),
                ],
              ),
              Utils.divider2(),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //image
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          image,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: OrderData(
                      qty: qty,
                      title: title,
                      size: size,
                      amount: amount,
                      status: status,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              status == 'pending'
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          OutlinedButton(
                            onPressed: () {
                              onPressed();
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Cancel Order'),
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              onPressed2();
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Delivered'),
                            ),
                          ),
                        ])
                  : const SizedBox(),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderData extends StatelessWidget {
  const OrderData({
    super.key,
    required this.title,
    required this.size,
    required this.amount,
    required this.status,
    required this.qty,
  });

  final String title;
  final Size size;
  final String amount;
  final String status;
  final String qty;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 200,
          child: Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: size.width > 400 ? 16 : 14,
            ),
          ),
        ),
        const Spacer(),
        const Text(
          'Qty:',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        Text(
          qty,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const Spacer(),
        Container(
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Text(
              status.capitalizeFirst!,
              style: TextStyle(
                color: Colors.white,
                fontSize: size.width > 400 ? 14 : 12,
              ),
            ),
          ),
        ),
        const Spacer(),
        Text('Rs. $amount',
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: AppColors.primaryColor)),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
