import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';


import '../../../controllers/job_view.dart';
import '../../../main.dart';
import '../../common/JobView/job_card_vertical.dart';
import '../../common/JobView/appbar.dart';
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




class SearchContainer extends StatelessWidget {
  const SearchContainer({
    Key? key,
    required this.screenWidth,
    required this.text,
    this.showBackground = true,
    this.showBorder = true
  }) : super(key: key);

  final double screenWidth;
  final String text;
  final bool showBackground, showBorder;

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<NavigationController>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: screenWidth,
        decoration: BoxDecoration(
          color: showBackground ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(16.0),
          border: showBorder ? Border.all(color: Colors.grey) : null,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: text,
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {
                Navigator.pushNamed(context, '/filterJob');
              },
            ),
          ],
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
