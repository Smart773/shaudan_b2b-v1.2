import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaudan_b2b/res/colors/AppColors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WholesalerHome extends StatelessWidget {
  const WholesalerHome({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: Column(
        children: [
          DashBoardHeader(size: size),
          Expanded(
            child: GridView.count(
              crossAxisCount: size.width > 600 ? 4 : 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                GridTile(
                  child: Container(
                    color: AppColors.primaryColor,
                  ),
                ),
                GridTile(
                  child: Container(
                    color: AppColors.primaryColor,
                  ),
                ),
                GridTile(
                  child: Container(
                    color: AppColors.primaryColor,
                  ),
                ),
                GridTile(
                  child: Container(
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          !(size.width > 600)
              ? Container()
              : SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  // Chart title
                  title: ChartTitle(text: 'Half yearly sales analysis'),
                  // Enable legend
                  legend: Legend(isVisible: true),
                  // Enable tooltip
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries<SalesData, String>>[
                    LineSeries<SalesData, String>(
                        dataSource: <SalesData>[
                          SalesData('Jan', 35),
                          SalesData('Feb', 28),
                          SalesData('Mar', 34),
                          SalesData('Apr', 32),
                          SalesData('May', 40)
                        ],
                        xValueMapper: (SalesData sales, _) => sales.year,
                        yValueMapper: (SalesData sales, _) => sales.sales,
                        // Enable data label
                        dataLabelSettings: DataLabelSettings(isVisible: true))
                  ],
                ),
        ],
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
      child: Center(
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
