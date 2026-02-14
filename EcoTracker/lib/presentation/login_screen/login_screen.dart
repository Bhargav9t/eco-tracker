import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../core/data/mock_database.dart';
import '../../theme/app_theme.dart';
import '../../widgets/visual_effects.dart';
import '../../routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void _handleLogin() async {
    setState(() => _isLoading = true);
    await Future.delayed(Duration(seconds: 1)); // Simulate network
    await MockDatabase().login();
    if (mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.mainContainerScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.ecoGreen,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(6.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeInSlide(
                offset: -50,
                child: Container(
                  padding: EdgeInsets.all(5.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.eco, size: 40.sp, color: AppTheme.ecoGreen),
                ),
              ),
              SizedBox(height: 4.h),
              FadeInSlide(
                delay: Duration(milliseconds: 200),
                child: Text(
                  'Eco-Tracker',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Colors.white,
                    fontSize: 28.sp,
                  ),
                ),
              ),
              SizedBox(height: 6.h),
              FadeInSlide(
                delay: Duration(milliseconds: 400),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: EdgeInsets.all(6.w),
                    child: Column(
                      children: [
                        TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            prefixIcon: Icon(Icons.person_outline),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                        SizedBox(height: 2.h),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock_outline),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        SizedBox(
                          width: double.infinity,
                          child: BouncyWrapper(
                            onTap: _handleLogin,
                            child: ElevatedButton(
                              onPressed: _handleLogin,
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 2.h),
                                backgroundColor: AppTheme.ecoGreen,
                                foregroundColor: Colors.white,
                              ),
                              child: _isLoading
                                  ? CircularProgressIndicator(color: Colors.white)
                                  : Text('Login', style: TextStyle(fontSize: 14.sp)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
