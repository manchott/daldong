import 'package:daldong/services/inventory_api.dart';
import 'package:daldong/utilites/common/common_util.dart';
import 'package:daldong/utilites/inventory_screen/inventory_util.dart';
import 'package:flutter/material.dart';

class PetBlock extends StatefulWidget {
  final dynamic petInfo;
  final int mainPetId;
  final int userPoint;
  final void Function(String, int) changeMainItem;
  final void Function(String, int) buySelectItem;
  final void Function(String, int) changeAssetName;

  const PetBlock({
    required this.petInfo,
    required this.mainPetId,
    required this.userPoint,
    required this.changeMainItem,
    required this.buySelectItem,
    required this.changeAssetName,
    Key? key,
  }) : super(key: key);

  @override
  State<PetBlock> createState() => _PetBlockState();
}

class _PetBlockState extends State<PetBlock> {
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Container(
        width: 100,
        height: 140,
        decoration: BoxDecoration(
          color: Theme.of(context).disabledColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            widget.mainPetId == widget.petInfo['assetId']
                ? BoxShadow(
                    color: Theme.of(context).primaryColorDark,
                    spreadRadius: 0.5,
                    blurRadius: 14,
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
                widget.petInfo['assetStatus'] != 0
                    ? Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fitHeight,
                            image: AssetImage(
                              'lib/assets/images/animals/${widget.petInfo['assetName']}.png',
                            ),
                          ),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0),
                          ),
                        ),
                      )
                    : Container(),
                widget.petInfo['assetStatus'] != 2
                    ? Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0),
                          ),
                        ),
                      )
                    : Container(),
                InkWell(
                  onTap: () {
                    widget.petInfo['assetStatus'] == 2
                        ? showDetailPet(
                            context,
                            widget.petInfo,
                            widget.changeAssetName,
                          )
                        : null;
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(
                                    widget.petInfo['assetStatus'] != 2
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
                                    widget.petInfo['assetKRName'],
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: widget.petInfo['assetStatus'] != 2
                                          ? Colors.white
                                          : Colors.black.withOpacity(0.75),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            widget.petInfo['assetStatus'] == 2
                                ? Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: InkWell(
                                      child: Icon(
                                        Icons.info,
                                        size: 20,
                                        color: Colors.black.withOpacity(
                                          0.8,
                                        ),
                                      ),
                                      onTap: () {
                                        showDetailPet(
                                          context,
                                          widget.petInfo,
                                          widget.changeAssetName,
                                        );
                                      },
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                        // SizedBox(height: 10,),
                        widget.petInfo['assetStatus'] != 2
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
                                    ),
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
                                        widget.petInfo['assetStatus'] == 0
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
                                              widget.petInfo['assetStatus'] == 1
                                                  ? 5
                                                  : 4,
                                        ),
                                        Text(
                                          widget.petInfo['assetStatus'] == 0
                                              ? 'LV.${widget.petInfo['assetUnlockLevel']}'
                                              : '${widget.petInfo['assetPrice']} PT',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color:
                                                widget.petInfo['assetStatus'] !=
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
                        widget.petInfo['assetStatus'] == 2
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
                                            widget.petInfo['assetCustomName'],
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
                ),
              ],
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  if (widget.petInfo['assetStatus'] == 2) {
                    if (widget.mainPetId != widget.petInfo['assetId']) {
                      putChangeMainAsset(
                          success: (dynamic response) {
                            widget.changeMainItem(
                                'pet', widget.petInfo['assetId']);
                            print('에셋 변경 완료');
                          },
                          fail: (error) {
                            print('메인 에셋 변경 에러: $error');
                          },
                          body: {'assetId': widget.petInfo['assetId']});
                    }
                  } else if (widget.petInfo['assetStatus'] == 1) {
                    if (widget.userPoint >= widget.petInfo['assetPrice']) {
                      postBuyAsset(
                          success: (dynamic response) {
                            widget.buySelectItem(
                                'pet', widget.petInfo['assetId']);
                            print('에셋 구매 완료');
                          },
                          fail: (error) {
                            print('에셋 구매 에러: $error');
                          },
                          body: {'assetId': widget.petInfo['assetId']});
                    } else {
                      showInfoDialog(context, '포인트 부족', '포인트 부족으로 구매가 불가능합니다.', '확인');
                    }
                  }
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: widget.petInfo['assetStatus'] != 0
                        ? widget.petInfo['assetStatus'] == 2
                            ? widget.mainPetId == widget.petInfo['assetId']
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
                        widget.petInfo['assetStatus'] != 0
                            ? widget.petInfo['assetStatus'] == 2
                                ? widget.mainPetId == widget.petInfo['assetId']
                                    ? '선택중'
                                    : '선택하기'
                                : '구매하기'
                            : '구매불가',
                        style: TextStyle(
                          color: (widget.petInfo['assetStatus'] == 2 &&
                                  widget.mainPetId == widget.petInfo['assetId'])
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
