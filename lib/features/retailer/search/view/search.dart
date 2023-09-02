import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shaudan_b2b/features/retailer/home/controller/home_controller/home_controller.dart';
import 'package:shaudan_b2b/features/retailer/home/data/models/product_model.dart';
import 'package:shaudan_b2b/features/retailer/home/view/home/widgets/home_widgets.dart';
import 'package:shaudan_b2b/features/retailer/search/controller/search_controller.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // final  searchController = Get.put(SearchController());
    final searchController = Get.put(SearchProductController());
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: searchController.searchTextController.value,
                  onSubmitted: (value) {
                    searchController.onSearch(
                        searchController.searchTextController.value.text);
                  },
                  decoration: const InputDecoration(
                    hintText: 'Search',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              // Search Button(),
              SizedBox(
                height: 40,
                width: 60,
                child: OutlinedButton(
                  onPressed: () {
                    searchController.onSearch(
                        searchController.searchTextController.value.text);
                  },
                  child: const Text('Search'),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Obx(() {
        if (searchController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final List<ProductModel> productList =
              searchController.productModelList.value;
          return productList.isEmpty
              ? const Center(
                  child: Text('No Product Found'),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StaggeredGridView.countBuilder(
                    primary: false,
                    shrinkWrap: true,
                    key: ObjectKey(size.width > 1016 ? 2 : 4),
                    // **add this line**
                    crossAxisCount: size.width > 1016 ? 8 : 4,
                    itemCount: productList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final ProductModel product = productList[index];
                      return InkWell(
                          onTap: () {
                            HomeController.to.onProductTab(product);
                          },
                          child: ProductItem(size: size, product: product));
                    },

                    staggeredTileBuilder: (int index) =>
                        const StaggeredTile.fit(2),
                    mainAxisSpacing: 15.0,
                    crossAxisSpacing: 15.0,
                  ),
                );
        }
      }),
    );
  }
}
