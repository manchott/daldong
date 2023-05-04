package com.ssafy.daldong.mission.model.entity;

import com.ssafy.daldong.mission.model.dto.DailyMissionDTO;
import com.ssafy.daldong.user.model.entity.User;
import lombok.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import javax.persistence.*;

@Entity
@Table(name = "userMission")
@IdClass(UserMissionId.class)
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserMission {

    @Id
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    private User user;

    @Id
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "mission_id", nullable = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    private DailyMission mission;

    @Column(name = "is_receive", nullable = false)
    private boolean isReceive;

    @Column(name = "is_done", nullable = false)
    private boolean isDone;

    public void receive() {
        isReceive = true;
    }
}
