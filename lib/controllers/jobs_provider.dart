

import 'package:flutter/cupertino.dart';
import 'package:jobapp/models/request/job_response.dart';

import '../services/helpers/jobs_helper.dart';

class JobNotifier extends ChangeNotifier{
  late Future<List<JobsResponse>> jobList ;
  late Future<List<JobsResponse>> jobListForEmp ;

  List<JobsResponse> filteredJobDetails =[];
  bool onSearch = false;

  List<JobsResponse> get filteredJobDetail => filteredJobDetails;

  Future<List<JobsResponse>> getJobs(){
    jobList = JobHelper.getJobs();
    return jobList;
  }

  Future<List<JobsResponse>> getJobsEmp(){

    jobListForEmp  = JobHelper.getJobsForEmp();
    return jobListForEmp ;
  }

}