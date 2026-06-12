import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/shared/app_image/app_images.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_button.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/presentation/view/controller/request_proposal_controller.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/consent_disclaimer.dart';

class AppointmentPage extends GetView<RequestProposalController> {
  const AppointmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon:
              const Icon(Icons.chevron_left, color: AppColors.white, size: 30),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: const Text(
          'Request Full Proposal',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(AppImages.calenderIcon,
                                    width: 22, height: 22),
                                const SizedBox(width: 8),
                                const Text(
                                  'Appointment',
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                            /// Calendar
                            Obx(() => _MonthCalendar(
                                  selectedDate: controller.selectedDate.value,
                                  onDateSelected: (date) {
                                    controller.selectedDate.value = date;
                                  },
                                )),

                            const SizedBox(height: 100),

                            /// Set Time
                            const Text(
                              'Set Time',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: () => _selectTime(context),
                              child: AbsorbPointer(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.containerHighlight,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: TextField(
                                    controller: controller.timeController,
                                    style: const TextStyle(
                                      color: AppColors.white,
                                      fontSize: 14,
                                    ),
                                    decoration: const InputDecoration(
                                      hintText: 'Time',
                                      hintStyle: TextStyle(
                                        color: AppColors.hintGrey,
                                        fontSize: 14,
                                      ),
                                      suffixIcon: Icon(
                                        Icons.access_time,
                                        color: AppColors.hintGrey,
                                        size: 20,
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 14,
                                      ),
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                      const ConsentDisclaimer(),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Obx(() => CustomButton(
                              text: 'Send',
                              onPressed: controller.submitFromAppointment,
                              backgroundColor: AppColors.buttonBlue,
                              textColor: AppColors.white,
                              isLoading: controller.isLoading.value,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.buttonBlue,
              onPrimary: AppColors.white,
              surface: AppColors.containerHighlight,
              onSurface: AppColors.white,
            ),
            dialogBackgroundColor: AppColors.primary,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      final hour = picked.hourOfPeriod == 0 ? 12 : picked.hourOfPeriod;
      final minute = picked.minute.toString().padLeft(2, '0');
      final period = picked.period == DayPeriod.am ? 'AM' : 'PM';
      controller.timeController.text = '$hour:$minute $period';
    }
  }
}

class _MonthCalendar extends StatelessWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const _MonthCalendar({
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final displayMonth = selectedDate ?? now;
    final year = displayMonth.year;
    final month = displayMonth.month;
    final firstDayOfMonth = DateTime(year, month, 1);
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final startWeekday = firstDayOfMonth.weekday % 7; // Sunday = 0

    final monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];

    return Column(
      children: [
        /// Month/Year header with arrows
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(AppImages.monthCalenderIcon),
            Text(
              '${monthNames[month - 1]} $year',
              style: const TextStyle(
                color: AppColors.yellow500,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () {
                onDateSelected(DateTime(year, month - 1, 1));
              },
              child: const Icon(Icons.chevron_left,
                  color: AppColors.white, size: 22),
            ),
            GestureDetector(
              onTap: () {
                onDateSelected(DateTime(year, month + 1, 1));
              },
              child: const Icon(Icons.chevron_right,
                  color: AppColors.white, size: 22),
            ),
          ],
        ),
        const SizedBox(height: 16),

        /// Day headers
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _DayHeader('Sun'),
            _DayHeader('Mon'),
            _DayHeader('Tue'),
            _DayHeader('Wed'),
            _DayHeader('Thu'),
            _DayHeader('Fri'),
            _DayHeader('Sat'),
          ],
        ),
        const SizedBox(height: 8),

        /// Day grid
        ...List.generate(_weekCount(startWeekday, daysInMonth), (weekIndex) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(7, (dayIndex) {
                final dayNumber =
                    weekIndex * 7 + dayIndex - startWeekday + 1;
                if (dayNumber < 1 || dayNumber > daysInMonth) {
                  return const SizedBox(width: 36, height: 36);
                }

                final date = DateTime(year, month, dayNumber);
                final isSelected = selectedDate != null &&
                    selectedDate!.year == year &&
                    selectedDate!.month == month &&
                    selectedDate!.day == dayNumber;
                final isToday = now.year == year &&
                    now.month == month &&
                    now.day == dayNumber;

                return GestureDetector(
                  onTap: () => onDateSelected(date),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected
                          ? AppColors.blue500
                          : isToday
                              ? AppColors.buttonBlue
                              : Colors.transparent,
                    ),
                    child: Center(
                      child: Text(
                        '$dayNumber',
                        style: TextStyle(
                          color: isSelected || isToday
                              ? AppColors.primary
                              : AppColors.white,
                          fontSize: 16,
                          fontWeight: isSelected || isToday
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        }),
      ],
    );
  }

  int _weekCount(int startWeekday, int daysInMonth) {
    return ((startWeekday + daysInMonth + 6) / 7).floor();
  }
}

class _DayHeader extends StatelessWidget {
  final String label;

  const _DayHeader(this.label);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: AppColors.hintGrey,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
