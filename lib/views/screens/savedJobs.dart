import 'package:flutter/material.dart';
import '../common/buttons.dart';
import '../common/fonts.dart';
import '../common/header.dart';

class SavedJobs extends StatefulWidget {
  const SavedJobs({super.key});

  @override
  State<SavedJobs> createState() => _SavedJobsState();
}

class _SavedJobsState extends State<SavedJobs> {
  TextEditingController searchController = TextEditingController();

  List<Map<String,dynamic>> jobDetails =[
    //position,jobtype,workplace,location,salary lower,salary upper
    {
      'position': 'Software Developer',
      'jobtype': 'Full Time',
      'workplace': 'On-Site',
      'location': 'CodeSphere-Colombo,Sri Lanka',
      'salaryLower': 5000,
      'salaryUpper': 15000,
      'imageUrl':'https://firebasestorage.googleapis.com/v0/b/physics-book-15c4d.appspot.com/o/download%20(1).png?alt=media&token=d32986bb-9ed8-4f0d-8e0a-21592cea9d5d',
    },
    {
      'position': 'UI Designer',
      'jobtype': 'Part Time',
      'workplace': 'Hybrid',
      'location': 'CodeSphere-Colombo,Sri Lanka',
      'salaryLower': 2000,
      'salaryUpper': 15000,
      'imageUrl':'https://firebasestorage.googleapis.com/v0/b/physics-book-15c4d.appspot.com/o/download%20(1).png?alt=media&token=d32986bb-9ed8-4f0d-8e0a-21592cea9d5d',
    },
    {
      'position': 'UI Designer',
      'jobtype': 'Part Time',
      'workplace': 'Hybrid',
      'location': 'CodeSphere-Colombo,Sri Lanka',
      'salaryLower': 2000,
      'salaryUpper': 15000,
      'imageUrl':'https://firebasestorage.googleapis.com/v0/b/physics-book-15c4d.appspot.com/o/download%20(1).png?alt=media&token=d32986bb-9ed8-4f0d-8e0a-21592cea9d5d',
    },
    {
      'position': 'UI Designer',
      'jobtype': 'Part Time',
      'workplace': 'Hybrid',
      'location': 'CodeSphere-Colombo,Sri Lanka',
      'salaryLower': 2000,
      'salaryUpper': 15000,
      'imageUrl':'https://firebasestorage.googleapis.com/v0/b/physics-book-15c4d.appspot.com/o/download%20(1).png?alt=media&token=d32986bb-9ed8-4f0d-8e0a-21592cea9d5d',
    },
    {
      'position': 'UI Designer',
      'jobtype': 'Part Time',
      'workplace': 'Hybrid',
      'location': 'CodeSphere-Colombo,Canada',
      'salaryLower': 2000,
      'salaryUpper': 15000,
      'imageUrl':'https://firebasestorage.googleapis.com/v0/b/physics-book-15c4d.appspot.com/o/download%20(1).png?alt=media&token=d32986bb-9ed8-4f0d-8e0a-21592cea9d5d',
    }
  ];

  List<Map<String,dynamic>> filteredJobDetails =[];
  bool onSearch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customizedAppBar(title: '').header(context),
      drawer: CustomizedAppplicantDrawer(),
        body:Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      controller: searchController,
                      onChanged: (value){
                        setState(() {
                          onSearch = true;
                          filteredJobDetails = jobDetails.where((element) =>
                              element['position'].toString().toLowerCase().contains(value.toLowerCase()) ||
                              element['jobtype'].toString().toLowerCase().contains(value.toLowerCase()) ||
                              element['workplace'].toString().toLowerCase().contains(value.toLowerCase()) ||
                              element['location'].toString().toLowerCase().contains(value.toLowerCase()) ||
                              element['salaryLower'].toString().toLowerCase()==(value.toLowerCase()) ||
                              element['salaryUpper'].toString().toLowerCase()==(value.toLowerCase())).toList();
                        });
                      },
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                            onTap: (){
                              setState(() {
                                searchController.clear();
                                filteredJobDetails =[];
                                onSearch = false;
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
                SizedBox(height: 20,),
                onSearch==false?
                Expanded(
                  child:ListView.builder(
                    itemCount: jobDetails.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
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
                                    jobDetails[index]['imageUrl'],
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
                                        jobDetails[index]['position'],
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        jobDetails[index]['location'],
                                        style: TextStyle(color: Colors.grey),
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
                                 _buildTag(jobDetails[index]['jobtype']),
                                SizedBox(width: 8),
                                _buildTag(jobDetails[index]['workplace']),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'LKR ${jobDetails[index]['salaryLower'].toInt()}-${jobDetails[index]['salaryUpper'].toInt()}/Mo',
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
                      );
                    },
                  ),
                ):onSearch==true && !filteredJobDetails.isEmpty?
                Expanded(
                  child:ListView.builder(
                    itemCount: filteredJobDetails.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
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
                                    filteredJobDetails[index]['imageUrl'],
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
                                        filteredJobDetails[index]['position'],
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        filteredJobDetails[index]['location'],
                                        style: TextStyle(color: Colors.grey),
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
                                _buildTag(filteredJobDetails[index]['jobtype']),
                                SizedBox(width: 8),
                                _buildTag(filteredJobDetails[index]['workplace']),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'LKR ${filteredJobDetails[index]['salaryLower'].toInt()}-${filteredJobDetails[index]['salaryUpper'].toInt()}/Mo',
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
                      );
                    },
                  ),
                ):
                Expanded(
                  child:Center(child: AppFonts.customizeText('No Jobs Found', Colors.black, 14, FontWeight.normal)),
                )

              ],
            ),
          ),
        )
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
