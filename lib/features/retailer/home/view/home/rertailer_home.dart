import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:get/get.dart';
import 'package:shaudan_b2b/features/retailer/home/controller/home_controller/home_controller.dart';
import 'package:shaudan_b2b/features/retailer/home/data/models/product_model.dart';
import 'package:shaudan_b2b/features/retailer/home/view/home/home_loading.dart';
import 'package:shaudan_b2b/features/retailer/home/view/home/widgets/home_widgets.dart';
import 'package:shaudan_b2b/features/retailer/liked/controller/liked_controller.dart';
import 'package:shaudan_b2b/features/retailer/search/view/search.dart';
import 'package:shaudan_b2b/res/Images/image_strings.dart';
import 'package:shaudan_b2b/res/colors/AppColors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class RetailerHome extends StatelessWidget {
  const RetailerHome({super.key});

  @override
  Widget build(BuildContext context) {
    final likedController = Get.put(LikedController(), permanent: true);
    final imageList = [
      AppImagesStrings.banner1,
      AppImagesStrings.banner2,
      AppImagesStrings.banner3,
      AppImagesStrings.banner4,
    ];
    final homeController = Get.put(HomeController());
    final Size size = MediaQuery.of(context).size;
    // save random Time in variable Just time
    final mint = "";
    final sec = "";
    final hour = "";

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              flex: size.width > 800 ? 1 : 0,
              child: const SizedBox(),
            ),
            Expanded(
                child: InkWell(
                    onTap: () {
                      Get.to(() => const Search());
                    },
                    child: const MockSearchProduct())),
          ],
        ),
      ),
      body: FutureBuilder(
          future: homeController.fetchAllProduct(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              final List<ProductModel>? productList = snapshot.data;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    BannerWidgets(size: size, imageList: imageList),
                    const SizedBox(
                      height: 10,
                    ), //
                    Row(
                      children: [
                        Image.asset(
                          AppImagesStrings.flash,
                          height: size.width > 1016 ? 150 : 100,
                          width: size.width > 1016 ? 200 : 150,
                        ),
                      ],
                    ),
                    //CountDownTimer(),
                    const SizedBox(
                      height: 10,
                    ),
                    //CountDownTime
                    Obx(() => Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const TimerText(),
                              const SizedBox(
                                width: 10,
                              ),
                              Timer(
                                hour: "${homeController.hr!.value}",
                                mint: "${homeController.min!.value}",
                                sec: "${homeController.sec!.value}",
                              ),
                            ],
                          ),
                        )),
                    const HeadingOnProductList(),
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
                                homeController.onProductTab(product);
                              },
                              child: ProductItem(size: size, product: product));
                        },

                        staggeredTileBuilder: (int index) =>
                            const StaggeredTile.fit(2),
                        mainAxisSpacing: 15.0,
                        crossAxisSpacing: 15.0,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(" katam tata tata byee byee gayaaa",
                          style: TextStyle(
                              color: AppColors.greyColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
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

class TimerText extends StatelessWidget {
  const TimerText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text("Ends in : ",
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(
                color: AppColors.textColorDark, fontWeight: FontWeight.bold)
            .copyWith(fontSize: 20));
  }
}

class Timer extends StatelessWidget {
  const Timer({
    super.key,
    required this.hour,
    required this.mint,
    required this.sec,
  });

  final String hour;
  final String mint;
  final String sec;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TimeBox(text: hour),
        const TimeSperator(),
        TimeBox(text: mint),
        const TimeSperator(),
        TimeBox(text: sec),
      ],
    );
  }
}

class TimeSperator extends StatelessWidget {
  const TimeSperator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      " : ",
      style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor),
    );
  }
}

class TimeBox extends StatelessWidget {
  const TimeBox({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 35,
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
              color: AppColors.whiteColor,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class HeadingOnProductList extends StatelessWidget {
  const HeadingOnProductList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Top Rated",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textColorDark, fontWeight: FontWeight.bold)),
          Text("Exclusive for You",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textColorDark, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
