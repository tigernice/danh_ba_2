// lib/views/edit_contact_screen.dart
import 'package:flutter/material.dart';
import '../viewmodels/contact_viewmodel.dart';
import '../models/contact.dart';

class EditContactScreen extends StatelessWidget {
  final Contact contact;
  final ContactViewModel viewModel;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();

  EditContactScreen({required this.contact, required this.viewModel}) {
    _nameController.text = contact.name;
    _phoneController.text = contact.phone;
    _emailController.text = contact.email;
    _addressController.text = contact.address;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sửa danh bạ'),
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
                    final updatedContact = Contact(
                      id: contact.id,
                      name: _nameController.text,
                      phone: _phoneController.text,
                      email: _emailController.text,
                      address: _addressController.text,
                    );
                    viewModel.updateContact(contact.id!, updatedContact);
                    Navigator.pop(context);
                  }
                },
                child: Text('Cập nhật'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}