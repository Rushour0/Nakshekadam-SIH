class FAQModel {
  var faqs = [
    FAQTopics(topic: "Food Related Questions", faqs: [
      FAQs(question: "Why to eat food?", answer: "I don't know."),
      FAQs(
          question: "Why do we have to eat food?",
          answer: "I still don't know.")
    ]),
    FAQTopics(topic: "Payment Related Questions", faqs: [
      FAQs(question: "Why to pay?", answer: "I don't know."),
      FAQs(question: "Why do we have to pay?", answer: "I still don't know.")
    ]),
    FAQTopics(topic: "Delivery Related Questions", faqs: [
      FAQs(question: "When is delivery?", answer: "I don't know."),
    ]),
  ];
}

class FAQTopics {
  String topic;
  List<FAQs> faqs;
  FAQTopics({
    required this.topic,
    required this.faqs,
  });
}

class FAQs {
  String question;
  String answer;
  FAQs({
    required this.question,
    required this.answer,
  });
}
