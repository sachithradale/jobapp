import 'dart:convert';

import 'package:http/http.dart' as https;

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

          List<dynamic> jobData = jsonResponse["data"];
          var jobList =  jobsResponseFromJson(json.encode(jobData));
        return jobList;
      }else{
        throw Exception('Failed to load jobs');
      }


  }

  static Future<GetJobRes> getJob(String jobId) async{
    Map<String,String> requestHeaders = {
      'Content-Type':'application/json',
    };

    var url = Uri.https(Config.apiUrl,"${Config.allJobs}/$jobId");
    var response = await client.get(url,headers: requestHeaders);

    if(
    response.statusCode == 200
    ){
      var job =   getJobResFromJson(response.body);
      return job;
    }else{
      throw Exception('Failed to load jobs');
    }


  }
}