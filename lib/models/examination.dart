class Examination {
  final int id;
  final String date;
  final String diagnose;
  final String advise;
  final int testRequestId;
  final String clinicName;
  final double rate;
  final String rateStatus;

  Examination(this.id, this.date, this.diagnose, this.testRequestId, this.clinicName, this.rate, this.advise, this.rateStatus);

  factory Examination.fromJson(dynamic json) {
    String dateTemp = json['date'] == null ? "": json['date'];
    String diagnoseTemp = json['diagnose'] == null ? "": json['diagnose'];
    String clinicNameTemp = json['clinicName'] == null ? "": json['clinicName'];
    double rateTemp = json['rate'] == null ? 0: json['rate'];
    String adviseT = json['advise'] == null ? "": json['advise'];
    String rateStatusT = json['rateStatus'] == null ? "": json['rateStatus'];
    return Examination(
        json['id'] as int,
        dateTemp,
        diagnoseTemp,
        json['testRequestId'] as int,
        clinicNameTemp,
        rateTemp,
        adviseT,
        rateStatusT
    );
  }
}