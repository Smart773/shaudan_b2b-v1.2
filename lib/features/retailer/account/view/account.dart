import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaudan_b2b/features/auth/controllers/login/login_controller.dart';
import 'package:shaudan_b2b/features/auth/data/models/user_model.dart';
import 'package:shaudan_b2b/features/retailer/account/view/widgets/account.widgets.dart';
import 'package:shaudan_b2b/features/retailer/home/view/home/widgets/product_widgets.dart';
import 'package:shaudan_b2b/res/colors/AppColors.dart';
import 'package:shaudan_b2b/res/localizations/app_strings.dart';
import 'package:shaudan_b2b/res/routes/routes_name.dart';

import '../controller/account_controller.dart';

class Account extends StatelessWidget {
  const Account({super.key});
  final String storeName = 'Account';
  final String title = 'Account';
  final String phoneNo = 'Account';
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final accountController = Get.put(AccountController());
    final user = LoginController.to.user.value;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              LoginController.to.user.value = UserModel();
              Get.offAllNamed(RoutesName.auth);
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
        title: Text(AppStrings.account.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: AppColors.grey2Color,
                height:
                    size.width >= 650 ? size.height * 0.25 : size.height * 0.2,
                width: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: AccountHeaderWidget(
                    size: size,
                    storeName: user.name!,
                    // storeName: user.storeName!,
                    title: user.role!,
                    phoneNo: user.name!,
                  ),
                ),
              ),
              //mutil tab View()
              Obx(() => TabBar(
                      unselectedLabelColor: AppColors.grey3Color,
                      labelColor: AppColors.primaryColor,
                      controller: accountController.tabController.value,
                      indicatorWeight: 3.0,
                      tabs: [
                        Tab(icon: Text(AppStrings.contact.tr)),
                        Tab(icon: Text(AppStrings.reviews.tr)),
                      ])),
              Obx(() => SizedBox(
                    height: size.height * 0.6,
                    child: TabBarView(
                      controller: accountController.tabController.value,
                      children: const [
                        DataPage(),
                        //Order Histor
                        Reviews()
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class Reviews extends StatelessWidget {
  const Reviews({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Card(
          child: ListTile(
            leading: Icon(Icons.person),
            title: Text('Sir Syed'),
            subtitle: Rateings(),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.person),
            title: Text('Ahmmed Ali Shah'),
            subtitle: Rateings(),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.person),
            title: Text('Quid e Azam'),
            subtitle: Rateings(),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.person),
            title: Text('Alma Iqbal'),
            subtitle: Rateings(),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.person),
            title: Text('Jalalu Din Rumi'),
            subtitle: Rateings(),
          ),
        ),
      ],
    );
  }
}

class History extends StatelessWidget {
  const History({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 7,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: Image.network(
                    'https://picsum.photos/250?image=9',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text("Order No: 123456"),
                  subtitle: Text("Order Date: 12/12/2021"),
                ),
              );
            },
          ),
        ),
      ],
    ));
  }
}

class DataPage extends StatelessWidget {
  const DataPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.person),
          title: Text(AppStrings.name.tr),
          subtitle: Text(LoginController.to.user.value.name!),
        ),
        ListTile(
          leading: const Icon(Icons.email),
          title: Text(AppStrings.email.tr),
          subtitle: Text(LoginController.to.user.value.account!.email!),
          // subtitle: Text(LoginController.to.user.value.email!),
        ),
        ListTile(
          leading: const Icon(Icons.phone),
          title: Text(AppStrings.phone.tr),
          // subtitle: Text(LoginController.to.user.value.phon0e!),
          subtitle: Text(LoginController.to.user.value.contact!.phoneNumber!),
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: Text(AppStrings.address.tr),
          // subtitle: Text(LoginController.to.user.value.phon0e!),
          subtitle: Text(LoginController.to.user.value.address!.toString()),
        ),
      ],
    );
  }
}
