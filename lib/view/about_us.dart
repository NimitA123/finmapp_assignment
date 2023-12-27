import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/Questions.dart';
import 'result_screen.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AboutUs();
}

class _AboutUs extends State<AboutUs> {
  late List<Fields> fieldsWithOptions;
  late List<String?> selectedAnswers;
  late int selectedRadio;

  Future<void> readJson() async {
    final String response =
    await rootBundle.loadString('assets/json/questions.json');

    setState(() {
      var dataOfJson = questionsFromJson(response);
      // Filter out questions without options
      fieldsWithOptions = dataOfJson.schema!.fields!
          .where((field) =>
      field.schema?.options != null &&
          field.schema!.options!.isNotEmpty)
          .toList();
      selectedAnswers = List.filled(fieldsWithOptions.length, null);
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
        if (defaultPosition < (fieldsWithOptions.length - 1)) {
          defaultPosition += 1;

          while (fieldsWithOptions[defaultPosition].schema?.options?.isEmpty ==
              true) {
            defaultPosition += 1;
            if (defaultPosition >= fieldsWithOptions.length) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultScreen(
                    selectedAnswers: selectedAnswers,
                    fields: fieldsWithOptions,
                  ),
                ),
              );
              return;
            }
          }
        } else {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultScreen(
                selectedAnswers: selectedAnswers,
                fields: fieldsWithOptions,
              ),
            ),
          );
        }
      });
    }

    void descUpdateValue() {
      setState(() {
        if (defaultPosition > 0) {
          defaultPosition -= 1;

          while (fieldsWithOptions[defaultPosition].schema?.options?.isEmpty ==
              true) {
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

    void setSelectedRadio(String answer) {
      setState(() {
        selectedRadio = fieldsWithOptions[defaultPosition]
            .schema!
            .options!
            .indexWhere((option) => option.value == answer);
        selectedAnswers[defaultPosition] = answer; // Store the selected answer
      });
    }

    if (fieldsWithOptions.isEmpty) {
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
                itemCount: fieldsWithOptions.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: (screenWidth -
                        (32 + ((fieldsWithOptions.length + 5) * 2))) /
                        fieldsWithOptions.length,
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
              child:
              Text(fieldsWithOptions[defaultPosition].schema?.label ?? ""),
            ),
            Expanded(
              child: ListView.builder(
                itemCount:
                fieldsWithOptions[defaultPosition].schema?.options?.length ??
                    0,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setSelectedRadio(fieldsWithOptions[defaultPosition]
                          .schema!
                          .options![index]
                          .value!);
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
                              setSelectedRadio(fieldsWithOptions[defaultPosition]
                                  .schema!
                                  .options![index]
                                  .value!);
                            },
                            activeColor: Colors.deepOrangeAccent,
                          ),
                          Text(
                              "${fieldsWithOptions[defaultPosition].schema!.options?[index].value}")
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
