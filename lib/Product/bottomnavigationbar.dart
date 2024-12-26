import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: CupertinoColors.white, // Change background color to grey with a hint of red

      ),
      child: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                context,
                icon: CupertinoIcons.home,
                activeIcon: CupertinoIcons.home,
                index: 0,
              ),
              _buildNavItem(
                context,
                icon: Icons.work_history_outlined,
                activeIcon: Icons.work_rounded,
                index: 1,
              ),
              _buildNavItem(
                context,
                icon: Icons.widgets_outlined,
                activeIcon: Icons.widgets_rounded,
                index: 2,
              ),
              _buildNavItem(
                context,
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                index: 3,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
      BuildContext context, {
        required IconData icon,
        required IconData activeIcon,
        required int index,
      }) {
    return IconButton(
      enableFeedback: false,
      onPressed: () => onTap(index),
      icon: Icon(
        currentIndex == index ? activeIcon : icon,
        color: Colors.black.withOpacity(0.7),
        size: 28,
      ),
    );
  }
}
