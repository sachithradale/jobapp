import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jobapp/views/common/dropDown.dart';
import 'package:jobapp/views/common/header.dart';

import '../common/buttons.dart';
import '../common/fonts.dart';
import '../common/textField.dart';

class CreateJob extends StatefulWidget {
  const CreateJob({super.key});

  @override
  State<CreateJob> createState() => _CreateJobState();
}

class _CreateJobState extends State<CreateJob> {
  List<String> industry = ['IT','Finance','Healthcare','Education','Engineering'];
  List<String> category = ['Software Developer','UI Designer','UX Designer','QA Engineer','Business Analyst'];
  List<String> jobType = ['Full Time','Part Time','Internship'];
  List<String> workplace = ['On-Site','Remote','Hybrid'];

  final PageController _pageController = PageController();
  TextEditingController positionController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController jobDescriptionController = TextEditingController();
  TextEditingController requirementsController = TextEditingController();
  TextEditingController responsibilitiesController = TextEditingController();
  TextEditingController aboutCompanyController = TextEditingController();

  String? _selectedIndustry;
  String? _selectedCategory;
  String? _selectedJobType;
  String? _selectedWorkplace;

  double _minSalary = 5000;
  double _maxSalary = 1000000;

  int _currentPage = 0;
  final int _numPages = 4; // Set the total number of pages
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customizedAppBar(title: '').header(context),
        body: Center(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _numPages,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 10,
                      height: 10,
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index
                            ? Colors.blue
                            : Colors.grey, // Change the colors as needed
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: <Widget>[
                    // Add the pages as needed
                    Container(
                      child: SingleChildScrollView(
                        child: Column(
                          children:[
                              AppFonts.title('Description', null),
                              SizedBox(height: 10,),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: dropDown.customizeDropDown('Industry', industry, _selectedIndustry!=null?_selectedIndustry!:industry[0], (String? value){
                                  setState(() {
                                    _selectedIndustry = value;
                                  });
                                }),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: dropDown.customizeDropDown('Category', category, _selectedCategory!=null?_selectedCategory!:category[0], (String? value){
                                  setState(() {
                                    _selectedCategory = value;
                                  });
                                }),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: TextFields.textFieldWithLabel('Web Developer','Position',false,positionController,false)
                              ),
                              SizedBox(height: 10,),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: dropDown.customizeDropDown('Job Type', jobType, _selectedJobType!=null?_selectedJobType!:jobType[0], (String? value){
                                  setState(() {
                                    _selectedJobType = value;
                                  });
                                }),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: dropDown.customizeDropDown('Workplace', workplace, _selectedWorkplace!=null?_selectedWorkplace!:workplace[0], (String? value){
                                  setState(() {
                                    _selectedWorkplace = value;
                                  });
                                }),
                              ),
                              SizedBox(height: 20,),
                              Button.formButtton('Next',
                                      () =>{
                                        _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.ease)
                                      }, MediaQuery.of(context).size.width * 0.8),
                          ]
                        ),
                      ),
                    ),
                    Container(
                      child:SingleChildScrollView(
                        child: Column(
                          children: [
                            AppFonts.title('Location', Colors.black),
                            SizedBox(height: 20,),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: TextFormField(
                                  controller: searchController,
                                  onChanged: (value){
                                    setState(() {
                        
                                    });
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.search),
                                    hintText: 'Search Location',
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
                            Container(
                              height: MediaQuery.of(context).size.height * 0.5,
                            ),
                            SizedBox(height: 20,),
                            Button.formButtton('Next',
                                    () =>{
                                      _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.ease)
                                    }, MediaQuery.of(context).size.width * 0.8),
                          ],
                        ),
                      )
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Column(
                        children: [
                          AppFonts.title("Salary", Colors.black),
                          SizedBox(height: 20,),
                          RangeSlider(
                            values: RangeValues(_minSalary, _maxSalary),
                            min: 0,
                            max: 1000000, // Set your maximum salary range
                            onChanged: (RangeValues values) {
                              setState(() {
                                _minSalary = values.start;
                                _maxSalary = values.end;
                              });
                            },
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppFonts.customizeText('Min Salary: LKR ${_minSalary.toInt()}', Colors.black, 18, FontWeight.bold),
                                SizedBox(height: 10),
                                AppFonts.customizeText('Max Salary: LKR ${_maxSalary.toInt()}', Colors.black, 18, FontWeight.bold),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Button.formButtton('Next',
                                    () =>{
                                  _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.ease)
                                }, MediaQuery.of(context).size.width * 0.8),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            AppFonts.title('Details', Colors.black),
                            SizedBox(height: 20),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppFonts.customizeText('Job Description', Colors.black, 18, FontWeight.bold),
                                  TextFormField(
                                    maxLines: 3,
                                    controller: jobDescriptionController,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      hintText: 'Developed software for Google',
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  AppFonts.customizeText('Requirements', Colors.black, 18, FontWeight.bold),
                                  TextFormField(
                                    maxLines: 3,
                                    controller: requirementsController,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      hintText: 'Developed software for Google',
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  AppFonts.customizeText('Responsibilities', Colors.black, 18, FontWeight.bold),
                                  TextFormField(
                                    maxLines: 3,
                                    controller: responsibilitiesController,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      hintText: 'Developed software for Google',
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  AppFonts.customizeText('About Company', Colors.black, 18, FontWeight.bold),
                                  TextFormField(
                                    maxLines: 3,
                                    controller: aboutCompanyController,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      hintText: 'Developed software for Google',
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Button.formButtton('Post Job',
                                          () => {
                              
                                          }
                                  , MediaQuery.of(context).size.width * 0.8),
                                  SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}
