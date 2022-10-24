
import 'package:flutter/material.dart';
import 'package:quizapp/screens/quiz_screen.dart';
import 'package:quizapp/utils/color_utils.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.48,
            child: const Image(
              image: AssetImage("images/hero.png"),
            ),
          ),
          Text(
            "QUIZ SAGA",
            style: TextStyle(
                fontSize: 50, fontWeight: FontWeight.bold, color: primaryColor),
          ),
          Text(
            "Yo k xa guys haru yo hamro rabin sir ley banako quiz app. How is this app la heram hai aba k hunxa",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: primaryColor),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const QuizScreen()));
            },
            child: CircleAvatar(
                backgroundColor: primaryColor,
                radius: 40,
                child: const Icon(Icons.arrow_forward)),
          )
        ],
      ),
    ));
  }
}
