import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaudan_b2b/features/retailer/order/controller/retailer_order_controller.dart';
import 'package:shaudan_b2b/features/retailer/order/view/widgets.dart';
import 'package:shaudan_b2b/res/colors/AppColors.dart';

class RetailerOrder extends StatelessWidget {
  const RetailerOrder({super.key});

  @override
  Widget build(BuildContext context) {
    final RetailerOrderController controller =
        Get.put(RetailerOrderController());
    //
    // Path: lib\features\retailer\order\view\retailer_order.dart
    final Size size = MediaQuery.of(context).size;
    const String title =
        'Order DetailsOrder DetailsOrder DetailsOrder DetailsOrder DetailsOrder DetailsOrder DetailsOrder DetailsOrder DetailsOrder DetailsOrder DetailsOrder DetailsOrder DetailsOrder DetailsOrder DetailsOrder DetailsOrder DetailsOrder Details';
    const String amount = '1000000';
    const String status = 'Pending';
    const String qty = '1';
    const String date = '09 Dec 2020 11:11:58';
    const String order = '44564564564564';
    const String image =
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJpupwVnH6V9h_mEG-XImtt8h_6LhDmPNece6YfPJeLQ&s';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      backgroundColor: AppColors.grayColor10,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            isScrollable: true,
            controller: controller.tabController.value,
            indicatorColor: AppColors.primaryColor,
            labelColor: AppColors.primaryColor,
            unselectedLabelColor: AppColors.grey3Color,
            tabAlignment: TabAlignment.start,
            tabs: const [
              Tab(
                text: 'All',
              ),
              Tab(
                text: 'Pending',
              ),
              Tab(
                text: 'Completed',
              ),
              Tab(
                text: 'Cancelled',
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: controller.tabController.value,
              children: [
                LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints viewportConstraints) {
                  if (viewportConstraints.maxWidth > 580) {
                    return Row(
                      children: [
                        SizedBox(
                          width: size.width > 940 ? size.width * 0.1 : 0,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return OrderWebCard(
                                order: order,
                                date: date,
                                size: size,
                                image: image,
                                qty: qty,
                                title: title,
                                amount: amount,
                                status: status,
                                onPressed: () {},
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: size.width > 940 ? size.width * 0.1 : 0,
                        ),
                      ],
                    );
                  } else {
                    return ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return OrderCard(
                          order: order,
                          date: date,
                          size: size,
                          image: image,
                          title: title,
                          amount: amount,
                          status: status,
                          onPressed: () {},
                        );
                      },
                    );
                  }
                })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
