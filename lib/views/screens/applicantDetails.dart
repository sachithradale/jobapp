import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jobapp/views/common/buttons.dart';
import '../common/fonts.dart';
import '../common/header.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class jobApplicants extends StatefulWidget {
  jobApplicants({super.key, required this.jobId});
  var jobId;

  @override
  State<jobApplicants> createState() => _jobApplicantsState();
}

class _jobApplicantsState extends State<jobApplicants> {
  List<Map<String, dynamic>> applicants =[];
  var token;
  var userId;

  Future<void> getApplications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    userId = prefs.getString('id');
    var job= widget.jobId;
    Uri url = Uri.parse('https://madbackend-production.up.railway.app/api/job/$job/applications');
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
      List<dynamic> dataList= dataToSend["data"];
      applicants.clear();
      for(var data in dataList){
        applicants.add({
          'applicationId': data['_id'],
          'jobId': data['job'],
          'applicantName': data['applicant']['profile']['name'],
          'email': data['applicant']['email'],
          'applicantId': data['applicant']['_id'],
          'resumePath': data['resume'],
          'message': data['description'],
          'status': data['status'],
        });
      }
    } else {
      print('Failed to load jobs');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customizedAppBar(title: 'Job Applications').header(context),
      body: FutureBuilder(
        future: getApplications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: applicants.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                ),
                child: ListTile(
                  title: AppFonts.customizeText(applicants[index]['applicantName'], Colors.black, 18, FontWeight.bold),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppFonts.normal(applicants[index]['email'], Colors.blue),
                      AppFonts.normal(applicants[index]['message'], Colors.black),
                      (applicants[index]['status'] == 'pending')?
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Button.textButton('Accept', () => null, 14),
                              SizedBox(width: 10,),
                              Button.textButton("Reject", () => null, 14)
                            ],
                          ):AppFonts.normal(applicants[index]['status'], Colors.black
                          )
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.book),
                    onPressed: () {
                       DownloadCV(applicants[index]['resumePath']);
                    },
                  )
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> DownloadCV(fileBytes) async {
    try {
      // Convert the base64 string to bytes
      var bytes = base64.decode(fileBytes);
      Directory appDocumentsDirectory = Directory("/storage/emulated/0/Download");
      String filePath = appDocumentsDirectory.path + '/'+'resume.pdf';
      File file = File(filePath);
      await file.writeAsBytes(bytes);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text('File downloaded successfully'),
        ),
      );
    } catch (e) {
      // Handle any errors that occurred during the download process
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error downloading file'),
        ),
      );
    }
  }
}

