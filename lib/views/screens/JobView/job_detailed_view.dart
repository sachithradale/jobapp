
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/job_view.dart';
import '../../../models/request/job_response.dart';



class JobDetailView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final JobsResponse job = ModalRoute.of(context)!.settings.arguments as JobsResponse;
    print(job);
    final controller = Provider.of<NavigationController>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => {
            Navigator.pushNamed(
                context,
                '/homeScreen',
          )},
        ),
        title: Text('Job Details'),
      ),
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
                    Text("ABC company"),
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
            ElevatedButton(
              onPressed: () {
                // Apply now logic
              },
              child: Text('Apply Now'),
            ),
          ],
        ),
      ),
    );
  }
}