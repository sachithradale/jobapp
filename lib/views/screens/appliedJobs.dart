import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jobapp/views/common/fonts.dart';
import 'package:jobapp/views/common/header.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AppliedJobs extends StatefulWidget {
  const AppliedJobs({super.key});

  @override
  State<AppliedJobs> createState() => _AppliedJobsState();
}

class _AppliedJobsState extends State<AppliedJobs> {
  var token;
  var userId;

  @override
  void initState() {
    super.initState();
    getAppliedJobs();
  }

  List<Map<String,dynamic>> appliedJobs = [];

  Future<void> getAppliedJobs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    userId = prefs.getString('id');
    Uri url = Uri.parse('https://madbackend-production.up.railway.app/api/application/$userId');
    var response = await http.get(
      url,
      headers: {
        'x-access-token': token,
      },
    );
    if (response.statusCode == 200) {
      var jsonResponse = response.body;
      var dataToSend = json.decode(jsonResponse);
      List<dynamic> dataList= dataToSend["data"];
      for(var data in dataList){
        appliedJobs.add({
          'jobId': data['job']['_id'],
          'jobTitle': data['job']['title'],
          'description': data['job']['description'],
          'location': data['job']['location'],
          'status': data['status'],
          'salary': data['job']['salaryRange']['low']-data['job']['salaryRange']['high'],
          'currency': data['job']['salaryRange']['currency']
        });
      }
    } else {
      print('Failed to load jobs');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:customizedAppBar(title: 'Applied Jobs').header(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            appliedJobs.length == 0 ? AppFonts.subtitle('No Applied Jobs',Colors.black) : ListView.builder(
              itemCount: appliedJobs.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: AppFonts.subtitle(appliedJobs[index]['jobTitle'], Colors.black),
                  subtitle: Column(
                    children: [
                        AppFonts.normal(appliedJobs[index]['location'], Colors.black),
                        AppFonts.normal(appliedJobs[index]['description'], Colors.black),
                        AppFonts.normal(_formatSalary(appliedJobs[index]['salary'], appliedJobs[index]['currency']), Colors.black),
                    ],
                  ),
                  trailing: Text(appliedJobs[index]['status']),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String _formatSalary(salaryRange, currency) {
    return '$currency ${salaryRange.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
  }
}
