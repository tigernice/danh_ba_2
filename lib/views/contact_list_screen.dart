// lib/views/contact_list_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/contact_viewmodel.dart';
import '../models/contact.dart';
import 'add_contact_screen.dart';
import 'edit_contact_screen.dart';

class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Contact> _filteredContacts = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final viewModel = Provider.of<ContactViewModel>(context, listen: false);
    final query = _searchController.text;
    setState(() {
      _filteredContacts = viewModel.searchContacts(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ContactViewModel>(context);
    final contacts = _searchController.text.isEmpty ? viewModel.contacts : _filteredContacts;

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Tìm kiếm...',
            border: InputBorder.none, // Ẩn border mặc định
            hintStyle: TextStyle(color: Colors.grey),
            enabledBorder: UnderlineInputBorder( // Đường gợi ý khi không focus
              borderSide: BorderSide(color: Colors.grey, width: 1.0),
            ),
            focusedBorder: UnderlineInputBorder( // Đường gợi ý khi focus
              borderSide: BorderSide(color: Colors.blue, width: 2.0),
            ),
          ),
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: Icon(Icons.clear, color: Colors.black),
              onPressed: () {
                _searchController.clear();
              },
            ),
        ],
      ),
      body: contacts.isEmpty
          ? Center(
        child: Text(
          'Không có danh bạ nào được lưu',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return ListTile(
            title: Text(contact.name),
            subtitle: Text(contact.phone),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditContactScreen(
                    contact: contact,
                    viewModel: viewModel,
                  ),
                ),
              );
            },
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                viewModel.deleteContact(contact.id!);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddContactScreen(viewModel: viewModel),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}