import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaudan_b2b/features/retailer/order/controller/retailer_order_controller.dart';
import 'package:shaudan_b2b/features/retailer/order/data/models/order_model.dart';
import 'package:shaudan_b2b/features/retailer/order/view/widgets.dart';
import 'package:shaudan_b2b/res/colors/AppColors.dart';

class RetailerOrder extends StatelessWidget {
  const RetailerOrder({super.key});

  @override
  Widget build(BuildContext context) {
    final RetailerOrderController controller =
        Get.put(RetailerOrderController());

    final Size size = MediaQuery.of(context).size;
    const String title =
        'Order DetailsOrder DetailsOrder DetailsOrder DetailsOrder DetailsOrder DetailsOrder DetailsOrder DetailsOrder DetailsOrder DetailsOrder DetailsOrder DetailsOrder DetailsOrder DetailsOrder DetailsOrder DetailsOrder DetailsOrder Details';
    const String amount = '1000000';
    const String status = 'pending';
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
            onTap: (index) {
              controller.onTabChange(index);
              controller.tabController.value.animateTo(index);
              controller.selectedIndex.value = index;
            },
            
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
              physics: const NeverScrollableScrollPhysics(),
              controller: controller.tabController.value,
              children: [
                //Note: for all
                Obx(() => SizedBox(
                      child: (controller.isLoading.value)
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : controller.orderModelList.value.isEmpty
                              ? const Center(
                                  child: Text('No Orders Found'),
                                )
                              : TabViewItem(
                                  controller: controller,
                                  size: size,
                                  orderModelList:
                                      controller.orderModelList.value,
                                ),
                    )),
                Obx(() => SizedBox(
                      child: (controller.isLoading.value)
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : controller.pendingOrderModelList.value.isEmpty
                              ? const Center(
                                  child: Text('No Orders Found'),
                                )
                              : TabViewItem(
                                  controller: controller,
                                  size: size,
                                  orderModelList:
                                      controller.pendingOrderModelList.value,
                                ),
                    )),
                Obx(() => SizedBox(
                      child: (controller.isLoading.value)
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : controller.completedOrderModelList.value.isEmpty
                              ? const Center(
                                  child: Text('No Orders Found'),
                                )
                              : TabViewItem(
                                  controller: controller,
                                  size: size,
                                  orderModelList:
                                      controller.completedOrderModelList.value,
                                ),
                    )),
                Obx(() => SizedBox(
                      child: (controller.isLoading.value)
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : controller.cancelledOrderModelList.value.isEmpty
                              ? const Center(
                                  child: Text('No Orders Found'),
                                )
                              : TabViewItem(
                                  controller: controller,
                                  size: size,
                                  orderModelList:
                                      controller.cancelledOrderModelList.value,
                                ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FutureList extends StatelessWidget {
  const FutureList({
    super.key,
    required this.controller,
    required this.size,
    required this.future,
  });

  final RetailerOrderController controller;
  final Size size;
  final Future<List<OrderModel>> future;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.getOrderList(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData && snapshot.data!.length <= 0) {
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 100,
              ),
              SizedBox(
                height: 10,
              ),
              Text('No Orders Found'),
            ],
          );
        } else if (snapshot.hasData) {
          return TabViewItem(
            size: size,
            controller: controller,
            orderModelList: snapshot.data,
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class TabViewItem extends StatelessWidget {
  const TabViewItem({
    super.key,
    required this.size,
    required this.controller,
    required this.orderModelList,
  });

  final Size size;
  final RetailerOrderController controller;
  final List<OrderModel> orderModelList;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      if (viewportConstraints.maxWidth > 580) {
        return Row(
          children: [
            SizedBox(
              width: size.width > 940 ? size.width * 0.1 : 0,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: orderModelList.length,
                itemBuilder: (context, index) {
                  OrderModel order = orderModelList[index];
                  return OrderWebCard(
                    order: order.id!,
                    date: order.createdAt!,
                    size: size,
                    image: order.orderItem![0].product!.images![0].url!,
                    qty: (order.orderItem![0].quantity!).toString(),
                    title: order.orderItem![0].product!.title!,
                    amount: (order.totalAmmount!).toString(),
                    status: order.orderStatus!,
                    onPressed: () {
                      controller.onCanceled(order.id!);
                    },
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
          itemCount: orderModelList.length,
          itemBuilder: (context, index) {
            OrderModel order = orderModelList[index];
            return OrderCard(
              order: order.id!,
              date: order.createdAt!,
              size: size,
              image: order.orderItem![0].product!.images![0].url!,
              qty: (order.orderItem![0].quantity!).toString(),
              title: order.orderItem![0].product!.title!,
              amount: (order.orderItem![0].product!.price).toString(),
              status: order.orderStatus!,
              onPressed: () {
                controller.onCanceled(order.id!);
              },
            );
          },
        );
      }
    });
  }
}
