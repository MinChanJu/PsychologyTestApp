import 'package:flutter/material.dart';
import 'package:psychology/screen/make_psychology_problem_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../widget/appbar_widget.dart';

class MakePsychologyTestScreen extends StatefulWidget {
  const MakePsychologyTestScreen({super.key});

  @override
  State<MakePsychologyTestScreen> createState() => _MakePsychologyTestScreenState();
}

class _MakePsychologyTestScreenState extends State<MakePsychologyTestScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _createdByController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _createdByController.dispose();
    super.dispose();
  }

  Future<int?> insertPsychologyTest(String title, String description, String createdBy) async {
    try {
      final response = await Supabase.instance.client.from('psychology_test').insert({
        'title': title,
        'description': description,
        'created_by': createdBy,
      }).select();

      print('Inserted test: $response');
      return response[0]['id'];
    } catch (e) {
      print('Error inserting test: $e');
      return -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "심리 테스트 제목",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.cyan.shade800,
                      width: 3.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _createdByController,
                decoration: InputDecoration(
                  labelText: "테스트 만든 사람",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.cyan.shade800,
                      width: 3.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                maxLines: null,
                minLines: 2,
                keyboardType: TextInputType.multiline,
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: "심리 테스트 설명",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final id = await insertPsychologyTest(
                    _titleController.text,
                    _descriptionController.text,
                    _createdByController.text,
                  );
                  if (id != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MakePsychologyProblemScreen(
                          testId: id,
                        ),
                      ),
                    );
                  }
                },
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
