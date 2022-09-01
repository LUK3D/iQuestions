import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_icon/svg_icon.dart';
import 'package:unicons/unicons.dart';
import 'package:collection/collection.dart';
import '../../components/languageButton.dart';
import '../../core/utils.dart';
import 'questionsController.dart';

class QuestionsPage extends StatelessWidget {
  const QuestionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(QuestionsController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey,
        child: Icon(Icons.post_add_rounded),
        onPressed: ctrl.addQuestion,
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(
          gradient: Utils().mainGradient,
        ),
        child: CustomScrollView(
          slivers: [
            Obx(() => SliverAppBar(
                  pinned: false,
                  floating: true,
                  collapsedHeight: 65,
                  toolbarHeight: 65,
                  expandedHeight: 200,
                  backgroundColor: Utils().base1,
                  foregroundColor: ctrl.language.value.color,
                  leading: null,
                  centerTitle: true,
                  title: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Be Prepared for your test.',
                          style: TextStyle(
                              fontSize: 9,
                              color:
                                  ctrl.language.value.color.withOpacity(0.5)),
                        ),
                        Text(
                          ctrl.language.value.language,
                        ),
                      ],
                    ),
                  ),
                  flexibleSpace: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      margin: EdgeInsets.only(top: 70),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      color: Utils().base1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SvgIcon(
                              ctrl.language.value.icon.isNotEmpty
                                  ? ctrl.language.value.icon
                                  : 'assets/icons/icons8_bug.svg',
                              color: ctrl.language.value.color,
                              width: 80,
                              height: 80),
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Search...',
                                prefixIcon: Icon(UniconsLine.search),
                                border: InputBorder.none,
                                fillColor: Colors.white,
                              ),
                              onChanged: (val) {
                                ctrl.search(val);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
            SliverList(
                delegate: SliverChildListDelegate([
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                      'Questions',
                      style: TextStyle(color: Colors.white),
                    ),
                    Obx(() => Text(
                          ' (${ctrl.language.value.questions.length})',
                          key: Key('quetion_${ctrl.refreshList}'),
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.5)),
                        ))
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                margin: EdgeInsets.only(top: 30),
                child: Obx(() => Column(
                    key: Key('list_${ctrl.refreshList.value}'),
                    children: ctrl.language.value.questions
                        .mapIndexed((index, question) {
                      return LanguageButton(
                        icon: null,
                        iconWidget: Text((index + 1).toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 40)),
                        onClick: () {
                          ctrl.gotoAnswers(index);
                        },
                        onDismiss: () {
                          ctrl.onDismiss(index);
                        },
                        iconColor: ctrl.language.value.color,
                        tittle: Utils.elipsedString(question.tittle, 45),
                        description:
                            Utils.elipsedString(question.description, 45),
                      );
                    }).toList())),
              )
            ]))
          ],
        ),
      ),
    );
  }
}
