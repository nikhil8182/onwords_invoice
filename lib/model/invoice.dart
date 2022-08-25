import 'package:onwords_invoice/model/supplier.dart';

import 'customer.dart';

class Invoice {
  final InvoiceInfo info;
  final Supplier supplier;
  final Customer customer;
  final List<InvoiceItem> items;
  final String fileName;
  final String docType;
  final String cat;
  final String quotNo;
  final int labAndInstall;
  final int advancePaid;
  final String accountName;
  final String accountNumber;
  final String ifscCode;
  final String bankName;
  final bool gstNeed;
  final bool labNeed;

   Invoice({
    required this.info,
    required this.supplier,
    required this.customer,
    required this.items,
    required this.fileName,
    required this.docType,
    required this.cat,
    required this.quotNo,
    required this.labAndInstall,
     required this.advancePaid,
     required this.accountName,
     required this.accountNumber,
     required this.ifscCode,
     required this.bankName,
     required this.gstNeed,
     required this.labNeed,
  });
}

class InvoiceInfo {
  // final String description;
  // final String number;
  final DateTime date;
  // final DateTime dueDate;

  const InvoiceInfo({
    // required this.description,
    // required this.number,
    required this.date,
    // required this.dueDate,
  });
}

class InvoiceItem {
  final String description;
  // final DateTime date;
  final int quantity;
  final double unitPrice;

  const InvoiceItem({
    required this.description,
    // required this.date,
    required this.quantity,
    required this.unitPrice,
  });
}

class SubTotal{
  final int quantity;
  final double amount;

  SubTotal({
    required this.quantity,
    required this.amount,
    });
}
