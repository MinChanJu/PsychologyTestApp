import 'package:flutter/material.dart';
import 'package:psychology/screen/make_psychology_test_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/psychology_test_model.dart';
import '../widget/appbar_widget.dart';
import 'psychology_test_screen.dart';

class PsychologyTestListScreen extends StatefulWidget {
  const PsychologyTestListScreen({super.key});

  @override
  State<PsychologyTestListScreen> createState() => _PsychologyTestListScreenState();
}

class _PsychologyTestListScreenState extends State<PsychologyTestListScreen> {
  final _test = Supabase.instance.client.from('psychology_test').select();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: _test,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData) {
                    return const Center(child: Text('테스트가 비어있습니다.'));
                  }
                  final List<dynamic> data = snapshot.data!;
                  final List<PsychologyTestModel> testList = data.map((json) => PsychologyTestModel.fromJson(json)).toList();
                  return ListView.builder(
                    itemCount: testList.length,
                    itemBuilder: ((context, index) {
                      final test = testList[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: height * 0.01, horizontal: width * 0.05),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(16.0),
                            alignment: Alignment.centerLeft,
                            backgroundColor: const Color.fromARGB(255, 235, 207, 139),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PsychologyTestScreen(
                                  psychologyTest: test,
                                ),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                test.title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                test.description,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                '${test.createdBy} ${test.createdAt.toString().split(".")[0]}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 20)),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                fixedSize: Size(width * 0.7, height * 0.05),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MakePsychologyTestScreen(),
                  ),
                );
              },
              child: Text(
                "심리테스트 만들기",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 20)),
          ],
        ),
      ),
    );
  }
}
