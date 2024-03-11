import 'package:flutter/material.dart';
import 'package:jobapp/views/common/colors.dart';
import 'package:provider/provider.dart';
import '../../../controllers/job_view.dart';
import '../../common/buttons.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  List<String> tags = [
    'Remote',
    'Hybrid',
    'Full-time',
    'Intern',
    'On-site',
    'Senior',
    'Full Stack',
  ];

  RangeValues _salaryRange = RangeValues(30000, 70000);
  List<String> selectedTags = [];

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<NavigationController>(context); // Access controller here
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => {controller.setSelectedIndex(0)},
        ),
        title: Text('Filter'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              items: [
                DropdownMenuItem(child: Text('Design & Development'), value: 'IND_1'),
                DropdownMenuItem(child: Text('Test Automation'), value: 'IND_2'),
                DropdownMenuItem(child: Text('Devops'), value: 'IND_3')
                // Add more dropdown items for Industry
              ],
              decoration: InputDecoration(
                labelText: 'Industry',
              ),
              onChanged: (value) {},
            ),
            SizedBox(height: 10.0),
            DropdownButtonFormField<String>(
              items: [
                DropdownMenuItem(child: Text('UI/UX Design'), value: 'Cat_1'),
                DropdownMenuItem(child: Text('Software Engineering'), value: 'Cat_2'),
                DropdownMenuItem(child: Text('Web Developer'), value: '3')
                // Add more dropdown items
              ],
              decoration: InputDecoration(
                labelText: 'Category',
              ),
              onChanged: (value) {},
            ),
            SizedBox(height: 10.0),
            DropdownButtonFormField<String>(
              items: [
                DropdownMenuItem(child: Text('Sri Lanka'), value: 'SL'),
                DropdownMenuItem(child: Text('Finland'), value: 'Fin'),
                DropdownMenuItem(child: Text('Denmark'), value: 'Dan')
                // Add more dropdown items
              ],
              decoration: InputDecoration(
                labelText: 'Location',
              ),
              onChanged: (value) {},
            ),
            SizedBox(height: 10.0),
            Text(
              'Salary Scale',
              style: TextStyle(fontSize: 12.0),
            ),
            SizedBox(height: 10.0),
            RangeSlider(
              activeColor: AppColor.primaryColor,
              values: _salaryRange,
              min: 0,
              max: 100000, // Adjust max salary according to your needs
              onChanged: (values) {
                setState(() {
                  _salaryRange = values;
                });
              },
              divisions: 20,
              labels: RangeLabels(
                'LKR${_salaryRange.start.round()}',
                'LKR${_salaryRange.end.round()}',
              ),
            ),
            SizedBox(height: 20.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: tags.map((tag) {
                bool isSelected = selectedTags.contains(tag);
                return FilterChip(
                  label: Text(tag),
                  selected: isSelected,
                  selectedColor: Colors.grey[800],
                  onSelected: (bool selected) {
                    toggleTagSelection(tag);
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 90.0),
            Button.formButtton('Apply Filters', () {}, 200),
          ],
        ),
      ),
    );
  }

  void toggleTagSelection(String tag) {
    setState(() {
      if (selectedTags.contains(tag)) {
        selectedTags.remove(tag);
      } else {
        selectedTags.add(tag);
      }
    });
  }
}
