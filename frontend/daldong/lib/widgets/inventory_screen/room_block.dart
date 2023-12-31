import 'package:daldong/services/inventory_api.dart';
import 'package:daldong/utilites/common/common_util.dart';
import 'package:flutter/material.dart';

class RoomBlock extends StatefulWidget {
  final dynamic roomInfo;
  final int mainRoomId;
  final int userPoint;
  final void Function(String, int) changeMainItem;
  final void Function(String, int) buySelectItem;

  const RoomBlock({
    required this.roomInfo,
    required this.mainRoomId,
    required this.userPoint,
    required this.changeMainItem,
    required this.buySelectItem,
    Key? key,
  }) : super(key: key);

  @override
  State<RoomBlock> createState() => _RoomBlockState();
}

class _RoomBlockState extends State<RoomBlock> {
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 14,
      ),
      child: Container(
        width: 160,
        height: 200,
        decoration: BoxDecoration(
          color: Theme.of(context).disabledColor,
          borderRadius: BorderRadius.circular(10),
          // border: Border.all(
          //   color: Theme.of(context).primaryColorDark,
          //   width: 1,
          // ),
          boxShadow: [
            widget.mainRoomId == widget.roomInfo['assetId']
                ? BoxShadow(
                    color: Theme.of(context).primaryColorDark,
                    spreadRadius: 0.5,
                    blurRadius: 16,
                  )
                : BoxShadow(
                    color: Colors.black45,
                    spreadRadius: 0.3,
                    blurRadius: 4,
                  ),
          ],
        ),
        child: Column(
          children: [
            Stack(
              children: [
                widget.roomInfo['assetStatus'] != 0
                    ? Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fitHeight,
                            image: AssetImage(
                              'lib/assets/images/rooms/${widget.roomInfo['assetName']}.png',
                            ),
                          ),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0),
                          ),
                        ),
                      )
                    : Container(),
                widget.roomInfo['assetStatus'] != 2
                    ? Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0),
                          ),
                        ),
                      )
                    : Container(),
                Container(
                  width: 160,
                  height: 160,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(
                                  widget.roomInfo['assetStatus'] != 2
                                      ? 0.0
                                      : 0.0,
                                ),
                                borderRadius: BorderRadius.circular(
                                  20,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 4,
                                  horizontal: 4,
                                ),
                                child: Text(
                                  widget.roomInfo['assetStatus'] != 2
                                      ? widget.roomInfo['assetKRName']
                                      : widget.roomInfo['assetKRName'],
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: widget.roomInfo['assetStatus'] != 2
                                        ? Colors.white
                                        : Colors.black.withOpacity(0),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(),
                        ],
                      ),
                      // SizedBox(height: 10,),
                      widget.roomInfo['assetStatus'] != 2
                          ? Center(
                              child: Container(
                                width: 76,
                                height: 28,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(
                                      20,
                                    ),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    )),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 4,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      widget.roomInfo['assetStatus'] == 0
                                          ? Icon(
                                              Icons.lock,
                                              color: Colors.white,
                                              size: 14,
                                            )
                                          : Container(
                                              height: 10,
                                              width: 5,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                      SizedBox(
                                        width:
                                            widget.roomInfo['assetStatus'] == 1
                                                ? 5
                                                : 4,
                                      ),
                                      Text(
                                        widget.roomInfo['assetStatus'] == 0
                                            ? 'LV.${widget.roomInfo['assetUnlockLevel']}'
                                            : '${widget.roomInfo['assetPrice']} PT',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color:
                                              widget.roomInfo['assetStatus'] !=
                                                      2
                                                  ? Colors.white
                                                  : Colors.black,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      widget.roomInfo['assetStatus'] == 2
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 76,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.75),
                                    borderRadius: BorderRadius.circular(
                                      20,
                                    ),
                                    // border: Border.all(color: Colors.white, width: 2,)
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 4,
                                      horizontal: 4,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // Icon(Icons.lock, color: Colors.white, size: 14,),
                                        // SizedBox(
                                        //   width: 2,
                                        // ),
                                        Text(
                                          widget.roomInfo['assetKRName'],
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              height: 18,
                            ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  if (widget.roomInfo['assetStatus'] == 2) {
                    if (widget.mainRoomId != widget.roomInfo['assetId']) {
                      putChangeMainAsset(
                          success: (dynamic response) {
                            widget.changeMainItem(
                                'room', widget.roomInfo['assetId']);
                            print('에셋 변경 완료');
                          },
                          fail: (error) {
                            print('메인 에셋 변경 에러: $error');
                          },
                          body: {"assetId": widget.roomInfo['assetId']});
                    }
                  } else if (widget.roomInfo['assetStatus'] == 1) {
                    if (widget.userPoint >= widget.roomInfo['assetPrice']) {
                      postBuyAsset(
                          success: (dynamic response) {
                            widget.buySelectItem(
                                'room', widget.roomInfo['assetId']);
                            print('에셋 구매 완료');
                          },
                          fail: (error) {
                            print('에셋 구매 에러: $error');
                          },
                          body: {"assetId": widget.roomInfo['assetId']});
                    } else {
                      showInfoDialog(context, '포인트 부족', '포인트 부족으로 구매가 불가능합니다.', '확인');
                    }
                  }
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: widget.roomInfo['assetStatus'] != 0
                        ? widget.roomInfo['assetStatus'] == 2
                            ? widget.mainRoomId == widget.roomInfo['assetId']
                                ? Colors.redAccent
                                : Theme.of(context).primaryColorDark
                            : Color(0xFFFFA500)
                        : Colors.black,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.roomInfo['assetStatus'] != 0
                            ? widget.roomInfo['assetStatus'] == 2
                                ? widget.mainRoomId ==
                                        widget.roomInfo['assetId']
                                    ? '선택중'
                                    : '선택하기'
                                : '구매하기'
                            : '구매불가',
                        style: TextStyle(
                          color: (widget.roomInfo['assetStatus'] == 2 &&
                                  widget.mainRoomId !=
                                      widget.roomInfo['assetId'])
                              ? Colors.white
                              : Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
