import 'package:get/get.dart';
import 'package:shaudan_b2b/features/retailer/order/data/repositories/order_repositories.dart';
import 'package:shaudan_b2b/features/wholesaler/home/data/models/dashboard_model.dart';

class DashboardController extends GetxController {
  DashboardModel dashboardModel = DashboardModel();
  RxBool isLoading = false.obs;
  Future<void> getDashboardData() async {
    try {
      isLoading.value = true;
      OrderRepository orderRepository = OrderRepository();
      dashboardModel =
          await orderRepository.getOrderDetailByWholesaler().whenComplete(() {
        isLoading.value = false;
      });
    } //try ()
    catch (e) {
      isLoading.value = false;
      print(e);
    }
  }
}
