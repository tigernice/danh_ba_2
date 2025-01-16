// lib/views/contact_list_screen.dart
import 'package:danhba/utils/dialogs.dart';
import 'package:flutter/material.dart';
import '../viewmodels/contact_viewmodel.dart';
import '../models/contact.dart';
import 'add_contact_screen.dart';
import 'edit_contact_screen.dart';

class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final ContactViewModel _viewModel = ContactViewModel(); // Khởi tạo ViewModel
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print("hehehe initState");
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {

    print("hehehe dispose");
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    // Không cần setState, vì ListenableBuilder sẽ tự động cập nhật UI
    _viewModel.searchContacts(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Tìm kiếm...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.0),
            ),
            focusedBorder: UnderlineInputBorder(
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
      body: ListenableBuilder(
        listenable: _viewModel, // Lắng nghe thay đổi từ ViewModel
        builder: (context, _) {
          final contacts = _searchController.text.isEmpty
              ? _viewModel.contacts
              : _viewModel.searchContacts(_searchController.text);

          return contacts.isEmpty
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
              return Card(
                elevation: 4.0, // Độ nổi của Card
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), // Khoảng cách giữa các Card
                child: ListTile(
                  title: Text(contact.name),
                  subtitle: Text(contact.phone),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditContactScreen(
                          contact: contact,
                          viewModel: _viewModel, // Truyền ViewModel
                        ),
                      ),
                    );
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Sử dụng hàm showDeleteDialog
                      showDeleteDialog(
                        context: context,
                        title: 'Xác nhận xóa',
                        content: 'Bạn có chắc chắn muốn xóa liên hệ ${contact.name}?',
                        onDelete: () {
                          _viewModel.deleteContact(contact.id!); // Xóa liên hệ
                        },
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddContactScreen(
                viewModel: _viewModel, // Truyền ViewModel
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}