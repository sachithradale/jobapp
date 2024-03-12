

import 'package:flutter/cupertino.dart';
import 'package:jobapp/models/request/job_response.dart';

import '../services/helpers/jobs_helper.dart';

class JobNotifier extends ChangeNotifier{
  late Future<List<JobsResponse>> jobList;

  Future<List<JobsResponse>> getJobs(){
    jobList = JobHelper.getJobs();
    print(jobList);
    return jobList;
  }
}