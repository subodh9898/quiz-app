import 'package:flutter/material.dart';

import 'option_box.dart';

class MyPageView extends StatefulWidget {
  final PageController? myController;
  final List? data;
  final int? currentPageNumber;

  MyPageView({Key? key, this.myController, this.data, this.currentPageNumber}) : super(key: key);
  static int currentIndex = 0;

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  bool answerChecker(String option, String answer) {
    if (option == answer) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      // height: 300,
      child: PageView.builder(
        physics: NeverScrollableScrollPhysics(),
        
          controller: widget.myController,
          itemCount: widget.data!.length,
          onPageChanged: (value) {
            setState(() {
              MyPageView.currentIndex = value;
              print(value);
            });
          },
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.data![index]['question'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    OptionBox(
                      optionData: widget.data![index]['option1'],
                      isCorrect: answerChecker(widget.data![index]['option1'],
                          widget.data![index]['answer']),
                    ),
                    OptionBox(
                      optionData: widget.data![index]['option2'],
                      isCorrect: answerChecker(widget.data![index]['option2'],
                          widget.data![index]['answer']),
                    ),
                    OptionBox(
                      optionData: widget.data![index]['option3'],
                      isCorrect: answerChecker(widget.data![index]['option3'],
                          widget.data![index]['answer']),
                    ),
                    OptionBox(
                      optionData: widget.data![index]['option4'],
                      isCorrect: answerChecker(widget.data![index]['option4'],
                          widget.data![index]['answer']),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
