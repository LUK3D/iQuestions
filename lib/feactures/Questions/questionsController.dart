import 'dart:ffi';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iquestions/core/utils.dart';
import 'package:markdown_editor_plus/markdown_editor_plus.dart';
import 'package:markdown_editor_plus/widgets/markdown_field.dart';
import 'package:unicons/unicons.dart';

import '../../models/questionsModel.dart';
import '../answers/Answers.dart';

class QuestionsController extends GetxController {
  var strQuestion = '';
  var strQuestionDescription = '';
  var answer = '';
  var refreshList = 0.obs;

  var searching = ''.obs;

  var myQuestions = <Question>[];

  var language = Language(
      icon: '',
      language: '',
      color: Colors.black,
      description: '',
      questions: []).obs;
  void addQuestion() {
    Get.bottomSheet(
      Container(
        width: Get.width,
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(
                    'Add a new Question',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  Container(
                    width: Get.width,
                    height: 50,
                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: TextFormField(
                      onChanged: (value) {
                        strQuestion = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter the Question',
                        prefixIcon: Icon(UniconsLine.question),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    width: Get.width,
                    height: 50,
                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: TextFormField(
                      onChanged: (value) {
                        strQuestionDescription = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Question Description',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    width: Get.width,
                    height: 100,
                    child: Material(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.grey.shade200,
                      child: MarkdownField(
                        onChanged: (value) {
                          answer = value;
                        },
                        emojiConvert: true,
                        expands: true,
                        decoration: InputDecoration(
                          hintText: 'The Answer goes here',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    width: Get.width,
                    height: 50,
                    child: TextButton.icon(
                      onPressed: addToQuestions,
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          alignment: Alignment.centerLeft,
                          backgroundColor: Utils().base2),
                      icon: Icon(Icons.check),
                      label: Text('Append to List'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addToQuestions() {
    if (strQuestion.isEmpty || answer.isEmpty) {
      Get.snackbar('ERROR!',
          "The Question and Answer are required fields. Please provide a valid values.",
          colorText: Colors.white, duration: Duration(seconds: 7));
      return;
    }
    var q = Question(
      answer: answer,
      description: strQuestionDescription,
      favorites: 0,
      tittle: strQuestion,
      id: 0,
    );
    language.value.questions.insert(0, q);
    refreshList.value = refreshList.value + 1;
    answer = '';
    strQuestionDescription = '';
    strQuestion = '';

    Get.back();
  }

  void onDismiss(index) {
    var currentItem = language.value.questions[index];
    Get.snackbar(currentItem.tittle, "Was deleted from the list.",
        colorText: Colors.white);
    language.value.questions.removeAt(index);
  }

  void gotoAnswers(int index) {
    Get.to(() => AnswersPage(), arguments: [index, language]);
  }

  void search(String word) {
    print(word);
    if (word.isNotEmpty) {
      language.value.questions = myQuestions
          .where((e) =>
              e.tittle.toLowerCase().contains(word.toLowerCase()) ||
              e.answer.toLowerCase().contains(word.toLowerCase()))
          .toList();
    } else {
      language.value.questions = myQuestions;
    }
    refreshList.value = refreshList.value + 1;
  }

  @override
  void onInit() {
    super.onInit();
    language.value = (Get.arguments as Language);

    myQuestions = language.value.questions;
  }
}
