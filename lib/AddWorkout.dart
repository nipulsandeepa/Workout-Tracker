import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam2/ViewWorkout.dart';
import 'package:exam2/newHome.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'WorkoutLogin.dart';

class AddWorkout extends StatefulWidget {
  const AddWorkout({super.key});

  @override
  State<AddWorkout> createState() => _AddWorkoutState();
}


void logout(BuildContext context) async {
  await FirebaseAuth.instance.signOut(); // Logs out the user

  // Navigate back to login screen after logout
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const WorkoutLogin()),
        (route) => false, // Removes all previous routes from stack
  );
}
class _AddWorkoutState extends State<AddWorkout> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  DateTime selectedDate = DateTime.now();

  List<String> workoutTypes = ['Cardio', 'Strength', 'Flexibility', 'HIIT', 'Yoga'];
  List<String> whenToWorkoutOptions = ['Morning', 'Afternoon', 'Evening', 'Night'];

  TextEditingController workoutNameController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  String? selectedWorkoutType;
  String? selectedWhenToWorkout;

  @override
  void dispose() {
    workoutNameController.dispose();
    durationController.dispose();
    super.dispose();
  }

  Future<DateTime?> pickDate() async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
  }

  void saveWorkout() async {
    if (workoutNameController.text.isEmpty ||
        selectedWorkoutType == null ||
        selectedWhenToWorkout == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all fields')));
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('workouts').add({
        'workoutName': workoutNameController.text,
        'workoutType': selectedWorkoutType,
        'duration': durationController.text,
        'whenToWorkout': selectedWhenToWorkout,
        'startDate': Timestamp.fromDate(startDate),
        'endDate': Timestamp.fromDate(endDate),
      });

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Workout Saved')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error saving workout')));
    }
  }

  List<DateTime> getWeekDays() {
    return List.generate(7, (index) =>
        selectedDate.subtract(Duration(days: selectedDate.weekday - 1 - index)));
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> weekDays = getWeekDays();
    bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.blueAccent,
        backgroundColor: Colors.purple.shade800,
        title: const Text(
          'Add Your Activities',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.white
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image at the top
            Image.asset(
              'lib/images/girl.png',
              height: 450,
              width: 450,
            ),

            // Responsive weekdays list
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                height: isSmallScreen ? 70 : 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: weekDays.length,
                  itemBuilder: (context, index) {
                    DateTime day = weekDays[index];
                    bool isSelected = selectedDate.day == day.day;
                    return GestureDetector(
                      onTap: () => setState(() => selectedDate = day),
                      child: Container(
                        width: isSmallScreen ? 60 : 80,
                        height: isSmallScreen ? 60 : 80,
                        margin: EdgeInsets.symmetric(
                            horizontal: isSmallScreen ? 5 : 10),
                        padding: EdgeInsets.all(isSmallScreen ? 5 : 10),
                        decoration: BoxDecoration(
                          gradient: isSelected
                              ? const LinearGradient(
                            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                              : null,
                          color: isSelected ? null : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              isSmallScreen
                                  ? DateFormat.E().format(day).substring(0, 3)
                                  : DateFormat.E().format(day),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: isSmallScreen ? 12 : 14,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                            Text(
                              day.day.toString(),
                              style: TextStyle(
                                fontSize: isSmallScreen ? 14 : 16,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Card with form inputs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: workoutNameController,
                          decoration: const InputDecoration(
                            labelText: 'Workout Name',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.fitness_center, color: Colors.blue),
                          ),
                        ),
                        const SizedBox(height: 20),
                        DropdownButtonFormField<String>(
                          value: selectedWorkoutType,
                          decoration: const InputDecoration(
                            labelText: 'Workout Type',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.list_alt, color: Colors.blue),
                          ),
                          items: workoutTypes.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedWorkoutType = newValue;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: durationController,
                          decoration: const InputDecoration(
                            labelText: 'Duration/Intensity/Sets',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.timer, color: Colors.blue),
                          ),
                        ),
                        const SizedBox(height: 20),
                        DropdownButtonFormField<String>(
                          value: selectedWhenToWorkout,
                          decoration: const InputDecoration(
                            labelText: 'When to Workout',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.access_time, color: Colors.blue),
                          ),
                          items: whenToWorkoutOptions.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedWhenToWorkout = newValue;
                            });
                          },
                        ),
                        const SizedBox(height: 30),

                        // Responsive date pickers
                        isSmallScreen
                            ? Column(
                          children: [
                            _buildDatePickerRow("Start Date", startDate, (date) {
                              if (date != null) setState(() => startDate = date);
                            }),
                            const SizedBox(height: 10),
                            _buildDatePickerRow("End Date", endDate, (date) {
                              if (date != null) setState(() => endDate = date);
                            }),
                          ],
                        )
                            : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildDatePickerRow("Start Date :- ", startDate, (date) {
                              if (date != null) setState(() => startDate = date);
                            }),
                            const SizedBox(width: 20),
                            _buildDatePickerRow("End Date :- ", endDate, (date) {
                              if (date != null) setState(() => endDate = date);
                            }),
                          ],
                        ),

                        const SizedBox(height: 20),
                        _buildActionButton('Save Workout', saveWorkout),
                        const SizedBox(height: 15),
                        _buildActionButton('Logout', () {
                          logout(context);
                        }),
                        const SizedBox(height: 15),
                        _buildActionButton('View Workouts', () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const ViewWorkout()));
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePickerRow(String label, DateTime date, Function(DateTime?) onDatePicked) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          ),
          child: Text(
              '${date.year}/${date.month}/${date.day}',
              style: const TextStyle(color: Colors.white)),
          onPressed: () async {
            final pickedDate = await pickDate();
            onDatePicked(pickedDate);
          },
        ),
      ],
    );
  }

  Widget _buildActionButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),

          ),
          backgroundColor: Colors.white70
        ),
        child: Text(text),
      ),
    );
  }
}