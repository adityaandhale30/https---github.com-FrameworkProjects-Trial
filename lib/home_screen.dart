import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sqlite_trial/model/time_table_model.dart';
import 'package:sqlite_trial/services/data_fetch.dart';
import 'package:sqlite_trial/services/database_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: ttList.length,
          itemBuilder: (context, idx) {
            return Container(
              color: Colors.blueGrey,
              width: double.maxFinite,
              margin: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(ttList[idx].date),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(ttList[idx].subjectName),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(ttList[idx].time),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            );
          }),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
              onPressed: () {
                log("add Data Pressed");
                DatabaseHelper.instance.insert(TimetableModel(
                    date: "1",
                    subjectName: "Marathi",
                    time: DateTime.timestamp().toString()));
              },
              child: const Icon(Icons.add)),
          FloatingActionButton(onPressed: () async {
            log("get Data Pressed");

            ttList = await getTTData();
            setState(() {});
          }),
        ],
      ),
    );
  }
}
