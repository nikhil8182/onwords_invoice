import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:onwords_invoice/model/customer.dart';
import 'package:onwords_invoice/model/invoice.dart';
import 'package:onwords_invoice/model/supplier.dart';

class TaskData extends ChangeNotifier{
  final List<Customer> customerData = [
  const Customer(name: " ", street: " ", address: " ",phone: 0)
  ];

  final List<SubTotal> value = [ ];

  final List<InvoiceItem> invoiceListData = [ ];


  // final List<Supplier> ownerDetails = [ ];
  //
  //
  //
  // UnmodifiableListView<Supplier> get ownerData {
  //   return UnmodifiableListView(ownerDetails);
  // }

  UnmodifiableListView<Customer> get tasks {
    return UnmodifiableListView(customerData);
  }

  UnmodifiableListView<InvoiceItem> get invoiceData {
    return UnmodifiableListView(invoiceListData);
  }

  UnmodifiableListView<SubTotal> get subTotalValue {
    return UnmodifiableListView(value);
  }

  int get taskCount{
    return customerData.length;
  }



  void addTask(String name,String street,String address,int phone) {
    final task = Customer(name: name, street: street, address: address,phone:phone);
    customerData.add(task);
    notifyListeners();
  }

  void addInvoiceListData(String des,int quantity,double price) {
    final data = InvoiceItem(description: des, quantity: quantity,unitPrice: price);
    invoiceListData.add(data);
    notifyListeners();
  }

  void addSubTotal(int quantity,double price) {
    final data = SubTotal(quantity: quantity,amount: price);
    value.add(data);
    notifyListeners();
  }
  ///subtotal
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

  void clearSubtotal(int ind){
    value.removeAt(ind);
    notifyListeners();
  }

  void deleteCustomerDetails(int ind){
    customerData.removeAt(ind);
    notifyListeners();
  }

}
