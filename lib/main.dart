import 'package:flutter/material.dart';
void main() {
  runApp(MaterialApp(
    title: 'SendaConvert',
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  String expr = '0';
  String base = 'GNF';
  Map<String, double> rates = {
    'GNF': 8770, 'USD': 1, 'XOF': 590, 'EUR': 0.92, 'CDF': 2800
  };
  List<Map<String, String>> currencies = [
    {'code': 'GNF', 'flag': '🇬🇳', 'name': 'Franc guineen'},
    {'code': 'USD', 'flag': '🇺🇸', 'name': 'Dollar americain'},
    {'code': 'XOF', 'flag': '🇨🇮', 'name': 'Franc CFA'},
    {'code': 'EUR', 'flag': '🇪🇺', 'name': 'Euro'},
    {'code': 'CDF', 'flag': '🇨🇩', 'name': 'Franc congolais'},
  ];
  double get val {
    try { return double.parse(expr); } catch(_) { return 0; }
  }
  String conv(String to) {
    double r = (val / (rates[base] ?? 1)) * (rates[to] ?? 1);
    return r == r.truncateToDouble() ? r.toInt().toString() : r.toStringAsFixed(2);
  }
  void tap(String k) {
    setState(() {
      if (k == 'C') { expr = '0'; return; }
      if (k == '<') { expr = expr.length > 1 ? expr.substring(0, expr.length - 1) : '0'; return; }
      expr = expr == '0' ? k : expr + k;
    });
  }
  Widget key(String k, Color bg) {
    return Expanded(child: GestureDetector(
      onTap: () => tap(k),
      child: Container(
        height: 60, margin: EdgeInsets.all(3),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
        alignment: Alignment.center,
        child: Text(k, style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
    ));
  }
  @override
  Widget build(BuildContext context) {
    Color acc = Color(0xFFF5A623);
    Color s1 = Color(0xFF1A1A1E);
    Color s2 = Color(0xFF242428);
    return Scaffold(
      backgroundColor: Color(0xFF0F0F10),
      body: SafeArea(child: Column(children: [
        Padding(padding: EdgeInsets.all(16), child: Row(children: [
          Text('Senda', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
          Text('Convert', style: TextStyle(color: acc, fontSize: 22, fontWeight: FontWeight.bold)),
          Spacer(),
          Text('💱', style: TextStyle(fontSize: 22)),
        ])),
        Expanded(child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 12),
          children: currencies.map((c) {
            bool isBase = c['code'] == base;
            return GestureDetector(
              onTap: () => setState(() { expr = conv(c['code']!); base = c['code']!; }),
              child: Container(
                margin: EdgeInsets.only(bottom: 6),
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: s1, borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: isBase ? acc : Colors.transparent, width: 1.5),
                ),
                child: Row(children: [
                  Text(c['flag']!, style: TextStyle(fontSize: 24)),
                  SizedBox(width: 12),
                  Text(c['code']!, style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                  Spacer(),
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text(isBase ? expr : conv(c['code']!),
                      style: TextStyle(color: isBase ? acc : Colors.white, fontSize: 20)),
                    Text(c['name']!, style: TextStyle(color: Colors.grey, fontSize: 10)),
                  ]),
                ]),
              ),
            );
          }).toList(),
        )),
        Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 😎,
          child: Align(alignment: Alignment.centerRight,
            child: Text(expr, style: TextStyle(color: Colors.white, fontSize: 30)))),
        Padding(padding: EdgeInsets.fromLTRB(12, 0, 12, 16), child: Column(children: [
          Row(children: [key('7',s2), key('8',s2), key('9',s2), key('/',acc)]),
          SizedBox(height: 6),
          Row(children: [key('4',s2), key('5',s2), key('6',s2), key('x',acc)]),
          SizedBox(height: 6),
          Row(children: [key('1',s2), key('2',s2), key('3',s2), key('-',acc)]),
          SizedBox(height: 6),
          Row(children: [key('C',s1), key('0',s2), key('<',s1), key('+',acc)]),
        ])),
      ])),
    );
  }
} 
