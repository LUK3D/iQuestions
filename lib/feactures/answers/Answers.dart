import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:onboarding/onboarding.dart';

import '../../core/utils.dart';
import 'answersController.dart';

class AnswersPage extends StatelessWidget {
  const AnswersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(AnswersController());

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: Get.width,
            height: Get.height,
            decoration: BoxDecoration(
              gradient: Utils().mainGradient,
            ),
            child: Obx(() => Onboarding(
                  pages: ctrl.onboardingPagesList.value,
                  onPageChange: (int pageIndex) {
                    ctrl.index.value = pageIndex;
                    ctrl.goToNext(pageIndex);
                  },
                  startPageIndex: ctrl.index.value,
                  footerBuilder:
                      (context, dragDistance, pagesLength, setIndex) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          width: 0.0,
                          color: Colors.transparent,
                        ),
                      ),
                      child: ColoredBox(
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(45.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomIndicator(
                                netDragPercent: dragDistance,
                                pagesLength: pagesLength,
                                indicator: Indicator(
                                  indicatorDesign: IndicatorDesign.line(
                                    lineDesign: LineDesign(
                                      lineType: DesignType.line_uniform,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: Obx(
              () => Text(
                '${ctrl.index.value + 1} of ${ctrl.onboardingPagesList.length} Questions',
                style: TextStyle(color: Colors.white.withOpacity(0.5)),
              ),
            ),
          ),
          Positioned(
              top: 30,
              right: 20,
              child: CircularCountDownTimer(
                duration: 30,
                initialDuration: 0,
                controller: ctrl.counterController,
                width: 40,
                height: 40,
                ringColor: Colors.black,
                ringGradient: null,
                fillColor: Utils().base2,
                fillGradient: null,
                backgroundColor: Utils().base1,
                backgroundGradient: null,
                strokeWidth: 5.0,
                strokeCap: StrokeCap.round,
                textStyle: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                textFormat: CountdownTextFormat.S,
                isReverse: false,
                isReverseAnimation: false,
                isTimerTextShown: true,
                autoStart: true,
                onStart: () {},
                onComplete: () {
                  ctrl.goToNext(null);
                },
                onChange: (String timeStamp) {},
              ))
        ],
      ),
    );
  }
}
