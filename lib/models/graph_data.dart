class GraphData {

  double result;
  DateTime date;
  int examinationDetailId;

  GraphData({
    required this.result,
    required this.date,
    required this.examinationDetailId,
  });



  factory GraphData.fromJson(Map<String, dynamic> json) => GraphData(
    result: json["result"],
    date: DateTime.parse(json["date"]),
    examinationDetailId: json["examinationDetailID"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "examinationDetailID": examinationDetailId,
  };
}