import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
void main() => runApp(QuizApp());
class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: const Text('Welcome to Quiz Application! '
                'Test your knowledge and find out!', textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              child: const Text('Start Quiz'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizPage()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int score = 0;
  int questionIndex = 0;
  List<Map<String, dynamic>> questions = [    {'question': '     Which of the following is a type of fruit?',
    'choices': ['Carrot', 'Banana', 'Broccoli', 'Potato'],
    'answer': 'Banana',
  },
    {
      'question': "        What is the opposite of hot?",
      'choices': ['Cold', 'Wet', 'Dry', 'Tall'],
      'answer': 'Cold',
    },
    {
      'question': "       Who is the current President of the United States?",
      'choices': ['George Washington', 'Donald Trump', 'Joe Biden', 'Barack Obama'],
      'answer': 'Joe Biden',
    },
    {
      'question': "         Which of the following animals can fly?",
      'choices': ['Lion', 'Penguin', 'Bat', 'Elephant'],
      'answer': 'Bat',
    },
  ];

  void checkAnswer(String choice) {
    if (choice == questions[questionIndex]['answer']) {
      score+=score+25;
    }
    if (questionIndex < questions.length - 1) {
      setState(() {
        questionIndex++;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsPage(score),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${questionIndex + 1}'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            questions[questionIndex]['question'],
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 16),
          ...List.generate(
            4,
                (index) => ElevatedButton(
              child: Text(questions[questionIndex]['choices'][index]),
              onPressed: () {
                checkAnswer(questions[questionIndex]['choices'][index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ResultsPage extends StatelessWidget {
  final int score;

  ResultsPage(this.score);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Quiz Results'),
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Your Score: $score',
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 16),
                if (score >= 50)
                  const Text(
                    'Well done!!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold
                    ),
                  ),
                if (score < 50 && score >= 25)
                  const Text(
                    'Great job! keep trying to see how much better you can do.',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold
                    ),
                  ),
                if (score < 25)
                  const Text(
                    'Your performance could use some improvement. Take a break and try again later to see if you can do better.',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold
                    ),
                  ),
              ],
            ),
          ),
      );
    }
}