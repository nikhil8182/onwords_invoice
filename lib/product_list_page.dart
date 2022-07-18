import 'package:flutter/material.dart';
import 'package:onwords_invoice/pdf_page.dart';
import 'package:onwords_invoice/provider_page.dart';
import 'package:onwords_invoice/widget/button_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/pdf_api.dart';
import 'api/pdf_invoice_api.dart';
import 'model/customer.dart';
import 'model/invoice.dart';
import 'model/supplier.dart';

class ProductListOutPage extends StatefulWidget {
  const ProductListOutPage({Key? key}) : super(key: key);

  @override
  State<ProductListOutPage> createState() => _ProductListOutPageState();
}

class _ProductListOutPageState extends State<ProductListOutPage> {

  TextEditingController itermNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController vatController = TextEditingController();
  TextEditingController fileName = TextEditingController();
  TextEditingController quotNo = TextEditingController();
  List productName = [];
  List productPrice = [];
  List productQuantity = [];
  List productVat = [];
  late SharedPreferences logData;
  String supplierName = " ";
  String supplierStreet = " ";
  String supplierAddress = " ";
  String supplierCity = " ";
  String supplierCountry = " ";
  int supplierPin = 0;
  String dropdownValue = 'QUOTATION';
  String category = 'GA';


  readData() async {
    logData = await SharedPreferences.getInstance();
    setState((){
      supplierName = logData.getString('ownerName')!;
      supplierStreet = logData.getString('ownerStreet')!;
      supplierAddress = logData.getString('ownerAddress')!;
      supplierCity = logData.getString('ownerCity')!;
      supplierCountry = logData.getString('ownerCountry')!;
      supplierPin = logData.getInt('ownerPin')!;
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
    return Consumer<TaskData>(
        builder: (context, taskData, child) {
          final task = taskData.tasks[0];
          return  Scaffold(
        appBar: AppBar(
          actions: [
            ElevatedButton(onPressed: (){
              showAnotherAlertDialog(context,height,width);
            }, child: const Text(" Add ")),
          ],

        ),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          width: width*1.0,
          height: height*1.0,
          child: Column(
            children: [

              SizedBox(
                height: height*0.04,
              ),
              Table(
                border: TableBorder.all(),
                children: [
                  buildRow(['Product','Quantity','Amount'],isHeader: true,)
                ],
              ),
              Expanded(
                child: ListView.builder(
                  // shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: productName.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onLongPress: (){
                        setState((){
                          print("hello");
                          productName.removeAt(index);
                          productQuantity.removeAt(index);
                          productVat.removeAt(index);
                          productPrice.removeAt(index);
                          Provider.of<TaskData>(context,listen: false).deleteTask(index);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Table(
                          border: TableBorder.all(),
                          children: [
                            buildRow([
                              '${productName[index]}','${productQuantity[index]}','${productPrice[index]}',]
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(onPressed: (){
                showFileNameDialog(context,task,height,width,taskData);
              }, child: const Text("Generate Pdf")),
              SizedBox(
                height: height*0.07,
              ),
            ],
          ),
        ),
      );}
    );
  }
  TableRow buildRow(List<String> cells,{bool isHeader = false}) => TableRow(
    children: cells.map(
          (cell) {
        final style =TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        );
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Text(cell,style: style,),
          ),
        );
      },
    ).toList(),
  );

  showAnotherAlertDialog(BuildContext context,height,width) {
    // Create button
    Widget okButton = TextButton(
      child: const Text(" ok "),
      onPressed: () {
        setState((){
          productName.add(itermNameController.text);
          productPrice.add(priceController.text);
          productQuantity.add(quantityController.text);
          productVat.add(vatController.text);
        });
        Provider.of<TaskData>(context,listen: false).addInvoiceListData(itermNameController.text,int.parse(quantityController.text), double.parse(priceController.text));
        Navigator.pop(context, false);
        itermNameController.clear();
        priceController.clear();
        quantityController.clear();
        vatController.clear();
      },
    );
    Widget cancelButton = TextButton(
      child: const Text(" Cancel "),
      onPressed: () {
        Navigator.pop(context, false);
      },
    );
    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      title: const Text(
        "  Data entry ",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      content: Container(
        height: height*0.40,
        width: width*1.0,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  decoration: InputDecoration(hintText: 'Product name'),
                  controller: itermNameController,
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: 'quantity'),
                  controller: quantityController,
                ),
              ),

              // Container(
              //   padding: EdgeInsets.all(20.0),
              //   child: TextFormField(
              //     decoration: InputDecoration(hintText: 'vat'),
              //     controller: vatController,
              //   ),
              // ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: 'amount'),
                  controller: priceController,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        cancelButton,
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showFileNameDialog(BuildContext context,task,height,width,taskData) {
    // Create button
    Widget okButton =  ButtonWidget(
      text: 'Invoice PDF',
      onClicked: () async {
        final date = DateTime.now();
        final dueDate = date.add(Duration(days: 7));
        final invoice = Invoice(
          quotNo: int.parse(quotNo.text),
          fileName: fileName.text,
          supplier: Supplier(
            name: supplierName,
            street: supplierStreet,
            address: supplierAddress,
            city: supplierCity,
            country: supplierCountry,
            pin: supplierPin,
          ),
          customer: Customer(
              name: task.name,
              street: task.street,
              address: task.address,
              city: task.city,
              country: task.country,
              pin: task.pin
          ),
          info: InvoiceInfo(
            date: date,
            dueDate: dueDate,
            description: 'Description...',
            number: '${DateTime.now().year}-9999',
          ),
          items: taskData.invoiceListData,
          docType: dropdownValue, cat: category,
        );

        final pdfFile = await PdfInvoiceApi.generate(invoice);

        PdfApi.openFile(pdfFile).then((value){
          fileName.clear();
          quotNo.clear();
        });

      },
    );
    Widget cancelButton = TextButton(
      child: const Text(" Cancel "),
      onPressed: () {
        Navigator.pop(context, false);
      },
    );
    // Create AlertDialog
    final alert = StatefulBuilder(
      builder: (context, setState) => AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      content: Container(
        height: height*0.30,
        width: width*1.0,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    underline: Container(
                      height: 2,
                      color: Colors.black,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>['QUOTATION','INVOICE']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  DropdownButton<String>(
                    value: category,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    underline: Container(
                      height: 2,
                      color: Colors.black,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        category = newValue!;
                      });
                    },
                    items: <String>['GA','SH','IT','DL','SS','WTA']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  decoration: const InputDecoration(hintText: 'file name'),
                  controller: fileName,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: 'Quotation no'),
                  controller: quotNo,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        okButton,
        cancelButton,
      ],
    ));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
