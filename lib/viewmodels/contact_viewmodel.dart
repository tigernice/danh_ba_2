// lib/viewmodels/contact_viewmodel.dart
import 'package:flutter/material.dart';
import '../models/contact.dart';

class ContactViewModel with ChangeNotifier {
  final List<Contact> _contacts = [
    Contact(
      id: 1,
      name: 'Nguyễn Văn A',
      phone: '0123456789',
      email: '',
      address: 'Hà Nội',
    ),
    Contact(
      id: 2,
      name: 'Trần Thị B',
      phone: '0987654321',
      email: '',
      address: 'Hồ Chí Minh',
    ),

  ];

  List<Contact> get contacts => _contacts;

  List<Contact> _searchResults = [];
  List<Contact> get searchResults => _searchResults;


  void addContact(Contact contact) {
    _contacts.add(contact);
    notifyListeners();
  }

  void updateContact(int id, Contact updatedContact) {
    final index = _contacts.indexWhere((contact) => contact.id == id);
    if (index != -1) {
      _contacts[index] = updatedContact;
      notifyListeners();
    }
  }

  void deleteContact(int id) {
    _contacts.removeWhere((contact) => contact.id == id);
    notifyListeners();
  }


  void searchContacts(String query) {
    if (query.isEmpty) {
      _searchResults = _contacts; // Nếu query rỗng, hiển thị toàn bộ danh sách
    } else {
      _searchResults = _contacts
          .where((contact) =>
      contact.name.toLowerCase().contains(query.toLowerCase()) ||
          contact.phone.contains(query))
          .toList();
    }
    notifyListeners(); // Thông báo thay đổi
  }
}