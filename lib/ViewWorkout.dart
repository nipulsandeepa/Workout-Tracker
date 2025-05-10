
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam2/AddWorkout.dart';
import 'package:exam2/WorkoutLogin.dart';
import 'package:exam2/newHome.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ViewWorkout extends StatefulWidget {
  const ViewWorkout({super.key});

  @override
  State<ViewWorkout> createState() => _ViewWorkoutState();
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
class _ViewWorkoutState extends State<ViewWorkout> {
  DateTime selectedDate = DateTime.now();
  List<DocumentSnapshot> allWorkouts = [];
  List<DocumentSnapshot> filteredWorkouts = [];
  String filterType = "All";

  @override
  void initState() {
    super.initState();
    fetchAllWorkouts();
  }

  void deleteWorkout(String docId) {
    FirebaseFirestore.instance.collection('workouts').doc(docId).delete().then((_) {
      setState(() {
        fetchAllWorkouts();
      });
    });
  }

  void updateWorkout(String docId, String newName, String newDuration) {
    FirebaseFirestore.instance.collection('workouts').doc(docId).update({
      'workoutName': newName,
      'duration': newDuration,
    });
    fetchAllWorkouts();
  }

  void showEditDialog(String docId, String currentName, String currentDuration) {
    TextEditingController nameController = TextEditingController(text: currentName);
    TextEditingController durationController = TextEditingController(text: currentDuration);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        title: Text(
          "Edit Workout",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.blueAccent,
          ),
        ),
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Workout Name",
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
              ),
              SizedBox(height: 18),
              TextField(
                controller: durationController,
                decoration: InputDecoration(
                  labelText: "Duration (mins)",
                  labelStyle: TextStyle(color: Colors.blueAccent), // Text label color
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0), // Rounded text field
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.redAccent), // Red color for "Cancel"
            ),
          ),
          TextButton(
            onPressed: () {
              updateWorkout(docId, nameController.text, durationController.text);
              Navigator.pop(context);
            },
            child: Text(
              "Save",
              style: TextStyle(color: Colors.green), // Green color for "Save"
            ),
          ),
        ],
      ),
    );
  }

  void fetchAllWorkouts() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('workouts').get();
    setState(() {
      allWorkouts = snapshot.docs;
      filterWorkouts();
    });
  }

  void filterWorkouts() {
    setState(() {
      filteredWorkouts = allWorkouts.where((doc) {
        var data = doc.data() as Map<String, dynamic>;
        DateTime startDate = (data['startDate'] as Timestamp).toDate();
        DateTime endDate = (data['endDate'] as Timestamp).toDate();
        bool isWithinDate =
            selectedDate.isAfter(startDate.subtract(Duration(days: 1))) &&
                selectedDate.isBefore(endDate.add(Duration(days: 1)));

        if (!isWithinDate) return false;

        if (filterType == "Completed") return data['completed'] == true;
        if (filterType == "Pending") return data['completed'] == false;
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'View Workouts',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,color: Colors.white),
        ),
        centerTitle: true,
        //backgroundColor: Colors.blueAccent,
        backgroundColor: Colors.purple.shade800,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Find the Workout for a specific Date :- ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              ElevatedButton(
                onPressed: () async {
                  DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    setState(() {
                      selectedDate = date;
                      filterWorkouts();
                    });
                  }
                },
                child: Text("Select Date: ${selectedDate.year}/${selectedDate.month}/${selectedDate.day}"),
              ),
            ],
          ),
          SizedBox(height: 15),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DropdownButton<String>(
                value: filterType,
                onChanged: (String? newValue) {
                  setState(() {
                    filterType = newValue!;
                    filterWorkouts();
                  });
                },
                items: ["All", "Completed", "Pending"]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),






          filteredWorkouts.isEmpty
              ? Center(
            child: Column(
              children: [
                Image.asset(
                  'lib/images/heart.png',
                  height: 400,
                  width: 400,
                ),
                Text(
                  "No Workouts !!",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                )
              ],
            ),
          )
              :

          Column(
            children: [
              ...filteredWorkouts.map((workoutDoc) {
                var workout = workoutDoc.data() as Map<String, dynamic>;
                String docId = workoutDoc.id;
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(


                    /*leading: Checkbox(
                      value: workout['completed'] ?? false,
                      onChanged: (bool? newValue) {
                        FirebaseFirestore.instance.collection('workouts').doc(docId).update({'completed': newValue});
                      },
                    ),*/

                    leading: Checkbox(
                      value: workout['completed'] ?? false,
                      onChanged: (bool? newValue) {
                        setState(() {
                          workout['completed'] = newValue;  // Update local state first
                        });

                        // Update Firestore asynchronously
                        FirebaseFirestore.instance.collection('workouts').doc(docId).update({
                          'completed': newValue
                        }).then((_) {
                          fetchAllWorkouts(); // Refresh data after Firestore update
                        });
                      },
                    ),


                    title: Text(
                      workout['workoutName'],
                      style: TextStyle(
                        decoration: workout['completed'] == true ? TextDecoration.lineThrough : TextDecoration.none,fontSize: 20,
                      ),
                    ),
                    subtitle: Text("${workout['workoutType']} - ${workout['duration']}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => showEditDialog(docId, workout['workoutName'], workout['duration'].toString()),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteWorkout(docId),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),

              // Add your image here
              SizedBox(height: 35,),
              Column(
                children: [
                  Text("You have Workouts for this Date !",style:
                  TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),),
                  Text("You are amazing !!!",style:
                  TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),),
                ],
              ),



              Image.asset(
                'lib/images/good.png',  // Change to your actual image path
                height: 300, // Adjust as needed
                width: 300, // Adjust as needed
              ),
            ],
          ),

          const SizedBox(height: 19),

      ElevatedButton(
        onPressed: ()
        {
         // Navigator.push(context,MaterialPageRoute(builder: (context) => const HomePage()));
          logout(context);
        },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white70
          ),
        child: const Text('Logout'),
      ),

          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: ()
            {
              Navigator.push(context,MaterialPageRoute(builder: (context) => const AddWorkout()));
            },
            child: const Text('+Add Workout'),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white70
            )
          ),





        ],
      ),
    );
  }
}
