abstract class AiOps{
  AiOps?_()=>null;

  Future<dynamic> getEmbeddings(dynamic text);

  Future<dynamic> getQuiz(String context);

  Future<dynamic> getMcq(String context);
}