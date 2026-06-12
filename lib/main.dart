import 'package:flutter/material.dart';

void main() => runApp(const SendaConvertApp());

class SendaConvertApp extends StatelessWidget {
  const SendaConvertApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'SendaConvert',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _expression = '0';
  String _base = 'GNF';

  final Map<String, double> _rates = {
    'GNF': 8770, 'USD': 1, 'XOF': 590, 'EUR': 0.92, 'CDF': 2800,
  };

  final List<Map<String, String>> _currencies = [
    {'code': 'GNF', 'flag': '🇬🇳', 'name': 'Franc guinéen'},
    {'code': 'USD', 'flag': '🇺🇸', 'name': 'Dollar américain'},
    {'code': 'XOF', 'flag': '🇨🇮', 'name': 'Franc CFA'},
    {'code': 'EUR', 'flag': '🇪🇺', 'name': 'Euro'},
    {'code': 'CDF', 'flag': '🇨🇩', 'name': 'Franc congolais'},
  ];

  double get _value {
    try { return double.parse(_expression.replaceAll(',', '.')); }
    catch (_) { return 0; }
  }

  String _convert(String to) {
    final r = (_value / (_rates[_base] ?? 1)) * (_rates[to] ?? 1);
    return r == r.truncateToDouble() ? r.toInt().toString() : r.toStringAsFixed(2);
  }

  void _tap(String k) {
    setState(() {
      if (k == 'C') { _expression = '0'; return; }
      if (k == '⌫') {
        _expression = _expression.length > 1
            ? _expression.substring(0, _expression.length - 1) : '0';
        return;
      }
      _expression = _expression == '0' ? k : _expression + k;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F10),
      body: SafeArea(child: Column(children: [
        // Header
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 14, 18, 8),
          child: Row(children: [
            RichText(text: const TextSpan(
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              children: [
                TextSpan(text: 'Senda', style: TextStyle(color: Color(0xFFF0F0F0))),
                TextSpan(text: 'Convert', style: TextStyle(color: Color(0xFFF5A623))),
              ],
            )),
            const Spacer(),
            const Text('💱', style: TextStyle(fontSize: 22)),
          ]),
        ),

        // Devises
        Expanded(child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          children: _currencies.map((c) {
            final code = c['code']!;
            final isBase = code == _base;
            return GestureDetector(
              onTap: () => setState(() {
                _expression = _convert(code);
                _base = code;
              }),
              child: Container(
                margin: const EdgeInsets.only(bottom: 6),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1E),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isBase ? const Color(0xFFF5A623) : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                child: Row(children: [
                  Text(c['flag']!, style: const TextStyle(fontSize: 26)),
                  const SizedBox(width: 12),
                  Text(code, style: const TextStyle(
                    color: Color(0xFFF0F0F0), fontSize: 14, fontWeight: FontWeight.w600,
                  )),
                  const Spacer(),
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text(
                      isBase ? _expression : _convert(code),
                      style: TextStyle(
                        color: isBase ? const Color(0xFFF5A623) : const Color(0xFFF0F0F0),
                        fontSize: 20, fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(c['name']!, style: const TextStyle(
                      color: Color(0xFF6A6A70), fontSize: 10,
                    )),
                  ]),
                ]),
              ),
            );
          }).toList(),
        )),

        // Expression
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(_expression, style: const TextStyle(
              color: Color(0xFFF0F0F0), fontSize: 32, fontWeight: FontWeight.w300,
            )),
          ),
        ),

        // Clavier
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
          child: Column(children: [
            for (final row in [
              ['7','8','9','÷'],
              ['4','5','6','×'],
              ['1','2','3','-'],
              ['C','0','⌫','+'],
            ])
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(children: row.map((k) {
                final isOp = ['÷','×','-','+'].contains(k);
                final isFunc = ['C','⌫'].contains(k);
                return Expanded(child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: GestureDetector(
                    onTap: () => _tap(k),
                    child: Container(
                      height: 64,
                      decoration: BoxDecoration(
                        color: isOp ? const Color(0xFFF5A623)
                            : isFunc ? const Color(0xFF1A1A1E)
                            : const Color(0xFF242428),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      alignment: Alignment.center,
                      child: Text(k, style: TextStyle(
                        color: isOp ? Colors.white : const Color(0xFFF0F0F0),
                        fontSize: 20, fontWeight: FontWeight.w500,
                      )),
                    ),
                  ),
                ));
              }).toList()),
            ),
          ]),
        ),
      ])),
    );
  }
}
