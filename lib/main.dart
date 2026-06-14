import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
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
    'GNF': 8770,
    'USD': 1,
    'XOF': 590,
    'EUR': 0.92,
    'CDF': 2800,
  };
  final List<Map<String, String>> _currencies = [
    {'code': 'GNF', 'flag': '🇬🇳', 'name': 'Franc guineen'},
    {'code': 'USD', 'flag': '🇺🇸', 'name': 'Dollar americain'},
    {'code': 'XOF', 'flag': '🇨🇮', 'name': 'Franc CFA'},
    {'code': 'EUR', 'flag': '🇪🇺', 'name': 'Euro'},
    {'code': 'CDF', 'flag': '🇨🇩', 'name': 'Franc congolais'},
  ];
  double get _value {
    try {
      return double.parse(_expression.replaceAll(',', '.'));
    } catch (_) {
      return 0;
    }
  }
  String _convert(String to) {
    final fromRate = _rates[_base] ?? 1;
    final toRate = _rates[to] ?? 1;
    final result = (_value / fromRate) * toRate;
    if (result == result.truncateToDouble()) {
      return result.toInt().toString();
    }
    return result.toStringAsFixed(2);
  }
  void _tap(String k) {
    setState(() {
      if (k == 'C') {
        _expression = '0';
        return;
      }
      if (k == 'X') {
        if (_expression.length > 1) {
          _expression = _expression.substring(0, _expression.length - 1);
        } else {
          _expression = '0';
        }
        return;
      }
      if (_expression == '0') {
        _expression = k;
      } else {
        _expression = _expression + k;
      }
    });
  }
  Widget _buildKey(String label, Color bg, Color fg) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: GestureDetector(
          onTap: () => _tap(label),
          child: Container(
            height: 64,
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: Text(
              label == 'X' ? '⌫' : label,
              style: TextStyle(
                color: fg,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildRow(List<String> keys) {
    const orange = Color(0xFFF5A623);
    const dark = Color(0xFF1A1A1E);
    const darker = Color(0xFF242428);
    const white = Color(0xFFF0F0F0);
    return Row(
      children: keys.map((k) {
        final isOp = k == '+' || k == '-' || k == 'x' || k == '/';
        final isFunc = k == 'C' || k == 'X';
        final bg = isOp ? orange : isFunc ? dark : darker;
        final fg = isOp ? Colors.white : white;
        return _buildKey(k, bg, fg);
      }).toList(),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F10),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 😎,
              child: Row(
                children: [
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(text: 'Senda', style: TextStyle(color: Color(0xFFF0F0F0))),
                        TextSpan(text: 'Convert', style: TextStyle(color: Color(0xFFF5A623))),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Text('💱', style: TextStyle(fontSize: 22)),
                ],
              ),
            ),
            Expanded(
              child: ListView(
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
                      child: Row(
                        children: [
                          Text(c['flag']!, style: const TextStyle(fontSize: 26)),
                          const SizedBox(width: 12),
                          Text(code, style: const TextStyle(color: Color(0xFFF0F0F0), fontSize: 14, fontWeight: FontWeight.w600)),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                isBase ? _expression : _convert(code),
                                style: TextStyle(
                                  color: isBase ? const Color(0xFFF5A623) : const Color(0xFFF0F0F0),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(c['name']!, style: const TextStyle(color: Color(0xFF6A6A70), fontSize: 10)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  _expression,
                  style: const TextStyle(color: Color(0xFFF0F0F0), fontSize: 32, fontWeight: FontWeight.w300),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
              child: Column(
                children: [
                  _buildRow(['7', '8', '9', '/']),
                  const SizedBox(height: 😎,
                  _buildRow(['4', '5', '6', 'x']),
                  const SizedBox(height: 😎,
                  _buildRow(['1', '2', '3', '-']),
                  const SizedBox(height: 😎,
                  _buildRow(['C', '0', 'X', '+']),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
