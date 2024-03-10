import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../common/fonts.dart';
import '../common/header.dart';

class Skills extends StatefulWidget {
  const Skills({Key? key}) : super(key: key);

  @override
  _SkillsState createState() => _SkillsState();
}

class _SkillsState extends State<Skills> {
  List<String> skills=[
    'Python',
    'Java',
    'C++',
    'Dart',
    'Flutter',
    'React',
    'Node.js',
    'Express.js',
    'MongoDB',
    'SQL',
    'HTML',
    'CSS',
    'JavaScript',
    'TypeScript',
    'Angular',
    'Vue.js',
    'React Native',
    'Swift',
    'Kotlin',
    'PHP',
    'Laravel',
    'Ruby',
    'Rails',
    'C#',
    'ASP.NET',
    'Go',
    'Rust',
    'Scala',
    'Haskell',
    'R',
    'Perl',
    'Shell',
    'PowerShell',
    'Bash',
    'AWS',
    'Azure',
    'GCP',
    'Docker',
    'Kubernetes',
    'Jenkins',
    'Git',
    'GitHub',
    'GitLab',
    'Bitbucket',
    'Jira',
    'Confluence',
    'Slack',
    'Trello',
    'Asana',
    'Notion',
    'Figma',
    'Adobe XD',
    'Sketch',
    'InVision',
    'Zeplin',
    'Abstract',
    'Marvel',
    'Principle',
    'Framer',
    'Origami Studio',
    'Axure RP',
    'Balsamiq',
    'Adobe Illustrator',
    'Adobe Photoshop',
    'Adobe After Effects',
    'Adobe Premiere Pro',
    'Adobe InDesign',
    'Adobe Lightroom',
    'Adobe XD',
    'Sketch',
    'Figma',
    'InVision',
    'Zeplin',
    'Abstract',
    'Marvel',
    'Principle',
    'Framer',
    'Origami Studio',
    'Axure RP',
    'Balsamiq',
    'Adobe Illustrator',
    'Adobe Photoshop',
    'Adobe After Effects',
    'Adobe Premiere Pro',
    'Adobe InDesign',
    'Adobe Lightroom',
    'Adobe XD',
    'Sketch',
    'Figma',
    'InVision',
    'Zeplin',
    'Abstract',
    'Marvel',
    'Principle',
    'Framer',
    'Origami Studio',
    'Axure RP',
    'Balsamiq',
    'Adobe Illustrator',
    'Adobe Photoshop',
    'Adobe After Effects',
  ];
  List<String> filteredSkills = [];
  List<String> selectedSkills = [];
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customizedAppBar(title: '').header(context),
        body: SingleChildScrollView(
          child:Column(
            children:[
              Center(child: AppFonts.heading('Add Skills ', null)),
              SizedBox(height: 20,),
              Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFormField(
                    controller: searchController,
                    onChanged: (value){
                      setState(() {
                        filteredSkills = skills.where((element) => element.toLowerCase().contains(value.toLowerCase())).toList();
                      });
                    },
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search),
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
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.4,
                child: ListView.builder(
                  itemCount: filteredSkills.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Row(
                        children: [
                          Text(filteredSkills[index]),
                          Spacer(),
                          IconButton(
                              onPressed: (){
                                setState(() {
                                  selectedSkills.add(filteredSkills[index]);
                                });
                              },
                              icon: Icon(Icons.add)
                          )
                        ],
                      ),
                      // Add more UI or actions as needed
                    );
                  },
                ),
              ),
              SizedBox(height: 20,),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: AppFonts.customizeText('Selected Skills', Colors.black, 16, FontWeight.bold),
              ),
              SizedBox(height: 20,),
              SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: ListView.builder(
                    itemCount: selectedSkills.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Row(
                          children: [
                            Text(selectedSkills[index]),
                            Spacer(),
                            IconButton(
                                onPressed: (){
                                  setState(() {
                                    selectedSkills.removeAt(index);
                                  });
                                },
                                icon: Icon(Icons.remove)
                            )
                          ],
                        ),
                        // Add more UI or actions as needed
                      );
                    },
                  ),
                ),
              ),
            ]
          )
        )
    );
  }
}