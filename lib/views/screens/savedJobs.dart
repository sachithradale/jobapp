import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/saved_jobs_provider.dart';
import '../../models/request/job_response.dart';
import '../common/JobView/job_card_vertical.dart';
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

  List<JobsResponse> filteredJobDetails =[];
  bool onSearch = false;

  @override
  Widget build(BuildContext context) {
    final jobProvider = Provider.of<JobProvider>(context);
    return Scaffold(
      appBar: customizedAppBar(title: '').header(context),
      drawer: CustomizedAppplicantDrawer(),
        body:Center(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: AppFonts.customizeText('Saved Jobs', Colors.black, 24, FontWeight.bold),
                ),
                Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: TextFormField(
                      controller: searchController,
                      onChanged: (value) {
                        setState(() {
                          onSearch = true;
                          filteredJobDetails = jobProvider.savedJobs
                              .where((element) => element.title.toLowerCase().contains(value.toLowerCase()))
                              .toList();
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
                SizedBox(height: 10,),
                onSearch==false?
                Expanded(
                  child:ListView.builder(
                        itemCount: jobProvider.savedJobs.length,
                        itemBuilder: (context, index) {
                          var job = jobProvider.savedJobs[index];
                          return JobCardVertical(job: job);
                        }
                  ),
                ):onSearch==true && !filteredJobDetails.isEmpty?
                Expanded(
                  child:ListView.builder(
                    itemCount: filteredJobDetails.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var job = filteredJobDetails[index];
                      return JobCardVertical(job: job);
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
