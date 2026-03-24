import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/features/authentication/presentation/view/controller/auth_controller.dart';
import 'package:reverse_mortage_loan_app/features/inbox/presentation/view/widgets/inbox_item.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_calculation_item.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_search_bar.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_shimmer_loading_indicator.dart';
import 'package:reverse_mortage_loan_app/features/history/presentation/view/controller/history_controller.dart';

class HistoryScreen extends GetView<HistoryController> {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Center(
              child: const Text(
                'History',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  CustomSearchBar(
                    controller: controller.searchController,
                    onFilterTap: controller.onFilterTap,
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: Obx(() {
                      if (controller.isLoading.value) {
                        return const CustomShimmerLoadingIndicator(itemCount: 4);
                      }

                      final items = controller.filteredCalculations;
                      final isRealEstate =
                          AuthController.userRole.value == 'real_estate';

                      if (items.isEmpty) {
                        return RefreshIndicator(
                          onRefresh: controller.fetchCalculations,
                          color: AppColors.primary,
                          backgroundColor: AppColors.white,
                          child: const SingleChildScrollView(
                            physics: BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            child: SizedBox(
                              height: 400,
                              child: Center(
                                child: Text(
                                  'No history found.',
                                  style: TextStyle(
                                    color: AppColors.hintGrey,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }

                      return RefreshIndicator(
                        onRefresh: controller.fetchCalculations,
                        color: AppColors.primary,
                        backgroundColor: AppColors.white,
                        child: ListView.separated(
                          controller: controller.scrollController,
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          itemCount: items.length + 1,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 16),
                          itemBuilder: (context, index) {
                            if (index == items.length) {
                              return Obx(() => controller.isLoadingMore.value
                                  ? const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 16),
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : const SizedBox.shrink());
                            }

                            final item = items[index];
                            final date =
                                controller.formatDate(item.createdAt);
                            final tag =
                                controller.tagLabel(item.financeType);

                            if (isRealEstate) {
                              return InboxItem(
                                userName: 'Ankon Akash',
                                email: 'abcd1234@gmail.com',
                                date: date,
                                tag: tag,
                                scenarioText: 'Calculated by 2 scenario',
                                onViewDetails: () =>
                                    controller.onViewDetails(index),
                                onDelete: () =>
                                    controller.onDeleteCalculation(index),
                              );
                            }

                            return CustomCalculationItem(
                              date: date,
                              tag: tag,
                              loanAmount:
                                  controller.formatAmount(item.govtLoanAmount),
                              cashAvailable: controller
                                  .formatAmount(item.govtCashOrDownPayment),
                              downPayment: item.isPurchase
                                  ? controller
                                      .formatAmount(item.govtCashOrDownPayment)
                                  : null,
                              onViewDetails: () =>
                                  controller.onViewDetails(index),
                              onDelete: () =>
                                  controller.onDeleteCalculation(index),
                            );
                          },
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
