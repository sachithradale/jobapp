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
      appBar: customizedAppBar(title: '').header(context),
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
                            children:[
                              JAppBar(
                                showBackArrow: false,
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Hey Good Day',
                                      style: Theme.of(context).textTheme.labelMedium!.apply(color: Colors.grey),
                                    ),
                                    Text(
                                      'Sachithra Madhushan',
                                      style: Theme.of(context).textTheme.headlineSmall!.apply(color: Colors.white),
                                    )
                                  ],
                                ),
                                actions: [
                                  IconButton(
                                    onPressed: (){},
                                    icon: const Icon(Iconsax.message, color: Colors.white),
                                  )
                                ],
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
                padding: EdgeInsets.all(10.0),
                child : Container(
                    // width:MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: JobListView()
                )
            )
          ],
        ),
      ),
    );
  }
}

class VerticalImageStack extends StatelessWidget {
  const VerticalImageStack({
    super.key,
    required this.image,
    required this.title,
    this.textColor = Colors.white,
    this.backgroundColor,
    this.onTap,
  });

  final String image,title;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left:16 , right: 16),
        child: Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 9,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_,index){
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Column(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color:textColor,
                        borderRadius: BorderRadius.circular(100)
                      ),
                      child: Center(
                           child: Image(image:AssetImage(image),fit:BoxFit.cover,color:Colors.black)
                        )
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                        width: 55,
                        child: Text(title,
                                    style: Theme.of(context).textTheme.labelMedium!.apply(color:textColor),
                                    maxLines:1,
                                    overflow: TextOverflow.ellipsis
                                    ),
                                ),

                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class SectionHeading extends StatelessWidget {

  const SectionHeading({
    super.key,
    this.onPressed ,
    this.textColor,
    this.buttonTitle='View all',
    required this.title,
    this.showActionButton = false
  });

  final Color? textColor;
  final bool showActionButton;
  final String title, buttonTitle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style : Theme.of(context).textTheme.headlineSmall!.apply(color:textColor), maxLines: 1, overflow: TextOverflow.ellipsis,),
        if(showActionButton) TextButton(onPressed: (){}, child: Text(buttonTitle))
      ],
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
              onPressed: () => {controller.setSelectedIndex(1)},
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
