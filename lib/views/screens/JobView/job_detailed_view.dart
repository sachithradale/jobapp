
import 'package:flutter/material.dart';
import 'package:jobapp/views/common/header.dart';
import 'package:provider/provider.dart';
import '../../../controllers/job_view.dart';
import '../../../models/request/job_response.dart';
import 'dart:math';
import '../../../main.dart';
import '../../common/buttons.dart';
import '../applicationSubmission.dart';

class JobDetailView extends StatefulWidget {
  @override
  State<JobDetailView> createState() => _JobDetailViewState();
}

class _JobDetailViewState extends State<JobDetailView> {
  @override
  void initState() {
    super.initState();
    getCompanyName();
  }

  List<String> companyNames = [
    'Creative Software',
    '99X Technology',
    'MillenniumIT',
    'Virtusa',
    'IFS',
    'WSO2',
    'Zone24x7',
    'Sysco LABS',
  ];

  String CompanyName = '';

  void getCompanyName() {
    //generate a random integer between 0 and 7
    Random random = Random();
    int randomNumber = random.nextInt(8);
    CompanyName = companyNames[randomNumber];
  }

  @override
  Widget build(BuildContext context) {
    final JobsResponse job = ModalRoute.of(context)!.settings.arguments as JobsResponse;
    print(job);
    final controller = Provider.of<NavigationController>(context);
    return Scaffold(
      appBar: customizedAppBar(title: 'Job Details').header(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                // Add company logo widget here
                Image.network(
                  job.employer.image,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 200, // Set your desired width here
                      child: Expanded(
                        child: Text(
                          job.title,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2, // Limit the maximum number of lines to 2
                          overflow: TextOverflow.ellipsis, // Show ellipsis (...) if the text overflows
                        ),
                      ),
                    ),
                    Text(CompanyName),
                    Text(job.location),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Text(
              'Job Description',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              job.description,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Requirements',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: job.requirements.length,
              itemBuilder: (context, index) {
                return Text(
                  job.requirements[index],
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[800],
                  ),
                );
              },
            ),
            SizedBox(height: 20.0),
            Text(
              'Responsibilities',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: job.responsibilities.length,
              itemBuilder: (context, index) {
                return Text(
                  job.responsibilities[index],
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[800],
                  ),
                );
              },
            ),
            SizedBox(height: 20.0),
            Button.formButtton('Apply Now', () {
              Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) =>applicationSubmission(companyName: CompanyName, location: job.location, job: job.id,)),
              );
            }, MediaQuery.of(context).size.width * 0.8),
          ],
        ),
      ),
    );
  }
}