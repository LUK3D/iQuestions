import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iquestions/feactures/Questions/Questions.dart';
import 'package:iquestions/models/questionsModel.dart';

class DashboardController extends GetxController {
  var languages = <Language>[].obs;
  var searching = ''.obs;
  var myQLanguages = <Language>[];
  var refreshList = 0.obs;
  void OpenQuestion(Language language) async {
    await Get.to(() => QuestionsPage(), arguments: language);
    final box = GetStorage();
    box.write('languages', languages.value.map((e) => e.toJson()).toList());
    refresh();
    Get.snackbar(
      "Save!",
      "All changes where saved Successfuly",
      colorText: Colors.white,
    );
  }

  void addLanguages(List<Language>? languagesList) {
    languages.value = languagesList ??
        [
          Language(
            color: Colors.blue,
            icon: 'assets/icons/icons8_c_sharp_logo.svg',
            language: 'C Sharp',
            description: 'Most asked questions about C#',
            questions: [],
          ),
          Language(
            color: Colors.yellow,
            icon: 'assets/icons/icons8_javascript.svg',
            language: 'Javscript',
            description: 'Most asked questions about Javascript',
            questions: [],
          ),
          Language(
            color: Colors.green,
            icon: 'assets/icons/icons8_nodejs.svg',
            language: 'Nodejs',
            description: 'Most asked questions about Nodejs',
            questions: [],
          ),
          Language(
            color: Colors.blue,
            icon: 'assets/icons/icons8_react.svg',
            language: 'Reactjs',
            description: 'Most asked questions about Reactjs',
            questions: [],
          ),
          Language(
            color: Colors.green,
            icon: 'assets/icons/icons8_vuejs.svg',
            language: 'Vuejs',
            description: 'Most asked questions about Vuejs',
            questions: [],
          ),
        ];

    myQLanguages = languages.value;
  }

  void search(String word) {
    if (word.isNotEmpty) {
      languages.value = myQLanguages
          .where((e) =>
              e.language.toLowerCase().contains(word.toLowerCase()) ||
              e.description.toLowerCase().contains(word.toLowerCase()))
          .toList();
    } else {
      languages.value = myQLanguages;
    }
    refreshList.value = refreshList.value + 1;
  }

  void refresh() {
    final box = GetStorage();
    var savedQuestions = (box.read('languages') as List<dynamic>).map((x) {
      return Language.fromJson(x);
    }).toList();
    addLanguages(savedQuestions);
  }

  @override
  void onInit() {
    final box = GetStorage();
    // box.remove('languages');
    if (box.hasData('languages')) {
      refresh();
    } else {
      addLanguages(null);
    }

    super.onInit();
  }
}
