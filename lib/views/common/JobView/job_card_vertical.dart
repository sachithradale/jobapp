import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobapp/models/request/job_response.dart';
import 'package:provider/provider.dart';

import '../../../controllers/jobs_provider.dart';


class ShadowStyle{
  static final verticalJobShadow = BoxShadow(
    color: Colors.grey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0,2)
  );
}

class JobCardVertical extends StatelessWidget {
  final JobsResponse job;

  const JobCardVertical({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        boxShadow: [
          ShadowStyle.verticalJobShadow,
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    job.employer.image,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        job.location,
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.bookmark),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Salary:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  _formatSalary(job.salaryRange.low.toInt(), job.salaryRange.high.toInt(), job.salaryRange.currency),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Description:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              job.description,
              style: TextStyle(
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/jobDetailedView',
                        arguments: job,
                      );},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    ),
                  child: Text(
                    'View',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

    );
  }
  String _formatSalary(int low, int high, String currency) {
    return '$currency ${low.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} - ${high.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}/mo';
  }
}

class JobListView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<JobNotifier>(
      builder: (context, jobsNotifier, child) {
        jobsNotifier.getJobs();
        return SizedBox(
          height: 500,
          child: FutureBuilder<List<JobsResponse>>(
            future: jobsNotifier.jobList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator.adaptive());
              } else if (snapshot.hasError) {
                return Text("Errorsssss: ${snapshot.error}");
              } else if (snapshot.data!.isEmpty) {
                return const Text("No jobs available");
              } else {
                final jobs = snapshot.data;
                return ListView.builder(
                  itemCount: jobs!.length,
                  itemBuilder: (context, index) {
                    var job = jobs[index];
                    return JobCardVertical(job:job);
                  },
                );
              }
            },
          ),
        );
      },
    );
  }
}


