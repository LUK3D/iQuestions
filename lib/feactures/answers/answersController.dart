import 'dart:ffi';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboarding/onboarding.dart';
import 'package:svg_icon/svg_icon.dart';

import '../../models/questionsModel.dart';

class AnswersController extends GetxController {
  final onboardingPagesList = <PageModel>[
    PageModel(
      widget: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            width: 0.0,
            color: Colors.transparent,
          ),
        ),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 45.0,
                  vertical: 90.0,
                ),
                child: SvgIcon(
                  'assets/icons/icons8_bug.svg',
                  color: Colors.white,
                  width: 80,
                  height: 80,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 45.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'There is no questions to show.',
                    style: pageTitleStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Have you tried to add the question from the list?',
                    style: pageInfoStyle.copyWith(
                        fontSize: 9, color: Colors.yellow.shade600),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '',
                    style: pageInfoStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    )
  ].obs;
  var index = 0.obs;

  var language = Language(
      icon: '',
      language: '',
      color: Colors.black,
      description: '',
      questions: []).obs;

  var counterController = CountDownController();

  void makeQuestions() {
    onboardingPagesList.value = language.value.questions.map((question) {
      return PageModel(
        widget: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              width: 0.0,
              color: Colors.transparent,
            ),
          ),
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 45.0,
                    vertical: 90.0,
                  ),
                  child: SvgIcon(
                    language.value.icon,
                    color: language.value.color,
                    width: 80,
                    height: 80,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 45.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      question.tittle,
                      style: pageTitleStyle,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      question.description,
                      style: pageInfoStyle.copyWith(
                          fontSize: 9, color: language.value.color),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      question.answer,
                      style: pageInfoStyle,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }

  void goToNext(int? newIndex) {
    if ((newIndex ?? index.value + 1) >= onboardingPagesList.length) {
    } else {
      index.value = newIndex ?? index.value + 1;
      counterController.restart();
    }
  }

  @override
  void onInit() {
    super.onInit();
    language = Get.arguments[1] as Rx<Language>;
    makeQuestions();
    index.value = Get.arguments[0] as int;
  }
}
