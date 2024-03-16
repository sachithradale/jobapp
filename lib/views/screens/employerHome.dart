import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jobapp/views/common/fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controllers/jobs_provider.dart';
import '../../controllers/saved_jobs_provider.dart';
import '../../models/request/job_response.dart';
import '../common/JobView/job_card_vertical.dart';
import '../common/buttons.dart';
import '../common/header.dart';

class EmployerHome extends StatefulWidget {
  const EmployerHome({Key? key}) : super(key: key);

  @override
  _EmployerHomeState createState() => _EmployerHomeState();
}

class _EmployerHomeState extends State<EmployerHome> {
  TextEditingController searchController = TextEditingController();


  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customizedAppBar(title: '').header(context),
        drawer: CustomizedEmployeeDrawer(),
        body: Center(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: TextFormField(
                      controller: searchController,
                      onChanged: (value){
                      },
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                            onTap: (){
                              setState(() {
                                searchController.clear();
                              });
                            },
                            child: Icon(Icons.remove)
                        ),
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    )
                ),
                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  child: Button.formButtton('+ Create a New Job', (){
                    Navigator.pushNamed(context, '/createJob');
                  }, double.infinity,),
                ),
                SizedBox(height: 20,),
                AppFonts.customizeText('Recently Created', Colors.black, 14, FontWeight.bold),
                SizedBox(height: 20,),
                // Use FutureBuilder to handle asynchronous result
                JobListView()
              ],
            ),
          ),
        )
    );
  }
}


class JobListView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<JobNotifier>(
      builder: (context, jobsNotifier, child) {
        jobsNotifier.getJobsEmp();
        return SizedBox(
          height: 400,
          child: FutureBuilder<List<JobsResponse>>(
            future: jobsNotifier.jobListForEmp,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator.adaptive());
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text("No jobs available");
              } else {
                final jobs = snapshot.data!;
                return ListView.builder(
                  itemCount: jobs.length,
                  itemBuilder: (context, index) {
                    var job = jobs[index];
                    return JobCardVerticalEmp(job: job);
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


class ShadowStyle{
  static final verticalJobShadow = BoxShadow(
      color: Colors.grey.withOpacity(0.1),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0,2)
  );
}

class JobCardVerticalEmp extends StatelessWidget {
  final JobsResponse job;
  const JobCardVerticalEmp({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Consumer<JobProvider>(
        builder: (context, jobProvider, _) {
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
                        _formatSalary(job.salaryRange.low.toInt(),
                            job.salaryRange.high.toInt(),
                            job.salaryRange.currency),
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

                ],
              ),
            ),

          );

        });
  }
  String _formatSalary(int low, int high, String currency) {
    return '$currency ${low.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} - ${high.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}/mo';
  }
}

