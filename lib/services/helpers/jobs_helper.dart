import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/request/get_job.dart';
import '../../models/request/job_response.dart';
import '../config.dart';


class JobHelper{
  static var client = https.Client();

  static Future<List<JobsResponse>> getJobs() async{

    Map<String,String> requestHeaders = {
        'Content-Type':'application/json',
      };
      
      var url = Uri.https(Config.apiUrl,Config.allJobs);
      print(url);
      var response = await client.get(url,headers: requestHeaders);

      if(response.statusCode == 200){
        var jsonResponse = json.decode(response.body);
          // print(jsonResponse);
          List<dynamic> jobData = jsonResponse["data"];
          var jobList =  jobsResponseFromJson(json.encode(jobData));
          print(jobList[0]);
        return jobList;
      }else{
        throw Exception('Failed to load jobs');
      }


  }

  static Future<List<JobsResponse>> getJobsForEmp() async {
    print('heeee');
    Map<String,String> requestHeaders = {
      'Content-Type':'application/json',
    };

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var employerId = prefs.getString('id');

    print(employerId);

    // Define the request body
    Map<String, dynamic> requestBody = {
      "employer": employerId
    };

    var url = Uri.https(Config.apiUrl, Config.allJobsForEmp);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: json.encode(requestBody), // Encode the body to JSON
    );



    if(response.statusCode == 200){
      var jsonResponse = json.decode(response.body);
      List<dynamic> jobData = jsonResponse["data"];
      print(jobData);
      var jobListForEmp=  jobsResponseFromJson(json.encode(jobData));
      print(jobListForEmp[0]);
      return jobListForEmp;
    } else {
      throw Exception('Failed to load jobs');
    }
  }



}