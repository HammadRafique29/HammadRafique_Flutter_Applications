import 'package:ibm_table_gen_app/constantFile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import 'calculatorFile.dart';
// import 'resultFile.dart';
//  import 'calculatorFile.dart';
const kLabelStyle = TextStyle(
  fontSize: 18.0,
  color: Color(0xFF8D8E98),
);

const kNumberStyle = TextStyle(
  fontSize: 12.0,
  fontWeight: FontWeight.w900,
);

const kLargeButtonstyle = TextStyle(
  fontSize: 25.0,
  fontWeight: FontWeight.bold,
);

enum Quiz {
  mcqs,
  truefalse,
}

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Quiz? quizType;
  int sliderHeight = 1;
  int sliderUpperLimit = 20;
  int sliderLowerLimit = 1;
  int sliderAge = 20;
  int upperWeightLimit = 20;
  int lowerAgeLimit = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Table Generator app'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: RepeatContainerCode(
                    colors: quizType == Quiz.mcqs ? activeColor : deActiveColor,
                    cardWidget: const RepeatTextandICONeWidget(
                      icondata: AssetImage("images/choice.png"),
                      label: 'MCQS',
                    ),
                    onPressed: () {
                      setState(() {
                        quizType = Quiz.mcqs;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TableDisplayPage(
                              height: 0,
                              upperLimit: 0,
                              lowerLimit: 0,
                            ),
                          ),
                        );
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RepeatContainerCode(
                    colors: quizType == Quiz.truefalse
                        ? activeColor
                        : deActiveColor,
                    cardWidget: const RepeatTextandICONeWidget(
                      icondata: AssetImage("images/truefalse.png"),
                      label: 'True False',
                    ),
                    onPressed: () {
                      setState(() {
                        quizType = Quiz.truefalse;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: RepeatContainerCode(
              onPressed: () {},
              colors: const Color(0xFF1D1E33),
              cardWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Table Generator',
                    style: kLabelStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        sliderHeight.toString(),
                        style: kNumberStyle,
                      ),
                    ],
                  ),
                  Slider(
                    value: sliderHeight.toDouble(),
                    min: 1.0,
                    max: 10.0,
                    activeColor: const Color(0XFFEB1555),
                    inactiveColor: const Color(0xFF8D8E98),
                    onChanged: (double newValue) {
                      setState(() {
                        sliderHeight = newValue.round();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: RepeatContainerCode(
                    onPressed: () {
                      setState(() {
                        if (sliderLowerLimit > 1) {
                          sliderLowerLimit--;
                        }
                      });
                    },
                    colors: const Color(0xFF1D1E33),
                    cardWidget: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Lower Limit',
                          style: kLabelStyle,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              child: const Icon(
                                Icons.navigate_before,
                              ),
                              onTap: () {
                                setState(() {
                                  if (sliderLowerLimit > 1) {
                                    sliderLowerLimit--;
                                  }
                                });
                              },
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              sliderLowerLimit.toString(),
                              style: kNumberStyle,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              child: const Icon(
                                Icons.navigate_next,
                              ),
                              onTap: () {
                                setState(() {
                                  if (sliderLowerLimit < upperWeightLimit) {
                                    sliderLowerLimit++;
                                  }
                                });
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: RepeatContainerCode(
                    onPressed: () {
                      setState(() {
                        if (sliderUpperLimit < upperWeightLimit) {
                          sliderUpperLimit++;
                        }
                      });
                    },
                    colors: const Color(0xFF1D1E33),
                    cardWidget: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Upper Limit',
                          style: kLabelStyle,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              child: const Icon(
                                Icons.navigate_before,
                              ),
                              onTap: () {
                                setState(() {
                                  if (sliderUpperLimit > 1) {
                                    sliderUpperLimit--;
                                  }
                                });
                              },
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              sliderUpperLimit.toString(),
                              style: kNumberStyle,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              child: const Icon(
                                Icons.navigate_next,
                              ),
                              onTap: () {
                                setState(() {
                                  if (sliderUpperLimit < upperWeightLimit) {
                                    sliderUpperLimit++;
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TableDisplayPage(
                    height: sliderHeight,
                    upperLimit: sliderUpperLimit,
                    lowerLimit: sliderLowerLimit,
                  ),
                ),
              );
            },
            child: Container(
              color: const Color(0xFFEB1555),
              margin: const EdgeInsets.only(top: 10.0),
              width: double.infinity,
              height: 80.0,
              child: const Center(
                child: Text(
                  'Generate Table',
                  style: kLargeButtonstyle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TableDisplayPage extends StatelessWidget {
  final int height;
  final int upperLimit;
  final int lowerLimit;

  const TableDisplayPage({
    super.key,
    required this.height,
    required this.upperLimit,
    required this.lowerLimit,
  });

  List<Widget> DatabaseTable_Generator(BuildContext context) {
    List<Widget> WidgetList = [];

    for (int i = 0; i < 5; i++) {
      WidgetList.add(Container(
        width: MediaQuery.sizeOf(context).width * 0.6,
        height: MediaQuery.sizeOf(context).height * 0.22,
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(20)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black45,
                ),
                child: Center(
                  child: Text("Table of 4"),
                ),
              ),
              const SizedBox(height: 10.0),
              for (int i = lowerLimit; i <= upperLimit + 10; i++)
                Text(
                  '$height    x    $i  =  ${height * i}',
                  style: kNumberStyle,
                ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizPage(
                        height: height,
                        upperLimit: upperLimit,
                        lowerLimit: lowerLimit,
                      ),
                    ),
                  );
                },
                child: const Text('Start Quiz'),
              ),
            ],
          ),
        ),
      ));
    }

    return WidgetList;
  }

  @override
  Widget build(BuildContext context) {
    if (height == 0 && upperLimit == 0 && lowerLimit == 0) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Table Display'),
            actions: [
              GestureDetector(
                child: const Image(
                  image: AssetImage("images/choice.png"),
                  width: 30,
                  height: 30,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                child: const Image(
                  image: AssetImage("images/truefalse.png"),
                  width: 30,
                  height: 30,
                ),
              ),
              const SizedBox(
                width: 40,
              )
            ],
          ),
          body: Row(
            children: [
              Expanded(
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  height: MediaQuery.sizeOf(context).height * 0.9,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.45,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFF0A0E21)),
                        child: Text(
                          'Requested Table\nMultiplication Table for $height',
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        height: MediaQuery.sizeOf(context).height * 0.3,
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFF0A0E21),
                        ),
                        margin: EdgeInsets.only(
                            top: MediaQuery.sizeOf(context).height * 0.33),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 10.0),
                              Center(
                                child: Text("No Table Requested"),
                              ),
                              const SizedBox(height: 20.0),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Center(
                      child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.3,
                          height: MediaQuery.sizeOf(context).height * 0.06,
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black45,
                          ),
                          child: const Center(
                            child: Text(
                              "DATABASE",
                              style: TextStyle(fontSize: 14.0),
                            ),
                          )),
                    ),
                    Container(
                        width: MediaQuery.sizeOf(context).width * 0.9,
                        height: MediaQuery.sizeOf(context).height * 0.75,
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0A0E21),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: DatabaseTable_Generator(context),
                          ),
                        ))
                  ],
                ),
              ),
            ],
          ));
    } else {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Table Display'),
            actions: [
              GestureDetector(
                child: const Image(
                  image: AssetImage("images/choice.png"),
                  width: 30,
                  height: 30,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                child: const Image(
                  image: AssetImage("images/truefalse.png"),
                  width: 30,
                  height: 30,
                ),
              ),
              const SizedBox(
                width: 40,
              )
            ],
          ),
          body: Row(
            children: [
              Expanded(
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  height: MediaQuery.sizeOf(context).height * 0.9,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.45,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFF0A0E21)),
                        child: Text(
                          'Requested Table\nMultiplication Table for $height',
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        height: MediaQuery.sizeOf(context).height * 0.6,
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey,
                        ),
                        margin: EdgeInsets.only(
                            top: MediaQuery.sizeOf(context).height * 0.03),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 10.0),
                              for (int i = lowerLimit;
                                  i <= upperLimit + 50;
                                  i++)
                                Text('$height    x    $i  =  ${height * i}',
                                    style: TextStyle(fontSize: 15)),
                              const SizedBox(height: 20.0),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizPage(
                                height: height,
                                upperLimit: upperLimit,
                                lowerLimit: lowerLimit,
                              ),
                            ),
                          );
                        },
                        child: const Text('Save Table'),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Center(
                      child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.3,
                          height: MediaQuery.sizeOf(context).height * 0.06,
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black45,
                          ),
                          child: const Center(
                            child: Text(
                              "DATABASE",
                              style: TextStyle(fontSize: 14.0),
                            ),
                          )),
                    ),
                    Container(
                        width: MediaQuery.sizeOf(context).width * 0.9,
                        height: MediaQuery.sizeOf(context).height * 0.75,
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0A0E21),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: DatabaseTable_Generator(context),
                          ),
                        ))
                  ],
                ),
              ),
            ],
          ));
    }
  }
}

class QuizPage extends StatefulWidget {
  final int height;
  final int upperLimit;
  final int lowerLimit;

  const QuizPage({
    super.key,
    required this.height,
    required this.upperLimit,
    required this.lowerLimit,
  });

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentIndex = 0;
  int correctAnswers = 0;
  List<Question> questions = [];

  @override
  void initState() {
    super.initState();
    generateQuestions();
  }

  void generateQuestions() {
    questions.clear();
    List<int> sequence = List.generate(
        widget.upperLimit - widget.lowerLimit + 1,
        (index) => widget.lowerLimit + index);
    sequence.shuffle();

    for (int i in sequence) {
      int result = widget.height * i;
      List<String> options = generateOptions(result);
      questions.add(Question(
        questionNumber: questions.length + 1,
        question: '${widget.height} x $i = ?',
        correctAnswer: result.toString(),
        options: options,
      ));
    }
  }

  List<String> generateOptions(int correctAnswer) {
    List<String> options = [];
    options.add(correctAnswer.toString());
    while (options.length < 4) {
      int randomOption =
          correctAnswer + (1 + (DateTime.now().millisecondsSinceEpoch % 10));
      if (!options.contains(randomOption.toString())) {
        options.add(randomOption.toString());
      }
    }
    options.shuffle();
    return options;
  }

  void answerQuestion(String selectedAnswer) {
    if (selectedAnswer == questions[currentIndex].correctAnswer) {
      correctAnswers++;
    }

    if (currentIndex < questions.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      // Display the result page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(
            correctAnswers: correctAnswers,
            totalQuestions: questions.length,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Question ${currentIndex + 1}/${questions.length}',
              style: kLabelStyle,
            ),
            const SizedBox(height: 10.0),
            Text(
              'Quiz for Multiplication Table of ${widget.height}',
              style: kLabelStyle,
            ),
            const SizedBox(height: 20.0),
            QuestionWidget(
              question: questions[currentIndex],
              onAnswerSelected: answerQuestion,
            ),
          ],
        ),
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;

  const ResultPage({
    super.key,
    required this.correctAnswers,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Quiz Completed!'),
            Text('Correct Answers: $correctAnswers / $totalQuestions'),
            if (correctAnswers > 5)
              const Text('Congratulations, you passed!')
            else
              const Text('Hard work needed. Keep trying!'),
          ],
        ),
      ),
    );
  }
}

class Question {
  final String question;
  final String correctAnswer;
  final List<String> options;

  Question({
    required this.question,
    required this.correctAnswer,
    required this.options,
    required int questionNumber,
  });
}

class QuestionWidget extends StatelessWidget {
  final Question question;
  final Function(String) onAnswerSelected;

  const QuestionWidget({
    super.key,
    required this.question,
    required this.onAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          question.question,
          style: kLabelStyle,
        ),
        const SizedBox(height: 20.0),
        Column(
          children: question.options.map((option) {
            return ElevatedButton(
              onPressed: () => onAnswerSelected(option),
              child: Text(option),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class RoundIcon extends StatelessWidget {
  const RoundIcon({super.key, required this.iconData, this.onPress});
  final IconData? iconData;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPress,
      elevation: 6.0,
      constraints: const BoxConstraints.tightFor(
        height: 40.0,
        width: 40.0,
      ),
      shape: const CircleBorder(),
      fillColor: const Color(0XFF4C4F5E),
      child: Icon(iconData),
    );
  }
}

class RepeatContainerCode extends StatelessWidget {
  const RepeatContainerCode(
      {super.key,
      required this.colors,
      required this.cardWidget,
      this.onPressed});

  final Color colors;
  final Widget cardWidget;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: colors,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: cardWidget,
      ),
    );
  }
}

class RepeatTextandICONeWidget extends StatelessWidget {
  const RepeatTextandICONeWidget(
      {super.key, required this.icondata, required this.label});

  final AssetImage icondata;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: icondata,
          width: 80.0,
        ),
        // Icon(
        //   icondata,
        //   size: 80.0,
        // ),
        const SizedBox(
          height: 15.0,
        ),
        Text(
          label,
          style: kLabelStyle,
        ),
      ],
    );
  }
}
