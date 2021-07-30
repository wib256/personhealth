class ExaminationDetail {
  final int id;
  final int examinationID, testID;
  final double result, indexValueMax, indexValueMin;
  final String diagnose, testName;

  ExaminationDetail(this.id, this.examinationID, this.testID, this.result, this.indexValueMax, this.indexValueMin, this.diagnose, this.testName);

  factory ExaminationDetail.fromJson(dynamic json) {
    String diagnoseTemp = json['diagnose'] == null ? "": json['diagnose'];
    String testNameTemp = json['test_name'] == null ? "": json['test_name'];

    return ExaminationDetail(
        json['id'] as int,
        json['examinationId'] as int,
        json['testId'] as int,
        json['result'] as double,
        json['indexValueMax'] as double,
        json['indexValueMin'] as double,
        diagnoseTemp,
        testNameTemp);
  }
}

class ExaminationDetailExpand extends ExaminationDetail {
  final double lastResul;
  ExaminationDetailExpand(int id, int examinationID, int testID, double result, double indexValueMax, double indexValueMin, String diagnose, String testName, this.lastResul) : super(id, examinationID, testID, result, indexValueMax, indexValueMin, diagnose, testName);

}