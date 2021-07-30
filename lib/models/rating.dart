class Rating {
  final String clinicName, comment;
  final int examinationId;
  final double rate;
  final String status, time, timeExpire;

  Rating(this.clinicName, this.comment, this.examinationId, this.rate, this.status, this.time, this.timeExpire);

  Map<String, dynamic> toJson() => <String, dynamic>{
    "comment": comment,
    "examinationId": examinationId,
    "rate": rate,
    "status": status,
    "time": time,
    "timeExpire": timeExpire
  };
}