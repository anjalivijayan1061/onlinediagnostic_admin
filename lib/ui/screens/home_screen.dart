import 'package:flutter/material.dart';
import 'package:onlinediagnostic_admin/ui/screens/home_screen_sections/nurse_complaints_screen.dart';
import 'package:onlinediagnostic_admin/ui/screens/home_screen_sections/dashboard_screen.dart';
import 'package:onlinediagnostic_admin/ui/screens/home_screen_sections/feedbacks_screen.dart';
import 'package:onlinediagnostic_admin/ui/screens/home_screen_sections/nurse_management_section.dart';
import 'package:onlinediagnostic_admin/ui/screens/home_screen_sections/order_management_section.dart';
import 'package:onlinediagnostic_admin/ui/screens/home_screen_sections/patient_complaints.dart';
import 'package:onlinediagnostic_admin/ui/screens/home_screen_sections/test_management_section.dart';
import 'package:onlinediagnostic_admin/ui/screens/home_screen_sections/user_management_section.dart';
import 'package:onlinediagnostic_admin/ui/screens/login_screen.dart';
import 'package:onlinediagnostic_admin/ui/widgets/custom_alert_dialog.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    Future.delayed(
      const Duration(
        milliseconds: 100,
      ),
      () {
        if (Supabase.instance.client.auth.currentUser == null) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            (route) => true,
          );
        }
      },
    );

    tabController = TabController(
      length: 8,
      vsync: this,
      initialIndex: 0, //change the index to currently working section's index
    );
    super.initState();
  }

  String getName() {
    switch (tabController.index) {
      case 0:
        return 'Dashboard';
      case 1:
        return 'Order Management';
      case 2:
        return 'Test Management';
      case 3:
        return 'Nurse Management';
      case 4:
        return 'Patient Management';
      case 5:
        return 'Nurses Complaints';
      case 6:
        return 'Patients Complaints';
      case 7:
        return 'Suggestions';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF719BE1),
        centerTitle: true,
        title: Text(
          getName(),
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
        ),
        elevation: 5,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => CustomAlertDialog(
                  title: 'Logout',
                  message: 'Are you sure that you want to logout ?',
                  primaryButtonLabel: 'Logout',
                  primaryOnPressed: () async {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                      (route) => true,
                    );
                    await Supabase.instance.client.auth.signOut();
                  },
                  secondaryButtonLabel: 'Cancel',
                  secondaryOnPressed: () => Navigator.pop(context),
                ),
              );
            },
            icon: const Icon(
              Icons.logout_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: const [
          DashboardScreen(),
          OrderManagementSection(),
          TestManagementSection(),
          NurseManagmentSection(),
          UserManagementSection(),
          NurseComplaintsScreen(),
          PatientComplaintsScreen(),
          FeedbacksScreen(),
        ],
      ),
      drawer: Material(
        color: const Color(0xFF719BE1),
        child: SizedBox(
          width: 300,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "MENU",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white60,
                      ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomDrawerButton(
                  label: "Dashboard",
                  iconData: Icons.dashboard_outlined,
                  onPressed: () {
                    tabController.animateTo(0);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  isSelected: tabController.index == 0,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomDrawerButton(
                  label: "Order Management",
                  iconData: Icons.shopping_basket_outlined,
                  onPressed: () {
                    tabController.animateTo(1);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  isSelected: tabController.index == 1,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomDrawerButton(
                  label: "Test Management",
                  iconData: Icons.text_snippet_outlined,
                  onPressed: () {
                    tabController.animateTo(2);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  isSelected: tabController.index == 2,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomDrawerButton(
                  label: "Nurse Management",
                  iconData: Icons.local_hospital_outlined,
                  onPressed: () {
                    tabController.animateTo(3);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  isSelected: tabController.index == 3,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomDrawerButton(
                  label: "Patients Management",
                  iconData: Icons.sick_outlined,
                  onPressed: () {
                    tabController.animateTo(4);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  isSelected: tabController.index == 4,
                ),
                const SizedBox(
                  height: 15,
                ),
                DrawerButtonCollection(
                  icon: Icons.dangerous_outlined,
                  label: 'Complaints',
                  isActive: [5, 6].contains(tabController.index),
                  isExpanded: [5, 6].contains(tabController.index),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomDrawerButton(
                        label: "Nurses",
                        iconData: Icons.local_hospital_outlined,
                        onPressed: () {
                          tabController.animateTo(5);
                          setState(() {});
                          Navigator.pop(context);
                        },
                        isSelected: tabController.index == 5,
                      ),
                      const Divider(),
                      CustomDrawerButton(
                        label: "Patients",
                        iconData: Icons.sick_outlined,
                        onPressed: () {
                          tabController.animateTo(6);
                          setState(() {});
                          Navigator.pop(context);
                        },
                        isSelected: tabController.index == 6,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomDrawerButton(
                  label: "Suggestions",
                  iconData: Icons.feedback_outlined,
                  onPressed: () {
                    tabController.animateTo(7);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  isSelected: tabController.index == 7,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomDrawerButton extends StatelessWidget {
  final IconData iconData;
  final String label;
  final Function() onPressed;
  final bool isSelected;
  const CustomDrawerButton({
    Key? key,
    required this.iconData,
    required this.label,
    required this.onPressed,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? Colors.white : const Color(0xFF719BE1),
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.zero,
      //   side: BorderSide(
      //     color: Colors.white,
      //     width: 1,
      //   ),
      // ),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Row(
            children: [
              Icon(
                iconData,
                color: isSelected ? const Color(0xFF719BE1) : Colors.white,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                label,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color:
                          isSelected ? const Color(0xFF719BE1) : Colors.white,
                      fontWeight:
                          isSelected ? FontWeight.w500 : FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerButtonCollection extends StatefulWidget {
  final Widget child;
  final IconData icon;
  final String label;
  final bool isExpanded, isActive;
  const DrawerButtonCollection({
    Key? key,
    required this.child,
    required this.icon,
    required this.label,
    this.isExpanded = false,
    this.isActive = false,
  }) : super(key: key);

  @override
  State<DrawerButtonCollection> createState() => _DrawerButtonCollectionState();
}

class _DrawerButtonCollectionState extends State<DrawerButtonCollection> {
  bool _isExpanded = false;

  @override
  void initState() {
    _isExpanded = widget.isExpanded;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 100),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Material(
            color: widget.isActive ? Colors.white : const Color(0xFF719BE1),
            child: InkWell(
              borderRadius: BorderRadius.circular(0),
              onTap: () {
                _isExpanded = !_isExpanded;
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Icon(
                      widget.icon,
                      size: 25,
                      color: widget.isActive
                          ? const Color(0xFF719BE1)
                          : Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        widget.label,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: widget.isActive
                                      ? const Color(0xFF719BE1)
                                      : Colors.white,
                                  fontWeight: widget.isActive
                                      ? FontWeight.w500
                                      : FontWeight.w500,
                                ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Icon(
                      _isExpanded
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      color: widget.isActive
                          ? const Color(0xFF719BE1)
                          : Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
          _isExpanded
              ? Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                  ),
                  child: widget.child,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
