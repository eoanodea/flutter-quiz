/// Represents a single question
class Question {
  String questionText;
  bool questionAnswer;
  bool answerCorrect;

  Question({String q, bool a}) {
    questionText = q;
    questionAnswer = a;
    answerCorrect = false;
  }

  setAnswer({bool a}) {
    bool result = false;
    if (a == questionAnswer) result = true;
    answerCorrect = result;
  }
}
