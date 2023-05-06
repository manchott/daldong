package com.ssafy.daldong.friend.service;

import com.ssafy.daldong.friend.model.dto.FriendDto;
import com.ssafy.daldong.friend.model.entity.Friend;
import com.ssafy.daldong.friend.model.repository.FriendRepository;
import com.ssafy.daldong.user.model.entity.User;
import com.ssafy.daldong.user.model.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Slf4j
@Service
@RequiredArgsConstructor
public class FriendServiceImpl implements FriendService{

    private final FriendRepository friendRepository;
    private final UserRepository userRepository;

    @Override
    public void createFriend(long userId, long friendId) {
        friendRepository.save(Friend.builder().user(userRepository.getReferenceById(userId)).friend(userRepository.getReferenceById(friendId)).build());
        friendRepository.save(Friend.builder().user(userRepository.getReferenceById(friendId)).friend(userRepository.getReferenceById(userId)).build());
    }

    @Override
    @Transactional(readOnly = true)
    public List<FriendDto> getFriendList(long userId) {
        log.info("whattttttttt");
        List<Friend> friends = friendRepository.findAllByUser_UserId(userId);
        List<FriendDto> friendsDto = new ArrayList<>();
        for (Friend friend : friends) {
            User friendUser = friend.getFriend();
            FriendDto friendDto = FriendDto.builder()
                    .friendId(friendUser.getUserId())
                    .friendNickname(friendUser.getNickname())
                    .friendUserLevel(friendUser.getUserLevel())
                    .mainPetAssetName(friendUser.getMainPet().getAssetName())
                    .isSting(friend.isSting())
                    .build();
            friendsDto.add(friendDto);
        }
        log.info("[getFriendList] : 친구 목록 가져오기 완료, userId : {}", userId);
        return friendsDto;
    }

    @Override
    public boolean isFriend(long userId, long friendId) {
        return friendRepository.existsByUser_UserIdAndFriend_UserId(userId, friendId);
    }

//    @Override
//    public FriendDto getFriend(long userId, long friendId) {
//
//        return null;
//    }

    @Override
    @Transactional
    public void updateFriend(long userId, long friendId) {

        Optional<Friend> optionalFriendship = friendRepository.findByUser_UserIdAndFriend_UserId(userId, friendId);
        if (optionalFriendship.isEmpty()){
            return;
        }
        Friend friendship = optionalFriendship.get();
        if (friendship.isSting()){
            return;
        }
        friendship.updateFriend();
        log.info("[stingFriend] : 친구 찌르기 성공, userId : {}, friendId : {}", userId, friendId);

    }

    @Override
    @Transactional
    public boolean deleteFriend(long userId, long friendId) {
        if(userId == friendId){
            throw new IllegalStateException("same user");
        }
        Optional<Friend> optionalFriendship1 = friendRepository.findByUser_UserIdAndFriend_UserId(userId, friendId);
        Optional<Friend> optionalFriendship2 = friendRepository.findByUser_UserIdAndFriend_UserId(friendId, userId);
        log.info("getit {} {}", optionalFriendship1.toString(), optionalFriendship2.toString());
        if (optionalFriendship1.isEmpty() || optionalFriendship2.isEmpty()){
            return false;
        }
        Friend friendship1 = optionalFriendship1.get();
        Friend friendship2 = optionalFriendship2.get();
        friendRepository.delete(friendship1);
        friendRepository.delete(friendship2);
        return true;
    }

}
