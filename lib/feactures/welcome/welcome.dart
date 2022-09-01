import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iquestions/core/utils.dart';
import 'package:iquestions/feactures/welcome/welcomeController.dart';
import 'package:svg_icon/svg_icon.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctl = Get.put(WelcomeController());

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(gradient: Utils().mainGradient),
            width: Get.width,
            height: Get.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgIcon(
                  'assets/icons/icons8_light_on.svg',
                  width: 150,
                  height: 150,
                  color: Colors.white,
                ),
                Text(
                  'iQuestions',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Made by Filipe Lukebana @LUK3D',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
                Text(
                  'filipelukebana@gmail.com',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: TextButton(
              onPressed: ctl.gotoDashboard,
              child: Text('Start'),
            ),
          )
        ],
      ),
    );
  }
}
