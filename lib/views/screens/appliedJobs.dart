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
    Uri url = Uri.parse('https://madbackend-production.up.railway.app/api/application/user/$userId');
    var response = await http.get(
      url,
      headers: {
        'x-access-token': token,
        'Content-Type': 'application/json'
      },
    );
    if (response.statusCode == 200) {
      var jsonResponse = response.body;
      var dataToSend = json.decode(jsonResponse);
      print(dataToSend);
      List<dynamic> dataList= dataToSend["data"];
      appliedJobs.clear();
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
      drawer: CustomizedAppplicantDrawer(),
      body: FutureBuilder(
        future: getAppliedJobs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: appliedJobs.length,
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.blue,
                        width: 2
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: AppFonts.subtitle(appliedJobs[index]['jobTitle'], Colors.black),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppFonts.normal(appliedJobs[index]['location'], Colors.black),
                        AppFonts.normal(appliedJobs[index]['description'], Colors.black),
                        AppFonts.customizeText(_formatSalary(appliedJobs[index]['salary'], appliedJobs[index]['currency']), Colors.black,14,FontWeight.bold),
                      ],
                    ),
                    trailing: AppFonts.subtitle(appliedJobs[index]['status'],
                      appliedJobs[index]['status'] == 'pending' ? Colors.amber :
                      appliedJobs[index]['status'] == 'accepted' ? Colors.green :
                      appliedJobs[index]['status'] == 'rejected' ? Colors.red : Colors.black
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  String _formatSalary(salaryRange, currency) {
    return '$currency ${salaryRange.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
  }
}
