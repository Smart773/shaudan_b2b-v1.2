import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shaudan_b2b/features/retailer/home/data/models/product_model.dart';
import 'package:shaudan_b2b/features/retailer/home/view/Home/rertailer_home.dart';
import 'package:shaudan_b2b/features/retailer/home/view/home/home_loading.dart';
import 'package:shaudan_b2b/features/retailer/home/view/home/widgets/home_widgets.dart';
import 'package:shaudan_b2b/features/wholesaler/store/controller/store_controller.dart';
import 'package:shaudan_b2b/res/Images/image_strings.dart';
import 'package:shaudan_b2b/res/colors/AppColors.dart';

class Store extends StatelessWidget {
  const Store({super.key});
  @override
  Widget build(BuildContext context) {
    final imageList = [
      AppImagesStrings.banner1,
      AppImagesStrings.banner2,
      AppImagesStrings.banner3,
      AppImagesStrings.banner4,
    ];
    final Size size = MediaQuery.of(context).size;
    final storeController = Get.put(StoreController());
    return Scaffold(
      body: FutureBuilder(
          future: storeController.fetchAllProductByWholeSaler(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              final List<ProductModel>? productList = snapshot.data;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    HeaderText(size: size),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: StaggeredGridView.countBuilder(
                        primary: false,
                        shrinkWrap: true,
                        key: ObjectKey(size.width > 1016 ? 2 : 4),
                        // **add this line**
                        crossAxisCount: size.width > 1016 ? 8 : 4,
                        itemCount: productList!.length,
                        itemBuilder: (BuildContext context, int index) {
                          final ProductModel product = productList[index];
                          return InkWell(
                              onTap: () {
                                // homeController.onProductTab(product);
                                storeController.onProductTab(product);
                              },
                              child: ProductItem(size: size, product: product));
                        },

                        staggeredTileBuilder: (int index) =>
                            const StaggeredTile.fit(2),
                        mainAxisSpacing: 15.0,
                        crossAxisSpacing: 15.0,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: HomeLoading(),
              );
            }
          }),
    );
  }
}

class HeaderText extends StatelessWidget {
  const HeaderText({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.width > 750
          ? 200
          : size.width > 400
              ? 200
              : 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Store",
              style: TextStyle(
                  color: AppColors.textColorLight,
                  fontSize: size.width > 750
                      ? 100
                      : size.width > 400
                          ? 80
                          : 60,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
