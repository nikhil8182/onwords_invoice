

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onwords_invoice/image_saving/user.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/pdf_api.dart';
import '../api/pdf_invoice_api.dart';
import '../image_saving/user_preference.dart';
import '../model/customer.dart';
import '../model/invoice.dart';
import '../model/supplier.dart';
import '../provider_page.dart';
import '../widget/button_widget.dart';
import 'Account_Screen.dart';

class PreviewScreen extends StatefulWidget {
  final String doctype;
  final String category;
  final int advanceAmt;
  final int labAndInstall;

  const PreviewScreen({Key? key, required this.doctype, required this.category, required this.advanceAmt, required this.labAndInstall}) : super(key: key);

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  double amount = 0.0;
  final date = DateTime.now();
  late SharedPreferences logData;
  TextEditingController accountName = TextEditingController();
  TextEditingController accountNo = TextEditingController();
  TextEditingController ifsc = TextEditingController();
  TextEditingController bank = TextEditingController();
  TextEditingController fileName = TextEditingController();
  TextEditingController quotNo = TextEditingController();
  String supplierName = " ";
  String supplierStreet = " ";
  String supplierAddress = " ";
  int supplierPhone = 0;
  String supplierEmail = " ";
  String supplierWebsite = " ";
  String supplierGst= " ";
  late User user;
  final formKey = GlobalKey<FormState>();


  readData() async {
    logData = await SharedPreferences.getInstance();
    setState((){
      user = UserPreferences.getUser();
      supplierName = logData.getString('ownerName')!;
      supplierStreet = logData.getString('ownerStreet')!;
      supplierAddress = logData.getString('ownerAddress')!;
      supplierWebsite = logData.getString('ownerWebsite')!;
      supplierEmail = logData.getString('ownerEmail')!;
      supplierGst = logData.getString('ownerGst')!;
      supplierPhone = logData.getInt('ownerPhone')!;
      accountName.text = logData.getString('accountNameSaved')!;
      accountNo.text = logData.getString('accountNoSaved')!;
      ifsc.text = logData.getString('ifscCodeSaved')!;
      bank.text = logData.getString('bankNameSaved')!;
    });
  }



  @override
  void initState() {
    readData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return  Consumer<TaskData>(
        builder: (context, taskData,child) {
          final task = taskData.tasks[0];
          final invoice = taskData.invoiceListData;
          final val = taskData.subTotalValue;
          if(val.isEmpty){
            // print("aasswipe");
          }else{
            amount = val.map((e) => e.quantity*e.amount).reduce((value, element) => value + element);
            // print(subTotal);
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title:    Text(
                "Invoice Preview",
                style: TextStyle(
                    fontFamily: 'Nexa',
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontSize: height * 0.018),
              ),
              centerTitle: true,
              leading:   GestureDetector(
                child: Image.asset(
                  'assets/back arrow.png',
                  scale: 2.3,
                ),
                onTap: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              actions: [
                GestureDetector(
                  child: Icon(
                    Icons.account_circle_outlined,
                    color: Colors.deepOrangeAccent,
                    size: height * 0.03,
                  ),
                  onTap: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AccountScreen()));
                    });
                  },
                ),
                SizedBox(width: width*0.05,)

              ],
            ),
            backgroundColor: Colors.white,
          body: Form(
            key: formKey,
            child: Container(
              color: Colors.white,
                height: height * 1.0,
                width: width*1.0,
                padding: EdgeInsets.symmetric(horizontal: width*0.05),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Date : ${DateFormat("dd.MM.yyyy").format(date)}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: height * 0.012,
                                fontFamily: 'Nexa',
                                color: Colors.black),
                          ),
                          Column(
                            children: [
                              widget.doctype =='INVOICE'?Text(
                                'INVOICE No :',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: height * 0.014,
                                    fontFamily: 'Avenir',
                                    color: Colors.black),
                              ):Text(
                                'QUOTATION No :',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: height * 0.014,
                                    fontFamily: 'Avenir',
                                    color: Colors.black),
                              ),
                              Container(
                                height: height*0.050,
                                width: width*0.2,
                                child: Center(
                                  child: TextFormField(
                                    controller: quotNo,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter QUO-INV No';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: height * 0.012,
                                      fontFamily: 'Avenir',
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'QUO-INV No',
                                      hintStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: height * 0.012,
                                        fontFamily: 'Nexa',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Text(
                        "Bill To",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: height * 0.012,
                            fontFamily: 'Avenir',
                            color: Colors.black),
                      ),
                      Text(
                        task.name,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: height * 0.018,
                            fontFamily: 'Avenir',
                            color: Colors.black),
                      ),
                      Text(
                        "${task.street},${task.address}",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: height * 0.011,
                            fontFamily: 'Avenir',
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Container(
                        width: width * 0.9,
                        height: height * 0.06,
                        decoration: BoxDecoration(
                            color: Colors.deepOrangeAccent,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Table(
                            children: [
                              buildRow([
                                'Items',
                                'Qty',
                                'Rate',
                                'Amount'
                              ]),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Container(
                        width: width * 0.9,
                        height: height * 0.4,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 12.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: invoice.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Table(
                                // border: TableBorder.all(),
                                children: [
                                  buildRow(['${invoice[index].description}','${invoice[index].quantity}','${invoice[index].unitPrice}',
                                    '${invoice[index].quantity *invoice[index].unitPrice}']
                                  ),
                                ],
                              );
                            },

                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        width: width * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Acc.Name:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400, fontFamily: 'Nexa',fontSize: height*0.013),
                                    ),
                                    SizedBox(
                                      height: height*0.060,
                                      width: width*0.4,
                                      child: Center(
                                        child: TextFormField(
                                          textInputAction: TextInputAction.next,
                                          controller: accountName,
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please enter Acc Name';
                                            }
                                            return null;
                                          },
                                          keyboardType: TextInputType.multiline,
                                          minLines: 1,
                                          maxLines: 4,
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: height * 0.012,
                                            fontFamily: 'Avenir',
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: ' name',
                                            hintStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: height * 0.012,
                                              fontFamily: 'Nexa',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Acc.No: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400, fontFamily: 'Nexa',fontSize: height*0.013),),
                                    SizedBox(
                                      height: height*0.050,
                                      width: width*0.4,
                                      child: Center(
                                        child: TextFormField(
                                          textInputAction: TextInputAction.next,
                                          controller: accountNo,
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please enter Acc No';
                                            }
                                            return null;
                                          },
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: height * 0.012,
                                            fontFamily: 'Avenir',
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: ' Number',
                                            hintStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: height * 0.012,
                                              fontFamily: 'Nexa',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('IFSC code: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400, fontFamily: 'Nexa',fontSize: height*0.013),),
                                    SizedBox(
                                      height: height*0.050,
                                      width: width*0.4,
                                      child: Center(
                                        child: TextFormField(
                                          textInputAction: TextInputAction.next,
                                          controller: ifsc,
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please enter IFSC code';
                                            }
                                            return null;
                                          },
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: height * 0.012,
                                            fontFamily: 'Avenir',
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: ' code',
                                            hintStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: height * 0.012,
                                              fontFamily: 'Nexa',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Bank : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400, fontFamily: 'Nexa',fontSize: height*0.013),),
                                    SizedBox(
                                      height: height*0.080,
                                      width: width*0.4,
                                      child: Center(
                                        child: TextFormField(
                                          textInputAction: TextInputAction.done,
                                          keyboardType: TextInputType.multiline,
                                          minLines: 1,
                                          maxLines: 4,
                                          controller: bank,
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please enter Bank Name';
                                            }
                                            return null;
                                          },
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: height * 0.012,
                                            fontFamily: 'Avenir',
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: ' Bank',
                                            hintStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: height * 0.012,
                                              fontFamily: 'Nexa',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                              ButtonWidget(
                              text: 'Save as',
                              onClicked: () async {
                                final date = DateTime.now();
                                // final dueDate = date.add(Duration(days: 7));
                                final invoice = Invoice(
                                  quotNo: int.parse(quotNo.text),
                                  fileName: fileName.text,
                                  supplier: Supplier(
                                    gst: supplierGst,
                                    name: supplierName,
                                    street: supplierStreet,
                                    address: supplierAddress,
                                    phone: supplierPhone,
                                    email: supplierEmail,
                                    website: supplierWebsite,
                                  ),
                                  customer: Customer(
                                    name: task.name,
                                    street: task.street,
                                    address: task.address,
                                    phone: task.phone,
                                  ),
                                  info: InvoiceInfo(
                                    date: date,
                                    // dueDate: dueDate,
                                    // description: 'Description...',
                                    // number: '${DateTime.now().year}-9999',
                                  ),
                                  items: taskData.invoiceListData,
                                  docType: widget.doctype,
                                  cat: widget.category,
                                  advancePaid: widget.advanceAmt,
                                  labAndInstall: widget.labAndInstall,
                                  accountName: accountName.text,
                                  accountNumber: accountNo.text,
                                  ifscCode: ifsc.text,
                                  bankName: bank.text,
                                );
                                 // print(invoice.supplier.runtimeType);
                                final pdfFile = await PdfInvoiceApi.generate(invoice,user);

                                PdfApi.openFile(pdfFile).then((value){
                                  logData.setString('accountNameSaved', accountName.text);
                                  logData.setString('accountNoSaved', accountNo.text);
                                  logData.setString('ifscCodeSaved', ifsc.text);
                                  logData.setString('bankNameSaved', bank.text);
                                  fileName.clear();
                                  quotNo.clear();
                                  // accountName.clear();
                                  // accountNo.clear();
                                  // ifsc.clear();
                                  // bank.clear();

                                });
                              },
                            ),
                            // GestureDetector(
                            //   onTap: () {
                            //     _addItem(taskData);
                            //   },
                            //   child: Container(
                            //     padding: EdgeInsets.symmetric(horizontal: width*0.02),
                            //     width: width * 0.30,
                            //     height: height * 0.06,
                            //     decoration: BoxDecoration(
                            //       color: Color(0xffFF7E44),
                            //       borderRadius: BorderRadius.circular(15),
                            //       boxShadow: [
                            //         BoxShadow(
                            //             color: Colors.black.withOpacity(0.3),
                            //             offset: const Offset(8, 8),
                            //             blurRadius: 10,
                            //             spreadRadius: 0)
                            //       ],
                            //     ),
                            //     child: Row(
                            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //       children: [
                            //         Text(
                            //           "Save as",
                            //           style: TextStyle(
                            //               fontWeight: FontWeight.bold,
                            //               fontSize: height * 0.013,
                            //               fontFamily: 'Nexa',
                            //               color: Colors.white),
                            //         ),
                            //         Image.asset('assets/pdf.png',scale: 3.0,),
                            //
                            //       ],
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ),
      );
        }
    );
  }


  TableRow buildRow(List<String> cells, {bool isHeader = false}) => TableRow(
        children: cells.map(
          (cell) {
            const style = TextStyle(
              color: Colors.black,
            );
            return Padding(
              padding: const EdgeInsets.all(1),
              child: Center(
                child: Text(
                  cell,
                  style: style,
                ),
              ),
            );
          },
        ).toList(),
      );
  // showFileNameDialog(BuildContext context,task,height,width,taskData) {
  //   // Create button
  //   Widget okButton =  ButtonWidget(
  //     text: 'GENERATE PDF',
  //     onClicked: () async {
  //       final date = DateTime.now();
  //       // final dueDate = date.add(Duration(days: 7));
  //       final invoice = Invoice(
  //         quotNo: int.parse(quotNo.text),
  //         fileName: fileName.text,
  //         supplier: Supplier(
  //           name: supplierName,
  //           street: supplierStreet,
  //           address: supplierAddress,
  //           phone: supplierPhone,
  //           email: supplierEmail,
  //           website: supplierWebsite,
  //         ),
  //         customer: Customer(
  //           name: task.name,
  //           street: task.street,
  //           address: task.address,
  //           phone: task.phone,
  //         ),
  //         info: InvoiceInfo(
  //           date: date,
  //           // dueDate: dueDate,
  //           // description: 'Description...',
  //           // number: '${DateTime.now().year}-9999',
  //         ),
  //         items: taskData.invoiceListData,
  //         docType: dropdownValue, cat: category, advancePaid: advanceAmt, labAndInstall: labCharge,
  //       );
  //
  //       final pdfFile = await PdfInvoiceApi.generate(invoice);
  //
  //       PdfApi.openFile(pdfFile).then((value){
  //         fileName.clear();
  //         quotNo.clear();
  //         // labAndInstall.clear();
  //         // advancePaid.clear();
  //       });
  //     },
  //   );
  //   Widget cancelButton = TextButton(
  //     child: const Text(" Cancel "),
  //     onPressed: () {
  //       Navigator.pop(context, false);
  //     },
  //   );
  //   // Create AlertDialog
  //   final alert = StatefulBuilder(
  //       builder: (context, setState) => AlertDialog(
  //         backgroundColor: Colors.white,
  //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
  //         content: Container(
  //           height: height*0.30,
  //           width: width*1.0,
  //           child: SingleChildScrollView(
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               children: [
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     DropdownButton<String>(
  //                       value: dropdownValue,
  //                       icon: const Icon(Icons.arrow_downward),
  //                       elevation: 16,
  //                       style: const TextStyle(color: Colors.black),
  //                       underline: Container(
  //                         height: 2,
  //                         color: Colors.black,
  //                       ),
  //                       onChanged: (String? newValue) {
  //                         setState(() {
  //                           dropdownValue = newValue!;
  //                         });
  //                       },
  //                       items: <String>['QUOTATION','INVOICE']
  //                           .map<DropdownMenuItem<String>>((String value) {
  //                         return DropdownMenuItem<String>(
  //                           value: value,
  //                           child: Text(value),
  //                         );
  //                       }).toList(),
  //                     ),
  //                     DropdownButton<String>(
  //                       value: category,
  //                       icon: const Icon(Icons.arrow_downward),
  //                       elevation: 16,
  //                       style: const TextStyle(color: Colors.black),
  //                       underline: Container(
  //                         height: 2,
  //                         color: Colors.black,
  //                       ),
  //                       onChanged: (String? newValue) {
  //                         setState(() {
  //                           category = newValue!;
  //                         });
  //                       },
  //                       items: <String>['GA','SH','IT','DL','SS','WTA']
  //                           .map<DropdownMenuItem<String>>((String value) {
  //                         return DropdownMenuItem<String>(
  //                           value: value,
  //                           child: Text(value),
  //                         );
  //                       }).toList(),
  //                     ),
  //                   ],
  //                 ),
  //                 Container(
  //                   padding: const EdgeInsets.all(20.0),
  //                   child: TextFormField(
  //                     decoration: const InputDecoration(hintText: 'file name'),
  //                     controller: fileName,
  //                   ),
  //                 ),
  //                 Container(
  //                   padding: const EdgeInsets.all(20.0),
  //                   child: TextFormField(
  //                     keyboardType: TextInputType.number,
  //                     decoration: const InputDecoration(hintText: 'Quotation no'),
  //                     controller: quotNo,
  //                   ),
  //                 ),
  //                 dropdownValue=="INVOICE"? Container(
  //                   padding: const EdgeInsets.all(20.0),
  //                   child: TextFormField(
  //                     onChanged: (val){
  //                       setState((){
  //                         labCharge = int.parse(val);
  //                         print(labCharge);
  //                       });
  //                     },
  //                     keyboardType: TextInputType.number,
  //                     decoration: const InputDecoration(hintText: 'Labour and Installation Amount'),
  //                     controller: labAndInstall,
  //                   ),
  //                 ):Container(),
  //                 dropdownValue=="INVOICE"? Container(
  //                   padding: const EdgeInsets.all(20.0),
  //                   child: TextFormField(
  //                     onChanged: (val){
  //                       setState(() {
  //                         advanceAmt = int.parse(val);
  //                         print(advanceAmt);
  //                       });
  //                     },
  //                     keyboardType: TextInputType.number,
  //                     decoration: const InputDecoration(hintText: 'Advance Paid'),
  //                     controller: advancePaid,
  //                   ),
  //                 ):Container(),
  //               ],
  //             ),
  //           ),
  //         ),
  //         actions: [
  //           okButton,
  //           cancelButton,
  //         ],
  //       ));
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }
}
