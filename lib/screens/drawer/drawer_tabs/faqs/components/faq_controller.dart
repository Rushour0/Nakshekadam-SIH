import 'package:flutter/cupertino.dart';
import 'package:nakshekadam/models/faq_model.dart';

class FAQsController extends ChangeNotifier {
  final faqs = FAQModel().faqs;
  List<FAQTopics> _selectedfaqs = FAQModel().faqs;
  List<FAQTopics> get selectedfaqs => _selectedfaqs;
  TextEditingController _editingController = TextEditingController();
  TextEditingController get editingController => _editingController;

  FAQsController() {
    __listentoChanges();
  }

  __listentoChanges() {
    _editingController.addListener(() {
      _selectedfaqs = [];
      faqs.forEach((faqTopics) {
        List<FAQs> temp_faq = [];
        FAQTopics temp_faq_topics = FAQTopics(faqs: [], topic: "");
        faqTopics.faqs.forEach((faq) {
          if (faq.question
              .toLowerCase()
              .contains(_editingController.text.toLowerCase())) {
            temp_faq.add(faq);
          }
        });
        temp_faq_topics.topic = faqTopics.topic;
        temp_faq_topics.faqs = temp_faq;
        if (temp_faq_topics.faqs.isNotEmpty) {
          selectedfaqs.add(temp_faq_topics);
        }
      });
      notifyListeners();
    });
  }
}
