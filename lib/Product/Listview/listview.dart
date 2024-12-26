import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TaskListViewCell extends StatelessWidget {
  final String title;
  final String subtitle;
  final int tasksCount;
  final double progressPercentage;

  const TaskListViewCell({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.tasksCount,
    required this.progressPercentage,
  }) : super(key: key);

  Color getProgressColor(double progressPercentage) {
    if (progressPercentage <= 30) {
      return Colors.red;
    } else if (progressPercentage > 30 && progressPercentage <= 50) {
      return Colors.amber;
    } else if (progressPercentage > 50 && progressPercentage <= 75) {
      return Colors.yellow;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            offset: const Offset(0, 3),
            blurRadius: 6,
          ),
        ],
        border: Border.all(color: Colors.white),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(
                      CupertinoIcons.checkmark_circle,
                      color: Colors.black,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "$tasksCount Tasks",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          CircularPercentIndicator(
            radius: 40,
            lineWidth: 6.0,
            percent: (progressPercentage.clamp(0, 100)) / 100,
            center: Text(
              "${progressPercentage.toInt()}%",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            progressColor: getProgressColor(progressPercentage),
            backgroundColor: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }
}

class TaskListView extends StatelessWidget {
  final List<Map<String, dynamic>> tasks;

  const TaskListView({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 16),
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return TaskListViewCell(
              title: task['title'] ?? 'No Title',
              subtitle: task['subtitle'] ?? 'No Subtitle',
              tasksCount: task['tasksCount'] ?? 0,
              progressPercentage: task['progressPercentage']?.toDouble() ?? 0.0,
            );
          },
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: CupertinoColors.systemGrey6,
        ),
      ),
    );
  }
}

class CircularPercentIndicator extends StatelessWidget {
  final double radius;
  final double lineWidth;
  final double percent;
  final Widget center;
  final Color progressColor;
  final Color backgroundColor;

  const CircularPercentIndicator({
    Key? key,
    required this.radius,
    required this.lineWidth,
    required this.percent,
    required this.center,
    required this.progressColor,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: radius * 2,
      width: radius * 2,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: percent,
            strokeWidth: lineWidth,
            color: progressColor,
            backgroundColor: backgroundColor,
          ),
          Center(
            child: center,
          ),
        ],
      ),
    );
  }
}
