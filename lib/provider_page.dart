import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:onwords_invoice/model/customer.dart';
import 'package:onwords_invoice/model/invoice.dart';
import 'package:onwords_invoice/model/supplier.dart';

class TaskData extends ChangeNotifier{
  final List<Customer> _tasks = [ ];

  final List<InvoiceItem> invoiceListData = [ ];

  // final List<Supplier> ownerDetails = [ ];
  //
  //
  //
  // UnmodifiableListView<Supplier> get ownerData {
  //   return UnmodifiableListView(ownerDetails);
  // }

  UnmodifiableListView<Customer> get tasks {
    return UnmodifiableListView(_tasks);
  }

  UnmodifiableListView<InvoiceItem> get invoiceData {
    return UnmodifiableListView(invoiceListData);
  }

  int get taskCount{
    return _tasks.length;
  }
  void addTask(String name,String street,String address,int phone) {
    final task = Customer(name: name, street: street, address: address,phone:phone);
    _tasks.add(task);
    notifyListeners();
  }

  void addInvoiceListData(String des,int quantity,double price) {
    final data = InvoiceItem(description: des, quantity: quantity,unitPrice: price);
    invoiceListData.add(data);
    notifyListeners();
  }

  // void addOwnerData(String name,String street,String address,String city,String country) {
  //   final ownerData = Supplier(name: name, street: street, address: address, city: city, country: country);
  //   ownerDetails.add(ownerData);
  //   notifyListeners();
  // }

  // void upDateTask(Task task){
  //   task.toggleDone();
  //   notifyListeners();
  // }

  void deleteTask(int ind){
    invoiceListData.removeAt(ind);
    notifyListeners();
  }

}
