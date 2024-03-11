import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'rounded_container.dart';

class ShadowStyle{
  static final verticalJobShadow = BoxShadow(
    color: Colors.grey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0,2)
  );
}

class Job {
  final String title;
  final String location;
  final List<String> tags;
  final double lowersalary;
  final double uppersalary;
  final String imageUrl;

  Job({
    required this.title,
    required this.location,
    required this.tags,
    required this.lowersalary,
    required this.uppersalary,
    required this.imageUrl,
  });
}

class JobCardVertical extends StatelessWidget {
  final Job job;

  const JobCardVertical({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/jobDetail');
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          boxShadow: [
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    job.imageUrl,
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
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        job.location,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/savedJobs');
                    },
                    child: Icon(Icons.bookmark))
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Row(
                  children: job.tags
                      .map((tag) => _buildTag(tag))
                      .toList(), // Map each tag to a widget
                ),
                SizedBox(width: 30),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'LKR ${job.lowersalary.toInt()}-${job.uppersalary.toInt()}/Mo',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      margin: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),

    );
  }
}

class JobListView extends StatelessWidget {
  final List<Job> jobs = [
    Job(
      title: 'Junior Developer',
      location: 'Code-space-Colombo-Srilanka',
      tags: ['Remote', 'Full Time'],
      lowersalary: 8000,
      uppersalary: 150000,
      imageUrl: 'https://firebasestorage.googleapis.com/v0/b/physics-book-15c4d.appspot.com/o/download%20(1).png?alt=media&token=d32986bb-9ed8-4f0d-8e0a-21592cea9d5d',
    ),
    // Add more jobs here
    Job(
      title: 'Senior Developer',
      location: 'Tech Hub - New York, USA',
      tags: ['On-site', 'Part Time'],
      lowersalary: 12000,
      uppersalary: 200000,
      imageUrl: 'https://firebasestorage.googleapis.com/v0/b/physics-book-15c4d.appspot.com/o/download%20(1).png?alt=media&token=d32986bb-9ed8-4f0d-8e0a-21592cea9d5d',
    ),
    Job(
      title: 'UI/UX Designer',
      location: 'Design Studio - Paris, France',
      tags: ['Remote', 'Contract'],
      lowersalary: 10000,
      uppersalary: 150000,
      imageUrl: 'https://firebasestorage.googleapis.com/v0/b/physics-book-15c4d.appspot.com/o/download%20(1).png?alt=media&token=d32986bb-9ed8-4f0d-8e0a-21592cea9d5d',
    ),
    // Add more jobs as needed
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: jobs.length,
      itemBuilder: (BuildContext context, int index) {
        return JobCardVertical(job: jobs[index]);
      },
    );
  }
}
