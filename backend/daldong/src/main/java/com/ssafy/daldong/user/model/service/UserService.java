package com.ssafy.daldong.user.model.service;


import com.google.firebase.auth.FirebaseAuthException;
import com.ssafy.daldong.user.model.dto.UserDetailDTO;
import com.ssafy.daldong.user.model.dto.UserJoinDTO;
import com.ssafy.daldong.user.model.dto.UserLoginDTO;
import com.ssafy.daldong.user.model.dto.UserUpdateDTO;

import javax.transaction.Transactional;

public interface UserService {
 UserLoginDTO login(String address, String fcm) throws FirebaseAuthException;


 void updateUser(long uid, UserUpdateDTO userUpdateDTO);

 Boolean updateNickname(long uid, String nickname);

 @Transactional
 void saveRefreshToken( String principal, String refreshToken);

 void join(String uid,UserJoinDTO userJoinDTO);

 Boolean nameCheck(String nickname);

 UserDetailDTO mypage(long uid);

 String getUid(String idToken) throws FirebaseAuthException;

 void logout(long uid);
}
