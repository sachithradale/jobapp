import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/jobs_provider.dart';
import '../../common/JobView/job_card_vertical.dart';
import '../../common/JobView/curved_edges.dart';
import '../../common/header.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: customizedAppBar(title: 'SimplyHired').header(context),
      drawer: CustomizedAppplicantDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            clipPath(
              child: Container(
                color: Colors.blueAccent,
                padding: const EdgeInsets.all(0),
                child: SizedBox(
                  height: 200,
                  child: Stack(
                    children: [
                      Positioned(
                        top: -150,
                        right: -250,
                        child: CircularContainer(),
                      ),
                      Positioned(
                        top: 100,
                        right: -300,
                        child: CircularContainer(),
                      ),
                      Container(
                        width: screenWidth,
                        child: Column(
                            children : [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal:17.0,vertical: 8.0),
                                child: Container(
                                width: MediaQuery.of(context).size.width, // Set width to screen width
                                child: Text(
                                  'Find Your Dream Job',
                                  style: TextStyle(
                                    fontSize: 30.0, // Custom font size
                                    fontWeight: FontWeight.bold, // Bold font weight
                                    color: Colors.white, // White text color
                                  ),
                                  softWrap: true, // Enable automatic wrapping
                                  overflow: TextOverflow.visible, // Show overflowed text
                                ),
                                                            ),
                              ),
                              SearchContainer(screenWidth: screenWidth , text:'Search..'),
                            ]
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.all(1.0),
                child : Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal:25.0,vertical: 8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width, // Set width to screen width
                          child: Text(
                            'All Jobs',
                            style: TextStyle(
                              fontSize: 20.0, // Custom font size
                              fontWeight: FontWeight.bold, // Bold font weight
                              color: Colors.grey, // White text color
                            ),
                            softWrap: true, // Enable automatic wrapping
                            overflow: TextOverflow.visible, // Show overflowed text
                          ),
                        ),
                      ),
                      Container(
                        // width:MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: JobListView()
                    ),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}



class SearchContainer extends StatefulWidget {
  const SearchContainer({
    Key? key,
    required this.screenWidth,
    required this.text,
  }) : super(key: key);

  final double screenWidth;
  final String text;

  @override
  _SearchContainerState createState() => _SearchContainerState();
}

class _SearchContainerState extends State<SearchContainer> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<JobNotifier>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[200], // Background color for the search bar
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextFormField(
          controller: searchController,
          onChanged: (value) async {
            setState(() {
              controller.onSearch = true;
            });

            final jobList = await controller.jobList; // Wait for the Future to complete
            final filteredJobs = jobList
                .where((element) => element.title.toLowerCase().contains(value.toLowerCase()))
                .toList();

            setState(() {
              controller.filteredJobDetails = filteredJobs;
            });
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      searchController.clear();
                      controller.filteredJobDetails = [];
                      controller.onSearch = false;
                    });
                  },
                  child: Icon(Icons.remove),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/filterJob');
                  },
                  child: Icon(Icons.filter_list),
                ),
              ],
            ),
            prefixIcon: Icon(Icons.search),
            hintText: 'Search by job',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ), // Remove border to avoid duplicate borders
          ),
        ),
      ),
    );
  }
}




class clipPath extends StatelessWidget {
  const clipPath({
    super.key,
    this.child
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomCurvedEdges(),
      child: child
    );
  }
}

class CircularContainer extends StatelessWidget {
  const CircularContainer({Key? key, this.width = 400, this.height = 400, this.radius = 400, this.padding = 0, this.child, this.backgroundColor = Colors.white12}) : super(key: key);

  final double? width;
  final double? height;
  final double radius;
  final double padding;
  final Widget? child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(400),
        color: Colors.white12,
      ),
      child:child,
    );
  }
}
