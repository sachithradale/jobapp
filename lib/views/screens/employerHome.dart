import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jobapp/views/common/fonts.dart';

import '../common/buttons.dart';
import '../common/header.dart';

class EmployerHome extends StatefulWidget {
  const EmployerHome({Key? key}) : super(key: key);

  @override
  _EmployerHomeState createState() => _EmployerHomeState();
}

class _EmployerHomeState extends State<EmployerHome> {
  TextEditingController searchController = TextEditingController();

  List<Map<String,dynamic>> jobDetails =[
    //position,jobtype,workplace,location,salary lower,salary upper
    {
      'position': 'Software Developer',
      'jobtype': 'Full Time',
      'workplace': 'On-Site',
      'location': 'CodeSphere-Colombo,Sri Lanka',
      'salaryLower': 5000,
      'salaryUpper': 15000

    },
    {
      'position': 'UI Designer',
      'jobtype': 'Part Time',
      'workplace': 'Hybrid',
      'location': 'CodeSphere-Colombo,Sri Lanka',
      'salaryLower': 2000,
      'salaryUpper': 15000

    },
    {
      'position': 'UI Designer',
      'jobtype': 'Part Time',
      'workplace': 'Hybrid',
      'location': 'CodeSphere-Colombo,Sri Lanka',
      'salaryLower': 2000,
      'salaryUpper': 15000

    },
    {
      'position': 'UI Designer',
      'jobtype': 'Part Time',
      'workplace': 'Hybrid',
      'location': 'CodeSphere-Colombo,Sri Lanka',
      'salaryLower': 2000,
      'salaryUpper': 15000

    },
    {
      'position': 'UI Designer',
      'jobtype': 'Part Time',
      'workplace': 'Hybrid',
      'location': 'CodeSphere-Colombo,Canada',
      'salaryLower': 2000,
      'salaryUpper': 15000

    }
  ];

  List<Map<String,dynamic>> filteredJobDetails =[];
  bool onSearch = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customizedAppBar(title: '').header(context),
      drawer: CustomizedDrawer(),
      body:Padding(
        padding: const EdgeInsets.fromLTRB(40, 0, 40, 5),
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
                        // filteredJobDetails = jobDetails.where((element) => element['position'].toString().toLowerCase().contains(value.toLowerCase())).toList();
                        //search value can be position,jobtype,workplace,location,salary lower,salary upper
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
              Button.formButtton('+ Create a New Job', (){
                Navigator.pushNamed(context, '/createJob');
              }, MediaQuery.of(context).size.width * 0.8),
              SizedBox(height: 20,),
              AppFonts.customizeText('Recently Created', Colors.black, 14, FontWeight.bold),
              onSearch==false?
              Expanded(
                child:ListView.builder(
                  itemCount: jobDetails.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title:AppFonts.customizeText(jobDetails[index]['position'], Colors.black, 14, FontWeight.bold),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppFonts.customizeText(jobDetails[index]['location'], Colors.black, 14, FontWeight.normal),
                            Row(
                              children: [
                                AppFonts.customizeText(jobDetails[index]['jobtype'], Colors.blue, 14, FontWeight.bold),
                                SizedBox(width: 20,),
                                AppFonts.customizeText(jobDetails[index]['workplace'], Colors.blue, 14, FontWeight.bold),
                              ],
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children:[
                                  AppFonts.customizeText('LKR ${jobDetails[index]['salaryLower']} - ${jobDetails[index]['salaryUpper']}/Mo', Colors.green, 14, FontWeight.normal),
                                ]
                            )
                          ],
                        ),
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
                    return Card(
                      child: ListTile(
                        title:AppFonts.customizeText(filteredJobDetails[index]['position'], Colors.black, 14, FontWeight.bold),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppFonts.customizeText(filteredJobDetails[index]['location'], Colors.black, 14, FontWeight.normal),
                            Row(
                              children: [
                                AppFonts.customizeText(filteredJobDetails[index]['jobtype'], Colors.blue, 14, FontWeight.bold),
                                SizedBox(width: 20,),
                                AppFonts.customizeText(filteredJobDetails[index]['workplace'], Colors.blue, 14, FontWeight.bold),
                              ],
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children:[
                                  AppFonts.customizeText('LKR ${filteredJobDetails[index]['salaryLower']} - ${filteredJobDetails[index]['salaryUpper']}/Mo', Colors.green, 14, FontWeight.normal),
                                ]
                            )
                          ],
                        ),
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
}
