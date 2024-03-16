import 'package:flutter/material.dart';
import 'package:jobapp/models/request/job_response.dart';
import 'package:provider/provider.dart';

class JobProvider extends ChangeNotifier {
  List<JobsResponse> _savedJobs = [];

  List<JobsResponse> get savedJobs => _savedJobs;

  void addToSavedJobs(JobsResponse job) {
    _savedJobs.add(job);
    notifyListeners();
  }
}