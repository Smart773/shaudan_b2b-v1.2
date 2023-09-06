import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_document/open_document.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

// import 'dart:html' as html;

import 'package:shaudan_b2b/res/Images/image_strings.dart';

class CustomRow {
  final String description;
  final String amount;
  final String qty;
  final String total;
  CustomRow(this.description, this.amount, this.qty, this.total);
}

class PdfInvoiceService {
  // createInvoice();
  static Future<Uint8List> createInvoice() async {
    final pdf = pw.Document();
    // final List<CustomRow> elements = [
    //   for (var i = 0; i < soldProducts.length; i++)
    //     CustomRow(
    //         soldProducts[i].description,
    //         soldProducts[i].amount.toString(),
    //         soldProducts[i].qty.toString(),
    //         soldProducts[i].getTotal.toString()),
    // ];

    final image = (await rootBundle.load(AppImagesStrings.logoShaudanGreen))
        .buffer
        .asUint8List();
    // final arabicTax =
    //     (await rootBundle.load("assets/images/tax.png")).buffer.asUint8List();

    pdf.addPage(
      // ********************************mango start hrere************************************
      pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.only(
              left: 20.0, right: 20.0, top: 0, bottom: 26.0),
          build: (pw.Context context) {
            // order deleiver back page
            // its has Order Id in String and BarCode on top
            // and Order Details in Table
            // and Order Status in Table

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
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
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
                      "Saleable Order",
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
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
                pw.BarcodeWidget(
                  data: "12345678901234567890",
                  width: 475,
                  height: 130,
                  barcode: pw.Barcode.code128(),
                ),
              ]),
              pw.SizedBox(height: 10),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
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
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
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
                        "Order Number : 153203718097988",
                        style: const pw.TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ))
              ]),

              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
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
                          "Order Date : 2021-07-20",
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
                            "AWB Print Date =2021-07-21",
                            style: const pw.TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ]))
              ]),
              pw.SizedBox(height: 6),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
                pw.Container(
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(
                        color: PdfColors.black,
                        width: 1,
                      ),
                    ),
                    height: 200,
                    width: 200,
                    child: pw.Center(
                      child: pw.Text(
                        "QR Code",
                        style: const pw.TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    )),
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
                                "Recipient: Zaheer Abbas phone 03068401606",
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
                                  height: 100,
                                  width: 300,
                                  child: pw.Text(
                                    "Sender: Caestores 518100,China",
                                    style: const pw.TextStyle(
                                      fontSize: 16,
                                    ),
                                  )),
                            ],
                          )
                        ]))
              ]),

              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
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
                                  "1",
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
                    "2022 Hand Printed Cartoon Cover",
                    style: const pw.TextStyle(
                      fontSize: 16,
                    ),
                  ),
                )
              ])
            ]));
          }),
    );

    return pdf.save();
  }

  static Future<void> savePdfFile(String fileName, Uint8List byteList) async {
    // Q:: MissingPluginException(No implementation found for method getTemporaryDirectory on channel plugins.flutter.io/path_provider)
    // A:: flutter clean
    // in web
    // final output = await getApplicationDocumentsDirectory();
    // print(output.path);
    // final file = File("${output.path}/$fileName.pdf");
    // await file.writeAsBytes(byteList);
    // final String pathInString = file.path;
    // OpenDocument.openDocument(filePath: pathInString);
  }

  static void saveUint8ListToFile(Uint8List uint8List, String fileName) {
    if (Platform.isAndroid) {
    } else {
      // final blob = html.Blob([uint8List]);
      // final url = html.Url.createObjectUrlFromBlob(blob);
      // final anchor = html.AnchorElement(href: url)
      //   ..target = 'a'
      //   ..download = fileName
      //   ..click();
      // html.Url.revokeObjectUrl(url);
    }
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

//   pw.Expanded itemColumn(List<CustomRow> elements, double subTotle) {
//     int temp = 0;
//     String? wordTotal =
//         decimalToWord(subTotle == 0 ? 0 : subTotle + (subTotle * 0.05));
//     // wordTotal = wordTotal.toTitleCase;
//     return pw.Expanded(
//       child: pw.Column(
//         children: [
//           pw.Row(
//             children: [
//               pw.Expanded(
//                   flex: 1,
//                   child: pw.Text("S.N.",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                           fontWeight: pw.FontWeight.bold, fontSize: 12))),
//               pw.Expanded(
//                   flex: 6,
//                   child: pw.Text("Description",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                           fontWeight: pw.FontWeight.bold, fontSize: 12))),
//               pw.Expanded(
//                   flex: 2,
//                   child: pw.Text("Qty.",
//                       textAlign: pw.TextAlign.right,
//                       style: pw.TextStyle(
//                           fontWeight: pw.FontWeight.bold, fontSize: 12))),
//               pw.Expanded(
//                   flex: 2,
//                   child: pw.Text("Price",
//                       textAlign: pw.TextAlign.right,
//                       style: pw.TextStyle(
//                           fontWeight: pw.FontWeight.bold, fontSize: 12))),
//               pw.Expanded(
//                   flex: 2,
//                   child: pw.Text("Amount",
//                       textAlign: pw.TextAlign.right,
//                       style: pw.TextStyle(
//                           fontWeight: pw.FontWeight.bold, fontSize: 12))),
//             ],
//           ),
//           pw.Divider(
//             color: PdfColors.grey700,
//             thickness: 1,
//           ),
//           for (; temp < 8; temp++)
//             pw.Container(
//               height: 26,
//               color: (temp >= elements.length)
//                   ? PdfColors.white
//                   : temp % 2 == 0
//                       ? PdfColors.white
//                       : PdfColors.grey200,
//               child: (temp >= elements.length)
//                   ? pw.Row(children: [
//                       pw.Expanded(child: pw.Text("")),
//                       pw.Expanded(child: pw.Text("")),
//                       pw.Expanded(child: pw.Text("")),
//                       pw.Expanded(child: pw.Text("")),
//                     ])
//                   : pw.Row(
//                       children: [
//                         pw.Expanded(
//                             flex: 1,
//                             child: pw.Text(
//                               "${temp + 1}",
//                               textAlign: pw.TextAlign.center,
//                               style: pw.TextStyle(
//                                   fontSize: 12, fontWeight: pw.FontWeight.bold),
//                             )),
//                         pw.Expanded(
//                             flex: 6,
//                             child: pw.Text(
//                               elements[temp].description,
//                               textAlign: pw.TextAlign.left,
//                               style: const pw.TextStyle(fontSize: 10),
//                             )),
//                         pw.Expanded(
//                             flex: 2,
//                             child: pw.Text(
//                               elements[temp].qty,
//                               style: const pw.TextStyle(fontSize: 10),
//                               textAlign: pw.TextAlign.right,
//                             )),
//                         pw.Expanded(
//                             flex: 2,
//                             child: pw.Text(
//                               formatNumber(double.parse(elements[temp].amount)),
//                               style: const pw.TextStyle(fontSize: 10),
//                               textAlign: pw.TextAlign.right,
//                             )),
//                         pw.Expanded(
//                             flex: 2,
//                             child: pw.Text(
//                               formatNumber(double.parse(elements[temp].total)),
//                               style: const pw.TextStyle(fontSize: 10),
//                               textAlign: pw.TextAlign.right,
//                             )),
//                       ],
//                     ),
//             ),
//           pw.Divider(
//             color: PdfColors.grey700,
//             thickness: 1,
//           ),
//           pw.Row(
//             children: [
//               pw.Expanded(
//                   flex: 4,
//                   child: pw.Text("",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                           fontWeight: pw.FontWeight.bold, fontSize: 12))),
//               pw.Expanded(
//                   flex: 1,
//                   child: pw.Text("",
//                       textAlign: pw.TextAlign.right,
//                       style: pw.TextStyle(
//                           fontWeight: pw.FontWeight.bold, fontSize: 12))),
//               pw.Expanded(
//                   flex: 2,
//                   child: pw.Text("Sub Total",
//                       textAlign: pw.TextAlign.right,
//                       style: pw.TextStyle(
//                           fontWeight: pw.FontWeight.bold, fontSize: 10))),
//               pw.Expanded(
//                   flex: 2,
//                   child: pw.Text(formatNumber(subTotle),
//                       textAlign: pw.TextAlign.right,
//                       style: pw.TextStyle(
//                           fontWeight: pw.FontWeight.bold, fontSize: 10))),
//             ],
//           ),
//           pw.Row(
//             children: [
//               pw.Expanded(
//                   flex: 4,
//                   child: pw.Text("",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
//               pw.Expanded(
//                   flex: 1,
//                   child: pw.Text("",
//                       textAlign: pw.TextAlign.right,
//                       style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
//               pw.Expanded(
//                   flex: 2,
//                   child: pw.Text("VAT 5%",
//                       textAlign: pw.TextAlign.right,
//                       style: pw.TextStyle(
//                           fontWeight: pw.FontWeight.bold, fontSize: 10))),
//               pw.Expanded(
//                   flex: 2,
//                   child: pw.Text(formatNumber((subTotle * 0.05)),
//                       textAlign: pw.TextAlign.right,
//                       style: pw.TextStyle(
//                           fontWeight: pw.FontWeight.bold, fontSize: 10))),
//             ],
//           ),
//           pw.Divider(
//             color: PdfColors.grey700,
//             thickness: 1,
//           ),
//           pw.Row(
//             children: [
//               pw.Expanded(
//                   flex: 4,
//                   child: pw.Text("Total In Words:   \n${(wordTotal)}",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                           fontWeight: pw.FontWeight.bold, fontSize: 10))),
//               pw.Expanded(
//                   flex: 1,
//                   child: pw.Text("",
//                       textAlign: pw.TextAlign.right,
//                       style: pw.TextStyle(
//                           fontWeight: pw.FontWeight.bold, fontSize: 10))),
//               pw.Expanded(
//                   flex: 2,
//                   child: pw.Container(
//                       alignment: pw.Alignment.topRight,
//                       height: 30,
//                       child: pw.Text("Grand Total",
//                           style: pw.TextStyle(
//                               fontWeight: pw.FontWeight.bold, fontSize: 10)))),
//               pw.Expanded(
//                   flex: 2,
//                   child: pw.Container(
//                       alignment: pw.Alignment.topRight,
//                       height: 30,
//                       child: pw.Text(formatNumber(subTotle + (subTotle * 0.05)),
//                           textAlign: pw.TextAlign.right,
//                           style: pw.TextStyle(
//                               fontWeight: pw.FontWeight.bold, fontSize: 10)))),
//             ],
//           ),
//           pw.Divider(
//             color: PdfColors.grey700,
//             thickness: 1,
//           ),
//         ],
//       ),
//     );
//   }
}
