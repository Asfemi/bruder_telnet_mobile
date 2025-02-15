import 'package:bruder_telnet_mobile/src/features/faq/domain/faq_model.dart';

class AppConstants {
  static List<FaqModel> mockFaqs = List.generate(
    5,
    (index) => FaqModel(
      id: index.toString(),
      question: 'Demnächst verfügbar',
      answer:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    ),
  );
}
