import 'dart:io';
import 'package:flutter/services.dart';
import 'package:open_document/open_document.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:shaudan_b2b/features/auth/controllers/login/login_controller.dart';
import 'package:shaudan_b2b/features/retailer/order/data/models/order_model.dart';

import 'dart:html' as html;

import 'package:shaudan_b2b/res/Images/image_strings.dart';

class PdfInvoiceService {
  static Future<Uint8List> createInvoice({
    required List<OrderModel> listorder,
  }) async {
    final pdf = pw.Document();
    final image = (await rootBundle.load(AppImagesStrings.logoShaudanGreen))
        .buffer
        .asUint8List();

    for (var i = 0; i < listorder.length; i++) {
      OrderModel orderModel = listorder[i];
      pdf.addPage(
        // ********************************Pdf Page Start here************************************
        pw.Page(
            pageFormat: PdfPageFormat.a4,
            margin: const pw.EdgeInsets.only(
                left: 20.0, right: 20.0, top: 0, bottom: 26.0),
            build: (pw.Context context) {
              return pw.Container(
                  child: pw.Column(children: [
                pw.Row(children: [
                  pw.Image(
                    pw.MemoryImage(
                      image,
                    ),
                    width: 200,
                    height: 200,
                  ),
                ]),
                pw.SizedBox(height: 10),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Container(
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(
                            color: PdfColors.black,
                            width: 1,
                          ),
                        ),
                        width: 250,
                        height: 40,
                        child: pw.Center(
                          child: pw.Text(
                            "Invoice order",
                            style: pw.TextStyle(
                              fontSize: 20,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      pw.Container(
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(
                            color: PdfColors.black,
                            width: 1,
                          ),
                        ),
                        child: pw.Center(
                          child: pw.Text(
                            "Pakistan",
                            style: pw.TextStyle(
                              fontSize: 20,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                        width: 250,
                        height: 40,
                      ),
                    ]),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.BarcodeWidget(
                        data: orderModel.id!,
                        width: 475,
                        height: 130,
                        barcode: pw.Barcode.code128(),
                      ),
                    ]),
                pw.SizedBox(height: 10),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Container(
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(
                            color: PdfColors.black,
                            width: 1,
                          ),
                        ),
                        width: 250,
                        height: 140,
                        child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          children: [
                            pw.Text(
                              "Origin : SXS-FEWX-WEF-WEF",
                              style: const pw.TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            pw.SizedBox(height: 10),
                            pw.Text(
                              "Dest : ASE-FVD-WCC-DDD",
                              style: const pw.TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      pw.Container(
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(
                            color: PdfColors.black,
                            width: 1,
                          ),
                        ),
                        child: pw.Column(children: [
                          pw.Container(
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(
                                color: PdfColors.black,
                                width: 1,
                              ),
                            ),
                            child: pw.Center(
                              child: pw.Text(
                                "STANDARD",
                                style: const pw.TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            height: 28,
                          ),
                          pw.Container(
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(
                                color: PdfColors.black,
                                width: 1,
                              ),
                            ),
                            height: 28,
                          ),
                          pw.Container(
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(
                                color: PdfColors.black,
                                width: 1,
                              ),
                            ),
                            child: pw.Center(
                              child: pw.Text(
                                "UnKnown KG",
                                style: const pw.TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            height: 28,
                          ),
                          pw.Container(
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(
                                color: PdfColors.black,
                                width: 1,
                              ),
                            ),
                            child: pw.Center(
                              child: pw.Text(
                                "Cash On Delivery",
                                style: const pw.TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            height: 28,
                          ),
                          pw.Container(
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(
                                color: PdfColors.black,
                                width: 1,
                              ),
                            ),
                            child: pw.Center(
                              child: pw.Text(
                                "PKR: ${orderModel.totalAmmount}",
                                style: const pw.TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            height: 28,
                          ),
                          pw.Container(
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(
                                color: PdfColors.black,
                                width: 1,
                              ),
                            ),
                            height: 28,
                          ),
                        ]),
                        width: 250,
                        height: 140,
                      ),
                    ]),

//
                pw.SizedBox(height: 6),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Container(
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(
                              color: PdfColors.black,
                              width: 1,
                            ),
                          ),
                          height: 28,
                          width: 500,
                          child: pw.Center(
                            child: pw.Text(
                              "Order Number : ${orderModel.id!}",
                              style: const pw.TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ))
                    ]),

                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Container(
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(
                              color: PdfColors.black,
                              width: 1,
                            ),
                          ),
                          height: 28,
                          width: 250,
                          child: pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: [
                              pw.Text(
                                "Order Date : ${orderModel.createdAt!.substring(0, 10)}",
                                style: const pw.TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          )),
                      pw.Container(
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(
                            color: PdfColors.black,
                            width: 1,
                          ),
                        ),
                        height: 28,
                      ),
                      pw.Container(
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(
                              color: PdfColors.black,
                              width: 1,
                            ),
                          ),
                          height: 28,
                          width: 250,
                          child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.center,
                              children: [
                                pw.Text(
                                  "Store Print Date = ${DateTime.now().toString().substring(0, 10)}",
                                  style: const pw.TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ]))
                    ]),
                pw.SizedBox(height: 6),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Container(
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(
                            color: PdfColors.black,
                            width: 1,
                          ),
                        ),
                        height: 200,
                        width: 200,
                        child: pw.Padding(
                          padding: const pw.EdgeInsets.all(5.0),
                          child: pw.BarcodeWidget(
                            data: orderModel.id!,
                            width: 190,
                            height: 185,
                            barcode: pw.Barcode.qrCode(),
                          ),
                        ),
                      ),
                      pw.Container(
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(
                              color: PdfColors.black,
                              width: 1,
                            ),
                          ),
                          child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.center,
                              children: [
                                pw.Container(
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                        color: PdfColors.black,
                                        width: 1,
                                      ),
                                    ),
                                    padding: const pw.EdgeInsets.all(5.0),
                                    height: 100,
                                    width: 300,
                                    child: pw.Text(
                                      // "Recipient: Zaheer Abbas phone 03068401606",
                                      "Recipient: ${orderModel.ordername} ph# ${orderModel.contact}  ${orderModel.billingAddress}  ",
                                      style: const pw.TextStyle(
                                        fontSize: 16,
                                      ),
                                    )),
                                pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.center,
                                  children: [
                                    pw.Container(
                                        decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                            color: PdfColors.black,
                                            width: 1,
                                          ),
                                        ),
                                        padding: const pw.EdgeInsets.all(5.0),
                                        height: 100,
                                        width: 300,
                                        child: pw.Text(
                                          "Sender: ${LoginController.to.user.value.name} ph# ${LoginController.to.user.value.contact!.phoneNumber!}",
                                          style: const pw.TextStyle(
                                            fontSize: 16,
                                          ),
                                        )),
                                  ],
                                )
                              ]))
                    ]),

                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Container(
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(
                            color: PdfColors.black,
                            width: 1,
                          ),
                        ),
                        child: pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: [
                              pw.Container(
                                  decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                      color: PdfColors.black,
                                      width: 1,
                                    ),
                                  ),
                                  padding: const pw.EdgeInsets.all(5.0),
                                  height: 30,
                                  width: 100,
                                  child: pw.Text(
                                    "QTY",
                                    style: const pw.TextStyle(
                                      fontSize: 16,
                                    ),
                                  )),
                              pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.center,
                                children: [
                                  pw.Container(
                                      decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                          color: PdfColors.black,
                                          width: 1,
                                        ),
                                      ),
                                      padding: const pw.EdgeInsets.all(5.0),
                                      height: 30,
                                      width: 100,
                                      child: pw.Text(
                                        orderModel.orderItem![0].quantity!
                                            .toString(),
                                        style: const pw.TextStyle(
                                          fontSize: 16,
                                        ),
                                      )),
                                ],
                              )
                            ]),
                      ),
                      pw.Container(
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(
                            color: PdfColors.black,
                            width: 1,
                          ),
                        ),
                        padding: const pw.EdgeInsets.all(5),
                        height: 60,
                        width: 400,
                        child: pw.Text(
                          orderModel.orderItem![0].product!.title!,
                          style: const pw.TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      )
                    ])
              ]));
            }),
      );
    }
    return pdf.save();
  }

  static Future<void> saveUint8ListToFile(
      Uint8List uint8List, String fileName) async {
    // if (Platform.isAndroid) {
    // final output = await getApplicationDocumentsDirectory();
    // var dir = Directory("${output.path}/Shaudanpdf`");
    // if (!dir.existsSync()) {
    //   dir.createSync();
    // }
    // var filePath = "${dir.path}/$fileName.pdf";
    // final file = File(filePath);
    // await file.writeAsBytes(uint8List);
    // await OpenDocument.openDocument(filePath: filePath);
    // } else {
    final blob = html.Blob([uint8List]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..target = 'a'
      ..download = fileName
      ..click();
    html.Url.revokeObjectUrl(url);
    // }
  }

  pw.Container alignText(
      String text, pw.TextAlign align, pw.FontWeight weight) {
    return pw.Container(
      width: 220,
      child: pw.Text(
        text,
        textAlign: align,
        style: pw.TextStyle(
          fontSize: 10,
          fontWeight: weight,
        ),
      ),
    );
  }

  pw.Positioned headerElements(String text, double left) {
    return pw.Positioned(
        top: 54,
        left: left,
        child: pw.Text(text, style: const pw.TextStyle(fontSize: 5.5)));
  }
}
