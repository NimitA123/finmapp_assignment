import 'package:flutter/material.dart';

import '../model/Questions.dart';

class ResultScreen extends StatelessWidget {
  final List<String?> selectedAnswers;
  final List<Fields> fields;

  ResultScreen({Key? key, required this.selectedAnswers, required this.fields})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    // Filter out questions without options
    List<Fields> filteredFields = fields
        .where((field) =>
    field.schema?.options != null && field.schema!.options!.isNotEmpty)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Result"),
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
                itemCount: filteredFields.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: (screenWidth -
                        (32 + ((filteredFields.length + 5) * 2))) /
                        filteredFields.length,
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: index < selectedAnswers.length
                          ? Colors.deepOrangeAccent
                          : Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: filteredFields.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  int selectedAnswerIndex =
                  filteredFields[index].schema!.options!.indexWhere(
                        (option) =>
                    option.value == selectedAnswers[index],
                  );

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Question ${index + 1}: ${filteredFields[index].schema?.label ?? ""}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Selected Answer: ${selectedAnswers[index] ?? 'No answer'}",
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 10),

                        Divider(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
