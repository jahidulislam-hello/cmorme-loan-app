import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';
import 'package:reverse_mortage_loan_app/core/exceptions/app_exceptions.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/data/models/my_proposal_response_model.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/data/models/request_proposal_request_model.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/data/models/update_proposal_request_model.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/domain/usecases/create_proposal_usecase.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/domain/usecases/get_my_proposal_usecase.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/domain/usecases/update_proposal_usecase.dart';

class RequestProposalController extends GetxController {
  final GetMyProposalUseCase _getMyProposalUseCase;
  final CreateProposalUseCase _createProposalUseCase;
  final UpdateProposalUseCase _updateProposalUseCase;
  final _logger = Logger();

  RequestProposalController({
    required GetMyProposalUseCase getMyProposalUseCase,
    required CreateProposalUseCase createProposalUseCase,
    required UpdateProposalUseCase updateProposalUseCase,
  })  : _getMyProposalUseCase = getMyProposalUseCase,
        _createProposalUseCase = createProposalUseCase,
        _updateProposalUseCase = updateProposalUseCase;

  final isLoading = false.obs;

  // Stored after POST or GET response — used as the PATCH id
  String proposalId = '';

  // Step 1 - Basic Information
  final fullNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();

  // Step 2 - Address
  final addressController = TextEditingController();

  // Step 3 - City & State
  final cityController = TextEditingController();
  final stateCodeController = TextEditingController();

  // Step 4 - Phone
  final phoneController = TextEditingController();
  String phoneCompleteNumber = '';
  final phoneError = RxnString();

  // Step 5 - Interested (finance_type)
  final selectedInterest = 0.obs;
  final interestOptions = [
    'Reverse Mortgage - Reverse Refinance',
    'Reverse Mortgage - Reverse for purchase',
  ];

  // Step 6 - Loan Amount
  final homeValueController = TextEditingController();
  final mortgageAmountController = TextEditingController();

  // Step 7 - Date of Birth
  final dobController = TextEditingController();

  // Step 8 - Contact Preference
  final inquiryController = TextEditingController();
  final selectedContactTime = 'Morning'.obs;
  final selectedContactMethod = Rxn<String>(); // 'Email' or 'Phone'

  // Step 9 - Appointment
  final selectedDate = Rxn<DateTime>();
  final timeController = TextEditingController();

  // ── Lifecycle ────────────────────────────────────────────────────────────

  @override
  void onInit() {
    super.onInit();
    _fetchMyProposal();
  }

  /// Fetches existing incomplete proposal and pre-fills all fields.
  /// Silently ignores 404 (no incomplete proposal → fresh start).
  Future<void> _fetchMyProposal() async {
    isLoading.value = true;
    try {
      final response = await _getMyProposalUseCase();
      if (response != null) {
        _prefillFields(response.data);
        _logger.i('Pre-filled proposal: ${response.data.id}');
      }
    } on ServerException catch (e) {
      // 404 means no incomplete proposal — start fresh, no error shown
      _logger.d('No incomplete proposal found: ${e.message}');
    } on NoInternetException catch (e) {
      _logger.w('No internet on prefill: $e');
    } catch (e) {
      _logger.e('Error fetching my proposal: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _prefillFields(MyProposalDataModel data) {
    proposalId = data.id;

    // Step 1
    fullNameController.text = data.firstName;
    lastNameController.text = data.lastName;
    emailController.text = data.email;

    // Step 2
    addressController.text = data.address ?? '';

    // Step 3
    cityController.text = data.city ?? '';
    stateCodeController.text = data.stateCode ?? '';

    // Step 4
    phoneController.text = data.phone ?? '';
    phoneCompleteNumber = data.phone ?? '';

    // Step 5 — finance_type
    if (data.financeType != null) {
      selectedInterest.value =
          data.financeType == 'reverse_refinance' ? 0 : 1;
    }

    // Step 6
    if (data.homeValue != null) {
      homeValueController.text = data.homeValue!.toStringAsFixed(
          data.homeValue! % 1 == 0 ? 0 : 2);
    }
    if (data.mortgageAmount != null) {
      mortgageAmountController.text = data.mortgageAmount!.toStringAsFixed(
          data.mortgageAmount! % 1 == 0 ? 0 : 2);
    }

    // Step 7 — Spouse DOB: ISO → "dd/MM/yyyy"
    if (data.spouseDateOfBirth != null) {
      dobController.text =
          DateFormat('dd/MM/yyyy').format(data.spouseDateOfBirth!.toLocal());
    }

    // Step 8
    if (data.contactTime != null) {
      // "morning" → "Morning"
      final ct = data.contactTime!;
      selectedContactTime.value =
          ct[0].toUpperCase() + ct.substring(1).toLowerCase();
    }
    if (data.responseType != null) {
      // "email" → "Email", "phone" → "Phone"
      final rt = data.responseType!;
      selectedContactMethod.value =
          rt[0].toUpperCase() + rt.substring(1).toLowerCase();
    }

    // Step 9
    if (data.setTime != null) {
      final dt = data.setTime!.toLocal();
      selectedDate.value = DateTime(dt.year, dt.month, dt.day);
      timeController.text = DateFormat('h:mm a').format(dt);
    }
  }

  // ── Step 1: POST create (skipped if proposalId already set from GET) ─────

  Future<void> goToAddress() async {
    final firstName = fullNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final email = emailController.text.trim();

    if (firstName.isEmpty || lastName.isEmpty || email.isEmpty) {
      Get.snackbar('Validation', 'Please fill in all fields.');
      return;
    }

    // If we already have a proposal from the GET, skip POST and just navigate
    if (proposalId.isNotEmpty) {
      Get.toNamed(RouteNames.proposalAddress);
      return;
    }

    isLoading.value = true;
    try {
      final response = await _createProposalUseCase(
        RequestProposalRequestModel(
          firstName: firstName,
          lastName: lastName,
          email: email,
        ),
      );
      proposalId = response.data.id;
      _logger.i('Proposal created: $proposalId');
      Get.toNamed(RouteNames.proposalAddress);
    } on NoInternetException catch (e) {
      _logger.w('No internet: $e');
      Get.snackbar('No Internet', e.message);
    } on TimeoutException catch (e) {
      _logger.w('Timeout: $e');
      Get.snackbar('Timeout', 'Server took too long. Please try again.');
    } on ServerException catch (e) {
      _logger.e('Server error: $e');
      Get.snackbar('Error', e.message);
    } catch (e) {
      _logger.e('Unknown error: $e');
      Get.snackbar('Error', 'Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  // ── Navigation helpers ───────────────────────────────────────────────────

  void goToCityState() => Get.toNamed(RouteNames.proposalCityState);
  void goToPhonePage() => Get.toNamed(RouteNames.phonePage);
  void goToInterested() {
    final digits = phoneController.text.trim();
    if (digits.isEmpty) {
      phoneError.value = 'Please enter your phone number.';
      return;
    }
    if (digits.length != 10) {
      phoneError.value = 'Enter a valid phone number.';
      return;
    }
    phoneError.value = null;
    Get.toNamed(RouteNames.proposalInterested);
  }
  void goToLoanAmount() => Get.toNamed(RouteNames.proposalLoanAmount);
  void goToDob() => Get.toNamed(RouteNames.proposalDob);
  void goToInquiry() => Get.toNamed(RouteNames.proposalInquiry);
  void goToAppointment() => Get.toNamed(RouteNames.proposalAppointment);

  // ── Step 8: Submit from inquiry page (Email selected) ───────────────────

  Future<void> submitFromInquiry() async {
    await _submitProposal(setTime: null);
  }

  // ── Step 9: Submit from appointment page (Phone selected) ────────────────

  Future<void> submitFromAppointment() async {
    await _submitProposal(setTime: _buildSetTime());
  }

  // ── Internal PATCH call ──────────────────────────────────────────────────

  Future<void> _submitProposal({required String? setTime}) async {
    isLoading.value = true;
    try {
      final request = UpdateProposalRequestModel(
        address: addressController.text.trim(),
        city: cityController.text.trim(),
        stateCode: stateCodeController.text.trim(),
        phone: phoneCompleteNumber.isNotEmpty
            ? phoneCompleteNumber
            : phoneController.text.trim(),
        financeType: selectedInterest.value == 0
            ? 'reverse_refinance'
            : 'reverse_purchase',
        homeValue: double.tryParse(homeValueController.text.trim()) ?? 0,
        mortgageAmount:
            double.tryParse(mortgageAmountController.text.trim()) ?? 0,
        spouseDateOfBirth: _formatDob(dobController.text.trim()),
        contactTime: selectedContactTime.value.toLowerCase(),
        responseType:
            (selectedContactMethod.value ?? 'email').toLowerCase(),
        setTime: setTime,
        isCompleted: true,
      );
      await _updateProposalUseCase(proposalId, request);
      _logger.i('Proposal updated successfully');
      Get.offAllNamed(RouteNames.inquirySuccess);
    } on NoInternetException catch (e) {
      _logger.w('No internet: $e');
      Get.snackbar('No Internet', e.message);
    } on TimeoutException catch (e) {
      _logger.w('Timeout: $e');
      Get.snackbar('Timeout', 'Server took too long. Please try again.');
    } on ServerException catch (e) {
      _logger.e('Server error: $e');
      Get.snackbar('Error', e.message);
    } catch (e) {
      _logger.e('Unknown error: $e');
      Get.snackbar('Error', 'Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  // ── Helpers ──────────────────────────────────────────────────────────────

  /// Converts "dd/MM/yyyy" → "yyyy-MM-dd" for the API.
  String _formatDob(String dob) {
    try {
      final parsed = DateFormat('dd/MM/yyyy').parse(dob);
      return DateFormat('yyyy-MM-dd').format(parsed);
    } catch (_) {
      return dob;
    }
  }

  /// Combines selectedDate + timeController text → ISO 8601 UTC string.
  String _buildSetTime() {
    final date = selectedDate.value ?? DateTime.now();
    final timeText = timeController.text.trim();

    if (timeText.isEmpty) {
      return DateTime(date.year, date.month, date.day).toUtc().toIso8601String();
    }

    try {
      // Parse "3:30 PM" format
      final colonIdx = timeText.indexOf(':');
      final hour12 = int.parse(timeText.substring(0, colonIdx));
      final rest = timeText.substring(colonIdx + 1); // "30 PM"
      final parts = rest.split(' ');
      final minute = int.parse(parts[0]);
      final period = parts.length > 1 ? parts[1] : 'AM';

      int hour24 = hour12;
      if (period == 'PM' && hour12 != 12) hour24 += 12;
      if (period == 'AM' && hour12 == 12) hour24 = 0;

      return DateTime(date.year, date.month, date.day, hour24, minute)
          .toUtc()
          .toIso8601String();
    } catch (_) {
      return DateTime(date.year, date.month, date.day).toUtc().toIso8601String();
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    addressController.dispose();
    phoneController.dispose();
    cityController.dispose();
    stateCodeController.dispose();
    homeValueController.dispose();
    mortgageAmountController.dispose();
    dobController.dispose();
    inquiryController.dispose();
    timeController.dispose();
    super.onClose();
  }
}
