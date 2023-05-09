import 'package:daldong/screens/friend_screen/friend_received_screen.dart';
import 'package:daldong/screens/friend_screen/friend_search_screen.dart';
import 'package:daldong/screens/friend_screen/friend_send_screen.dart';
import 'package:daldong/widgets/friend_screen/other_user_block.dart';
import 'package:flutter/material.dart';

// 일정 상세보기 (수정, 삭제 기능 추가하기)
void showDetailCalender(
    int id, String title, String memo, bool auto, BuildContext context) {
  FocusNode unUsedFocusNode = FocusNode();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        // backgroundColor: Theme.of(context).primaryColorLight,
        backgroundColor: Colors.white,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.all(4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: DefaultTabController(
                    length: 3,
                    child: Scaffold(
                      appBar: AppBar(
                        elevation: 0,
                        toolbarOpacity: 0,
                        foregroundColor: Colors.transparent,
                        surfaceTintColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        toolbarHeight: 1,
                        // backgroundColor: Theme.of(context).primaryColorLight,
                        backgroundColor: Colors.white,
                        bottom: TabBar(
                          labelColor: Theme.of(context).primaryColorDark,
                          unselectedLabelColor: Theme.of(context).disabledColor,
                          indicatorColor: Theme.of(context).primaryColorDark,
                          indicatorWeight: 3,
                          tabs: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                              ),
                              child: const Text(
                                "유저 검색",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                              ),
                              child: const Text(
                                "받은 요청",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                              ),
                              child: const Text(
                                "보낸 요청",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      body: TabBarView(
                        children: [
                          FriendSearchScreen(unUsedFocusNode: unUsedFocusNode),
                          FriendReceivedScreen(),
                          FriendSendScreen(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () => {
                  Navigator.pop(context),
                },
                splashColor: Colors.transparent,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Theme.of(context).primaryColorDark,
                  child: Icon(
                    Icons.highlight_remove_outlined,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
