import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SafetyReport {
  final String issueType;
  final String location;
  final String description;
  final String severity;
  final String workerId;
  String status;

  SafetyReport({
    required this.issueType,
    required this.location,
    required this.description,
    required this.severity,
    required this.workerId,
    this.status = 'Pending',
  });
}

class UserProfile {
  final String fullName;
  final String userId;
  final String password;
  final String mobile;
  final String email;
  final String department;
  final String mine;
  final String role;

  UserProfile({
    required this.fullName,
    required this.userId,
    required this.password,
    required this.mobile,
    required this.email,
    required this.department,
    required this.mine,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'userId': userId,
      'password': password,
      'mobile': mobile,
      'email': email,
      'department': department,
      'mine': mine,
      'role': role,
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      fullName: json['fullName'] ?? '',
      userId: json['userId'] ?? '',
      password: json['password'] ?? '',
      mobile: json['mobile'] ?? '',
      email: json['email'] ?? '',
      department: json['department'] ?? '',
      mine: json['mine'] ?? '',
      role: json['role'] ?? '',
    );
  }
}

class AppData {
  static UserProfile? currentUser;

  static final List<SafetyReport> safetyReports = [];

  static final Map<String, UserProfile> users = {};

  static const String _usersKey = 'khanan_setu_users';

  // Load saved users when app starts
  static Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();

    final savedUsers = prefs.getString(_usersKey);

    if (savedUsers == null || savedUsers.isEmpty) {
      return;
    }

    try {
      final List<dynamic> decoded = jsonDecode(savedUsers);

      users.clear();

      for (final item in decoded) {
        final user = UserProfile.fromJson(
          Map<String, dynamic>.from(item),
        );

        users[user.userId] = user;
      }
    } catch (e) {
      // If saved data is damaged, keep app running.
      users.clear();
    }
  }

  // Save user permanently
  static Future<void> saveUser(UserProfile user) async {
    users[user.userId] = user;

    final prefs = await SharedPreferences.getInstance();

    final userList = users.values
        .map((user) => user.toJson())
        .toList();

    await prefs.setString(
      _usersKey,
      jsonEncode(userList),
    );
  }

  static UserProfile? getUser(String userId) {
    return users[userId];
  }

  static bool userExists(String userId) {
    return users.containsKey(userId);
  }

  static bool validateLogin(
    String userId,
    String password,
  ) {
    final user = users[userId];

    if (user == null) {
      return false;
    }

    return user.password == password;
  }
}