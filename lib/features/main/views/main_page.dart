import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kars_driver_app/core/notification/notification_client.dart';
import 'package:kars_driver_app/features/main/main.dart';
import 'package:kars_driver_app/features/orders/detail/detail_order.dart';
import 'package:kars_driver_app/gen/colors.gen.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    required this.navigationShell,
    required this.children,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FeatureTabBarCubit(),
      child: _MainView(
        navigationShell: navigationShell,
        children: children,
      ),
    );
  }
}

class _MainView extends StatefulWidget {
  const _MainView({required this.navigationShell, required this.children});

  final StatefulNavigationShell navigationShell;

  final List<Widget> children;

  @override
  State<_MainView> createState() => _MainViewState();
}

class _MainViewState extends State<_MainView> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: widget.navigationShell.currentIndex,
    );

    // Redirect jika app diluncurkan dari notifikasi (terminated state)
    FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (value != null) {
        _onRedirectNotification(value);
      }
    });

    // Foreground: tampilkan local notification
    FirebaseMessaging.onMessage.listen((event) async {
      await NotificationClient.displayNotifications(event);
    });

    // Background->Foreground: klik notifikasi sistem
    FirebaseMessaging.onMessageOpenedApp.listen(_onRedirectNotification);

    // Foreground: klik local notification
    // Ubah pemanggilan: gunakan setter, bukan method
    NotificationClient.onNotificationTap = (data) {
      final id = data['uuid'] ?? data['order_id'] ?? data['id'];
      if (id is String && id.isNotEmpty) {
        context.pushNamed(
          'order-detail',
          extra: DetailOrderExtra(orderId: id, isView: true),
        );
      } else {
        context.pushNamed('notification');
      }
    };
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainListener(
      navigationShell: widget.navigationShell,
      child: Scaffold(
        body: SafeArea(
          child: Scaffold(
            backgroundColor: ColorName.cultured,
            body: Column(
              children: [
                const SizedBox(height: 16),
                const UserInformationHeader(),
                const SizedBox(height: 16),
                FeatureTabBar(
                  _pageController,
                  navigationShell: widget.navigationShell,
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: PageView(
                    physics: const BouncingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (index) {
                      final cubit = context.read<FeatureTabBarCubit>();
                      cubit.onPageChanged(index);
                    },
                    children: widget.children,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onRedirectNotification(RemoteMessage message) {
    // Klik notifikasi sistem (FCM), parse data untuk order id
    final data = message.data;
    final id = data['uuid'] ?? data['order_id'] ?? data['id'];
    if (id is String && id.isNotEmpty) {
      context.pushNamed(
        'order-detail',
        extra: DetailOrderExtra(orderId: id, isView: true),
      );
    } else {
      context.pushNamed('notification');
    }
  }
}
