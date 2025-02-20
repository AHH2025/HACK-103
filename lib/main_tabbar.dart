import 'package:complaint_manager/profile_screen.dart';
import 'package:complaint_manager/register_complaint_form.dart';
import 'package:complaint_manager/user_home_page.dart';
import 'package:flutter/material.dart';

class MainTabbar extends StatefulWidget {
  const MainTabbar({super.key});

  @override
  State<MainTabbar> createState() => _MainTabbarState();
}

/// [AnimationController]s can be created with `vsync: this` because of
/// [TickerProviderStateMixin].
class _MainTabbarState extends State<MainTabbar> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(
      () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: TabBar(
        controller: _tabController,
        tabs: const <Widget>[
          Tab(icon: Icon(Icons.home)),
          Tab(icon: Icon(Icons.add)),
          Tab(icon: Icon(Icons.person)),
        ],
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: <Widget>[
            UserHomePage(
              onPageChanged: (p0) {
                _tabController.animateTo(1);
              },
            ),
            RegisterComplaintForm(
              onPageChanged: (p0) {
                _tabController.animateTo(0);
              },
            ),
            ProfileScreen(),
          ],
        ),
      ),
    );
  }
}
