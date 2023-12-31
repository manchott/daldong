package com.ssafy.daldong.main.model.entity;

import com.ssafy.daldong.main.model.dto.AssetDTO;
import com.ssafy.daldong.main.model.dto.UserAssetDTO;
import com.ssafy.daldong.user.model.entity.User;
import lombok.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "userAsset")
//@IdClass(UserAssetId.class)
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class UserAsset {


//    @Id
//    @ManyToOne(fetch = FetchType.LAZY)
//    @JoinColumn(name = "user_id", nullable = false)
//    @OnDelete(action = OnDeleteAction.CASCADE)
//    private User user;
//
//    @Id
//    @ManyToOne(fetch = FetchType.LAZY)
//    @JoinColumn(name = "asset_id", nullable = false)
//    @OnDelete(action = OnDeleteAction.CASCADE)
//    private Asset asset;

    @EmbeddedId
    private UserAssetId userAssetId;

    @Column(name = "asset_type", nullable = false)
    private boolean assetType;

    @Column(name = "pet_exp", nullable = false)
    private int petExp;

    @Column(name = "pet_name")
    private String petName;


    public void setPetName(String newName){
        this.petName=newName;
    }

    public void sumExp(int exp) {
        this.petExp += exp;
        if (this.petExp >= 100 )
            this.petExp = 100;
    }
}