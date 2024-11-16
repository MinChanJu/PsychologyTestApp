import 'package:flutter/material.dart';

import 'psychology_problem_screen.dart';

import '../widget/appbar_widget.dart';
import '../model/psychology_test_model.dart';

class PsychologyTestScreen extends StatefulWidget {
  final PsychologyTestModel psychologyTest;
  const PsychologyTestScreen({super.key, required this.psychologyTest});

  @override
  State<PsychologyTestScreen> createState() => _PsychologyTestScreenState();
}

class _PsychologyTestScreenState extends State<PsychologyTestScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(),
        body: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 20)),
            Center(
              child: Image.asset(
                "images/test.png",
                width: width * 0.6,
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 30)),
            Text(
              widget.psychologyTest.title,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            SizedBox(
              width: width * 0.3,
              child: Center(child: Text('설명 : ${widget.psychologyTest.description}')),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Text('만든 사람 : ${widget.psychologyTest.createdBy}'),
            Padding(padding: EdgeInsets.only(top: 10)),
            Text('만든 날짜 : ${widget.psychologyTest.createdAt.toString().split(".")[0]}'),
            Padding(padding: EdgeInsets.only(top: 50)),
            ElevatedButton(
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
                  MaterialPageRoute(
                    builder: (context) => PsychologyProblemScreen(
                      testId: widget.psychologyTest.id,
                    ),
                  ),
                );
              },
              child: Text(
                "테스트 시작",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
