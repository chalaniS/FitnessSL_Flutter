//completely complete
//
import 'package:firebase_database/firebase_database.dart';
import 'package:fitness/screens/EventManagement/Admin/admin_listview.dart';
import 'package:flutter/material.dart';

class AddEventForm extends StatefulWidget {
  const AddEventForm({Key? key}) : super(key: key);

  @override
  _AddEventFormState createState() => _AddEventFormState();
}

class _AddEventFormState extends State<AddEventForm> {
  final TextEditingController eventNameController = TextEditingController();
  String selectedCategory = 'Mental Health';
  String selectedAgeGap = '18-25';
  final TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child('events');

  List<String> categories = ['Mental Health', 'Physical Health'];
  List<String> ageGaps = ['18-25', '25-35', '35-50', '50-75'];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          title: const Text("Insert Event"),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: const Color.fromARGB(255, 7, 16, 68),
          elevation: 0,
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 14, 7, 73),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text("Event Name"),
              const SizedBox(height: 10),
              _buildTextField(eventNameController),
              const SizedBox(height: 10),
              const Text("Category"),
              const SizedBox(height: 10),
              _buildDropdownButton(categories, selectedCategory, (newValue) {
                selectedCategory = newValue;
              }),
              const SizedBox(height: 10),
              const Text("Age"),
              const SizedBox(height: 10),
              _buildDropdownButton(ageGaps, selectedAgeGap, (newValue) {
                selectedAgeGap = newValue;
              }),
              const SizedBox(height: 10),
              const Text("Description"),
              const SizedBox(height: 10),
              _buildTextField(descriptionController),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Date: ${selectedDate.toLocal()}'.split(' ')[0],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () => _selectDate(context),
                          child: const Text('Select Date'),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Time: ${selectedTime.format(context)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () => _selectTime(context),
                          child: const Text('Select Time'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 194, 190, 185),
                      fixedSize: const Size(200, 40),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    // onPressed: _submitEvent,
                    onPressed: () {
                      _submitEvent(); // Call your submit function
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              EventListView(), // Navigate to EventListView
                        ),
                      );
                    },

                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                      fixedSize: const Size(200, 40),
                    ),

                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color.fromARGB(255, 105, 104, 104),
      ),
      child: TextField(
        controller: controller,
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
        ),
      ),
    );
  }

  Widget _buildDropdownButton(List<String> items, String selectedItem,
      void Function(String) onChanged) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: const Color.fromARGB(255, 105, 104, 104),
        primaryColor: Colors.grey,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: const Color.fromARGB(255, 105, 104, 104),
        ),
        child: DropdownButtonFormField<String>(
          value: selectedItem,
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (String? newValue) {
            onChanged(
                newValue!); // Call the callback to update the selected value
          },
        ),
      ),
    );
  }

  void _submitEvent() {
    String eventName = eventNameController.text;
    String category = selectedCategory;
    String ageGap = selectedAgeGap;
    String description = descriptionController.text;
    String date = selectedDate.toString();
    String time = selectedTime.toString();

    Map<String, dynamic> eventData = {
      "eventName": eventName,
      "category": category,
      "ageGap": ageGap,
      "description": description,
      "date": date,
      "time": time,
    };

    databaseReference.push().set(eventData);

    eventNameController.clear();
    descriptionController.clear();
  }
}

void main() {
  runApp(const MaterialApp(
    home: AddEventForm(),
  ));
}
