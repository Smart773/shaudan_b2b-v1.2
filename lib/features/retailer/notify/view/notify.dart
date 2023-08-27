import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shaudan_b2b/res/localizations/app_Strings.dart';

class Notify extends StatelessWidget {
  const Notify({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.cart),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(LineIcons.trash), onPressed: () {}),
        ],
      ),
      body: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding: const EdgeInsets.all(8.0),
              title: const Text('Product Name'),
              subtitle: const Text('Order Id\n #1-355548'),
              isThreeLine: true,
              leading: Image.network(
                "https://picsum.photos/250?image=9",
                fit: BoxFit.cover,
              ),
              trailing: const Text('Product Status\nDeliver in 3 days'),
            );
          }),
    );
  }
}
