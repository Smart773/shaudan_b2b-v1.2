import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaudan_b2b/features/wholesaler/home/controller/home_controller/dashboard_controller.dart';
import 'package:shaudan_b2b/res/colors/AppColors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WholesalerHome extends StatelessWidget {
  const WholesalerHome({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final dashboardController = Get.put(DashboardController());
    String title = "";
    String value = "";

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: dashboardController.getDashboardData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox();
                }
                return const SizedBox();
              }),
          DashBoardHeader(size: size),
          Expanded(
            child: GridView.count(
              crossAxisCount: size.width > 600 ? 4 : 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                Obx(() => DataBlocks(
                    title: "Total Order",
                    value: dashboardController.dashboardModel.totalOrders
                        .toString(),
                    size: size,
                    isloading: dashboardController.isLoading.value)),
                Obx(() => DataBlocks(
                    title: "Pending",
                    value: dashboardController.dashboardModel.totalPendingOrders
                        .toString(),
                    size: size,
                    isloading: dashboardController.isLoading.value)),
                Obx(() => DataBlocks(
                    title: "Cancelled",
                    value: dashboardController
                        .dashboardModel.totalCancelledOrders
                        .toString(),
                    size: size,
                    isloading: dashboardController.isLoading.value)),
                Obx(() => DataBlocks(
                    title: "Delivered",
                    value: dashboardController
                        .dashboardModel.totalDeliveredOrders
                        .toString(),
                    size: size,
                    isloading: dashboardController.isLoading.value)),
              ],
            ),
          ),
          !(size.width > 600)
              ? Container()
              // chart that express dailay weekly and monthly Sale(),
              : Obx(
                  () => SizedBox(
                    height: size.height * 0.4,
                    width: double.infinity,
                    child: dashboardController.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ))
                        : SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            // Chart title
                            title: ChartTitle(text: ' sales analysis in Rs.'),
                            // Enable legend
                            legend: Legend(isVisible: true),
                            // Enable tooltip
                            tooltipBehavior: TooltipBehavior(enable: true),
                            series: <ChartSeries<SalesData, String>>[
                              ColumnSeries<SalesData, String>(
                                  dataSource: <SalesData>[
                                    SalesData(
                                      'Today',
                                      dashboardController
                                          .dashboardModel.todaySaleAmount!
                                          .toDouble(),
                                    ),
                                    SalesData(
                                        'This Week',
                                        dashboardController
                                            .dashboardModel.thisWeekSaleAmount!
                                            .toDouble()),
                                    SalesData(
                                        'This Month',
                                        dashboardController
                                            .dashboardModel.thisMonthSaleAmount!
                                            .toDouble()),
                                  ],
                                  xValueMapper: (SalesData sales, _) =>
                                      sales.year,
                                  yValueMapper: (SalesData sales, _) =>
                                      sales.sales,
                                  name: 'Sales',
                                  // Enable data label
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: true))
                            ],
                          ),
                  ),
                ),
        ],
      ),
    );
  }
}

class DataBlocks extends StatelessWidget {
  const DataBlocks({
    super.key,
    required this.title,
    required this.value,
    required this.size,
    required this.isloading,
  });

  final String title;
  final String value;
  final Size size;
  final bool isloading;
  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Container(
        color: AppColors.primaryColor,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: isloading
              ? const Center(
                  child: CircularProgressIndicator(
                  color: AppColors.whiteColor,
                ))
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: size.width > 600
                            ? size.width > 1060
                                ? 35
                                : 20
                            : 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: size.width > 600
                            ? size.width > 1060
                                ? 35
                                : 20
                            : 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

class DashBoardHeader extends StatelessWidget {
  const DashBoardHeader({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.175,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.blackColor, width: 2),
      ),
      child: const Center(
        child: Text(
          "DASHBOARD",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 3.5,
          ),
        ),
      ),
    );
  }
}
