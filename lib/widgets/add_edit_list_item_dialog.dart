import 'package:flutter/material.dart';

class AddEditListItemDialog extends StatefulWidget {
  final String title;
  final String field1Label;
  final String field2Label;
  final String field3Label;

  const AddEditListItemDialog({
    super.key,
    required this.title,
    required this.field1Label,
    required this.field2Label,
    required this.field3Label,
  });

  @override
  State<AddEditListItemDialog> createState() => _AddEditListItemDialogState();
}

class _AddEditListItemDialogState extends State<AddEditListItemDialog> {
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  final _controller3 = TextEditingController();

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E1A34))),
            const SizedBox(height: 16),
            TextField(
              controller: _controller1,
              decoration: InputDecoration(hintText: widget.field1Label, filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Colors.black12)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Colors.black12))),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _controller2,
              decoration: InputDecoration(hintText: widget.field2Label, filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Colors.black12)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Colors.black12))),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _controller3,
              decoration: InputDecoration(hintText: widget.field3Label, filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Colors.black12)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Colors.black12))),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_controller1.text.isNotEmpty) {
                        Navigator.pop(context, {
                          'field1': _controller1.text,
                          'field2': _controller2.text,
                          'field3': _controller3.text,
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Vui lòng nhập ít nhất dòng đầu tiên')));
                      }
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF11005E), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), padding: const EdgeInsets.symmetric(vertical: 16), elevation: 0),
                    child: const Text('SAVE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFF11005E)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), padding: const EdgeInsets.symmetric(vertical: 16)),
                    child: const Text('CLOSE', style: TextStyle(color: Color(0xFF11005E), fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
