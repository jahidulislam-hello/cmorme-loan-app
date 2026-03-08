import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/features/legal/presentation/view/controller/legal_controller.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_shimmer_loading_indicator.dart';

class LegalScreen extends GetView<LegalController> {
  const LegalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: AppColors.white, size: 30),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Text(
          controller.title,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const LegalContentShimmer();
        }

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Html(
            data: controller.htmlContent.value,
            style: {
              'body': Style(
                color: AppColors.white,
                fontSize: FontSize(15),
                lineHeight: const LineHeight(1.5),
                margin: Margins.zero,
                padding: HtmlPaddings.zero,
              ),
              'p': Style(
                color: AppColors.white,
                fontSize: FontSize(15),
                lineHeight: const LineHeight(1.5),
                margin: Margins.only(bottom: 8),
              ),
              'h1': Style(
                color: AppColors.white,
                fontSize: FontSize(20),
                fontWeight: FontWeight.bold,
                margin: Margins.only(bottom: 8, top: 4),
              ),
              'h2': Style(
                color: AppColors.white,
                fontSize: FontSize(18),
                fontWeight: FontWeight.bold,
                margin: Margins.only(bottom: 6, top: 4),
              ),
              'h3': Style(
                color: AppColors.white,
                fontSize: FontSize(16),
                fontWeight: FontWeight.bold,
                margin: Margins.only(bottom: 4, top: 4),
              ),
              'strong': Style(
                color: AppColors.yellow500,
                fontWeight: FontWeight.bold,
              ),
              'em': Style(
                color: AppColors.white,
                fontStyle: FontStyle.italic,
              ),
              'li': Style(
                color: AppColors.white,
                fontSize: FontSize(15),
                lineHeight: const LineHeight(1.5),
              ),
              'ul': Style(
                margin: Margins.only(bottom: 8),
              ),
              'ol': Style(
                margin: Margins.only(bottom: 8),
              ),
            },
          ),
        );
      }),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
// import 'package:reverse_mortage_loan_app/features/legal/presentation/view/controller/legal_controller.dart';
//
// class LegalScreen extends GetView<LegalController> {
//   const LegalScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final String title = Get.arguments as String? ?? 'Legal';
//
//     return Scaffold(
//       backgroundColor: AppColors.primary,
//       appBar: AppBar(
//         backgroundColor: AppColors.primary,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.chevron_left, color: AppColors.white, size: 30),
//           onPressed: () => Get.back(),
//         ),
//         centerTitle: true,
//         title: Text(
//           title,
//           style: const TextStyle(
//             color: AppColors.white,
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: ListView.separated(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
//           itemCount: controller.legalItems.length,
//           separatorBuilder: (_, __) => const SizedBox(height: 20),
//           itemBuilder: (context, index) {
//             return Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   margin: const EdgeInsets.only(top: 6),
//                   width: 10,
//                   height: 10,
//                   decoration: const BoxDecoration(
//                     color: AppColors.yellow500,
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Text(
//                     controller.legalItems[index],
//                     style: const TextStyle(
//                       color: AppColors.white,
//                       fontSize: 15,
//                       height: 1.4,
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }