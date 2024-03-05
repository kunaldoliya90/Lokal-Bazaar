import 'package:ecomapp/common/widgets/customShapes/Container/TPrimaryHeaderContainer.dart';
import 'package:flutter/material.dart';

class HomeUI extends StatelessWidget {
  const HomeUI({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainerWidget(
                child: Column(
              children: [
                
              ],
            ))
          ],
        ),
      ),
    );
  }
}
