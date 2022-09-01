import 'package:get/get.dart';
import 'package:iquestions/feactures/dashboard/dashboard.dart';

class WelcomeController extends GetxController {
  void gotoDashboard() {
    Get.to(() => DashboardPage());
  }
}
