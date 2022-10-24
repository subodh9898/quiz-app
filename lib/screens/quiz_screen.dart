import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quizapp/data/qna_data.dart';
import 'package:quizapp/screens/json_test.dart';
// import 'package:quizapp/services/api_call.dart';
import 'package:quizapp/utils/color_utils.dart';
// import 'package:quizapp/widgets/bottom_model.dart';
// import 'package:quizapp/widgets/option_box.dart';
import 'package:quizapp/widgets/page_view.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionNumber = 1;
  String currentSet = "general knowledge";
  final PageController _pageController = PageController();
  Duration examDuration = const Duration(minutes: 60);

  double width = 0.1;

  Color borderColor = Colors.white;

  decreaseTime() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (examDuration.inSeconds > 0) {
        setState(() {
          examDuration = Duration(seconds: examDuration.inSeconds - 1);
        });
      } else {
        timer.cancel();
        showAboutDialog(
            context: context, children: [const Text("Time is over")]);
      }
    });
  }

  int getLength(Map map) {
    num length = 0;
    List list = map.keys.toList();
    for (int i = 0; i < list.length; i++) {
      length = length + map["${list[i]}"].length;
    }
    return length.toInt();
  }

  @override
  void initState() {
    super.initState();
    decreaseTime();

    // getData("author");
  }

  int getIndexForPages(Map map, int currentIndex) {
    num myindex = 1;
    int index = currentIndex + 1;

    List myList = map.keys.toList();

    for (int i = 0; i < index - 1; i++) {
      myindex = myindex + map[myList[i]].length;
    }

    print(" my index is ${myindex.toString()}");

    return myindex.toInt();
  }

  @override
  Widget build(BuildContext context) {
    String minutes = examDuration.inMinutes.toString().padLeft(2, '0');
    String seconds =
        examDuration.inSeconds.remainder(60).toString().padLeft(2, '0');

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const JsonText()));
                    },
                    child: RichText(
                        text: TextSpan(
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            children: [
                          TextSpan(
                              text: (MyPageView.currentIndex +
                                      currentQuestionNumber)
                                  .toString(),
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 25)),
                          const TextSpan(text: "/"),
                          TextSpan(text: getLength(qnaData).toString()),
                        ])),
                  ),
                  Text("$minutes:$seconds"),
                  Row(
                    children: [
                      Builder(builder: (context) {
                        return InkWell(
                          onTap: () {
                            bottomModal(context, _pageController, primaryColor,
                                (inde) {
                              setState(() {
                                currentSet = qnaData.keys.toList()[inde];
                                // print(currentSet);
                              });
                            });
                          },
                          child: const CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.purple,
                            child: Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                          ),
                        );
                      }),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("15",
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  )
                ],
              ),
              Stack(
                children: [
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  Container(
                    height: 8,
                    width: MediaQuery.of(context).size.width * width,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ],
              ),
              //
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)),
                  child: ListView.builder(
                    itemCount: qnaData.keys.toList().length,

                    itemBuilder: ((context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _pageController.jumpTo(0);
                                currentSet = qnaData.keys.toList()[index];
                                currentQuestionNumber =
                                    getIndexForPages(qnaData, index);
                              });
                            },
                            child: Container(
                              height: 30,
                              color: Colors.indigo,
                              child: Text(qnaData.keys.toList()[index]),
                            ),
                          ),
                        )),
                    scrollDirection: Axis.horizontal,
                    // children: [
                    //   Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: InkWell(
                    //       onTap: () {
                    //         setState(() {
                    //           currentSet = 1;
                    //         });
                    //       },
                    //       child: Container(
                    //         height: 30,
                    //         color: Colors.indigo,
                    //         child: Text(" K xaa hajur Set 1"),
                    //       ),
                    //     ),
                    //   ),
                    //   InkWell(
                    //     onTap: () {
                    //       setState(() {
                    //         currentSet = 2;
                    //       });
                    //     },
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: Container(
                    //         height: 30,
                    //         color: Colors.indigo,
                    //         child: Text(" K xaa hajurrrrrrr Data 2"),
                    //       ),
                    //     ),
                    //   ),
                    //   Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: InkWell(
                    //       onTap: () {
                    //         currentSet = 3;
                    //       },
                    //       child: Container(
                    //         height: 30,
                    //         color: Colors.indigo,
                    //         child: Text(" K xaa hajur Data 3"),
                    //       ),
                    //     ),
                    //   ),
                    //   Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: InkWell(
                    //       onTap: () {
                    //         setState(() {
                    //           currentSet = 4;
                    //         });
                    //       },
                    //       child: Container(
                    //         height: 30,
                    //         color: Colors.indigo,
                    //         child: Text(" K xaa hajur Data 4"),
                    //       ),
                    //     ),
                    //   ),
                    //   Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Container(
                    //       height: 30,
                    //       color: Colors.indigo,
                    //       child: Text(" K xaa hajur"),
                    //     ),
                    //   )
                    // ],
                  ),
                ),
              ),
              MyPageView(
                myController: _pageController,
                data: qnaData[currentSet],
              ),
              // Container(
              //   height: MediaQuery.of(context).size.height * 0.5,
              //   // height: 300,
              //   child: PageView.builder(

              //       controller: _pageController,
              //       itemCount: qnaData.length,
              //       itemBuilder: (context, index) {
              //         return Padding(
              //           padding: const EdgeInsets.symmetric(vertical: 8.0),
              //           child: Container(
              //             padding: const EdgeInsets.all(16),
              //             height: MediaQuery.of(context).size.height * 0.5,
              //             decoration: BoxDecoration(
              //                 color: secondaryColor,
              //                 borderRadius: BorderRadius.circular(10)),
              //             child: Column(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Text(
              //                   qnaData[index]['question'],
              //                   textAlign: TextAlign.center,
              //                   style: TextStyle(
              //                       color: primaryColor,
              //                       fontSize: 18,
              //                       fontWeight: FontWeight.bold),
              //                 ),
              //                 OptionBox(
              //                   optionData: qnaData[index]['option1'],
              //                 ),
              //                 OptionBox(
              //                   optionData: qnaData[index]['option2'],
              //                 ),
              //                 OptionBox(
              //                   optionData: qnaData[index]['option3'],
              //                 ),
              //                 OptionBox(
              //                   optionData: qnaData[index]['option4'],
              //                 )
              //               ],
              //             ),
              //           ),
              //         );
              //       }),
              // ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                    child: CircleAvatar(
                        backgroundColor: primaryColor,
                        radius: 40,
                        child: const Icon(Icons.arrow_back)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Timer.periodic(const Duration(seconds: 2), (timer) {
                          setState(() {
                            width = qnaData.length / 2;
                          });
                        });

                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },
                      child: CircleAvatar(
                          backgroundColor: primaryColor,
                          radius: 40,
                          child: const Icon(Icons.arrow_forward)),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> bottomModal(BuildContext context,
      PageController pageControllers, Color primaryColor, Function onClick) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      pageControllers.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                    child: CircleAvatar(
                        backgroundColor: primaryColor,
                        radius: 30,
                        child: const Icon(Icons.arrow_back)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        pageControllers.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },
                      child: CircleAvatar(
                          backgroundColor: primaryColor,
                          radius: 30,
                          child: const Icon(Icons.arrow_forward)),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: ListView.builder(
                    itemCount: qnaData.keys.toList().length,
                    itemBuilder: ((context, indexx) => Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(qnaData.keys.toList()[indexx]),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 130,
                                color: secondaryColor,
                                child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2),
                                    // gridDelegate:
                                    //     SliverGridDelegateWithMaxCrossAxisExtent(
                                    //         maxCrossAxisExtent: 1),
                                    itemCount:
                                        qnaData[qnaData.keys.toList()[indexx]]
                                            .length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        // onTap: onClick,
                                        onTap: () {
                                          setState(() {
                                            borderColor = Colors.black;
                                            currentQuestionNumber =
                                                getIndexForPages(
                                                    qnaData, indexx);
                                          });
                                          onClick(indexx);
                                          pageControllers.jumpToPage(index);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  color: Colors.red,
                                                  border: Border.all(
                                                      color: borderColor,
                                                      width: 2)),
                                              child: Center(
                                                child: Text((getIndexForPages(
                                                            qnaData, indexx) +
                                                        index)
                                                    .toString()),
                                              )),
                                          // child: CircleAvatar(
                                          //   // backgroundColor: primaryColor,
                                          //   // child: Text("${index + 1}"),
                                          //   child: Text((getIndexForPages(
                                          //               qnaData, indexx) +
                                          //           index)
                                          //       .toString()),
                                          // ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ],
                        ))),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(onPressed: () {}, child: const Text("Submit")),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel")),
                ],
              )
            ],
          );
        });
  }
}
