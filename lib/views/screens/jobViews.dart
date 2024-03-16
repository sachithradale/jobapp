import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:jobapp/views/common/fonts.dart';
import 'package:jobapp/views/common/header.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'applicantDetails.dart';

class JobViews extends StatefulWidget {
  const JobViews({super.key});

  @override
  State<JobViews> createState() => _JobViewsState();
}

class _JobViewsState extends State<JobViews> {
  var token;
  var userId;
  List<Map<String, dynamic>> appliedJobs = [];

  Future<void> getAppliedJobs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    userId = prefs.getString('id');
    Uri url = Uri.parse('https://madbackend-production.up.railway.app/api/job/all');
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
      //take the data where dataList['employee']['_id'] == userId and add to appliedJobs
      appliedJobs.clear();
      for(var data in dataList){
        if(data['employer']['_id'].toString() == userId.toString()){
          print("Hello");
          appliedJobs.add({
            'jobId': data['_id'],
            'jobTitle': data['title'],
            'description': data['description'],
            'location': data['location'],
          });
        }
      }
      print(appliedJobs);
    } else {
      print('Failed to load jobs');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customizedAppBar(title: 'Job Details').header(context),
      drawer: CustomizedEmployeeDrawer(),
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
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                  child: ListTile(
                    title: AppFonts.subtitle(appliedJobs[index]['jobTitle'],Colors.blue),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppFonts.normal(appliedJobs[index]['description'],null),
                        AppFonts.normal(appliedJobs[index]['location'],null),
                      ],
                    ),
                    trailing: IconButton(
                      icon:Icon(
                          Icons.remove_red_eye,
                          color: Colors.blue,
                      ),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => jobApplicants(jobId: appliedJobs[index]['jobId']),
                        ));
                      },
                    )
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
