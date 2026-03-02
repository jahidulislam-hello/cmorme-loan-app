import 'package:get/get.dart';

class FaqItem {
  final String question;
  final String answer;

  const FaqItem({required this.question, required this.answer});
}

class FaqQuestionsController extends GetxController {
  final expandedIndex = RxnInt();

  final List<FaqItem> faqItems = const [
    FaqItem(
      question: 'How do I qualify for a reverse mortgage?',
      answer:
          'To qualify, you must be at least 62 years of age, your home must be your primary residence, and you must have sufficient equity in your home. You\'ll also need to complete a HUD-approved counseling session.',
    ),
    FaqItem(
      question: 'To qualify, what are income requirements?',
      answer:
          'Unlike traditional mortgages, a Reverse Mortgage does not have strict income requirements. However, you must demonstrate the ability to pay ongoing property taxes, insurance, and maintenance costs.',
    ),
    FaqItem(
      question:
          'Does a Reverse Mortgage require that I make monthly payments?',
      answer:
          'No, a Reverse Mortgage does not require monthly mortgage payments. The loan balance is repaid when you sell the home, permanently move out, or pass away.',
    ),
    FaqItem(
      question: 'Will the bank own my home?',
      answer:
          'No. You retain the title and ownership of your home. The lender only has a lien on the property, just like with a traditional mortgage.',
    ),
    FaqItem(
      question: 'How much tax-free cash will I receive?',
      answer:
          'The amount depends on your age, home value, and current interest rates. Generally, the older you are and the more your home is worth, the more you can receive.',
    ),
    FaqItem(
      question: 'What if I have an existing mortgage?',
      answer:
          'That\'s okay. If you qualify, a reverse mortgage will first pay off your existing mortgage, then give you the remaining proceeds. Many times, we advise our clients to use the Reverse Mortgage to eliminate monthly mortgage payments on their traditional mortgage.',
    ),
    FaqItem(
      question: 'Will my children lose their inheritance?',
      answer:
          'When the last remaining borrower moves out, the home is sold. The loan is repaid (including interest and any fees) and the remaining equity left over goes to your heirs. If your children choose to keep the house, they may do so by paying off the loan.',
    ),
    FaqItem(
      question:
          'What if my home goes down in value. Do I, owe the difference?',
      answer:
          'A Reverse Mortgage is a government-insured, non-recourse loan, meaning that you will never owe more on the loan than what the house is worth at the time the loan is paid back. You and your heirs have no obligation and can simply walk away.',
    ),
    FaqItem(
      question: 'How much is it going to cost me to get a Reverse Mortgage?',
      answer:
          'In general, your costs are the same as a traditional forward mortgage: escrow, title fee, and appraisal fee. With a Reverse Mortgage, you purchase a unique HUD government insurance plan that protects you, your heirs, and your lender in the event your mortgage balance exceeds your value. This is why your funds are guaranteed and why it\'s truly a non-recourse loan.',
    ),
  ];

  void toggleExpanded(int index) {
    if (expandedIndex.value == index) {
      expandedIndex.value = null;
    } else {
      expandedIndex.value = index;
    }
  }
}
