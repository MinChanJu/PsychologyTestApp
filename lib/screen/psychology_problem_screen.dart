import 'package:flutter/material.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/psychology_problem_model.dart';
import '../model/problem_choice_model.dart';
import '../widget/appbar_widget.dart';
import 'psychology_test_list_screen.dart';

class PsychologyProblemScreen extends StatefulWidget {
  final int testId;
  const PsychologyProblemScreen({super.key, required this.testId});

  @override
  State<PsychologyProblemScreen> createState() => _PsychologyProblemScreenState();
}

class _PsychologyProblemScreenState extends State<PsychologyProblemScreen> {
  late var _problem = Supabase.instance.client.from('psychology_problem').select();

  @override
  void initState() {
    super.initState();
    _problem = _problem.eq('test_id', widget.testId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: FutureBuilder(
        future: _problem,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('문제가 비어있습니다.'));
          }
          final List<dynamic> data = snapshot.data!;
          final List<PsychologyProblemModel> problemList = data.map((json) => PsychologyProblemModel.fromJson(json)).toList();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(
                  score: 0,
                  index: 0,
                  problemList: problemList,
                ),
              ),
            );
          });
          return ListView.builder(
            itemCount: problemList.length,
            itemBuilder: ((context, index) {
              final problem = problemList[index];
              return ListTile(
                title: Text(problem.problemTitle),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(
                        score: 0,
                        index: index,
                        problemList: problemList,
                      ),
                    ),
                  );
                },
              );
            }),
          );
        },
      ),
    );
  }
}

class DetailPage extends StatefulWidget {
  final int score;
  final int index;
  final List<PsychologyProblemModel> problemList;

  const DetailPage({
    super.key,
    required this.score,
    required this.index,
    required this.problemList,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late var _choice = Supabase.instance.client.from('problem_choice').select();

  @override
  void initState() {
    super.initState();
    _choice = _choice.eq("problem_id", widget.problemList[widget.index].id);
  }

  @override
  Widget build(BuildContext context) {
    final problem = widget.problemList[widget.index];
    final isLastItem = widget.index == widget.problemList.length - 1;

    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  problem.problemTitle,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 50)),
              Expanded(
                child: FutureBuilder(
                  future: _choice,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (!snapshot.hasData) {
                      return const Center(child: Text('보기가 비어있습니다.'));
                    }
                    final List<dynamic> data = snapshot.data!;
                    final List<ProblemChoiceModel> choiceList = data.map((json) => ProblemChoiceModel.fromJson(json)).toList();
                    return ListView.builder(
                      itemCount: choiceList.length,
                      itemBuilder: ((context, index) {
                        final choice = choiceList[index];
                        return ListTile(
                          title: Text(choice.choiceTitle),
                          onTap: () {
                            if (!isLastItem) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                    score: widget.score + choice.choiceScore,
                                    index: widget.index + 1,
                                    problemList: widget.problemList,
                                  ),
                                ),
                              );
                            } else {
                              int popped = 0;

                              Navigator.popUntil(
                                context,
                                (route) {
                                  return popped++ == widget.problemList.length || route.isFirst;
                                },
                              );

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FinishPage(
                                    totalScore: widget.score + choice.choiceScore,
                                  ),
                                ),
                              );
                            }
                          },
                        );
                      }),
                    );
                  },
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 50)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("이전으로 돌아가기"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FinishPage extends StatefulWidget {
  final int totalScore;
  const FinishPage({
    super.key,
    required this.totalScore,
  });

  @override
  State<FinishPage> createState() => _FinishPageState();
}

class _FinishPageState extends State<FinishPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Text(widget.totalScore.toString())),
            Padding(padding: EdgeInsets.only(top: 30)),
            ElevatedButton(
              onPressed: () {
                int popped = 0;

                Navigator.popUntil(
                  context,
                  (route) {
                    return popped++ == 3 || route.isFirst;
                  },
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PsychologyTestListScreen(),
                  ),
                );
              },
              child: Text("목록"),
            )
          ],
        ),
      ),
    );
  }
}
