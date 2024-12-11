class TimetableModel {
  String subjectName;
  String date;
  String time;
  


  TimetableModel({required this.date, required this.subjectName,required this.time});

  Map<String, dynamic> timeMap() {
    return {
      'subjectName':subjectName,
      'date': date,
      'time': time,
    };
  }

}
