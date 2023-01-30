import 'dart:convert';
import 'package:currency_converter/model/listmodel.dart';
import 'package:currency_converter/model/model.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BoxDecoration decor = BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      border: Border.all(color: Colors.black, width: 1.0));

  late Currency _firstcurrency;
  late Currency _secondcurrency;

  List<Currency> currencyDataList = [
    Currency("INR", const Icon(MdiIcons.currencyInr)),
    Currency("USD", const Icon(MdiIcons.currencyUsd)),
    Currency("EUR", const Icon(MdiIcons.currencyEur)),
  ];
  @override
  void initState() {
    super.initState();
    _firstcurrency = currencyDataList[0];
    _secondcurrency = currencyDataList[0];
    _getlist();
    _getlatest('INR');
  }

  void _onDropDownItemSelectedfirst(Currency newSelectedcurrency) {
    setState(() {
      _firstcurrency = newSelectedcurrency;
    });
  }

  void _onDropDownItemSelectedsecond(Currency newSelectedcurrency) {
    setState(() {
      _secondcurrency = newSelectedcurrency;
    });
  }

  String dropbutton = 'INR';
  String dropdownvalue = 'INR';
  Welcome data = Welcome();
  Datalist list = Datalist();
  final amountcontroller = TextEditingController();
  String result = '';
  String date = '';
  Map<String, String> currencylist = {};
  Map<String, double> ratelist = {};

  String resultname = '';
  List<String> currencyName = [
    "AED",
    "AFN",
    "ALL",
    "AMD",
    "ANG",
    "AOA",
    "ARS",
    "AUD",
    "AWG",
    "AZN",
    "BAM",
    "BBD",
    "BDT",
    "BGN",
    "BHD",
    "BIF",
    "BMD",
    "BND",
    "BOB",
    "BRL",
    "BSD",
    "BTC",
    "BTN",
    "BWP",
    "BYN",
    "BYR",
    "BZD",
    "CAD",
    "CDF",
    "CHF",
    "CLF",
    "CLP",
    "CNY",
    "COP",
    "CRC",
    "CUC",
    "CUP",
    "CVE",
    "CZK",
    "DJF",
    "DKK",
    "DOP",
    "DZD",
    "EGP",
    "ERN",
    "ETB",
    "EUR",
    "FJD",
    "FKP",
    "GBP",
    "GEL",
    "GGP",
    "GHS",
    "GIP",
    "GMD",
    "GNF",
    "GTQ",
    "GYD",
    "HKD",
    "HNL",
    "HRK",
    "HTG",
    "HUF",
    "IDR",
    "ILS",
    "IMP",
    "INR",
    "IQD",
    "IRR",
    "ISK",
    "JEP",
    "JMD",
    "JOD",
    "JPY",
    "KES",
    "KGS",
    "KHR",
    "KMF",
    "KPW",
    "KRW",
    "KWD",
    "KYD",
    "KZT",
    "LAK",
    "LBP",
    "LKR",
    "LRD",
    "LSL",
    "LTL",
    "LVL",
    "LYD",
    "MAD",
    "MDL",
    "MGA",
    "MKD",
    "MMK",
    "MNT",
    "MOP",
    "MRO",
    "MUR",
    "MVR",
    "MWK",
    "MXN",
    "MYR",
    "MZN",
    "NAD",
    "NGN",
    "NIO",
    "NOK",
    "NPR",
    "NZD",
    "OMR",
    "PAB",
    "PEN",
    "PGK",
    "PHP",
    "PKR",
    "PLN",
    "PYG",
    "QAR",
    "RON",
    "RSD",
    "RUB",
    "RWF",
    "SAR",
    "SBD",
    "SCR",
    "SDG",
    "SEK",
    "SGD",
    "SHP",
    "SLE",
    "SLL",
    "SOS",
    "SRD",
    "STD",
    "SVC",
    "SYP",
    "SZL",
    "THB",
    "TJS",
    "TMT",
    "TND",
    "TOP",
    "TRY",
    "TTD",
    "TWD",
    "TZS",
    "UAH",
    "UGX",
    "USD",
    "UYU",
    "UZS",
    "VEF",
    "VES",
    "VND",
    "VUV",
    "WST",
    "XAF",
    "XAG",
    "XAU",
    "XCD",
    "XDR",
    "XOF",
    "XPF",
    "YER",
    "ZAR",
    "ZMK",
    "ZMW",
    "ZWL",
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Currency Converter'),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Text("As of Date : $date"),
              const SizedBox(height: 10),
              TextField(
                controller: amountcontroller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'Enter Amount',
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(),
                        borderRadius: BorderRadius.circular(10.0))),
              ),
              const SizedBox(height: 10),
              FormField<String>(
                builder: (FormFieldState<String> state1) {
                  return InputDecorator(
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.fromLTRB(12, 10, 20, 20),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<Currency>(
                        elevation: 2,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        hint: const Text(
                          "Select Currency",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        items: currencyDataList
                            .map<DropdownMenuItem<Currency>>((Currency value1) {
                          return DropdownMenuItem(
                            value: value1,
                            child: Row(
                              children: [
                                value1.currency_logo,
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(value1.currency_name),
                              ],
                            ),
                          );
                        }).toList(),
                        isExpanded: true,
                        isDense: true,
                        onChanged: (firstvalue) {
                          _onDropDownItemSelectedfirst(firstvalue!);
                        },
                        value: _firstcurrency,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 15),
              FormField<String>(
                builder: (FormFieldState<String> state1) {
                  return InputDecorator(
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.fromLTRB(12, 10, 20, 20),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<Currency>(
                        elevation: 2,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        hint: const Text(
                          "Select Currency",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        items: currencyDataList
                            .map<DropdownMenuItem<Currency>>((Currency value2) {
                          return DropdownMenuItem(
                            value: value2,
                            child: Row(
                              children: [
                                value2.currency_logo,
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(value2.currency_name),
                              ],
                            ),
                          );
                        }).toList(),
                        isExpanded: true,
                        isDense: true,
                        onChanged: (secondvalue) {
                          _onDropDownItemSelectedsecond(secondvalue!);
                        },
                        value: _secondcurrency,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: MediaQuery.of(context).size.width / 2.3,
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(12)),
                    child: Text(
                      result,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      _doConversion();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 45,
                      width: MediaQuery.of(context).size.width / 2.3,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Text(
                        "Convert",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width / 4,
                height: MediaQuery.of(context).size.height * 0.05,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(12)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: dropdownvalue,
                    items: currencyName.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                        dropbutton = newValue;
                        _getlatest(newValue);
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.50,
                child: ListView.builder(
                    itemCount: currencylist.length,
                    itemBuilder: (context, index) => SizedBox(
                          height: 30,
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 35,
                                  child: Text(
                                    currencyName[index],
                                    style: const TextStyle(
                                        color: Color(0xff0002A1)),
                                  )),
                              Text(data.symbols![currencyName[index]]!,
                                  style: const TextStyle(color: Colors.blue)),
                              const Spacer(),
                              Text(
                                  "${list.rates![currencyName[index]]!.toStringAsFixed(2)} ",
                                  style: const TextStyle(color: Colors.red)),
                              const SizedBox(width: 5),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  width: 30,
                                  child: Text(dropbutton)),
                            ],
                          ),
                        )),
              )
            ],
          ),
        ),
      ),
    );
  }

  _doConversion() async {
    String uri =
        "https://api.apilayer.com/exchangerates_data/convert?to=${_secondcurrency.currency_name}&from=${_firstcurrency.currency_name}&amount=${amountcontroller.text}&apikey=MX8RDsx2z6wpOGRhx6LprNOIX12v3Mc7";
    var url = Uri.parse(uri);
    var response = await http.get(url, headers: {
      "Accept": "application/json",
    });
    var responseBody = json.decode(response.body);
    setState(() {
      result = responseBody['result'].toString();
      date = responseBody['date'];
    });
    return "Success";
  }

  _getlist() async {
    String uri =
        "https://api.apilayer.com/exchangerates_data/symbols?apikey=MX8RDsx2z6wpOGRhx6LprNOIX12v3Mc7";
    var url = Uri.parse(uri);
    var response = await http.get(url, headers: {
      "Accept": "application/json",
    });
    // var responseBody = json.decode(response.body);
    data = welcomeFromJson(response.body);

    currencylist.addAll(data.symbols!);
    print(data.symbols!['INR']);
    return "Success";
  }

  _getlatest(String base) async {
    String uri =
        "https://api.apilayer.com/exchangerates_data/latest?symbols=AED%2CAFN%2CALL%2CAMD%2CANG%2CAOA%2CARS%2CAUD%2CAWG%2CAZN%2CBAM%2CBBD%2CBDT%2CBGN%2CBHD%2CBIF%2CBMD%2CBND%2CBOB%2CBRL%2CBSD%2CBTC%2CBTN%2CBWP%2CBYN%2CBYR%2CBZD%2CCAD%2CCDF%2CCHF%2CCLF%2CCLP%2CCNY%2CCOP%2CCRC%2CCUC%2CCUP%2CCVE%2CCZK%2CDJF%2CDKK%2CDOP%2CDZD%2CEGP%2CERN%2CETB%2CEUR%2CFJD%2CFKP%2CGBP%2CGEL%2CGGP%2CGHS%2CGIP%2CGMD%2CGNF%2CGTQ%2CGYD%2CHKD%2CHNL%2CHRK%2CHTG%2CHUF%2CIDR%2CILS%2CIMP%2CINR%2CIQD%2CIRR%2CISK%2CJEP%2CJMD%2CJOD%2CJPY%2CKES%2CKGS%2CKHR%2CKMF%2CKPW%2CKRW%2CKWD%2CKYD%2CKZT%2CLAK%2CLBP%2CLKR%2CLRD%2CLSL%2CLTL%2CLVL%2CLYD%2CMAD%2CMDL%2CMGA%2CMKD%2CMMK%2CMNT%2CMOP%2CMRO%2CMUR%2CMVR%2CMWK%2CMXN%2CMYR%2CMZN%2CNAD%2CNGN%2CNIO%2CNOK%2CNPR%2CNZD%2COMR%2CPAB%2CPEN%2CPGK%2CPHP%2CPKR%2CPLN%2CPYG%2CQAR%2CRON%2CRSD%2CRUB%2CRWF%2CSAR%2CSBD%2CSCR%2CSDG%2CSEK%2CSGD%2CSHP%2CSLE%2CSLL%2CSOS%2CSRD%2CSTD%2CSVC%2CSYP%2CSZL%2CTHB%2CTJS%2CTMT%2CTND%2CTOP%2CTRY%2CTTD%2CTWD%2CTZS%2CUAH%2CUGX%2CUSD%2CUYU%2CUZS%2CVEF%2CVES%2CVND%2CVUV%2CWST%2CXAF%2CXAG%2CXAU%2CXCD%2CXDR%2CXOF%2CXPF%2CYER%2CZAR%2CZMK%2CZMW%2CZWL%2C&base=$base&apikey=MX8RDsx2z6wpOGRhx6LprNOIX12v3Mc7";
    var url = Uri.parse(uri);
    var response = await http.get(url, headers: {
      "Accept": "application/json",
    });
    // var responseBody = json.decode(response.body);
    setState(() {
      list = datalistFromJson(response.body);
      ratelist.addAll(list.rates!);
      print(list.rates!['INR']);
    });

    return "Success";
  }
}

class Currency {
  String currency_name;
  Icon currency_logo;
  Currency(
    this.currency_name,
    this.currency_logo,
  );
}
