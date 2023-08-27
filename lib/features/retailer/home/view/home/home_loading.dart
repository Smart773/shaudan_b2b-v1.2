import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:shaudan_b2b/res/colors/AppColors.dart';
import 'package:shimmer/shimmer.dart';

class HomeLoading extends StatelessWidget {
  const HomeLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          SwipperPlaceHolder(size: size),

          GridPlaceHolder(size: size),

          // ),
        ],
      ),
    );
  }
}

class GridPlaceHolder extends StatelessWidget {
  const GridPlaceHolder({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: StaggeredGridView.countBuilder(
        primary: false,
        shrinkWrap: true,
        key: ObjectKey(size.width > 1016 ? 2 : 4),
        // **add this line**
        crossAxisCount: size.width > 1016 ? 8 : 4,
        itemCount: 24,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              width: size.width > 750 ? 250 : 200,
              height: size.width > 750
                  ? 250
                  : size.width > 400
                      ? 200
                      : 150,
              constraints: BoxConstraints(
                minHeight: size.width > 750
                    ? 250
                    : size.width > 400
                        ? 200
                        : 150,
                minWidth: size.width > 750 ? 250 : 200,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade300,
                // border color and size
              ),
              child: Center(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade400,
                  highlightColor: Colors.grey.shade100,
                  child: Text(
                    'Shaudan',
                    style: TextStyle(
                      fontSize: size.width > 750
                          ? 40
                          : size.width > 400
                              ? 30
                              : 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ));
        },

        staggeredTileBuilder: (int index) => const StaggeredTile.fit(2),
        mainAxisSpacing: 15.0,
        crossAxisSpacing: 15.0,
      ),
    );
  }
}

class SwipperPlaceHolder extends StatelessWidget {
  const SwipperPlaceHolder({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.width > 750
          ? 250
          : size.width > 400
              ? 200
              : 150,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Swiper(
          control: const SwiperControl(
            color: AppColors.primaryColor,
          ),
          scrollDirection: Axis.horizontal,
          loop: true,
          autoplay: true,
          autoplayDelay: 3000,
          autoplayDisableOnInteraction: true,
          itemCount: 4,
          itemBuilder: (context, index) {
            return BannerPlaceholder(size: size);
          },
        ),
      ),
    );
  }
}

class BannerPlaceholder extends StatelessWidget {
  const BannerPlaceholder({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        height: size.width > 750
            ? 250
            : size.width > 400
                ? 200
                : 150,
        width: double.infinity,
      ),
    );
  }
}
