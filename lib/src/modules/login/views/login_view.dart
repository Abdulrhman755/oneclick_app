import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_click/src/shared/constants/app_colors.dart';
import '../controllers/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginController controller = Get.find<LoginController>();

  final FocusNode _companyPhoneFocus = FocusNode();
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _companyPhoneFocus.addListener(() => setState(() {}));
    _usernameFocus.addListener(() => setState(() {}));
    _passwordFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _companyPhoneFocus.dispose();
    _usernameFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    // ثوابت ألوان مريحة
    const Color primaryBlue = Color(0xFF1E6FD8); // لون تركيز/أيقونات
    const Color gradientTop = Color(0xFFEAF6FF); // خلفية فاتحة من فوق
    const Color gradientMid = Color(0xFFD9EEFF);
    const Color gradientBottom = Color(0xFFBEE6FF); // أعمق قليلاً في الأسفل
    const Color cardShadowLight = Color(0x14000000); // ظل خفيف
    const Color cardShadowStrong = Color(0x1F000000); // ظل أقوى عند الفوكس
    const Color titleColor = Color(0xFF0F3B6F); // لون العنوان (متوافق مع الخلفية الفاتحة)
    const Color subtitleColor = Color(0xFF405C76); // لون النص الثانوي

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              gradientTop,
              gradientMid,
              gradientBottom,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 28),
            child: AnimatedPadding(
              duration: const Duration(milliseconds: 220),
              padding: EdgeInsets.only(bottom: bottomInset),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // لوجو متحرك خفيف
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.92, end: 1.0),
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOutBack,
                    builder: (context, scale, child) {
                      return Transform.scale(
                        scale: scale,
                        child: child,
                      );
                    },
                    child: Hero(
                      tag: 'app_logo',
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 92,
                        width: 92,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // ترحيب مركزي - محسّن
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        'مرحبا بعودتك إلى لوحة التحكم',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Calibri',
                          letterSpacing: 0.2,
                          color: titleColor,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'سجل دخولك للبدء في إدارة حسابك',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Calibri',
                          color: subtitleColor,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),

                  // بطاقة الحقول (محددة بعرض أقصى)
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 520),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 22),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: cardShadowLight,
                            blurRadius: 28,
                            offset: const Offset(0, 14),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _fieldWrapper(
                            focusNode: _companyPhoneFocus,
                            focusedShadowColor: cardShadowStrong,
                            child: _buildBorderedTextField(
                              controller: controller.companyPhoneController,
                              hint: 'رقم هاتف الشركة',
                              icon: Icons.phone_android_rounded,
                              keyboardType: TextInputType.phone,
                              focusNode: _companyPhoneFocus,
                              primaryColor: primaryBlue,
                            ),
                          ),

                          const SizedBox(height: 12),

                          _fieldWrapper(
                            focusNode: _usernameFocus,
                            focusedShadowColor: cardShadowStrong,
                            child: _buildBorderedTextField(
                              controller: controller.usernameController,
                              hint: 'اسم المستخدم',
                              icon: Icons.person_rounded,
                              focusNode: _usernameFocus,
                              primaryColor: primaryBlue,
                            ),
                          ),

                          const SizedBox(height: 12),

                          _fieldWrapper(
                            focusNode: _passwordFocus,
                            focusedShadowColor: cardShadowStrong,
                            child: Obx(() => _buildBorderedTextField(
                                  controller: controller.passwordController,
                                  hint: 'كلمة المرور',
                                  icon: Icons.lock_rounded,
                                  obscureText: controller.isPasswordHidden.value,
                                  focusNode: _passwordFocus,
                                  primaryColor: primaryBlue,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      controller.isPasswordHidden.value
                                          ? Icons.visibility_off_rounded
                                          : Icons.visibility_rounded,
                                      color: Colors.grey.shade600,
                                      size: 22,
                                    ),
                                    onPressed: controller.togglePasswordVisibility,
                                  ),
                                )),
                          ),

                          const SizedBox(height: 18),

                          Obx(() {
                            if (controller.isLoading.value) {
                              return const SizedBox(
                                  height: 48, child: Center(child: CircularProgressIndicator()));
                            } else {
                              return SizedBox(
                                height: 52,
                                child: ElevatedButton(
                                  onPressed: controller.login,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryBlue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 6,
                                  ),
                                  child: const Text(
                                    'تسجيل الدخول',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'Calibri',
                                    ),
                                  ),
                                ),
                              );
                            }
                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // يلف الحقول ليعطي تأثير رفع وظل عند التركيز
  Widget _fieldWrapper({
    required FocusNode focusNode,
    required Widget child,
    Color focusedShadowColor = const Color(0x1F000000),
  }) {
    final bool focused = focusNode.hasFocus;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      transform: Matrix4.translationValues(0, focused ? -10 : 0, 0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: focused ? focusedShadowColor : const Color(0x08000000),
            blurRadius: focused ? 18 : 6,
            offset: Offset(0, focused ? 10 : 4),
          ),
        ],
      ),
      child: child,
    );
  }

  // دالة مساعدة لحقل الإدخال (تدعم فوكاس و label floating)
  Widget _buildBorderedTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
    FocusNode? focusNode,
    Color primaryColor = const Color(0xFF1E6FD8),
  }) {
    final bool focused = focusNode?.hasFocus ?? false;

    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      textAlign: TextAlign.right,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(
        fontFamily: 'Calibri',
        fontWeight: FontWeight.w600,
        fontSize: 15,
        color: Color(0xFF1E293B),
      ),
      decoration: InputDecoration(
        labelText: hint,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelStyle: TextStyle(
          fontFamily: 'Calibri',
          color: focused ? primaryColor : Colors.grey.shade700,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        hintText: null,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 4.0),
          child: Icon(icon, color: primaryColor, size: 22),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 48, minHeight: 48),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white,
        isDense: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: primaryColor,
            width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 1.0),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
      ),
    );
  }
}
