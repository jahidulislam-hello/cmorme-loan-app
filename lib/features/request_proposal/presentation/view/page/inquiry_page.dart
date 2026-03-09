import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_button.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/presentation/view/controller/request_proposal_controller.dart';

class InquiryPage extends GetView<RequestProposalController> {
  const InquiryPage({super.key});

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Best time to contact ──────────────────────────
                      const Text(
                        'What is the best time to contact you?',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Obx(() => _TimeDropdown(
                            selected: controller.selectedContactTime.value,
                            onSelect: (val) =>
                                controller.selectedContactTime.value = val,
                          )),

                      const SizedBox(height: 36),

                      // ── How to receive proposal ───────────────────────
                      const Text(
                        'How would you like to receive your proposal?',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Obx(() => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: ['Email', 'Phone'].map((method) {
                              final isSelected =
                                  controller.selectedContactMethod.value ==
                                      method;
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: GestureDetector(
                                  onTap: () => controller
                                      .selectedContactMethod.value = method,
                                  child: Row(
                                    children: [
                                      _RadioDot(isSelected: isSelected),
                                      const SizedBox(width: 12),
                                      Text(
                                        method,
                                        style: const TextStyle(
                                          color: AppColors.blue500,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          )),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Obx(() {
                  final isEmail =
                      controller.selectedContactMethod.value == 'Email';
                  return CustomButton(
                    text: isEmail ? 'Send' : 'Next',
                    onPressed: isEmail
                        ? controller.submitFromInquiry
                        : controller.goToAppointment,
                    backgroundColor: AppColors.buttonBlue,
                    textColor: AppColors.white,
                    isLoading: controller.isLoading.value,
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Custom dropdown with overlay popup + checkbox-style items
// ─────────────────────────────────────────────────────────────────────────────

class _TimeDropdown extends StatefulWidget {
  final String selected;
  final ValueChanged<String> onSelect;

  const _TimeDropdown({
    required this.selected,
    required this.onSelect,
  });

  @override
  State<_TimeDropdown> createState() => _TimeDropdownState();
}

class _TimeDropdownState extends State<_TimeDropdown> {
  static const _options = ['Morning', 'Afternoon', 'Evening'];

  final _key = GlobalKey();
  OverlayEntry? _entry;

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    _entry?.remove();
    _entry = null;
  }

  void _toggleOverlay() {
    if (_entry != null) {
      _removeOverlay();
      setState(() {});
      return;
    }

    final box = _key.currentContext!.findRenderObject() as RenderBox;
    final offset = box.localToGlobal(Offset.zero);
    final size = box.size;

    _entry = OverlayEntry(
      builder: (_) => Stack(
        children: [
          // Transparent tap-away dismiss
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                _removeOverlay();
                if (mounted) setState(() {});
              },
              child: Container(color: Colors.transparent),
            ),
          ),
          // The popup card
          Positioned(
            top: offset.dy + size.height + 4,
            right: MediaQuery.of(context).size.width -
                offset.dx -
                size.width,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 180,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.18),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _options.map((option) {
                    final isSelected = widget.selected == option;
                    return GestureDetector(
                      onTap: () {
                        widget.onSelect(option);
                        _removeOverlay();
                        if (mounted) setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: option != _options.last
                                ? BorderSide(
                                    color: Colors.grey.shade200,
                                    width: 0.8,
                                  )
                                : BorderSide.none,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              option,
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 14,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                            ),
                            if (isSelected)
                              Container(
                                width: 24,
                                height: 24,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.green500,
                                ),
                                child: const Icon(
                                  Icons.check,
                                  color: AppColors.white,
                                  size: 14,
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_entry!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isOpen = _entry != null;
    return GestureDetector(
      key: _key,
      onTap: _toggleOverlay,
      child: Container(
        width: double.infinity,
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.containerHighlight,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.selected,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 14,
              ),
            ),
            AnimatedRotation(
              turns: isOpen ? 0.5 : 0,
              duration: const Duration(milliseconds: 200),
              child: const Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.hintGrey,
                size: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Custom radio dot widget
// ─────────────────────────────────────────────────────────────────────────────

class _RadioDot extends StatelessWidget {
  final bool isSelected;

  const _RadioDot({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
        border: Border.all(
          color: isSelected ? AppColors.blue500 : AppColors.white,
          width: 2,
        ),
      ),
      child: isSelected
          ? Center(
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.blue500,
                ),
              ),
            )
          : null,
    );
  }
}
