class TimetableModel {
  String subjectName;
  String date;
  String time;
  int id = 0;

  TimetableModel({required this.date, required this.subjectName,required this.time});

  Map<String, dynamic> timeMap() {
    return {
      'subjectName':subjectName,
      'date': date,
      'time': time,
    };
  }

}
