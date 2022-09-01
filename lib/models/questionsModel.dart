import 'dart:convert';

import 'package:flutter/cupertino.dart';

Language languageFromJson(String str) => Language.fromJson(json.decode(str));

String languageToJson(Language data) => json.encode(data.toJson());

class Language {
  Language({
    required this.icon,
    required this.language,
    required this.color,
    required this.description,
    required this.questions,
  });

  String icon;
  String language;
  Color color;
  String description;
  List<Question> questions;

  factory Language.fromJson(Map<String, dynamic> json) {
    var tmpColor = json["color"].split(',');

    var color = Color.fromARGB(
      int.parse(tmpColor[3]),
      int.parse(tmpColor[0]),
      int.parse(tmpColor[1]),
      int.parse(
        tmpColor[2],
      ),
    );
    return Language(
      icon: json["icon"],
      language: json["language"],
      description: json["description"],
      color: color,
      questions: List<Question>.from(
          json["questions"].map((x) => Question.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "icon": icon,
        "language": language,
        "description": description,
        "color": "${color.red},${color.green},${color.blue},${color.alpha}",
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}

class Question {
  Question({
    required this.id,
    required this.tittle,
    required this.description,
    required this.answer,
    required this.favorites,
  });

  int id;
  String tittle;
  String description;
  String answer;
  int favorites;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        tittle: json["tittle"],
        description: json["description"],
        answer: json["answer"],
        favorites: json["favorites"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tittle": tittle,
        "description": description,
        "answer": answer,
        "favorites": favorites,
      };
}
