import 'dart:convert';
import 'package:finmapp_quiz/view/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/Questions.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AboutUs();
}

class _AboutUs extends State<AboutUs> {
  late List<Fields> fields;
  late List<int?> selectedAnswers;
  late int selectedRadio;

  Future<void> readJson() async {
    final String response =
    await rootBundle.loadString('assets/json/questions.json');

    setState(() {
      var dataOfJson = questionsFromJson(response);
      fields = dataOfJson.schema!.fields!;
      selectedAnswers = List.filled(fields.length, null);
    });
  }

  var defaultPosition = 0;

  @override
  void initState() {
    super.initState();
    readJson();
    selectedRadio = 0;
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;


    void updateValue() {
      setState(() {
        if (defaultPosition < (fields.length - 1)) {
          defaultPosition += 1;

          while (fields[defaultPosition].schema?.options?.isEmpty == true) {
            defaultPosition += 1;
            if (defaultPosition >= fields.length) {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultScreen(selectedAnswers: selectedAnswers),
                ),
              );
              return;
            }
          }
        } else {
          // If at the last question, navigate to the result screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultScreen(selectedAnswers: selectedAnswers),
            ),
          );
        }
      });
    }

    void descUpdateValue() {
      setState(() {
        if (defaultPosition > 0) {
          defaultPosition -= 1;

          while (fields[defaultPosition].schema?.options?.isEmpty == true) {
            defaultPosition -= 1;
            if (defaultPosition < 0) {

              defaultPosition = 0;
              break;
            }
          }
        } else {
          Navigator.pop(context);
        }
      });
    }

    void setSelectedRadio(int val) {
      setState(() {
        selectedRadio = val;
        selectedAnswers[defaultPosition] = val; // Store the selected answer
      });
    }

    if (fields.isEmpty) {

      return Scaffold(
        body: Center(
          child: Text("No questions available."),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("About loan"),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        width: screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: screenWidth,
              height: 5,
              child: ListView.builder(
                itemCount: fields.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: (screenWidth -
                        (32 + ((fields.length + 5) * 2))) /
                        fields.length,
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: (defaultPosition < index)
                          ? Colors.grey
                          : Colors.deepOrangeAccent,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              child: Text(fields[defaultPosition].schema?.label ?? ""),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: fields[defaultPosition].schema?.options?.length ?? 0,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setSelectedRadio(index);
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10, top: 5),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                            color: (index == selectedRadio)
                                ? Colors.deepOrangeAccent
                                : Colors.grey,
                            width: 1),
                      ),
                      child: Row(
                        children: [
                          Radio(
                            value: index,
                            groupValue: selectedRadio,
                            onChanged: (onChanged) {
                              setSelectedRadio(onChanged ?? 0);
                            },
                            activeColor: Colors.deepOrangeAccent,
                          ),
                          Text(
                              "${fields[defaultPosition].schema!.options?[index].value}")
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        child: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  descUpdateValue();
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10, bottom: 10),
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 6),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back_ios_new_outlined, size: 15,),
                      Text("Back")
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  updateValue();
                },
                child: Container(
                  margin: EdgeInsets.only(right: 10, bottom: 10),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.deepOrangeAccent,
                      borderRadius: BorderRadius.all(Radius.circular(30))
                  ),
                  child: Icon(Icons.arrow_forward_ios_outlined, color: Colors.white,),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

