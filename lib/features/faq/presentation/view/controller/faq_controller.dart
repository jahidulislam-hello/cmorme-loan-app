import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';

class FaqController extends GetxController {
  void onAboutUs() {
    Get.toNamed(RouteNames.aboutUs);
  }

  void onWhyWeEducate() {
    Get.toNamed(RouteNames.whyWeEducate);
  }

  void onFrequentlyAskedQuestion() {
    Get.toNamed(RouteNames.faqQuestions);
  }

  void onOurBlog() {
    Get.toNamed(RouteNames.ourBlog);
  }

  void onTestimonial() {
    Get.toNamed(RouteNames.testimonial);
  }

  void onInstantQuote() {
    Get.toNamed(RouteNames.instantQuote);
  }
}
