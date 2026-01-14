import 'package:chat_app/modal/chat_litst_item.dart';
import 'package:chat_app/provider/providers.dart';
import 'package:chat_app/provider/socket_providers.dart';
import 'package:chat_app/services/socket_client.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:chat_app/widgets/app_text.dart';
import 'package:chat_app/widgets/homescreen/chat_list.dart';
import 'package:chat_app/widgets/homescreen/group_list.dart';
import 'package:chat_app/widgets/homescreen/homepage_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomepageScreen extends ConsumerStatefulWidget {
  const HomepageScreen({super.key});

  @override
  ConsumerState<HomepageScreen> createState() {
    return _HomepageScreenState();
  }
}

class _HomepageScreenState extends ConsumerState<HomepageScreen> {
  final PageController pageViewController = PageController();
  late final ProviderSubscription<AuthenticatedState> _authSub;
  late final SocketClient _socket;
  List<ChatListItem> chatListItems = [];

  int selectedTab = 0;
  bool _socketConnected = false;

  @override
  void initState() {
    super.initState();
    _socket = ref.read(socketStateProvider);
    Future.microtask(() async {
      final result = await ref.read(verifySessionProvider.future);
      ref.read(authStateProvider.notifier).state = result;
    });

    _authSub = ref.listenManual<AuthenticatedState>(authStateProvider, (
      prev,
      next,
    ) async {
      if (next == AuthenticatedState.authenticated && !_socketConnected) {
        final storage = ref.read(secureStorageProvider);
        final token = await storage.getData(key: "accessToken");

        if (token == null || token.isEmpty) return;

        _socketConnected = true;
        await _socket.createSocketConnection(token);
        _socket.invitedToRoom(
          onInvitation: (data) {
            setState(() {
              chatListItems.add(
                ChatListItem(
                  name: data.name,
                  profilePic: NetworkImage(data.userMainImageUrl),
                  roomId: data.roomId,
                ),
              );
            });
          },
        );
      }

      if (next == AuthenticatedState.unauthenticated) {
        _socketConnected = false;
      }
    });
  }

  @override
  void dispose() {
    _authSub.close();
    pageViewController.dispose();
    _socket.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void openSearchUserScreen() {
      Navigator.of(context).pushNamed('/search-user');
    }

    return Scaffold(
      floatingActionButton: Transform.translate(
        offset: const Offset(-10, 0),
        child: FloatingActionButton(
          onPressed: openSearchUserScreen,
          backgroundColor: AppColors.textMediumColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Image.asset("assets/icons/message-icon.png"),
        ),
      ),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
        title: Transform.translate(
          offset: const Offset(20, 0),
          child: const AppText(
            "Chatx",
            color: AppColors.textMediumColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),

        actions: [
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 32),
            child: Row(
              children: [
                const Icon(Icons.search_sharp, size: 25),
                const SizedBox(width: 10),
                const Icon(Icons.settings_outlined, size: 25),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 32),
        child: Column(
          children: [
            const SizedBox(height: 20),
            HomepageNavigationBar(
              selectedTab: selectedTab,
              onTabChanged: (index) {
                setState(() {
                  selectedTab = index;
                  pageViewController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeInOut,
                  );
                });
              },
            ),
            Expanded(
              child: PageView(
                controller: pageViewController,

                onPageChanged: (value) {
                  setState(() {
                    selectedTab = value;
                  });
                },
                children: [
                  ChatList(items: chatListItems),
                  GroupList(items: chatListItems),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
