// lib/views/add_contact_screen.dart
import 'package:flutter/material.dart';
import '../viewmodels/contact_viewmodel.dart';
import '../models/contact.dart';

class AddContactScreen extends StatelessWidget {
  final ContactViewModel viewModel;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();

  AddContactScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm danh bạ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Tên'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Số điện thoại'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập số điện thoại';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Địa chỉ'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newContact = Contact(
                      id: DateTime.now().millisecondsSinceEpoch,
                      name: _nameController.text,
                      phone: _phoneController.text,
                      email: _emailController.text,
                      address: _addressController.text,
                    );
                    viewModel.addContact(newContact);
                    Navigator.pop(context);
                  }
                },
                child: Text('Lưu'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}