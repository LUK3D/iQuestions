import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iquestions/feactures/dashboard/dashboardController.dart';
import 'package:svg_icon/svg_icon.dart';
import 'package:unicons/unicons.dart';

import '../../components/languageButton.dart';
import '../../core/utils.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(DashboardController());
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(
          gradient: Utils().mainGradient,
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: false,
              floating: true,
              collapsedHeight: 65,
              toolbarHeight: 65,
              expandedHeight: 150,
              backgroundColor: Utils().base1,
              leading: Icon(
                UniconsLine.paragraph,
                color: Colors.grey,
              ),
              centerTitle: true,
              title: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Be Prepared for your test.',
                      style: TextStyle(fontSize: 9, color: Colors.grey),
                    ),
                    Text(
                      'iQuestions.',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              flexibleSpace: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          prefixIcon: Icon(UniconsLine.search),
                          border: InputBorder.none,
                        ),
                        onChanged: (val) {
                          ctrl.search(val);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // actions: [
              //   Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: CircleAvatar(
              //       radius: 40,
              //       backgroundColor: Colors.grey.withOpacity(0.5),
              //     ),
              //   )
              // ],
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                      'Tecnologies',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      ' (05)',
                      style: TextStyle(color: Colors.white.withOpacity(0.5)),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: Get.height,
                margin: EdgeInsets.only(top: 30),
                child: Obx(
                  () => Column(
                    children: ctrl.languages
                        .map((language) => LanguageButton(
                              totaQuestions: language.questions.length,
                              icon: language.icon,
                              onClick: () {
                                ctrl.OpenQuestion(language);
                              },
                              iconColor: language.color,
                              tittle:
                                  Utils.elipsedString(language.language, 45),
                              description:
                                  Utils.elipsedString(language.description, 45),
                            ))
                        .toList(),
                  ),
                ),
              )
            ]))
          ],
        ),
      ),
    );
  }
}
