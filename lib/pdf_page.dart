// import 'package:flutter/material.dart';
// import 'package:onwords_invoice/widget/button_widget.dart';
// import 'api/pdf_api.dart';
// import 'api/pdf_invoice_api.dart';
// import 'model/customer.dart';
// import 'model/invoice.dart';
// import 'model/supplier.dart';
//
// class PdfPage extends StatefulWidget {
//   @override
//   _PdfPageState createState() => _PdfPageState();
// }
//
// class _PdfPageState extends State<PdfPage> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//
//
//   TextEditingController itermNameController = TextEditingController();
//   TextEditingController priceController = TextEditingController();
//   TextEditingController quantityController = TextEditingController();
//   TextEditingController vatController = TextEditingController();
//
//
//   List productName = [];
//   List productPrice = [];
//   List productQun = [];
//   List productVat = [];
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//         backgroundColor: Colors.blueGrey,
//         body: Container(
//           padding: EdgeInsets.all(32),
//           child: Column(
//             children: <Widget>[
//               ButtonWidget(
//                 text: 'Invoice PDF',
//                 onClicked: () async {
//                   final date = DateTime.now();
//                   final dueDate = date.add(Duration(days: 7));
//                   final invoice = Invoice(
//                     supplier: Supplier(
//                       name: 'Onwords Smart Solution',
//                       address: 'Pollachi, Coimbatore',
//                       // paymentInfo: 'https://paypal.me/sarahfieldzz',
//                     ),
//                     customer: Customer(
//                       name: '${nameController.text.toString()}',
//                       address: '${addressController.text.toString()}',
//                     ),
//                     info: InvoiceInfo(
//                       date: date,
//                       dueDate: dueDate,
//                       description: 'Description...',
//                       number: '${DateTime.now().year}-9999',
//                     ),
//                     items: [
//                       InvoiceItem(
//                         description: 'Coffee',
//                         date: DateTime.now(),
//                         quantity: 3,
//                         unitPrice: 5.99,
//                       ),
//                       InvoiceItem(
//                         description: 'Water',
//                         date: DateTime.now(),
//                         quantity: 8,
//                         unitPrice: 0.99,
//                       ),
//                     ],
//                   );
//
//                   final pdfFile = await PdfInvoiceApi.generate(invoice);
//
//                   PdfApi.openFile(pdfFile);
//                 },
//               ),
//             ],
//           ),
//         ),
//       );
// }
