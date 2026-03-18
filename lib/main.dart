import 'package:flutter/material.dart';

void main() {
  runApp(const HabitTrackerApp());
}

class HabitTrackerApp extends StatelessWidget {
  const HabitTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '极简习惯追踪',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HabitListPage(),
    );
  }
}

class HabitListPage extends StatefulWidget {
  const HabitListPage({super.key});

  @override
  State<HabitListPage> createState() => _HabitListPageState();
}

class _HabitListPageState extends State<HabitListPage> {
  final List<String> _habits = ['早起', '运动', '阅读', '喝水'];
  final Map<String, bool> _todayChecks = {};

  @override
  void initState() {
    super.initState();
    for (var habit in _habits) {
      _todayChecks[habit] = false;
    }
  }

  void _toggleCheck(String habit) {
    setState(() {
      _todayChecks[habit] = !_todayChecks[habit]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('今日习惯')),
      body: ListView.builder(
        itemCount: _habits.length,
        itemBuilder: (context, index) {
          final habit = _habits[index];
          return CheckboxListTile(
            title: Text(habit),
            value: _todayChecks[habit],
            onChanged: (value) => _toggleCheck(habit),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showAddHabitDialog(),
      ),
    );
  }

  void _showAddHabitDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('添加新习惯'),
        content: TextField(controller: controller, decoration: const InputDecoration(hintText: '输入习惯名称')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('取消')),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setState(() => _habits.add(controller.text));
                _todayChecks[controller.text] = false;
              }
              Navigator.pop(context);
            },
            child: const Text('添加'),
          ),
        ],
      ),
    );
  }
}