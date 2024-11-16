import 'package:flutter/material.dart';

import '../widget/appbar_widget.dart';
import 'psychology_test_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Image.asset(
                "images/home.jpeg",
                width: width * 0.8,
              ),
            ),
            Padding(padding: EdgeInsets.all(width * 0.01)),
            Text(
              "심리 테스트",
              style: TextStyle(
                color: Colors.black,
                fontSize: width * 0.06,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(padding: EdgeInsets.all(width * 0.001)),
            Text(
              "* 테스트 주의 사항 *",
              style: TextStyle(
                color: Colors.black,
                fontSize: width * 0.04,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(padding: EdgeInsets.all(width * 0.02)),
            buildStep(width, "1. 총 문제는 테스트마다 다릅니다."),
            buildStep(width, "2. 테스트는 아무나 만들 수 있습니다."),
            buildStep(width, "3. 테스트는 점수로 나옵니다."),
            Padding(padding: EdgeInsets.all(width * 0.02)),
            Container(
              padding: EdgeInsets.only(bottom: width * 0.03),
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(width * 0.8, height * 0.05),
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PsychologyTestListScreen()),
                    );
                  },
                  child: Text(
                    "테스트 하러 가기",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStep(double width, String string) {
    return SizedBox(
      child: Text(
        string,
        style: TextStyle(
          color: Colors.red,
          fontSize: width * 0.03,
        ),
      ),
    );
  }
}
