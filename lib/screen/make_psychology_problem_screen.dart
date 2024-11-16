import 'package:flutter/material.dart';
import 'package:psychology/screen/home_screen.dart';
import 'package:psychology/widget/appbar_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MakePsychologyProblemScreen extends StatefulWidget {
  final int testId;

  const MakePsychologyProblemScreen({
    super.key,
    required this.testId,
  });

  @override
  State<MakePsychologyProblemScreen> createState() => _MakePsychologyProblemScreenState();
}

class _MakePsychologyProblemScreenState extends State<MakePsychologyProblemScreen> {
  final TextEditingController _titleController = TextEditingController();
  final List<ProblemChoice> _choiceControllers = [];

  @override
  void initState() {
    super.initState();
    _choiceControllers.add(ProblemChoice(
      titleController: TextEditingController(),
      scoreController: TextEditingController(),
    ));
    _choiceControllers.add(ProblemChoice(
      titleController: TextEditingController(),
      scoreController: TextEditingController(),
    ));
  }

  @override
  void dispose() {
    _titleController.dispose();
    for (var choice in _choiceControllers) {
      choice.titleController.dispose();
      choice.scoreController.dispose();
    }
    super.dispose();
  }

  Future<void> insertPsychologyTest(String title, List<ProblemChoice> choiceList) async {
    try {
      final response = await Supabase.instance.client.from('psychology_problem').insert({
        'test_id': widget.testId,
        'problem_title': title,
      }).select();

      print('Inserted problem: $response');

      if (response[0]['id'] != null) {
        for (var choice in choiceList) {
          final choiceResponse = await Supabase.instance.client.from('problem_choice').insert({
            'problem_id': response[0]['id'],
            'choice_title': choice.titleController.text,
            'choice_score': choice.scoreController.text,
          }).select();

          print('Inserted choice: $choiceResponse');
        }
      }
    } catch (e) {
      print('Error inserting test: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Center(),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "문제 명",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.cyan,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 3.0,
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 50)),
              Expanded(
                child: ListView.builder(
                  itemCount: _choiceControllers.length,
                  itemBuilder: (context, index) {
                    final choice = _choiceControllers[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              controller: choice.titleController,
                              decoration: InputDecoration(
                                labelText: "선택지 ${index + 1}",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextField(
                              controller: choice.scoreController,
                              decoration: InputDecoration(
                                labelText: "점수 ${index + 1}",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                // 삭제하기 전에 Controller 메모리 해제
                                choice.titleController.dispose();
                                choice.scoreController.dispose();
                                _choiceControllers.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _choiceControllers.add(ProblemChoice(
                            titleController: TextEditingController(),
                            scoreController: TextEditingController(),
                          ));
                        });
                      },
                      child: Text("선택지 추가"),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        insertPsychologyTest(_titleController.text, _choiceControllers);
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MakePsychologyProblemScreen(
                              testId: widget.testId,
                            ),
                          ),
                        );
                      },
                      child: Text("다음 문제"),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        insertPsychologyTest(_titleController.text, _choiceControllers);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                          (route) => false,
                        );
                      },
                      child: Text("테스트 완성"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProblemChoice {
  final TextEditingController titleController;
  final TextEditingController scoreController;

  ProblemChoice({
    required this.titleController,
    required this.scoreController,
  });
}
