import 'dart:io';
import 'Colors.dart';
import '../models/Employee.dart'; 
import '../models/Position.dart'; 
import '../models/Department.dart';

class Cli {
  final List<Employee> _employees = [];

  void start() {
    while (true) {
      _clearScreen();
      _showMenu();
      bool shouldQuit = _processInput();

      if (shouldQuit) {
        break;
      }
    }
  }

  bool _processInput() {
    stdout.write('${Colors.white}Choose an option: ${Colors.reset}');
    String? input = stdin.readLineSync();

    bool shouldQuit = false;

    switch (input) {
      case '1':
        _createEmployee();
        break;
      case '2':
        _displayEmployees();
        break;
      case '3':
        print('${Colors.red}Exiting...${Colors.reset}');
        shouldQuit = true;
        break;
      default:
        print('${Colors.red}Invalid option, try again.${Colors.reset}');
        _waitForUser();
        break;
    }

    return shouldQuit;
  }

  void _createEmployee() {
    _clearScreen();
    String fullName = _promptInput('Enter full name: ', Colors.green);
    String positionInput = _promptInput('Enter position (director/manager/engineer/handyman): ', Colors.green);
    String departmentName = _promptInput('Enter department name: ', Colors.green);

    try {
      Position position = _getPositionFromString(positionInput);
      Department department = Department(departmentName);
      var employee = Employee(fullName, position, department);
      _employees.add(employee);

      print('${Colors.yellow}Created Employee: ${employee.toString()}${Colors.reset}');
    } catch (e) {
      print('${Colors.red}Error: ${e.toString()}${Colors.reset}');
    }
    _waitForUser();
  }

  String _promptInput(String message, String color) {
    stdout.write('$color$message${Colors.reset}');
    return stdin.readLineSync() ?? '';
  }

  Position _getPositionFromString(String positionInput) {
    return Position.values.firstWhere(
      (e) => e.toString().split('.').last == positionInput.toLowerCase(),
      orElse: () => throw Exception('Invalid position')
    );
  }

  void _displayEmployees() {
    _clearScreen();
    if (_employees.isEmpty) {
      print('${Colors.magenta}No employees created yet.${Colors.reset}');
    } else {
      print('${Colors.magenta}Employees:${Colors.reset}');
      _employees.forEach((employee) => print('${Colors.yellow}$employee${Colors.reset}'));
    }
    _waitForUser();
  }

  void _showMenu() {
    print('${Colors.cyan}1. Create new employee${Colors.reset}');
    print('${Colors.cyan}2. Display all employees${Colors.reset}');
    print('${Colors.cyan}3. Quit${Colors.reset}');
  }

  void _waitForUser() {
    print('${Colors.white}\nPress any key to return to the main menu...${Colors.reset}');
    stdin.readLineSync();
  }

  void _clearScreen() {
    stdout.write(Platform.isWindows ? '\x1B[2J\x1B[0f' : '\x1B[2J\x1B[3J\x1B[H');
  }
}
