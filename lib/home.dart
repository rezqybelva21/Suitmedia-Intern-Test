import 'package:flutter/material.dart';
import 'controllers/user_controller.dart';
import 'welcome_page.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final UserController userController = Get.find<UserController>();
  final TextEditingController palindromeController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
                'asset/background.png',
                fit: BoxFit.cover),
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    child: Icon(
                      Icons.person_add,
                      size: 40,
                      color: Colors.white,
                    )
                  ),
                  SizedBox(height: 80),

                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: "Name",
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      )
                    ),
                  ),
                  SizedBox(height: 15),

                  TextField(
                    controller: palindromeController,
                    decoration: InputDecoration(
                      hintText: "Palindrome",
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () {
                      String text = palindromeController.text;
                      String normalized = text
                        .toLowerCase()
                        .replaceAll(RegExp(r'[^a-z]'), '');
                      String reversed = normalized.split('').reversed.join();
                      bool isPalindrome = normalized == reversed;

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                              isPalindrome ? "It's a palindrome!" : "Not a palindrome.",
                            ),
                        ),
                      );
                    },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          backgroundColor: Color(0xFF2D7F9D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )
                        ),
                        child: Text(
                            "CHECK",
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                    ),
                  ),
                  SizedBox(height: 15),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          String name = nameController.text;
                          if (name.isEmpty) {
                            Get.snackbar(
                              "Error",
                              "Name field cannot be empty!",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.redAccent,
                              colorText: Colors.white,
                            );
                          } else {
                            userController.setUser(name, '', '');
                          }

                          Get.to(() => WelcomePage());
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          backgroundColor: Color(0xFF2D7F9D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                            "NEXT",
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                            ),
                        )
                    ),
                  ),
                ],
              )
            )
          )
        ]
      )
    );
  }
}