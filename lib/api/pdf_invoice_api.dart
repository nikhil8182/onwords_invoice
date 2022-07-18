import 'dart:io';
import 'package:flutter/services.dart';
import 'package:onwords_invoice/api/pdf_api.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

import '../model/customer.dart';
import '../model/invoice.dart';
import '../model/supplier.dart';
import '../utils.dart';

class PdfInvoiceApi {
  static Future<File> generate(Invoice invoice) async {
    final pdf = Document();
    var assetImage = pw.MemoryImage((await rootBundle.load('images/logo.png')).buffer.asUint8List());

    pdf.addPage(MultiPage(
      build: (context) => [
        builderLogo(assetImage,invoice.info,invoice),
        buildHeader(invoice),
        SizedBox(height: 0.8 * PdfPageFormat.cm),
        // buildTitle(invoice),
        buildInvoice(invoice),
        Divider(),
        buildTotal(invoice),
      ],
      footer: (context) => buildFooter(invoice),
    ));

    return PdfApi.saveDocument(name: '${invoice.fileName}.pdf', pdf: pdf);
  }

  static Widget builderLogo(MemoryImage img,InvoiceInfo info,Invoice invoice)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 150,
            width: 150,
            child: pw.Image(img),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(invoice.docType, style: TextStyle(fontWeight: FontWeight.normal,color: PdfColors.red,fontSize: 25.0 )),
              invoice.docType == "QUOTATION"?Text("#EST${invoice.cat}-${Utils.formatDummyDate(info.date)}${invoice.quotNo}"):
                       Text("#INV${invoice.cat}-${Utils.formatDummyDate(info.date)}${invoice.quotNo}"),
              Text("Date :  ${Utils.formatDate(info.date)}"),
            ]
          )

        ],
      ),
    ],
  );



  static Widget buildHeader(Invoice invoice) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 0.5 * PdfPageFormat.cm),
      buildSupplierAddress(invoice.supplier),
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     buildSupplierAddress(invoice.supplier),
      //     buildInvoiceInfo(invoice.info),
      //   ],
      // ),
      ///
      // Container(
      //   height: 50,
      //   width: 50,
      //   child: BarcodeWidget(
      //     barcode: Barcode.qrCode(),
      //     data: invoice.info.number,
      //   ),
      // ),
      SizedBox(height: 0.5 * PdfPageFormat.cm),
      buildCustomerAddress(invoice.customer),
      SizedBox(height: 0.5 * PdfPageFormat.cm),
    ],
  );

  static Widget buildCustomerAddress(Customer customer) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Bill To:", style: TextStyle(fontWeight: FontWeight.normal,fontSize: 20.0)),
      SizedBox(height: 0.5 * PdfPageFormat.cm),
      Text("${customer.name},", style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 2 * PdfPageFormat.mm),
      Text("${customer.street},"),
      Text("${customer.address},"),
      Text("${customer.city},"),
      Text("${customer.country} -${customer.pin}."),
    ],
  );
  ///invoiceInfo
  // static Widget buildInvoiceInfo(InvoiceInfo info) {
  //
  //   final paymentTerms = '${info.dueDate.difference(info.date).inDays} days';
  //   final titles = <String>[
  //     'Invoice Number:',
  //     'Invoice Date:',
  //     'Payment Terms:',
  //     'Due Date:',
  //   ];
  //   final data = <String>[
  //     info.number,
  //     Utils.formatDate(info.date),
  //     paymentTerms,
  //     Utils.formatDate(info.dueDate),
  //   ];
  //
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: List.generate(titles.length, (index) {
  //       final title = titles[index];
  //       final value = data[index];
  //
  //       return buildText(title: title, value: value, width: 200);
  //     }),
  //   );
  // }

  static Widget buildSupplierAddress(Supplier supplier) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("${supplier.name},", style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 2 * PdfPageFormat.mm),
      Text("${supplier.street},"),
      Text("${supplier.address},"),
      Text("${supplier.city},"),
      Text("${supplier.country} -${supplier.pin}."),
      SizedBox(height: 0.5 * PdfPageFormat.cm),
      Text("GST NO: 33BTUPN5784J1ZT ", style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15.0)),
    ],
  );
  ///doctype
  // static Widget buildTitle(Invoice invoice) => Column(
  //   crossAxisAlignment: CrossAxisAlignment.start,
  //   children: [
  //     Text(
  //       invoice.docType,
  //       style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  //     ),
  //     SizedBox(height: 0.4 * PdfPageFormat.cm),
  //     // Text(invoice.info.description),
  //     // SizedBox(height: 0.8 * PdfPageFormat.cm),
  //   ],
  // );

  static Widget buildInvoice(Invoice invoice) {
    final headers = [
      'Item & Description',
      'Quantity',
      'Unit Price',
      'Total'
    ];

    final data = invoice.items.map((item) {
      // final total = item.unitPrice * item.quantity * ( 1 + item.vat);
      final total = item.unitPrice * item.quantity * ( 1 + 0);
      return [
        item.description,
        // Utils.formatDate(item.date),
        '${item.quantity}',
        '${item.unitPrice}',
        // '${0} %',
        // '${item.vat} %',
        '${total.toStringAsFixed(2)}',
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: const BoxDecoration(color: PdfColors.red),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
        5: Alignment.centerRight,
      },
    );
  }


  static Widget buildBankDetails()=> Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Acc.No: 5020-0065-403656", style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15.0)),
      Text("Acc.Name: Onwords", style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15.0)),
      Text("IFSC Code: HDFC0000787", style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15.0)),
      Text("Bank : HDFC", style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15.0)),
    ]
  );



  static Widget buildTotal(Invoice invoice) {
    final netTotal = invoice.items.map((item) => item.unitPrice * item.quantity).reduce((item1, item2) => item1 + item2);
    // final vatPercent = invoice.items.first.vat;
    const vatPercent = 0.09;
    final vat = netTotal * vatPercent;
    final iVat = netTotal * vatPercent;
    final total = netTotal + vat + iVat;

    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          buildBankDetails(),
          Spacer(flex: 5),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                  title: 'Sub total',
                  value: Utils.formatPrice(netTotal),
                  unite: true,
                ),
                buildText(
                  title: 'Grand total',
                  value: Utils.formatPrice(netTotal),
                  unite: true,
                ),
                buildText(
                  title: 'CGST ${vatPercent * 100} %',
                  value: Utils.formatPrice(vat),
                  unite: true,
                ),
                buildText(
                  title: 'IGST ${vatPercent * 100} %',
                  value: Utils.formatPrice(vat),
                  unite: true,
                ),
                Divider(),
                buildText(
                  title: 'Total amount ',
                  titleStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  value: Utils.formatPrice(total),
                  unite: true,
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildFooter(Invoice invoice) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Divider(),
      SizedBox(height: 2 * PdfPageFormat.mm),
      buildSimpleText(title: 'Address', value: "${invoice.supplier.street},${invoice.supplier.address},${invoice.supplier.city}"),
      SizedBox(height: 1 * PdfPageFormat.mm),
      // buildSimpleText(title: 'Paypal', value: invoice.supplier.paymentInfo),
    ],
  );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}