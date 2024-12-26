import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class PopupView extends StatelessWidget {
  final String message;
  final VoidCallback? onDone;
  final VoidCallback? onCancel;
  final String doneButtonText;
  final String cancelButtonText;

  const PopupView({
    super.key,
    required this.message,
    required this.onDone,
    required this.onCancel,
    this.doneButtonText = "Done",
    this.cancelButtonText = "Cancel",
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: CupertinoColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              message,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: CupertinoColors.darkBackgroundGray),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: CupertinoColors.activeGreen),
                    onPressed: onDone ?? () => Navigator.of(context).pop(),
                    child: Text(
                      doneButtonText,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: CupertinoColors.white),
                    ),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: CupertinoColors.systemRed),
                    onPressed: onCancel ?? () => Navigator.of(context).pop(),
                    child: Text(
                      cancelButtonText,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: CupertinoColors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StudyPopupView extends StatelessWidget {
  final String message;
  final VoidCallback? onDone;
  final VoidCallback? onCancel;
  final String doneButtonText;
  final String cancelButtonText;
  final TextEditingController planName;
  final TextEditingController dateController;
  final TextEditingController timeController;
  final TextEditingController timeEndController;
  double starttime;
  double endtime;
   StudyPopupView({
    super.key,
    required this.message,
    required this.onDone,
    required this.onCancel,
    required this.planName,
    required this.dateController,
    required this.timeController,
    required this.timeEndController,
    this.starttime = 0,
    this.endtime = 0,
    this.doneButtonText = "Done",
    this.cancelButtonText = "Cancel",
  });





  double _timeToDouble(TimeOfDay time) {
    final double hour = time.hour.toDouble();
    final double minute = time.minute / 60;
    return hour + minute;
  }


  Future<void> _selectEndTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      timeEndController.text = selectedTime.format(context);
      double timeInDouble = _timeToDouble(selectedTime);
      endtime = timeInDouble;
      print("Selected time as double: $timeInDouble");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                message,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Divider(height: 0.5, color: Colors.grey),
              const SizedBox(height: 20),
              Column(
                children: [
                  TextField(
                    controller: planName,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      labelText: "Plan details",
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {

                    },
                    child: AbsorbPointer(
                      child: TextField(
                        controller: dateController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          labelText: "Select date",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {


                    },
                    child: AbsorbPointer(
                      child: TextField(
                        controller: timeController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          labelText: "Select start time",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      _selectEndTime(context);
                    },
                    child: AbsorbPointer(
                      child: TextField(
                        controller: timeEndController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          labelText: "Select end time",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: onDone ?? () {
                          // Save the study plan data to the database or state
                          Navigator.of(context).pop();
                        },
                        child: Text(doneButtonText),
                      ),
                      ElevatedButton(
                        onPressed: onCancel ?? () {
                          Navigator.of(context).pop();
                        },
                        child: Text(cancelButtonText),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

