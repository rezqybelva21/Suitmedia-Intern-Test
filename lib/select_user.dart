import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'controllers/user_controller.dart';

class SelectUser extends StatelessWidget {

  final UserController userController = Get.find<UserController>();

  Future<List<dynamic>> fetchUsers() async {
    final response = await http.get(
      Uri.parse('http://reqres.in/api/users?page=1'),
      headers: {
        'Authorization': 'Bearer reqres-free-v1'
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select User',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.blue),
        centerTitle: true,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchUsers(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(color: Colors.red),
              ));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No User Found.'));
          }

          final users = snapshot.data!;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user['avatar']),
                ),
                title: Text(
                  '${user['first_name']} ${user['last_name']}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(user['email']),
                onTap: () {
                  userController.setUser(
                    '${user['first_name']} ${user['last_name']}',
                    user['email'],
                    user['avatar'],
                  );
                  Get.back();
                }
              );
            }
          );
        }
      )
    );
  }
}