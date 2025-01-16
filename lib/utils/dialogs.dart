import 'package:flutter/material.dart';

Future<void> showDeleteDialog({
  required BuildContext context,
  required String title,
  required String content,
  required VoidCallback onDelete,
}) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Đóng dialog
            },
            child: Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              onDelete(); // Gọi hàm xóa
              Navigator.pop(context); // Đóng dialog
            },
            child: Text(
              'Xóa',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );
}