import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String nameButton;
  final IconData icon;

  const CustomButton(
      {super.key,
      required this.icon,
      required this.onPressed,
      required this.nameButton});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
      child: TextButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey.withOpacity(0.3),
          padding: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 22,
            ),
            const SizedBox(width: 5),
            Text(
              nameButton,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButtonList extends StatelessWidget {
  const CustomButtonList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          CustomButton(
              onPressed: () {
                print('Button 1 was pressed!');
              },
              nameButton: 'Create',
              icon: Icons.add_rounded),
          CustomButton(
              onPressed: () {
                print('Button 1 was pressed!');
              },
              nameButton: 'Import',
              icon: Icons.label_important_outline_rounded),
          CustomButton(
              onPressed: () {
                print('Button 1 was pressed!');
              },
              nameButton: 'Export',
              icon: Icons.import_export_rounded),
        ],
      ),
    );
  }
}
