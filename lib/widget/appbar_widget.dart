import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return AppBar(
      title: const Text(
        "심리 테스트",
        style: TextStyle(color: Color.fromARGB(255, 37, 33, 243)),
      ),
      backgroundColor: Colors.grey,
      actions: [
        const Icon(Icons.menu),
        Padding(
          padding: EdgeInsets.only(right: width * 0.02),
        ),
      ],
    );
  }

  // AppBar의 높이를 정의합니다.
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
