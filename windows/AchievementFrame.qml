// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: achievementFrame
    name: "AchievementFrame"
    width: 768
    height: 500

    Part {
        id: achievementFrameAchievements
        name: "AchievementFrameAchievements"
        kind: "Frame"
        anchors.left: achievementFrameCategories.right
        anchors.top: achievementFrameCategories.top
        width: 504
        height: 440
    }

    Part {
        id: achievementFrameAchievementsContainer
        name: "AchievementFrameAchievementsContainer"
        kind: "ScrollFrame"
        anchors.left: achievementFrameAchievements.left
        anchors.leftMargin: 4
        anchors.top: achievementFrameAchievements.top
        anchors.topMargin: 3
        width: 500
        height: 453
    }

    Part {
        id: achievementFrameAchievementsContainerButton1
        name: "AchievementFrameAchievementsContainerButton1"
        kind: "Button"
        anchors.left: achievementFrameAchievementsContainerScrollChild.left
        anchors.top: achievementFrameAchievementsContainerScrollChild.top
        anchors.topMargin: 2
        width: 496
        height: 84
    }

    Part {
        id: achievementFrameAchievementsContainerButton1DateCompleted
        name: "AchievementFrameAchievementsContainerButton1DateCompleted"
        kind: "FontString"
        text: "9/28/26"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton1Shield.horizontalCenter
        anchors.horizontalCenterOffset: -3
        anchors.top: achievementFrameAchievementsContainerButton1Shield.bottom
        anchors.topMargin: -6
        width: 42
        height: 12
    }

    Part {
        id: achievementFrameAchievementsContainerButton1Description
        name: "AchievementFrameAchievementsContainerButton1Description"
        kind: "FontString"
        text: "Obtain 10 mounts."
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton1.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton1.top
        anchors.topMargin: 30
        width: 102
        height: 12
    }

    Part {
        id: achievementFrameAchievementsContainerButton1Icon
        name: "AchievementFrameAchievementsContainerButton1Icon"
        kind: "Frame"
        anchors.left: achievementFrameAchievementsContainerButton1.left
        anchors.leftMargin: 8
        anchors.top: achievementFrameAchievementsContainerButton1.top
        anchors.topMargin: 9
        width: 60
        height: 60
    }

    Part {
        id: achievementFrameAchievementsContainerButton1Label
        name: "AchievementFrameAchievementsContainerButton1Label"
        kind: "FontString"
        text: "Stable Keeper"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton1TitleBackground.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton1TitleBackground.top
        width: 78
        height: 12
    }

    Part {
        id: achievementFrameAchievementsContainerButton1Objectives
        name: "AchievementFrameAchievementsContainerButton1Objectives"
        kind: "Frame"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton1Description.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton1Description.bottom
        anchors.topMargin: 8
        width: 340
        height: -6
    }

    Part {
        id: achievementFrameAchievementsContainerButton1Reward
        name: "AchievementFrameAchievementsContainerButton1Reward"
        kind: "FontString"
        text: "Title Reward: Ambassador"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton1RewardBackground.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton1RewardBackground.top
        anchors.topMargin: -1
        width: 144
        height: 12
    }

    Part {
        id: achievementFrameAchievementsContainerButton1Shield
        name: "AchievementFrameAchievementsContainerButton1Shield"
        kind: "Frame"
        anchors.right: achievementFrameAchievementsContainerButton1.right
        anchors.rightMargin: 6
        anchors.top: achievementFrameAchievementsContainerButton1.top
        width: 64
        height: 64
    }

    Part {
        id: achievementFrameAchievementsContainerButton1ShieldPoints
        name: "AchievementFrameAchievementsContainerButton1ShieldPoints"
        kind: "FontString"
        text: "10"
        anchors.right: achievementFrameAchievementsContainerButton1Shield.right
        anchors.rightMargin: 18
        anchors.top: achievementFrameAchievementsContainerButton1Shield.top
        anchors.topMargin: 26
        width: 12
        height: 12
    }

    Part {
        id: achievementFrameAchievementsContainerButton2
        name: "AchievementFrameAchievementsContainerButton2"
        kind: "Button"
        anchors.left: achievementFrameAchievementsContainerButton1.left
        anchors.top: achievementFrameAchievementsContainerButton1.bottom
        width: 496
        height: 84
    }

    Part {
        id: achievementFrameAchievementsContainerButton2DateCompleted
        name: "AchievementFrameAchievementsContainerButton2DateCompleted"
        kind: "FontString"
        text: "8/14/26"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton2Shield.horizontalCenter
        anchors.horizontalCenterOffset: -3
        anchors.top: achievementFrameAchievementsContainerButton2Shield.bottom
        anchors.topMargin: -6
        width: 42
        height: 12
    }

    Part {
        id: achievementFrameAchievementsContainerButton2Description
        name: "AchievementFrameAchievementsContainerButton2Description"
        kind: "FontString"
        text: "Equip 10 unique tabards."
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton2.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton2.top
        anchors.topMargin: 30
        width: 144
        height: 12
    }

    Part {
        id: achievementFrameAchievementsContainerButton2Icon
        name: "AchievementFrameAchievementsContainerButton2Icon"
        kind: "Frame"
        anchors.left: achievementFrameAchievementsContainerButton2.left
        anchors.leftMargin: 8
        anchors.top: achievementFrameAchievementsContainerButton2.top
        anchors.topMargin: 9
        width: 60
        height: 60
    }

    Part {
        id: achievementFrameAchievementsContainerButton2Label
        name: "AchievementFrameAchievementsContainerButton2Label"
        kind: "FontString"
        text: "Ten Tabards"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton2TitleBackground.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton2TitleBackground.top
        width: 66
        height: 12
    }

    Part {
        id: achievementFrameAchievementsContainerButton2Objectives
        name: "AchievementFrameAchievementsContainerButton2Objectives"
        kind: "Frame"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton2Description.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton2Description.bottom
        anchors.topMargin: 8
        width: 340
        height: -8.4
    }

    Part {
        id: achievementFrameAchievementsContainerButton2Shield
        name: "AchievementFrameAchievementsContainerButton2Shield"
        kind: "Frame"
        anchors.right: achievementFrameAchievementsContainerButton2.right
        anchors.rightMargin: 6
        anchors.top: achievementFrameAchievementsContainerButton2.top
        width: 64
        height: 64
    }

    Part {
        id: achievementFrameAchievementsContainerButton2ShieldPoints
        name: "AchievementFrameAchievementsContainerButton2ShieldPoints"
        kind: "FontString"
        text: "20"
        anchors.right: achievementFrameAchievementsContainerButton2Shield.right
        anchors.rightMargin: 18
        anchors.top: achievementFrameAchievementsContainerButton2Shield.top
        anchors.topMargin: 26
        width: 12
        height: 12
    }

    Part {
        id: achievementFrameAchievementsContainerButton3
        name: "AchievementFrameAchievementsContainerButton3"
        kind: "Button"
        anchors.left: achievementFrameAchievementsContainerButton2.left
        anchors.top: achievementFrameAchievementsContainerButton2.bottom
        width: 496
        height: 84
    }

    Part {
        id: achievementFrameAchievementsContainerButton3DateCompleted
        name: "AchievementFrameAchievementsContainerButton3DateCompleted"
        kind: "FontString"
        text: "6/24/26"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton3Shield.horizontalCenter
        anchors.horizontalCenterOffset: -3
        anchors.top: achievementFrameAchievementsContainerButton3Shield.bottom
        anchors.topMargin: -6
        width: 42
        height: 12
    }

    Part {
        id: achievementFrameAchievementsContainerButton3Description
        name: "AchievementFrameAchievementsContainerButton3Description"
        kind: "FontString"
        text: "Collect 15 unique companion pets."
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton3.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton3.top
        anchors.topMargin: 30
        width: 198
        height: 12
    }

    Part {
        id: achievementFrameAchievementsContainerButton3Icon
        name: "AchievementFrameAchievementsContainerButton3Icon"
        kind: "Frame"
        anchors.left: achievementFrameAchievementsContainerButton3.left
        anchors.leftMargin: 8
        anchors.top: achievementFrameAchievementsContainerButton3.top
        anchors.topMargin: 9
        width: 60
        height: 60
    }

    Part {
        id: achievementFrameAchievementsContainerButton3Label
        name: "AchievementFrameAchievementsContainerButton3Label"
        kind: "FontString"
        text: "Plenty of Pets"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton3TitleBackground.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton3TitleBackground.top
        width: 84
        height: 12
    }

    Part {
        id: achievementFrameAchievementsContainerButton3Objectives
        name: "AchievementFrameAchievementsContainerButton3Objectives"
        kind: "Frame"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton3Description.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton3Description.bottom
        anchors.topMargin: 8
        width: 340
        height: -6
    }

    Part {
        id: achievementFrameAchievementsContainerButton3Reward
        name: "AchievementFrameAchievementsContainerButton3Reward"
        kind: "FontString"
        text: "Title Reward: Flame Warden"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton3RewardBackground.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton3RewardBackground.top
        anchors.topMargin: -1
        width: 156
        height: 12
    }

    Part {
        id: achievementFrameAchievementsContainerButton3Shield
        name: "AchievementFrameAchievementsContainerButton3Shield"
        kind: "Frame"
        anchors.right: achievementFrameAchievementsContainerButton3.right
        anchors.rightMargin: 6
        anchors.top: achievementFrameAchievementsContainerButton3.top
        width: 64
        height: 64
    }

    Part {
        id: achievementFrameAchievementsContainerButton3ShieldPoints
        name: "AchievementFrameAchievementsContainerButton3ShieldPoints"
        kind: "FontString"
        text: "20"
        anchors.right: achievementFrameAchievementsContainerButton3Shield.right
        anchors.rightMargin: 18
        anchors.top: achievementFrameAchievementsContainerButton3Shield.top
        anchors.topMargin: 26
        width: 12
        height: 12
    }

    Part {
        id: achievementFrameAchievementsContainerButton4
        name: "AchievementFrameAchievementsContainerButton4"
        kind: "Button"
        anchors.left: achievementFrameAchievementsContainerButton3.left
        anchors.top: achievementFrameAchievementsContainerButton3.bottom
        width: 496
        height: 84
    }

    Part {
        id: achievementFrameAchievementsContainerButton4DateCompleted
        name: "AchievementFrameAchievementsContainerButton4DateCompleted"
        kind: "FontString"
        text: "5/30/26"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton4Shield.horizontalCenter
        anchors.horizontalCenterOffset: -3
        anchors.top: achievementFrameAchievementsContainerButton4Shield.bottom
        anchors.topMargin: -6
        width: 42
        height: 12
    }

    Part {
        id: achievementFrameAchievementsContainerButton4Description
        name: "AchievementFrameAchievementsContainerButton4Description"
        kind: "FontString"
        text: "Loot 1,000 gold."
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton4.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton4.top
        anchors.topMargin: 30
        width: 96
        height: 12
    }

    Part {
        id: achievementFrameAchievementsContainerButton4Icon
        name: "AchievementFrameAchievementsContainerButton4Icon"
        kind: "Frame"
        anchors.left: achievementFrameAchievementsContainerButton4.left
        anchors.leftMargin: 8
        anchors.top: achievementFrameAchievementsContainerButton4.top
        anchors.topMargin: 9
        width: 60
        height: 60
    }

    Part {
        id: achievementFrameAchievementsContainerButton4Label
        name: "AchievementFrameAchievementsContainerButton4Label"
        kind: "FontString"
        text: "Got My Mind On My Money"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton4TitleBackground.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton4TitleBackground.top
        width: 138
        height: 12
    }

    Part {
        id: achievementFrameAchievementsContainerButton4Objectives
        name: "AchievementFrameAchievementsContainerButton4Objectives"
        kind: "Frame"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton4Description.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton4Description.bottom
        anchors.topMargin: 8
        width: 340
        height: -6
    }

    Part {
        id: achievementFrameAchievementsContainerButton4Reward
        name: "AchievementFrameAchievementsContainerButton4Reward"
        kind: "FontString"
        text: "Title Reward: The Diplomat"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton4RewardBackground.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton4RewardBackground.top
        anchors.topMargin: -1
        width: 156
        height: 12
    }

    Part {
        id: achievementFrameAchievementsContainerButton4Shield
        name: "AchievementFrameAchievementsContainerButton4Shield"
        kind: "Frame"
        anchors.right: achievementFrameAchievementsContainerButton4.right
        anchors.rightMargin: 6
        anchors.top: achievementFrameAchievementsContainerButton4.top
        width: 64
        height: 64
    }

    Part {
        id: achievementFrameAchievementsContainerButton4ShieldPoints
        name: "AchievementFrameAchievementsContainerButton4ShieldPoints"
        kind: "FontString"
        text: "20"
        anchors.right: achievementFrameAchievementsContainerButton4Shield.right
        anchors.rightMargin: 18
        anchors.top: achievementFrameAchievementsContainerButton4Shield.top
        anchors.topMargin: 26
        width: 12
        height: 12
    }

    Part {
        id: achievementFrameAchievementsContainerButton5
        name: "AchievementFrameAchievementsContainerButton5"
        kind: "Button"
        anchors.left: achievementFrameAchievementsContainerButton4.left
        anchors.top: achievementFrameAchievementsContainerButton4.bottom
        width: 496
        height: 84
    }

    Part {
        id: achievementFrameAchievementsContainerButton5DateCompleted
        name: "AchievementFrameAchievementsContainerButton5DateCompleted"
        kind: "FontString"
        text: "5/29/26"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton5Shield.horizontalCenter
        anchors.horizontalCenterOffset: -3
        anchors.top: achievementFrameAchievementsContainerButton5Shield.bottom
        anchors.topMargin: -6
        width: 42
        height: 12
    }

    Part {
        id: achievementFrameAchievementsContainerButton5Description
        name: "AchievementFrameAchievementsContainerButton5Description"
        kind: "FontString"
        text: "Win a greed roll on a superior or better item above level 185 by rolling 100."
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton5.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton5.top
        anchors.topMargin: 30
        width: 462
        height: 12
    }

    Part {
        id: achievementFrameAchievementsContainerButton5Icon
        name: "AchievementFrameAchievementsContainerButton5Icon"
        kind: "Frame"
        anchors.left: achievementFrameAchievementsContainerButton5.left
        anchors.leftMargin: 8
        anchors.top: achievementFrameAchievementsContainerButton5.top
        anchors.topMargin: 9
        width: 60
        height: 60
    }

    Part {
        id: achievementFrameAchievementsContainerButton5Label
        name: "AchievementFrameAchievementsContainerButton5Label"
        kind: "FontString"
        text: "Greedy"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton5TitleBackground.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton5TitleBackground.top
        width: 36
        height: 12
    }

    Part {
        id: achievementFrameAchievementsContainerButton5Objectives
        name: "AchievementFrameAchievementsContainerButton5Objectives"
        kind: "Frame"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton5Description.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton5Description.bottom
        anchors.topMargin: 8
        width: 340
        height: -6
    }

    Part {
        id: achievementFrameAchievementsContainerButton5Reward
        name: "AchievementFrameAchievementsContainerButton5Reward"
        kind: "FontString"
        text: "Title Reward: The Argent Champion"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton5RewardBackground.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton5RewardBackground.top
        anchors.topMargin: -1
        width: 198
        height: 12
    }

    Part {
        id: achievementFrameAchievementsContainerButton5Shield
        name: "AchievementFrameAchievementsContainerButton5Shield"
        kind: "Frame"
        anchors.right: achievementFrameAchievementsContainerButton5.right
        anchors.rightMargin: 6
        anchors.top: achievementFrameAchievementsContainerButton5.top
        width: 64
        height: 64
    }

    Part {
        id: achievementFrameAchievementsContainerButton5ShieldPoints
        name: "AchievementFrameAchievementsContainerButton5ShieldPoints"
        kind: "FontString"
        text: "10"
        anchors.right: achievementFrameAchievementsContainerButton5Shield.right
        anchors.rightMargin: 18
        anchors.top: achievementFrameAchievementsContainerButton5Shield.top
        anchors.topMargin: 26
        width: 12
        height: 12
    }

    Part {
        id: achievementFrameAchievementsContainerButton6
        name: "AchievementFrameAchievementsContainerButton6"
        kind: "Button"
        anchors.left: achievementFrameAchievementsContainerButton5.left
        anchors.top: achievementFrameAchievementsContainerButton5.bottom
        width: 496
        height: 84
    }

    Part {
        id: achievementFrameAchievementsContainerButton6DateCompleted
        name: "AchievementFrameAchievementsContainerButton6DateCompleted"
        kind: "FontString"
        text: "5/26/26"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton6Shield.horizontalCenter
        anchors.horizontalCenterOffset: -3
        anchors.top: achievementFrameAchievementsContainerButton6Shield.bottom
        anchors.topMargin: -6
        width: 42
        height: 12
    }

    Part {
        id: achievementFrameAchievementsContainerButton6Description
        name: "AchievementFrameAchievementsContainerButton6Description"
        kind: "FontString"
        text: "Learn the artisan riding skill."
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton6.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton6.top
        anchors.topMargin: 30
        width: 186
        height: 12
    }

    Part {
        id: achievementFrameAchievementsContainerButton6Icon
        name: "AchievementFrameAchievementsContainerButton6Icon"
        kind: "Frame"
        anchors.left: achievementFrameAchievementsContainerButton6.left
        anchors.leftMargin: 8
        anchors.top: achievementFrameAchievementsContainerButton6.top
        anchors.topMargin: 9
        width: 60
        height: 60
    }

    Part {
        id: achievementFrameAchievementsContainerButton6Label
        name: "AchievementFrameAchievementsContainerButton6Label"
        kind: "FontString"
        text: "The Right Stuff"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton6TitleBackground.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton6TitleBackground.top
        width: 90
        height: 12
    }

    Part {
        id: achievementFrameAchievementsContainerButton6Objectives
        name: "AchievementFrameAchievementsContainerButton6Objectives"
        kind: "Frame"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton6Description.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton6Description.bottom
        anchors.topMargin: 8
        width: 340
        height: -6
    }

    Part {
        id: achievementFrameAchievementsContainerButton6Reward
        name: "AchievementFrameAchievementsContainerButton6Reward"
        kind: "FontString"
        text: "Title Reward: Guardian of Cenarius"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton6RewardBackground.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton6RewardBackground.top
        anchors.topMargin: -1
        width: 204
        height: 12
    }

    Part {
        id: achievementFrameAchievementsContainerButton6Shield
        name: "AchievementFrameAchievementsContainerButton6Shield"
        kind: "Frame"
        anchors.right: achievementFrameAchievementsContainerButton6.right
        anchors.rightMargin: 6
        anchors.top: achievementFrameAchievementsContainerButton6.top
        width: 64
        height: 64
    }

    Part {
        id: achievementFrameAchievementsContainerButton6ShieldPoints
        name: "AchievementFrameAchievementsContainerButton6ShieldPoints"
        kind: "FontString"
        text: "40"
        anchors.right: achievementFrameAchievementsContainerButton6Shield.right
        anchors.rightMargin: 18
        anchors.top: achievementFrameAchievementsContainerButton6Shield.top
        anchors.topMargin: 26
        width: 12
        height: 12
    }

    Part {
        id: achievementFrameAchievementsContainerButton7
        name: "AchievementFrameAchievementsContainerButton7"
        kind: "Button"
        anchors.left: achievementFrameAchievementsContainerButton6.left
        anchors.top: achievementFrameAchievementsContainerButton6.bottom
        width: 496
        height: 84
    }

    Part {
        id: achievementFrameAchievementsContainerButton7DateCompleted
        name: "AchievementFrameAchievementsContainerButton7DateCompleted"
        kind: "FontString"
        text: "5/26/26"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton7Shield.horizontalCenter
        anchors.horizontalCenterOffset: -3
        anchors.top: achievementFrameAchievementsContainerButton7Shield.bottom
        anchors.topMargin: -6
        width: 42
        height: 12
    }

    Part {
        id: achievementFrameAchievementsContainerButton7Description
        name: "AchievementFrameAchievementsContainerButton7Description"
        kind: "FontString"
        text: "Read the volumes of \"The Schools of Arcane Magic\" found in Dalaran listed below."
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton7.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton7.top
        anchors.topMargin: 30
        width: 480
        height: 12
    }

    Part {
        id: achievementFrameAchievementsContainerButton7Icon
        name: "AchievementFrameAchievementsContainerButton7Icon"
        kind: "Frame"
        anchors.left: achievementFrameAchievementsContainerButton7.left
        anchors.leftMargin: 8
        anchors.top: achievementFrameAchievementsContainerButton7.top
        anchors.topMargin: 9
        width: 60
        height: 60
    }

    Part {
        id: achievementFrameAchievementsContainerButton7Label
        name: "AchievementFrameAchievementsContainerButton7Label"
        kind: "FontString"
        text: "Higher Learning"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton7TitleBackground.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton7TitleBackground.top
        width: 90
        height: 12
    }

    Part {
        id: achievementFrameAchievementsContainerButton7Objectives
        name: "AchievementFrameAchievementsContainerButton7Objectives"
        kind: "Frame"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton7Description.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton7Description.bottom
        anchors.topMargin: 8
        width: 340
        height: -6
    }

    Part {
        id: achievementFrameAchievementsContainerButton7Reward
        name: "AchievementFrameAchievementsContainerButton7Reward"
        kind: "FontString"
        text: "Reward: The Schools of Arcane Magic - Mastery"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton7RewardBackground.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton7RewardBackground.top
        anchors.topMargin: -1
        width: 270
        height: 12
    }

    Part {
        id: achievementFrameAchievementsContainerButton7Shield
        name: "AchievementFrameAchievementsContainerButton7Shield"
        kind: "Frame"
        anchors.right: achievementFrameAchievementsContainerButton7.right
        anchors.rightMargin: 6
        anchors.top: achievementFrameAchievementsContainerButton7.top
        width: 64
        height: 64
    }

    Part {
        id: achievementFrameAchievementsContainerButton7ShieldPoints
        name: "AchievementFrameAchievementsContainerButton7ShieldPoints"
        kind: "FontString"
        text: "10"
        anchors.right: achievementFrameAchievementsContainerButton7Shield.right
        anchors.rightMargin: 18
        anchors.top: achievementFrameAchievementsContainerButton7Shield.top
        anchors.topMargin: 26
        width: 12
        height: 12
    }

    Part {
        id: achievementFrameAchievementsContainerScrollBar
        name: "AchievementFrameAchievementsContainerScrollBar"
        kind: "Slider"
        anchors.left: achievementFrameAchievementsContainer.right
        anchors.leftMargin: 1
        anchors.top: achievementFrameAchievementsContainer.top
        anchors.topMargin: 16
        width: 20
        height: 425
    }

    Part {
        id: achievementFrameAchievementsContainerScrollBarScrollDownButton
        name: "AchievementFrameAchievementsContainerScrollBarScrollDownButton"
        kind: "Button"
        anchors.horizontalCenter: achievementFrameAchievementsContainerScrollBar.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerScrollBar.bottom
        anchors.topMargin: -2
        width: 16
        height: 16
    }

    Part {
        id: achievementFrameAchievementsContainerScrollBarScrollUpButton
        name: "AchievementFrameAchievementsContainerScrollBarScrollUpButton"
        kind: "Button"
        anchors.horizontalCenter: achievementFrameAchievementsContainerScrollBar.horizontalCenter
        anchors.bottom: achievementFrameAchievementsContainerScrollBar.top
        anchors.bottomMargin: -2
        width: 16
        height: 16
    }

    Part {
        id: achievementFrameAchievementsContainerScrollChild
        name: "AchievementFrameAchievementsContainerScrollChild"
        kind: "Frame"
        anchors.left: achievementFrameAchievementsContainer.left
        anchors.top: achievementFrameAchievementsContainer.top
        width: 500
        height: 588
    }

    Part {
        id: achievementFrameCategories
        name: "AchievementFrameCategories"
        kind: "Frame"
        wowParent: "AchievementFrame"
        anchors.left: achievementFrame.left
        anchors.leftMargin: 21
        anchors.top: achievementFrame.top
        anchors.topMargin: 19
        width: 197
        height: 461
    }

    Part {
        id: achievementFrameCategoriesContainer
        name: "AchievementFrameCategoriesContainer"
        kind: "ScrollFrame"
        wowParent: "AchievementFrameCategories"
        anchors.left: achievementFrameCategories.left
        anchors.top: achievementFrameCategories.top
        anchors.topMargin: 5
        width: 197
        height: 451
    }

    Part {
        id: achievementFrameCategoriesContainerButton1
        name: "AchievementFrameCategoriesContainerButton1"
        kind: "Button"
        wowParent: "AchievementFrameCategoriesContainerScrollChild"
        anchors.horizontalCenter: achievementFrameCategoriesContainerScrollChild.horizontalCenter
        anchors.top: achievementFrameCategoriesContainerScrollChild.top
        width: 187
        height: 24
    }

    Part {
        id: achievementFrameCategoriesContainerButton10
        name: "AchievementFrameCategoriesContainerButton10"
        kind: "Button"
        wowParent: "AchievementFrameCategoriesContainerScrollChild"
        anchors.horizontalCenter: achievementFrameCategoriesContainerButton9.horizontalCenter
        anchors.top: achievementFrameCategoriesContainerButton9.bottom
        width: 187
        height: 24
    }

    Part {
        id: achievementFrameCategoriesContainerButton10Label
        name: "AchievementFrameCategoriesContainerButton10Label"
        kind: "FontString"
        text: "Social"
        wowParent: "AchievementFrameCategoriesContainerButton10"
        anchors.left: achievementFrameCategoriesContainerButton10.left
        anchors.leftMargin: 14
        anchors.verticalCenter: achievementFrameCategoriesContainerButton10.verticalCenter
        width: 159
        height: 11.9
    }

    Part {
        id: achievementFrameCategoriesContainerButton11
        name: "AchievementFrameCategoriesContainerButton11"
        kind: "Button"
        wowParent: "AchievementFrameCategoriesContainerScrollChild"
        anchors.horizontalCenter: achievementFrameCategoriesContainerButton10.horizontalCenter
        anchors.top: achievementFrameCategoriesContainerButton10.bottom
        width: 187
        height: 24
    }

    Part {
        id: achievementFrameCategoriesContainerButton11Label
        name: "AchievementFrameCategoriesContainerButton11Label"
        kind: "FontString"
        text: "Player vs. Player"
        wowParent: "AchievementFrameCategoriesContainerButton11"
        anchors.left: achievementFrameCategoriesContainerButton11.left
        anchors.leftMargin: 14
        anchors.verticalCenter: achievementFrameCategoriesContainerButton11.verticalCenter
        width: 159
        height: 11.9
    }

    Part {
        id: achievementFrameCategoriesContainerButton12
        name: "AchievementFrameCategoriesContainerButton12"
        kind: "Button"
        anchors.horizontalCenter: achievementFrameCategoriesContainerButton11.horizontalCenter
        anchors.top: achievementFrameCategoriesContainerButton11.bottom
        width: 187
        height: 24
    }

    Part {
        id: achievementFrameCategoriesContainerButton12Label
        name: "AchievementFrameCategoriesContainerButton12Label"
        kind: "FontString"
        text: "Skills"
        anchors.left: achievementFrameCategoriesContainerButton12.left
        anchors.leftMargin: 14
        anchors.verticalCenter: achievementFrameCategoriesContainerButton12.verticalCenter
        width: 36
        height: 12
    }

    Part {
        id: achievementFrameCategoriesContainerButton13
        name: "AchievementFrameCategoriesContainerButton13"
        kind: "Button"
        anchors.horizontalCenter: achievementFrameCategoriesContainerButton12.horizontalCenter
        anchors.top: achievementFrameCategoriesContainerButton12.bottom
        width: 187
        height: 24
    }

    Part {
        id: achievementFrameCategoriesContainerButton13Label
        name: "AchievementFrameCategoriesContainerButton13Label"
        kind: "FontString"
        text: "Travel"
        anchors.left: achievementFrameCategoriesContainerButton13.left
        anchors.leftMargin: 14
        anchors.verticalCenter: achievementFrameCategoriesContainerButton13.verticalCenter
        width: 36
        height: 12
    }

    Part {
        id: achievementFrameCategoriesContainerButton14
        name: "AchievementFrameCategoriesContainerButton14"
        kind: "Button"
        anchors.horizontalCenter: achievementFrameCategoriesContainerButton13.horizontalCenter
        anchors.top: achievementFrameCategoriesContainerButton13.bottom
        width: 187
        height: 24
    }

    Part {
        id: achievementFrameCategoriesContainerButton14Label
        name: "AchievementFrameCategoriesContainerButton14Label"
        kind: "FontString"
        text: "Social"
        anchors.left: achievementFrameCategoriesContainerButton14.left
        anchors.leftMargin: 14
        anchors.verticalCenter: achievementFrameCategoriesContainerButton14.verticalCenter
        width: 36
        height: 12
    }

    Part {
        id: achievementFrameCategoriesContainerButton15
        name: "AchievementFrameCategoriesContainerButton15"
        kind: "Button"
        anchors.horizontalCenter: achievementFrameCategoriesContainerButton14.horizontalCenter
        anchors.top: achievementFrameCategoriesContainerButton14.bottom
        width: 187
        height: 24
    }

    Part {
        id: achievementFrameCategoriesContainerButton15Label
        name: "AchievementFrameCategoriesContainerButton15Label"
        kind: "FontString"
        text: "Player vs. Player"
        anchors.left: achievementFrameCategoriesContainerButton15.left
        anchors.leftMargin: 14
        anchors.verticalCenter: achievementFrameCategoriesContainerButton15.verticalCenter
        width: 102
        height: 12
    }

    Part {
        id: achievementFrameCategoriesContainerButton16
        name: "AchievementFrameCategoriesContainerButton16"
        kind: "Button"
        anchors.horizontalCenter: achievementFrameCategoriesContainerButton15.horizontalCenter
        anchors.top: achievementFrameCategoriesContainerButton15.bottom
        width: 187
        height: 24
    }

    Part {
        id: achievementFrameCategoriesContainerButton16Label
        name: "AchievementFrameCategoriesContainerButton16Label"
        kind: "FontString"
        text: "Reputation"
        anchors.left: achievementFrameCategoriesContainerButton16.left
        anchors.leftMargin: 14
        anchors.verticalCenter: achievementFrameCategoriesContainerButton16.verticalCenter
        width: 60
        height: 12
    }

    Part {
        id: achievementFrameCategoriesContainerButton17
        name: "AchievementFrameCategoriesContainerButton17"
        kind: "Button"
        anchors.horizontalCenter: achievementFrameCategoriesContainerButton16.horizontalCenter
        anchors.top: achievementFrameCategoriesContainerButton16.bottom
        width: 187
        height: 24
    }

    Part {
        id: achievementFrameCategoriesContainerButton17Label
        name: "AchievementFrameCategoriesContainerButton17Label"
        kind: "FontString"
        text: "World Events"
        anchors.left: achievementFrameCategoriesContainerButton17.left
        anchors.leftMargin: 14
        anchors.verticalCenter: achievementFrameCategoriesContainerButton17.verticalCenter
        width: 72
        height: 12
    }

    Part {
        id: achievementFrameCategoriesContainerButton18
        name: "AchievementFrameCategoriesContainerButton18"
        kind: "Button"
        anchors.horizontalCenter: achievementFrameCategoriesContainerButton17.horizontalCenter
        anchors.top: achievementFrameCategoriesContainerButton17.bottom
        width: 187
        height: 24
    }

    Part {
        id: achievementFrameCategoriesContainerButton18Label
        name: "AchievementFrameCategoriesContainerButton18Label"
        kind: "FontString"
        text: "Feats of Strength"
        anchors.left: achievementFrameCategoriesContainerButton18.left
        anchors.leftMargin: 14
        anchors.verticalCenter: achievementFrameCategoriesContainerButton18.verticalCenter
        width: 102
        height: 12
    }

    Part {
        id: achievementFrameCategoriesContainerButton19
        name: "AchievementFrameCategoriesContainerButton19"
        kind: "Button"
        anchors.horizontalCenter: achievementFrameCategoriesContainerButton18.horizontalCenter
        anchors.top: achievementFrameCategoriesContainerButton18.bottom
        width: 165
        height: 24
    }

    Part {
        id: achievementFrameCategoriesContainerButton19Label
        name: "AchievementFrameCategoriesContainerButton19Label"
        kind: "FontString"
        text: "Feats of Strength"
        anchors.left: achievementFrameCategoriesContainerButton19.left
        anchors.leftMargin: 14
        anchors.verticalCenter: achievementFrameCategoriesContainerButton19.verticalCenter
        width: 102
        height: 12
    }

    Part {
        id: achievementFrameCategoriesContainerButton1Label
        name: "AchievementFrameCategoriesContainerButton1Label"
        kind: "FontString"
        text: "Summary"
        wowParent: "AchievementFrameCategoriesContainerButton1"
        anchors.left: achievementFrameCategoriesContainerButton1.left
        anchors.leftMargin: 14
        anchors.verticalCenter: achievementFrameCategoriesContainerButton1.verticalCenter
        width: 159
        height: 11.9
    }

    Part {
        id: achievementFrameCategoriesContainerButton2
        name: "AchievementFrameCategoriesContainerButton2"
        kind: "Button"
        wowParent: "AchievementFrameCategoriesContainerScrollChild"
        anchors.horizontalCenter: achievementFrameCategoriesContainerButton1.horizontalCenter
        anchors.top: achievementFrameCategoriesContainerButton1.bottom
        width: 187
        height: 24
    }

    Part {
        id: achievementFrameCategoriesContainerButton20
        name: "AchievementFrameCategoriesContainerButton20"
        kind: "Button"
        anchors.horizontalCenter: achievementFrameCategoriesContainerButton19.horizontalCenter
        anchors.top: achievementFrameCategoriesContainerButton19.bottom
        width: 165
        height: 24
    }

    Part {
        id: achievementFrameCategoriesContainerButton20Label
        name: "AchievementFrameCategoriesContainerButton20Label"
        kind: "FontString"
        text: "Feats of Strength"
        anchors.left: achievementFrameCategoriesContainerButton20.left
        anchors.leftMargin: 14
        anchors.verticalCenter: achievementFrameCategoriesContainerButton20.verticalCenter
        width: 102
        height: 12
    }

    Part {
        id: achievementFrameCategoriesContainerButton2Label
        name: "AchievementFrameCategoriesContainerButton2Label"
        kind: "FontString"
        text: "Character"
        wowParent: "AchievementFrameCategoriesContainerButton2"
        anchors.left: achievementFrameCategoriesContainerButton2.left
        anchors.leftMargin: 14
        anchors.verticalCenter: achievementFrameCategoriesContainerButton2.verticalCenter
        width: 159
        height: 11.9
    }

    Part {
        id: achievementFrameCategoriesContainerButton3
        name: "AchievementFrameCategoriesContainerButton3"
        kind: "Button"
        wowParent: "AchievementFrameCategoriesContainerScrollChild"
        anchors.horizontalCenter: achievementFrameCategoriesContainerButton2.horizontalCenter
        anchors.top: achievementFrameCategoriesContainerButton2.bottom
        width: 187
        height: 24
    }

    Part {
        id: achievementFrameCategoriesContainerButton3Label
        name: "AchievementFrameCategoriesContainerButton3Label"
        kind: "FontString"
        text: "Combat"
        wowParent: "AchievementFrameCategoriesContainerButton3"
        anchors.left: achievementFrameCategoriesContainerButton3.left
        anchors.leftMargin: 14
        anchors.verticalCenter: achievementFrameCategoriesContainerButton3.verticalCenter
        width: 159
        height: 11.9
    }

    Part {
        id: achievementFrameCategoriesContainerButton4
        name: "AchievementFrameCategoriesContainerButton4"
        kind: "Button"
        wowParent: "AchievementFrameCategoriesContainerScrollChild"
        anchors.horizontalCenter: achievementFrameCategoriesContainerButton3.horizontalCenter
        anchors.top: achievementFrameCategoriesContainerButton3.bottom
        width: 187
        height: 24
    }

    Part {
        id: achievementFrameCategoriesContainerButton4Label
        name: "AchievementFrameCategoriesContainerButton4Label"
        kind: "FontString"
        text: "Kills"
        wowParent: "AchievementFrameCategoriesContainerButton4"
        anchors.left: achievementFrameCategoriesContainerButton4.left
        anchors.leftMargin: 14
        anchors.verticalCenter: achievementFrameCategoriesContainerButton4.verticalCenter
        width: 159
        height: 11.9
    }

    Part {
        id: achievementFrameCategoriesContainerButton5
        name: "AchievementFrameCategoriesContainerButton5"
        kind: "Button"
        wowParent: "AchievementFrameCategoriesContainerScrollChild"
        anchors.horizontalCenter: achievementFrameCategoriesContainerButton4.horizontalCenter
        anchors.top: achievementFrameCategoriesContainerButton4.bottom
        width: 187
        height: 24
    }

    Part {
        id: achievementFrameCategoriesContainerButton5Label
        name: "AchievementFrameCategoriesContainerButton5Label"
        kind: "FontString"
        text: "Deaths"
        wowParent: "AchievementFrameCategoriesContainerButton5"
        anchors.left: achievementFrameCategoriesContainerButton5.left
        anchors.leftMargin: 14
        anchors.verticalCenter: achievementFrameCategoriesContainerButton5.verticalCenter
        width: 159
        height: 11.9
    }

    Part {
        id: achievementFrameCategoriesContainerButton6
        name: "AchievementFrameCategoriesContainerButton6"
        kind: "Button"
        wowParent: "AchievementFrameCategoriesContainerScrollChild"
        anchors.horizontalCenter: achievementFrameCategoriesContainerButton5.horizontalCenter
        anchors.top: achievementFrameCategoriesContainerButton5.bottom
        width: 187
        height: 24
    }

    Part {
        id: achievementFrameCategoriesContainerButton6Label
        name: "AchievementFrameCategoriesContainerButton6Label"
        kind: "FontString"
        text: "Quests"
        wowParent: "AchievementFrameCategoriesContainerButton6"
        anchors.left: achievementFrameCategoriesContainerButton6.left
        anchors.leftMargin: 14
        anchors.verticalCenter: achievementFrameCategoriesContainerButton6.verticalCenter
        width: 159
        height: 11.9
    }

    Part {
        id: achievementFrameCategoriesContainerButton7
        name: "AchievementFrameCategoriesContainerButton7"
        kind: "Button"
        wowParent: "AchievementFrameCategoriesContainerScrollChild"
        anchors.horizontalCenter: achievementFrameCategoriesContainerButton6.horizontalCenter
        anchors.top: achievementFrameCategoriesContainerButton6.bottom
        width: 187
        height: 24
    }

    Part {
        id: achievementFrameCategoriesContainerButton7Label
        name: "AchievementFrameCategoriesContainerButton7Label"
        kind: "FontString"
        text: "Dungeons & Raids"
        wowParent: "AchievementFrameCategoriesContainerButton7"
        anchors.left: achievementFrameCategoriesContainerButton7.left
        anchors.leftMargin: 14
        anchors.verticalCenter: achievementFrameCategoriesContainerButton7.verticalCenter
        width: 159
        height: 11.9
    }

    Part {
        id: achievementFrameCategoriesContainerButton8
        name: "AchievementFrameCategoriesContainerButton8"
        kind: "Button"
        wowParent: "AchievementFrameCategoriesContainerScrollChild"
        anchors.horizontalCenter: achievementFrameCategoriesContainerButton7.horizontalCenter
        anchors.top: achievementFrameCategoriesContainerButton7.bottom
        width: 187
        height: 24
    }

    Part {
        id: achievementFrameCategoriesContainerButton8Label
        name: "AchievementFrameCategoriesContainerButton8Label"
        kind: "FontString"
        text: "Skills"
        wowParent: "AchievementFrameCategoriesContainerButton8"
        anchors.left: achievementFrameCategoriesContainerButton8.left
        anchors.leftMargin: 14
        anchors.verticalCenter: achievementFrameCategoriesContainerButton8.verticalCenter
        width: 159
        height: 11.9
    }

    Part {
        id: achievementFrameCategoriesContainerButton9
        name: "AchievementFrameCategoriesContainerButton9"
        kind: "Button"
        wowParent: "AchievementFrameCategoriesContainerScrollChild"
        anchors.horizontalCenter: achievementFrameCategoriesContainerButton8.horizontalCenter
        anchors.top: achievementFrameCategoriesContainerButton8.bottom
        width: 187
        height: 24
    }

    Part {
        id: achievementFrameCategoriesContainerButton9Label
        name: "AchievementFrameCategoriesContainerButton9Label"
        kind: "FontString"
        text: "Travel"
        wowParent: "AchievementFrameCategoriesContainerButton9"
        anchors.left: achievementFrameCategoriesContainerButton9.left
        anchors.leftMargin: 14
        anchors.verticalCenter: achievementFrameCategoriesContainerButton9.verticalCenter
        width: 159
        height: 11.9
    }

    Part {
        id: achievementFrameCategoriesContainerScrollBar
        name: "AchievementFrameCategoriesContainerScrollBar"
        kind: "Slider"
        anchors.left: achievementFrameCategoriesContainer.right
        anchors.leftMargin: 1
        anchors.top: achievementFrameCategoriesContainer.top
        anchors.topMargin: 14
        width: 20
        height: 425
    }

    Part {
        id: achievementFrameCategoriesContainerScrollBarScrollDownButton
        name: "AchievementFrameCategoriesContainerScrollBarScrollDownButton"
        kind: "Button"
        anchors.horizontalCenter: achievementFrameCategoriesContainerScrollBar.horizontalCenter
        anchors.top: achievementFrameCategoriesContainerScrollBar.bottom
        anchors.topMargin: -2
        width: 16
        height: 16
    }

    Part {
        id: achievementFrameCategoriesContainerScrollBarScrollUpButton
        name: "AchievementFrameCategoriesContainerScrollBarScrollUpButton"
        kind: "Button"
        anchors.horizontalCenter: achievementFrameCategoriesContainerScrollBar.horizontalCenter
        anchors.bottom: achievementFrameCategoriesContainerScrollBar.top
        anchors.bottomMargin: -2
        width: 16
        height: 16
    }

    Part {
        id: achievementFrameCategoriesContainerScrollChild
        name: "AchievementFrameCategoriesContainerScrollChild"
        kind: "Frame"
        wowParent: "AchievementFrameCategoriesContainer"
        anchors.left: achievementFrameCategoriesContainer.left
        anchors.top: achievementFrameCategoriesContainer.top
        width: 197
        height: 480
    }

    Part {
        id: achievementFrameCloseButton
        name: "AchievementFrameCloseButton"
        kind: "Button"
        wowParent: "AchievementFrame"
        anchors.horizontalCenter: achievementFrameDiabolic.right
        anchors.horizontalCenterOffset: -31
        anchors.verticalCenter: achievementFrameDiabolic.top
        anchors.verticalCenterOffset: 31
        width: 22
        height: 22
    }

    Part {
        id: achievementFrameDiabolic
        name: "AchievementFrameDiabolic"
        kind: "Frame"
        wowParent: "AchievementFrame"
        anchors.left: achievementFrame.left
        anchors.top: achievementFrame.top
        anchors.topMargin: -64
        width: 768
        height: 582
    }

    Part {
        id: achievementFrameDiabolicBand
        name: "AchievementFrameDiabolicBand"
        kind: "Frame"
        wowParent: "AchievementFrameDiabolic"
        anchors.left: achievementFrameDiabolic.left
        anchors.leftMargin: 24
        anchors.top: achievementFrameDiabolic.top
        anchors.topMargin: 24
        width: 720
        height: 48
    }

    Part {
        id: achievementFrameDiabolicBorder
        name: "AchievementFrameDiabolicBorder"
        kind: "Frame"
        wowParent: "AchievementFrameDiabolic"
        anchors.left: achievementFrameDiabolic.left
        anchors.top: achievementFrameDiabolic.top
        width: 768
        height: 582
    }

    Part {
        id: achievementFrameDiabolicRail
        name: "AchievementFrameDiabolicRail"
        kind: "Frame"
        wowParent: "AchievementFrameDiabolic"
        anchors.left: achievementFrameDiabolic.left
        anchors.leftMargin: 18
        anchors.top: achievementFrameDiabolic.bottom
        anchors.topMargin: -19
        width: 304
        height: 18
    }

    Part {
        id: achievementFrameDiabolicSocket
        name: "AchievementFrameDiabolicSocket"
        kind: "Frame"
        wowParent: "AchievementFrameDiabolic"
        anchors.right: achievementFrameDiabolic.right
        anchors.rightMargin: 20
        anchors.top: achievementFrameDiabolic.top
        anchors.topMargin: 20
        width: 42
        height: 42
    }

    Part {
        id: achievementFrameDiabolicTitlePlate
        name: "AchievementFrameDiabolicTitlePlate"
        kind: "Frame"
        wowParent: "AchievementFrameDiabolic"
        anchors.horizontalCenter: achievementFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: achievementFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    Part {
        id: achievementFrameFilterDropDown
        name: "AchievementFrameFilterDropDown"
        kind: "Frame"
        wowParent: "AchievementFrame"
        anchors.left: achievementFrameDiabolicBand.left
        anchors.leftMargin: 18
        anchors.verticalCenter: achievementFrameDiabolicBand.verticalCenter
        width: 110
        height: 32
    }

    Part {
        id: achievementFrameFilterDropDownButton
        name: "AchievementFrameFilterDropDownButton"
        kind: "Button"
        wowParent: "AchievementFrameFilterDropDown"
        anchors.right: achievementFrameFilterDropDownDiabolicField.right
        anchors.rightMargin: -8
        anchors.verticalCenter: achievementFrameFilterDropDownDiabolicField.verticalCenter
        width: 18
        height: 18
    }

    Part {
        id: achievementFrameFilterDropDownDiabolicField
        name: "AchievementFrameFilterDropDownDiabolicField"
        kind: "Frame"
        wowParent: "AchievementFrameFilterDropDown"
        anchors.left: achievementFrameFilterDropDown.left
        anchors.verticalCenter: achievementFrameFilterDropDown.verticalCenter
        anchors.verticalCenterOffset: -4
        width: 110
        height: 22
    }

    Part {
        id: achievementFrameFilterDropDownText
        name: "AchievementFrameFilterDropDownText"
        kind: "FontString"
        text: "All"
        wowParent: "AchievementFrameFilterDropDown"
        anchors.left: achievementFrameFilterDropDownDiabolicField.left
        anchors.leftMargin: -4
        anchors.verticalCenter: achievementFrameFilterDropDownDiabolicField.verticalCenter
        width: 100
        height: 32
    }

    Part {
        id: achievementFrameHeader
        name: "AchievementFrameHeader"
        kind: "Frame"
        wowParent: "AchievementFrame"
        anchors.left: achievementFrameDiabolicBand.left
        anchors.top: achievementFrameDiabolicBand.top
        width: 720
        height: 48
    }

    Part {
        id: achievementFrameHeaderPoints
        name: "AchievementFrameHeaderPoints"
        kind: "FontString"
        text: "3460"
        wowParent: "AchievementFrameHeaderPointsDiabolicCartouche"
        anchors.horizontalCenter: achievementFrameHeaderPointsDiabolicCartouche.horizontalCenter
        anchors.horizontalCenterOffset: 10
        anchors.verticalCenter: achievementFrameHeaderPointsDiabolicCartouche.verticalCenter
        width: 51.4
        height: 12
    }

    Part {
        id: achievementFrameHeaderPointsDiabolicCartouche
        name: "AchievementFrameHeaderPointsDiabolicCartouche"
        kind: "Frame"
        wowParent: "AchievementFrameDiabolicBand"
        anchors.horizontalCenter: achievementFrameDiabolicBand.horizontalCenter
        anchors.verticalCenter: achievementFrameDiabolicBand.verticalCenter
        width: 107.4
        height: 38
    }

    Part {
        id: achievementFrameHeaderTitle
        name: "AchievementFrameHeaderTitle"
        kind: "FontString"
        text: "Achievements"
        wowParent: "AchievementFrameDiabolicTitlePlate"
        anchors.horizontalCenter: achievementFrameDiabolicTitlePlate.horizontalCenter
        anchors.verticalCenter: achievementFrameDiabolicTitlePlate.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 123.3
        height: 14.2
    }

    Part {
        id: achievementFrameStats
        name: "AchievementFrameStats"
        kind: "Frame"
        wowParent: "AchievementFrame"
        anchors.left: achievementFrameCategories.right
        anchors.top: achievementFrameCategories.top
        width: 504
        height: 461
    }

    Part {
        id: achievementFrameStatsBG
        name: "AchievementFrameStatsBG"
        kind: "Frame"
        wowParent: "AchievementFrameStats"
        anchors.left: achievementFrameStats.left
        anchors.leftMargin: 2
        anchors.top: achievementFrameStats.top
        width: 526
        height: 458
    }

    Part {
        id: achievementFrameStatsContainer
        name: "AchievementFrameStatsContainer"
        kind: "ScrollFrame"
        wowParent: "AchievementFrameStats"
        anchors.left: achievementFrameStats.left
        anchors.leftMargin: 3
        anchors.top: achievementFrameStats.top
        anchors.topMargin: 3
        width: 501
        height: 453
    }

    Part {
        id: achievementFrameStatsContainerButton1
        name: "AchievementFrameStatsContainerButton1"
        kind: "Button"
        wowParent: "AchievementFrameStatsContainerScrollChild"
        anchors.left: achievementFrameStatsContainerScrollChild.left
        anchors.top: achievementFrameStatsContainerScrollChild.top
        width: 496
        height: 24
    }

    Part {
        id: achievementFrameStatsContainerButton10
        name: "AchievementFrameStatsContainerButton10"
        kind: "Button"
        text: "Total gold acquired"
        wowParent: "AchievementFrameStatsContainerScrollChild"
        anchors.left: achievementFrameStatsContainerButton9.left
        anchors.top: achievementFrameStatsContainerButton9.bottom
        width: 496
        height: 24
    }

    Part {
        id: achievementFrameStatsContainerButton10Value
        name: "AchievementFrameStatsContainerButton10Value"
        kind: "FontString"
        wowParent: "AchievementFrameStatsContainerButton10"
        anchors.right: achievementFrameStatsContainerButton10.right
        anchors.rightMargin: 5
        anchors.verticalCenter: achievementFrameStatsContainerButton10.verticalCenter
        width: 110.2
        height: 11.9
    }

    Part {
        id: achievementFrameStatsContainerButton11
        name: "AchievementFrameStatsContainerButton11"
        kind: "Button"
        text: "Bandages used"
        wowParent: "AchievementFrameStatsContainerScrollChild"
        anchors.left: achievementFrameStatsContainerButton10.left
        anchors.top: achievementFrameStatsContainerButton10.bottom
        width: 496
        height: 24
    }

    Part {
        id: achievementFrameStatsContainerButton11Value
        name: "AchievementFrameStatsContainerButton11Value"
        kind: "FontString"
        text: "49"
        wowParent: "AchievementFrameStatsContainerButton11"
        anchors.right: achievementFrameStatsContainerButton11.right
        anchors.rightMargin: 5
        anchors.verticalCenter: achievementFrameStatsContainerButton11.verticalCenter
        width: 16.6
        height: 11.9
    }

    Part {
        id: achievementFrameStatsContainerButton12
        name: "AchievementFrameStatsContainerButton12"
        kind: "Button"
        text: "Flight paths taken"
        wowParent: "AchievementFrameStatsContainerScrollChild"
        anchors.left: achievementFrameStatsContainerButton11.left
        anchors.top: achievementFrameStatsContainerButton11.bottom
        width: 496
        height: 24
    }

    Part {
        id: achievementFrameStatsContainerButton12Value
        name: "AchievementFrameStatsContainerButton12Value"
        kind: "FontString"
        text: "278"
        wowParent: "AchievementFrameStatsContainerButton12"
        anchors.right: achievementFrameStatsContainerButton12.right
        anchors.rightMargin: 5
        anchors.verticalCenter: achievementFrameStatsContainerButton12.verticalCenter
        width: 24.5
        height: 11.9
    }

    Part {
        id: achievementFrameStatsContainerButton13
        name: "AchievementFrameStatsContainerButton13"
        kind: "Button"
        text: "Most factions at Exalted"
        wowParent: "AchievementFrameStatsContainerScrollChild"
        anchors.left: achievementFrameStatsContainerButton12.left
        anchors.top: achievementFrameStatsContainerButton12.bottom
        width: 496
        height: 24
    }

    Part {
        id: achievementFrameStatsContainerButton13Value
        name: "AchievementFrameStatsContainerButton13Value"
        kind: "FontString"
        text: "18"
        wowParent: "AchievementFrameStatsContainerButton13"
        anchors.right: achievementFrameStatsContainerButton13.right
        anchors.rightMargin: 5
        anchors.verticalCenter: achievementFrameStatsContainerButton13.verticalCenter
        width: 16.6
        height: 11.9
    }

    Part {
        id: achievementFrameStatsContainerButton14
        name: "AchievementFrameStatsContainerButton14"
        kind: "Button"
        text: "Total Honorable Kills"
        wowParent: "AchievementFrameStatsContainerScrollChild"
        anchors.left: achievementFrameStatsContainerButton13.left
        anchors.top: achievementFrameStatsContainerButton13.bottom
        width: 496
        height: 24
    }

    Part {
        id: achievementFrameStatsContainerButton14Value
        name: "AchievementFrameStatsContainerButton14Value"
        kind: "FontString"
        text: "66"
        wowParent: "AchievementFrameStatsContainerButton14"
        anchors.right: achievementFrameStatsContainerButton14.right
        anchors.rightMargin: 5
        anchors.verticalCenter: achievementFrameStatsContainerButton14.verticalCenter
        width: 16.6
        height: 11.9
    }

    Part {
        id: achievementFrameStatsContainerButton15
        name: "AchievementFrameStatsContainerButton15"
        kind: "Button"
        text: "Resurrected by priests"
        wowParent: "AchievementFrameStatsContainerScrollChild"
        anchors.left: achievementFrameStatsContainerButton14.left
        anchors.top: achievementFrameStatsContainerButton14.bottom
        width: 496
        height: 24
    }

    Part {
        id: achievementFrameStatsContainerButton15Value
        name: "AchievementFrameStatsContainerButton15Value"
        kind: "FontString"
        text: "8"
        wowParent: "AchievementFrameStatsContainerButton15"
        anchors.right: achievementFrameStatsContainerButton15.right
        anchors.rightMargin: 5
        anchors.verticalCenter: achievementFrameStatsContainerButton15.verticalCenter
        width: 9.5
        height: 11.9
    }

    Part {
        id: achievementFrameStatsContainerButton16
        name: "AchievementFrameStatsContainerButton16"
        kind: "Button"
        text: "Arenas won"
        wowParent: "AchievementFrameStatsContainerScrollChild"
        anchors.left: achievementFrameStatsContainerButton15.left
        anchors.top: achievementFrameStatsContainerButton15.bottom
        width: 496
        height: 24
    }

    Part {
        id: achievementFrameStatsContainerButton16Value
        name: "AchievementFrameStatsContainerButton16Value"
        kind: "FontString"
        text: "--"
        wowParent: "AchievementFrameStatsContainerButton16"
        anchors.right: achievementFrameStatsContainerButton16.right
        anchors.rightMargin: 5
        anchors.verticalCenter: achievementFrameStatsContainerButton16.verticalCenter
        width: 11.1
        height: 11.9
    }

    Part {
        id: achievementFrameStatsContainerButton17
        name: "AchievementFrameStatsContainerButton17"
        kind: "Button"
        text: "Battlegrounds played"
        wowParent: "AchievementFrameStatsContainerScrollChild"
        anchors.left: achievementFrameStatsContainerButton16.left
        anchors.top: achievementFrameStatsContainerButton16.bottom
        width: 496
        height: 24
    }

    Part {
        id: achievementFrameStatsContainerButton17Title
        name: "AchievementFrameStatsContainerButton17Title"
        kind: "FontString"
        text: "Professions"
        anchors.horizontalCenter: achievementFrameStatsContainerButton17.horizontalCenter
        anchors.verticalCenter: achievementFrameStatsContainerButton17.verticalCenter
        width: 66
        height: 12
    }

    Part {
        id: achievementFrameStatsContainerButton17Value
        name: "AchievementFrameStatsContainerButton17Value"
        kind: "FontString"
        text: "6"
        wowParent: "AchievementFrameStatsContainerButton17"
        anchors.right: achievementFrameStatsContainerButton17.right
        anchors.rightMargin: 5
        anchors.verticalCenter: achievementFrameStatsContainerButton17.verticalCenter
        width: 8.7
        height: 11.9
    }

    Part {
        id: achievementFrameStatsContainerButton18
        name: "AchievementFrameStatsContainerButton18"
        kind: "Button"
        text: "Equipped epic items in item slots"
        wowParent: "AchievementFrameStatsContainerScrollChild"
        anchors.left: achievementFrameStatsContainerButton17.left
        anchors.top: achievementFrameStatsContainerButton17.bottom
        width: 496
        height: 24
    }

    Part {
        id: achievementFrameStatsContainerButton18Value
        name: "AchievementFrameStatsContainerButton18Value"
        kind: "FontString"
        text: "--"
        wowParent: "AchievementFrameStatsContainerButton18"
        anchors.right: achievementFrameStatsContainerButton18.right
        anchors.rightMargin: 5
        anchors.verticalCenter: achievementFrameStatsContainerButton18.verticalCenter
        width: 11.1
        height: 11.9
    }

    Part {
        id: achievementFrameStatsContainerButton19
        name: "AchievementFrameStatsContainerButton19"
        kind: "Button"
        text: "Total 5-player dungeons entered"
        wowParent: "AchievementFrameStatsContainerScrollChild"
        anchors.left: achievementFrameStatsContainerButton18.left
        anchors.top: achievementFrameStatsContainerButton18.bottom
        width: 496
        height: 24
    }

    Part {
        id: achievementFrameStatsContainerButton19Value
        name: "AchievementFrameStatsContainerButton19Value"
        kind: "FontString"
        text: "462"
        wowParent: "AchievementFrameStatsContainerButton19"
        anchors.right: achievementFrameStatsContainerButton19.right
        anchors.rightMargin: 5
        anchors.verticalCenter: achievementFrameStatsContainerButton19.verticalCenter
        width: 24.5
        height: 11.9
    }

    Part {
        id: achievementFrameStatsContainerButton1Title
        name: "AchievementFrameStatsContainerButton1Title"
        kind: "FontString"
        text: "Summary"
        wowParent: "AchievementFrameStatsContainerButton1"
        anchors.horizontalCenter: achievementFrameStatsContainerButton1.horizontalCenter
        anchors.verticalCenter: achievementFrameStatsContainerButton1.verticalCenter
        width: 74.3
        height: 15.8
    }

    Part {
        id: achievementFrameStatsContainerButton1Value
        name: "AchievementFrameStatsContainerButton1Value"
        kind: "FontString"
        wowParent: "AchievementFrameStatsContainerButton1"
        anchors.right: achievementFrameStatsContainerButton1.right
        anchors.rightMargin: 5
        anchors.verticalCenter: achievementFrameStatsContainerButton1.verticalCenter
        width: 1
        height: 1
    }

    Part {
        id: achievementFrameStatsContainerButton2
        name: "AchievementFrameStatsContainerButton2"
        kind: "Button"
        text: "Deaths in Alterac Valley"
        wowParent: "AchievementFrameStatsContainerScrollChild"
        anchors.left: achievementFrameStatsContainerButton1.left
        anchors.top: achievementFrameStatsContainerButton1.bottom
        width: 496
        height: 24
    }

    Part {
        id: achievementFrameStatsContainerButton20
        name: "AchievementFrameStatsContainerButton20"
        kind: "Button"
        text: "Number of hugs"
        wowParent: "AchievementFrameStatsContainerScrollChild"
        anchors.left: achievementFrameStatsContainerButton19.left
        anchors.top: achievementFrameStatsContainerButton19.bottom
        width: 496
        height: 24
    }

    Part {
        id: achievementFrameStatsContainerButton20Value
        name: "AchievementFrameStatsContainerButton20Value"
        kind: "FontString"
        text: "--"
        wowParent: "AchievementFrameStatsContainerButton20"
        anchors.right: achievementFrameStatsContainerButton20.right
        anchors.rightMargin: 5
        anchors.verticalCenter: achievementFrameStatsContainerButton20.verticalCenter
        width: 11.1
        height: 11.9
    }

    Part {
        id: achievementFrameStatsContainerButton2Value
        name: "AchievementFrameStatsContainerButton2Value"
        kind: "FontString"
        text: "--"
        wowParent: "AchievementFrameStatsContainerButton2"
        anchors.right: achievementFrameStatsContainerButton2.right
        anchors.rightMargin: 5
        anchors.verticalCenter: achievementFrameStatsContainerButton2.verticalCenter
        width: 11.1
        height: 11.9
    }

    Part {
        id: achievementFrameStatsContainerButton3
        name: "AchievementFrameStatsContainerButton3"
        kind: "Button"
        text: "Total deaths"
        wowParent: "AchievementFrameStatsContainerScrollChild"
        anchors.left: achievementFrameStatsContainerButton2.left
        anchors.top: achievementFrameStatsContainerButton2.bottom
        width: 496
        height: 24
    }

    Part {
        id: achievementFrameStatsContainerButton3Value
        name: "AchievementFrameStatsContainerButton3Value"
        kind: "FontString"
        text: "371"
        wowParent: "AchievementFrameStatsContainerButton3"
        anchors.right: achievementFrameStatsContainerButton3.right
        anchors.rightMargin: 5
        anchors.verticalCenter: achievementFrameStatsContainerButton3.verticalCenter
        width: 21.3
        height: 11.9
    }

    Part {
        id: achievementFrameStatsContainerButton4
        name: "AchievementFrameStatsContainerButton4"
        kind: "Button"
        text: "Quests completed"
        wowParent: "AchievementFrameStatsContainerScrollChild"
        anchors.left: achievementFrameStatsContainerButton3.left
        anchors.top: achievementFrameStatsContainerButton3.bottom
        width: 496
        height: 24
    }

    Part {
        id: achievementFrameStatsContainerButton4Title
        name: "AchievementFrameStatsContainerButton4Title"
        kind: "FontString"
        text: "Rated Arenas"
        anchors.horizontalCenter: achievementFrameStatsContainerButton4.horizontalCenter
        anchors.verticalCenter: achievementFrameStatsContainerButton4.verticalCenter
        width: 72
        height: 12
    }

    Part {
        id: achievementFrameStatsContainerButton4Value
        name: "AchievementFrameStatsContainerButton4Value"
        kind: "FontString"
        text: "2384"
        wowParent: "AchievementFrameStatsContainerButton4"
        anchors.right: achievementFrameStatsContainerButton4.right
        anchors.rightMargin: 5
        anchors.verticalCenter: achievementFrameStatsContainerButton4.verticalCenter
        width: 33.2
        height: 11.9
    }

    Part {
        id: achievementFrameStatsContainerButton5
        name: "AchievementFrameStatsContainerButton5"
        kind: "Button"
        text: "Creatures killed"
        wowParent: "AchievementFrameStatsContainerScrollChild"
        anchors.left: achievementFrameStatsContainerButton4.left
        anchors.top: achievementFrameStatsContainerButton4.bottom
        width: 496
        height: 24
    }

    Part {
        id: achievementFrameStatsContainerButton5Value
        name: "AchievementFrameStatsContainerButton5Value"
        kind: "FontString"
        text: "42931"
        wowParent: "AchievementFrameStatsContainerButton5"
        anchors.right: achievementFrameStatsContainerButton5.right
        anchors.rightMargin: 5
        anchors.verticalCenter: achievementFrameStatsContainerButton5.verticalCenter
        width: 37.9
        height: 11.9
    }

    Part {
        id: achievementFrameStatsContainerButton6
        name: "AchievementFrameStatsContainerButton6"
        kind: "Button"
        text: "Deaths from drowning"
        wowParent: "AchievementFrameStatsContainerScrollChild"
        anchors.left: achievementFrameStatsContainerButton5.left
        anchors.top: achievementFrameStatsContainerButton5.bottom
        width: 496
        height: 24
    }

    Part {
        id: achievementFrameStatsContainerButton6Title
        name: "AchievementFrameStatsContainerButton6Title"
        kind: "FontString"
        text: "Secondary Skills"
        anchors.horizontalCenter: achievementFrameStatsContainerButton6.horizontalCenter
        anchors.verticalCenter: achievementFrameStatsContainerButton6.verticalCenter
        width: 96
        height: 12
    }

    Part {
        id: achievementFrameStatsContainerButton6Value
        name: "AchievementFrameStatsContainerButton6Value"
        kind: "FontString"
        text: "1"
        wowParent: "AchievementFrameStatsContainerButton6"
        anchors.right: achievementFrameStatsContainerButton6.right
        anchors.rightMargin: 5
        anchors.verticalCenter: achievementFrameStatsContainerButton6.verticalCenter
        width: 7.1
        height: 11.9
    }

    Part {
        id: achievementFrameStatsContainerButton7
        name: "AchievementFrameStatsContainerButton7"
        kind: "Button"
        text: "Largest hit dealt"
        wowParent: "AchievementFrameStatsContainerScrollChild"
        anchors.left: achievementFrameStatsContainerButton6.left
        anchors.top: achievementFrameStatsContainerButton6.bottom
        width: 496
        height: 24
    }

    Part {
        id: achievementFrameStatsContainerButton7Value
        name: "AchievementFrameStatsContainerButton7Value"
        kind: "FontString"
        text: "--"
        wowParent: "AchievementFrameStatsContainerButton7"
        anchors.right: achievementFrameStatsContainerButton7.right
        anchors.rightMargin: 5
        anchors.verticalCenter: achievementFrameStatsContainerButton7.verticalCenter
        width: 11.1
        height: 11.9
    }

    Part {
        id: achievementFrameStatsContainerButton8
        name: "AchievementFrameStatsContainerButton8"
        kind: "Button"
        text: "Duels won"
        wowParent: "AchievementFrameStatsContainerScrollChild"
        anchors.left: achievementFrameStatsContainerButton7.left
        anchors.top: achievementFrameStatsContainerButton7.bottom
        width: 496
        height: 24
    }

    Part {
        id: achievementFrameStatsContainerButton8Value
        name: "AchievementFrameStatsContainerButton8Value"
        kind: "FontString"
        text: "3"
        wowParent: "AchievementFrameStatsContainerButton8"
        anchors.right: achievementFrameStatsContainerButton8.right
        anchors.rightMargin: 5
        anchors.verticalCenter: achievementFrameStatsContainerButton8.verticalCenter
        width: 8.7
        height: 11.9
    }

    Part {
        id: achievementFrameStatsContainerButton9
        name: "AchievementFrameStatsContainerButton9"
        kind: "Button"
        text: "Total raid and dungeon deaths"
        wowParent: "AchievementFrameStatsContainerScrollChild"
        anchors.left: achievementFrameStatsContainerButton8.left
        anchors.top: achievementFrameStatsContainerButton8.bottom
        width: 496
        height: 24
    }

    Part {
        id: achievementFrameStatsContainerButton9Title
        name: "AchievementFrameStatsContainerButton9Title"
        kind: "FontString"
        text: "Wealth"
        anchors.horizontalCenter: achievementFrameStatsContainerButton9.horizontalCenter
        anchors.verticalCenter: achievementFrameStatsContainerButton9.verticalCenter
        width: 36
        height: 12
    }

    Part {
        id: achievementFrameStatsContainerButton9Value
        name: "AchievementFrameStatsContainerButton9Value"
        kind: "FontString"
        text: "169"
        wowParent: "AchievementFrameStatsContainerButton9"
        anchors.right: achievementFrameStatsContainerButton9.right
        anchors.rightMargin: 5
        anchors.verticalCenter: achievementFrameStatsContainerButton9.verticalCenter
        width: 23.7
        height: 11.9
    }

    Part {
        id: achievementFrameStatsContainerScrollBar
        name: "AchievementFrameStatsContainerScrollBar"
        kind: "Slider"
        wowParent: "AchievementFrameStatsContainer"
        anchors.left: achievementFrameStatsContainer.right
        anchors.leftMargin: 1
        anchors.top: achievementFrameStatsContainer.top
        anchors.topMargin: 16
        width: 20
        height: 425
    }

    Part {
        id: achievementFrameStatsContainerScrollBarDiabolicTrack
        name: "AchievementFrameStatsContainerScrollBarDiabolicTrack"
        kind: "Frame"
        wowParent: "AchievementFrameStatsContainerScrollBar"
        anchors.horizontalCenter: achievementFrameStatsContainerScrollBarScrollUpButton.horizontalCenter
        anchors.top: achievementFrameStatsContainerScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 455
    }

    Part {
        id: achievementFrameStatsContainerScrollBarScrollDownButton
        name: "AchievementFrameStatsContainerScrollBarScrollDownButton"
        kind: "Button"
        wowParent: "AchievementFrameStatsContainerScrollBar"
        anchors.horizontalCenter: achievementFrameStatsContainerScrollBar.horizontalCenter
        anchors.top: achievementFrameStatsContainerScrollBar.bottom
        anchors.topMargin: -2
        width: 16
        height: 16
    }

    Part {
        id: achievementFrameStatsContainerScrollBarScrollUpButton
        name: "AchievementFrameStatsContainerScrollBarScrollUpButton"
        kind: "Button"
        wowParent: "AchievementFrameStatsContainerScrollBar"
        anchors.horizontalCenter: achievementFrameStatsContainerScrollBar.horizontalCenter
        anchors.bottom: achievementFrameStatsContainerScrollBar.top
        anchors.bottomMargin: -2
        width: 16
        height: 16
    }

    Part {
        id: achievementFrameStatsContainerScrollChild
        name: "AchievementFrameStatsContainerScrollChild"
        kind: "Frame"
        wowParent: "AchievementFrameStatsContainer"
        anchors.left: achievementFrameStatsContainer.left
        anchors.top: achievementFrameStatsContainer.top
        width: 503
        height: 480
    }

    Part {
        id: achievementFrameSummary
        name: "AchievementFrameSummary"
        kind: "Frame"
        anchors.left: achievementFrameCategories.right
        anchors.top: achievementFrameCategories.top
        width: 530
        height: 461
    }

    Part {
        id: achievementFrameSummaryAchievement1
        name: "AchievementFrameSummaryAchievement1"
        kind: "Button"
        anchors.left: achievementFrameSummaryAchievementsHeader.left
        anchors.leftMargin: 18
        anchors.top: achievementFrameSummaryAchievementsHeader.bottom
        anchors.topMargin: -2
        width: 100
        height: 48
    }

    Part {
        id: achievementFrameSummaryAchievement1DateCompleted
        name: "AchievementFrameSummaryAchievement1DateCompleted"
        kind: "FontString"
        text: "10/30/26"
        anchors.right: achievementFrameSummaryAchievement1.right
        anchors.rightMargin: 63
        anchors.top: achievementFrameSummaryAchievement1.top
        anchors.topMargin: 8
        width: 48
        height: 12
    }

    Part {
        id: achievementFrameSummaryAchievement1Description
        name: "AchievementFrameSummaryAchievement1Description"
        kind: "FontString"
        text: "Show off your sparkling smile by using a Tooth Pick."
        anchors.horizontalCenter: achievementFrameSummaryAchievement1.horizontalCenter
        anchors.top: achievementFrameSummaryAchievement1.top
        anchors.topMargin: 30
        width: 312
        height: 12
    }

    Part {
        id: achievementFrameSummaryAchievement1Icon
        name: "AchievementFrameSummaryAchievement1Icon"
        kind: "Frame"
        anchors.left: achievementFrameSummaryAchievement1.left
        anchors.leftMargin: 3
        anchors.top: achievementFrameSummaryAchievement1.top
        anchors.topMargin: 3
        width: 48
        height: 48
    }

    Part {
        id: achievementFrameSummaryAchievement1Label
        name: "AchievementFrameSummaryAchievement1Label"
        kind: "FontString"
        text: "That Sparkling Smile"
        anchors.horizontalCenter: achievementFrameSummaryAchievement1TitleBackground.horizontalCenter
        anchors.top: achievementFrameSummaryAchievement1TitleBackground.top
        width: 120
        height: 12
    }

    Part {
        id: achievementFrameSummaryAchievement1Shield
        name: "AchievementFrameSummaryAchievement1Shield"
        kind: "Frame"
        anchors.right: achievementFrameSummaryAchievement1.right
        anchors.rightMargin: 10
        anchors.top: achievementFrameSummaryAchievement1.top
        anchors.topMargin: 4
        width: 48
        height: 48
    }

    Part {
        id: achievementFrameSummaryAchievement1ShieldPoints
        name: "AchievementFrameSummaryAchievement1ShieldPoints"
        kind: "FontString"
        text: "10"
        anchors.horizontalCenter: achievementFrameSummaryAchievement1Shield.horizontalCenter
        anchors.horizontalCenterOffset: -1
        anchors.verticalCenter: achievementFrameSummaryAchievement1Shield.verticalCenter
        anchors.verticalCenterOffset: -3
        width: 12
        height: 12
    }

    Part {
        id: achievementFrameSummaryAchievement2
        name: "AchievementFrameSummaryAchievement2"
        kind: "Button"
        anchors.left: achievementFrameSummaryAchievement1.left
        anchors.top: achievementFrameSummaryAchievement1.bottom
        anchors.topMargin: -3
        width: 100
        height: 48
    }

    Part {
        id: achievementFrameSummaryAchievement2DateCompleted
        name: "AchievementFrameSummaryAchievement2DateCompleted"
        kind: "FontString"
        text: "10/30/26"
        anchors.right: achievementFrameSummaryAchievement2.right
        anchors.rightMargin: 63
        anchors.top: achievementFrameSummaryAchievement2.top
        anchors.topMargin: 8
        width: 48
        height: 12
    }

    Part {
        id: achievementFrameSummaryAchievement2Description
        name: "AchievementFrameSummaryAchievement2Description"
        kind: "FontString"
        text: "Earn exalted status with and the right to represent every Alliance race's faction in the Argent Tournament."
        anchors.horizontalCenter: achievementFrameSummaryAchievement2.horizontalCenter
        anchors.top: achievementFrameSummaryAchievement2.top
        anchors.topMargin: 30
        width: 642
        height: 12
    }

    Part {
        id: achievementFrameSummaryAchievement2Icon
        name: "AchievementFrameSummaryAchievement2Icon"
        kind: "Frame"
        anchors.left: achievementFrameSummaryAchievement2.left
        anchors.leftMargin: 3
        anchors.top: achievementFrameSummaryAchievement2.top
        anchors.topMargin: 3
        width: 48
        height: 48
    }

    Part {
        id: achievementFrameSummaryAchievement2Label
        name: "AchievementFrameSummaryAchievement2Label"
        kind: "FontString"
        text: "Exalted Argent Champion of the Alliance"
        anchors.horizontalCenter: achievementFrameSummaryAchievement2TitleBackground.horizontalCenter
        anchors.top: achievementFrameSummaryAchievement2TitleBackground.top
        width: 234
        height: 12
    }

    Part {
        id: achievementFrameSummaryAchievement2Shield
        name: "AchievementFrameSummaryAchievement2Shield"
        kind: "Frame"
        anchors.right: achievementFrameSummaryAchievement2.right
        anchors.rightMargin: 10
        anchors.top: achievementFrameSummaryAchievement2.top
        anchors.topMargin: 4
        width: 48
        height: 48
    }

    Part {
        id: achievementFrameSummaryAchievement2ShieldPoints
        name: "AchievementFrameSummaryAchievement2ShieldPoints"
        kind: "FontString"
        text: "10"
        anchors.horizontalCenter: achievementFrameSummaryAchievement2Shield.horizontalCenter
        anchors.horizontalCenterOffset: -1
        anchors.verticalCenter: achievementFrameSummaryAchievement2Shield.verticalCenter
        anchors.verticalCenterOffset: -3
        width: 12
        height: 12
    }

    Part {
        id: achievementFrameSummaryAchievement3
        name: "AchievementFrameSummaryAchievement3"
        kind: "Button"
        anchors.left: achievementFrameSummaryAchievement2.left
        anchors.top: achievementFrameSummaryAchievement2.bottom
        anchors.topMargin: -3
        width: 100
        height: 48
    }

    Part {
        id: achievementFrameSummaryAchievement3DateCompleted
        name: "AchievementFrameSummaryAchievement3DateCompleted"
        kind: "FontString"
        text: "10/30/26"
        anchors.right: achievementFrameSummaryAchievement3.right
        anchors.rightMargin: 63
        anchors.top: achievementFrameSummaryAchievement3.top
        anchors.topMargin: 8
        width: 48
        height: 12
    }

    Part {
        id: achievementFrameSummaryAchievement3Description
        name: "AchievementFrameSummaryAchievement3Description"
        kind: "FontString"
        text: "Earn exalted status with and the right to represent every Alliance race's faction in the Argent Tournament."
        anchors.horizontalCenter: achievementFrameSummaryAchievement3.horizontalCenter
        anchors.top: achievementFrameSummaryAchievement3.top
        anchors.topMargin: 30
        width: 642
        height: 12
    }

    Part {
        id: achievementFrameSummaryAchievement3Highlight
        name: "AchievementFrameSummaryAchievement3Highlight"
        kind: "Frame"
        anchors.left: achievementFrameSummaryAchievement3.left
        anchors.top: achievementFrameSummaryAchievement3.top
        width: 484
        height: 48
    }

    Part {
        id: achievementFrameSummaryAchievement3Icon
        name: "AchievementFrameSummaryAchievement3Icon"
        kind: "Frame"
        anchors.left: achievementFrameSummaryAchievement3.left
        anchors.leftMargin: 3
        anchors.top: achievementFrameSummaryAchievement3.top
        anchors.topMargin: 3
        width: 48
        height: 48
    }

    Part {
        id: achievementFrameSummaryAchievement3Label
        name: "AchievementFrameSummaryAchievement3Label"
        kind: "FontString"
        text: "Exalted Champion of the Alliance"
        anchors.horizontalCenter: achievementFrameSummaryAchievement3TitleBackground.horizontalCenter
        anchors.top: achievementFrameSummaryAchievement3TitleBackground.top
        width: 192
        height: 12
    }

    Part {
        id: achievementFrameSummaryAchievement3Shield
        name: "AchievementFrameSummaryAchievement3Shield"
        kind: "Frame"
        anchors.right: achievementFrameSummaryAchievement3.right
        anchors.rightMargin: 10
        anchors.top: achievementFrameSummaryAchievement3.top
        anchors.topMargin: 4
        width: 48
        height: 48
    }

    Part {
        id: achievementFrameSummaryAchievement3ShieldPoints
        name: "AchievementFrameSummaryAchievement3ShieldPoints"
        kind: "FontString"
        text: "10"
        anchors.horizontalCenter: achievementFrameSummaryAchievement3Shield.horizontalCenter
        anchors.horizontalCenterOffset: -1
        anchors.verticalCenter: achievementFrameSummaryAchievement3Shield.verticalCenter
        anchors.verticalCenterOffset: -3
        width: 12
        height: 12
    }

    Part {
        id: achievementFrameSummaryAchievement4
        name: "AchievementFrameSummaryAchievement4"
        kind: "Button"
        anchors.left: achievementFrameSummaryAchievement3.left
        anchors.top: achievementFrameSummaryAchievement3.bottom
        anchors.topMargin: -3
        width: 100
        height: 48
    }

    Part {
        id: achievementFrameSummaryAchievement4DateCompleted
        name: "AchievementFrameSummaryAchievement4DateCompleted"
        kind: "FontString"
        text: "10/30/26"
        anchors.right: achievementFrameSummaryAchievement4.right
        anchors.rightMargin: 63
        anchors.top: achievementFrameSummaryAchievement4.top
        anchors.topMargin: 8
        width: 48
        height: 12
    }

    Part {
        id: achievementFrameSummaryAchievement4Description
        name: "AchievementFrameSummaryAchievement4Description"
        kind: "FontString"
        text: "Earn exalted reputation with 5 home cities."
        anchors.horizontalCenter: achievementFrameSummaryAchievement4.horizontalCenter
        anchors.top: achievementFrameSummaryAchievement4.top
        anchors.topMargin: 30
        width: 258
        height: 12
    }

    Part {
        id: achievementFrameSummaryAchievement4Icon
        name: "AchievementFrameSummaryAchievement4Icon"
        kind: "Frame"
        anchors.left: achievementFrameSummaryAchievement4.left
        anchors.leftMargin: 3
        anchors.top: achievementFrameSummaryAchievement4.top
        anchors.topMargin: 3
        width: 48
        height: 48
    }

    Part {
        id: achievementFrameSummaryAchievement4Label
        name: "AchievementFrameSummaryAchievement4Label"
        kind: "FontString"
        text: "Ambassador of the Alliance"
        anchors.horizontalCenter: achievementFrameSummaryAchievement4TitleBackground.horizontalCenter
        anchors.top: achievementFrameSummaryAchievement4TitleBackground.top
        width: 156
        height: 12
    }

    Part {
        id: achievementFrameSummaryAchievement4Shield
        name: "AchievementFrameSummaryAchievement4Shield"
        kind: "Frame"
        anchors.right: achievementFrameSummaryAchievement4.right
        anchors.rightMargin: 10
        anchors.top: achievementFrameSummaryAchievement4.top
        anchors.topMargin: 4
        width: 48
        height: 48
    }

    Part {
        id: achievementFrameSummaryAchievement4ShieldPoints
        name: "AchievementFrameSummaryAchievement4ShieldPoints"
        kind: "FontString"
        text: "10"
        anchors.horizontalCenter: achievementFrameSummaryAchievement4Shield.horizontalCenter
        anchors.horizontalCenterOffset: -1
        anchors.verticalCenter: achievementFrameSummaryAchievement4Shield.verticalCenter
        anchors.verticalCenterOffset: -3
        width: 12
        height: 12
    }

    Part {
        id: achievementFrameSummaryAchievements
        name: "AchievementFrameSummaryAchievements"
        kind: "Frame"
        anchors.left: achievementFrameSummary.left
        anchors.leftMargin: 5
        anchors.top: achievementFrameSummary.top
        anchors.topMargin: 20
        width: 520
        height: 210
    }

    Part {
        id: achievementFrameSummaryAchievementsHeader
        name: "AchievementFrameSummaryAchievementsHeader"
        kind: "Frame"
        anchors.left: achievementFrameSummaryAchievements.left
        anchors.top: achievementFrameSummaryAchievements.top
        width: 520
        height: 20
    }

    Part {
        id: achievementFrameSummaryAchievementsHeaderTitle
        name: "AchievementFrameSummaryAchievementsHeaderTitle"
        kind: "FontString"
        text: "Recent Achievements"
        anchors.left: achievementFrameSummaryAchievementsHeader.left
        anchors.leftMargin: 28
        anchors.verticalCenter: achievementFrameSummaryAchievementsHeader.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 114
        height: 12
    }

    Part {
        id: achievementFrameSummaryCategories
        name: "AchievementFrameSummaryCategories"
        kind: "Frame"
        anchors.left: achievementFrameSummaryAchievements.left
        anchors.top: achievementFrameSummaryAchievements.bottom
        anchors.topMargin: 8
        width: 520
        height: 164
    }

    Part {
        id: achievementFrameSummaryCategoriesCategory1
        name: "AchievementFrameSummaryCategoriesCategory1"
        kind: "StatusBar"
        anchors.left: achievementFrameSummaryCategoriesStatusBar.left
        anchors.top: achievementFrameSummaryCategoriesStatusBar.bottom
        anchors.topMargin: 24
        width: 224
        height: 16
    }

    Part {
        id: achievementFrameSummaryCategoriesCategory1Button
        name: "AchievementFrameSummaryCategoriesCategory1Button"
        kind: "Button"
        anchors.left: achievementFrameSummaryCategoriesCategory1.left
        anchors.top: achievementFrameSummaryCategoriesCategory1.top
        width: 224
        height: 16
    }

    Part {
        id: achievementFrameSummaryCategoriesCategory1Label
        name: "AchievementFrameSummaryCategoriesCategory1Label"
        kind: "FontString"
        text: "General"
        anchors.left: achievementFrameSummaryCategoriesCategory1.left
        anchors.leftMargin: 8
        anchors.verticalCenter: achievementFrameSummaryCategoriesCategory1.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 42
        height: 12
    }

    Part {
        id: achievementFrameSummaryCategoriesCategory1Text
        name: "AchievementFrameSummaryCategoriesCategory1Text"
        kind: "FontString"
        text: "29/54"
        anchors.right: achievementFrameSummaryCategoriesCategory1.right
        anchors.rightMargin: 8
        anchors.verticalCenter: achievementFrameSummaryCategoriesCategory1.verticalCenter
        width: 30
        height: 12
    }

    Part {
        id: achievementFrameSummaryCategoriesCategory2
        name: "AchievementFrameSummaryCategoriesCategory2"
        kind: "StatusBar"
        anchors.left: achievementFrameSummaryCategoriesCategory1.right
        anchors.leftMargin: 24
        anchors.top: achievementFrameSummaryCategoriesCategory1.top
        width: 224
        height: 16
    }

    Part {
        id: achievementFrameSummaryCategoriesCategory2Button
        name: "AchievementFrameSummaryCategoriesCategory2Button"
        kind: "Button"
        anchors.left: achievementFrameSummaryCategoriesCategory2.left
        anchors.top: achievementFrameSummaryCategoriesCategory2.top
        width: 224
        height: 16
    }

    Part {
        id: achievementFrameSummaryCategoriesCategory2Label
        name: "AchievementFrameSummaryCategoriesCategory2Label"
        kind: "FontString"
        text: "Quests"
        anchors.left: achievementFrameSummaryCategoriesCategory2.left
        anchors.leftMargin: 8
        anchors.verticalCenter: achievementFrameSummaryCategoriesCategory2.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 36
        height: 12
    }

    Part {
        id: achievementFrameSummaryCategoriesCategory2Text
        name: "AchievementFrameSummaryCategoriesCategory2Text"
        kind: "FontString"
        text: "28/49"
        anchors.right: achievementFrameSummaryCategoriesCategory2.right
        anchors.rightMargin: 8
        anchors.verticalCenter: achievementFrameSummaryCategoriesCategory2.verticalCenter
        width: 30
        height: 12
    }

    Part {
        id: achievementFrameSummaryCategoriesCategory3
        name: "AchievementFrameSummaryCategoriesCategory3"
        kind: "StatusBar"
        anchors.left: achievementFrameSummaryCategoriesCategory1.left
        anchors.top: achievementFrameSummaryCategoriesCategory1.bottom
        anchors.topMargin: 14
        width: 224
        height: 16
    }

    Part {
        id: achievementFrameSummaryCategoriesCategory3Button
        name: "AchievementFrameSummaryCategoriesCategory3Button"
        kind: "Button"
        anchors.left: achievementFrameSummaryCategoriesCategory3.left
        anchors.top: achievementFrameSummaryCategoriesCategory3.top
        width: 224
        height: 16
    }

    Part {
        id: achievementFrameSummaryCategoriesCategory3Label
        name: "AchievementFrameSummaryCategoriesCategory3Label"
        kind: "FontString"
        text: "Exploration"
        anchors.left: achievementFrameSummaryCategoriesCategory3.left
        anchors.leftMargin: 8
        anchors.verticalCenter: achievementFrameSummaryCategoriesCategory3.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 66
        height: 12
    }

    Part {
        id: achievementFrameSummaryCategoriesCategory3Text
        name: "AchievementFrameSummaryCategoriesCategory3Text"
        kind: "FontString"
        text: "22/70"
        anchors.right: achievementFrameSummaryCategoriesCategory3.right
        anchors.rightMargin: 8
        anchors.verticalCenter: achievementFrameSummaryCategoriesCategory3.verticalCenter
        width: 30
        height: 12
    }

    Part {
        id: achievementFrameSummaryCategoriesCategory4
        name: "AchievementFrameSummaryCategoriesCategory4"
        kind: "StatusBar"
        anchors.left: achievementFrameSummaryCategoriesCategory3.right
        anchors.leftMargin: 24
        anchors.top: achievementFrameSummaryCategoriesCategory3.top
        width: 224
        height: 16
    }

    Part {
        id: achievementFrameSummaryCategoriesCategory4Button
        name: "AchievementFrameSummaryCategoriesCategory4Button"
        kind: "Button"
        anchors.left: achievementFrameSummaryCategoriesCategory4.left
        anchors.top: achievementFrameSummaryCategoriesCategory4.top
        width: 224
        height: 16
    }

    Part {
        id: achievementFrameSummaryCategoriesCategory4Label
        name: "AchievementFrameSummaryCategoriesCategory4Label"
        kind: "FontString"
        text: "Player vs. Player"
        anchors.left: achievementFrameSummaryCategoriesCategory4.left
        anchors.leftMargin: 8
        anchors.verticalCenter: achievementFrameSummaryCategoriesCategory4.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 102
        height: 12
    }

    Part {
        id: achievementFrameSummaryCategoriesCategory4Text
        name: "AchievementFrameSummaryCategoriesCategory4Text"
        kind: "FontString"
        text: "16/166"
        anchors.right: achievementFrameSummaryCategoriesCategory4.right
        anchors.rightMargin: 8
        anchors.verticalCenter: achievementFrameSummaryCategoriesCategory4.verticalCenter
        width: 36
        height: 12
    }

    Part {
        id: achievementFrameSummaryCategoriesCategory5
        name: "AchievementFrameSummaryCategoriesCategory5"
        kind: "StatusBar"
        anchors.left: achievementFrameSummaryCategoriesCategory3.left
        anchors.top: achievementFrameSummaryCategoriesCategory3.bottom
        anchors.topMargin: 14
        width: 224
        height: 16
    }

    Part {
        id: achievementFrameSummaryCategoriesCategory5Button
        name: "AchievementFrameSummaryCategoriesCategory5Button"
        kind: "Button"
        anchors.left: achievementFrameSummaryCategoriesCategory5.left
        anchors.top: achievementFrameSummaryCategoriesCategory5.top
        width: 224
        height: 16
    }

    Part {
        id: achievementFrameSummaryCategoriesCategory5Label
        name: "AchievementFrameSummaryCategoriesCategory5Label"
        kind: "FontString"
        text: "Dungeons & Raids"
        anchors.left: achievementFrameSummaryCategoriesCategory5.left
        anchors.leftMargin: 8
        anchors.verticalCenter: achievementFrameSummaryCategoriesCategory5.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 96
        height: 12
    }

    Part {
        id: achievementFrameSummaryCategoriesCategory5Text
        name: "AchievementFrameSummaryCategoriesCategory5Text"
        kind: "FontString"
        text: "121/458"
        anchors.right: achievementFrameSummaryCategoriesCategory5.right
        anchors.rightMargin: 8
        anchors.verticalCenter: achievementFrameSummaryCategoriesCategory5.verticalCenter
        width: 42
        height: 12
    }

    Part {
        id: achievementFrameSummaryCategoriesCategory6
        name: "AchievementFrameSummaryCategoriesCategory6"
        kind: "StatusBar"
        anchors.left: achievementFrameSummaryCategoriesCategory5.right
        anchors.leftMargin: 24
        anchors.top: achievementFrameSummaryCategoriesCategory5.top
        width: 224
        height: 16
    }

    Part {
        id: achievementFrameSummaryCategoriesCategory6Button
        name: "AchievementFrameSummaryCategoriesCategory6Button"
        kind: "Button"
        anchors.left: achievementFrameSummaryCategoriesCategory6.left
        anchors.top: achievementFrameSummaryCategoriesCategory6.top
        width: 224
        height: 16
    }

    Part {
        id: achievementFrameSummaryCategoriesCategory6Label
        name: "AchievementFrameSummaryCategoriesCategory6Label"
        kind: "FontString"
        text: "Professions"
        anchors.left: achievementFrameSummaryCategoriesCategory6.left
        anchors.leftMargin: 8
        anchors.verticalCenter: achievementFrameSummaryCategoriesCategory6.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 66
        height: 12
    }

    Part {
        id: achievementFrameSummaryCategoriesCategory6Text
        name: "AchievementFrameSummaryCategoriesCategory6Text"
        kind: "FontString"
        text: "50/75"
        anchors.right: achievementFrameSummaryCategoriesCategory6.right
        anchors.rightMargin: 8
        anchors.verticalCenter: achievementFrameSummaryCategoriesCategory6.verticalCenter
        width: 30
        height: 12
    }

    Part {
        id: achievementFrameSummaryCategoriesCategory7
        name: "AchievementFrameSummaryCategoriesCategory7"
        kind: "StatusBar"
        anchors.left: achievementFrameSummaryCategoriesCategory5.left
        anchors.top: achievementFrameSummaryCategoriesCategory5.bottom
        anchors.topMargin: 14
        width: 224
        height: 16
    }

    Part {
        id: achievementFrameSummaryCategoriesCategory7Button
        name: "AchievementFrameSummaryCategoriesCategory7Button"
        kind: "Button"
        anchors.left: achievementFrameSummaryCategoriesCategory7.left
        anchors.top: achievementFrameSummaryCategoriesCategory7.top
        width: 224
        height: 16
    }

    Part {
        id: achievementFrameSummaryCategoriesCategory7Label
        name: "AchievementFrameSummaryCategoriesCategory7Label"
        kind: "FontString"
        text: "Reputation"
        anchors.left: achievementFrameSummaryCategoriesCategory7.left
        anchors.leftMargin: 8
        anchors.verticalCenter: achievementFrameSummaryCategoriesCategory7.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 60
        height: 12
    }

    Part {
        id: achievementFrameSummaryCategoriesCategory7Text
        name: "AchievementFrameSummaryCategoriesCategory7Text"
        kind: "FontString"
        text: "16/45"
        anchors.right: achievementFrameSummaryCategoriesCategory7.right
        anchors.rightMargin: 8
        anchors.verticalCenter: achievementFrameSummaryCategoriesCategory7.verticalCenter
        width: 30
        height: 12
    }

    Part {
        id: achievementFrameSummaryCategoriesCategory8
        name: "AchievementFrameSummaryCategoriesCategory8"
        kind: "StatusBar"
        anchors.left: achievementFrameSummaryCategoriesCategory7.right
        anchors.leftMargin: 24
        anchors.top: achievementFrameSummaryCategoriesCategory7.top
        width: 224
        height: 16
    }

    Part {
        id: achievementFrameSummaryCategoriesCategory8Button
        name: "AchievementFrameSummaryCategoriesCategory8Button"
        kind: "Button"
        anchors.left: achievementFrameSummaryCategoriesCategory8.left
        anchors.top: achievementFrameSummaryCategoriesCategory8.top
        width: 224
        height: 16
    }

    Part {
        id: achievementFrameSummaryCategoriesCategory8Label
        name: "AchievementFrameSummaryCategoriesCategory8Label"
        kind: "FontString"
        text: "World Events"
        anchors.left: achievementFrameSummaryCategoriesCategory8.left
        anchors.leftMargin: 8
        anchors.verticalCenter: achievementFrameSummaryCategoriesCategory8.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 72
        height: 12
    }

    Part {
        id: achievementFrameSummaryCategoriesCategory8Text
        name: "AchievementFrameSummaryCategoriesCategory8Text"
        kind: "FontString"
        text: "48/141"
        anchors.right: achievementFrameSummaryCategoriesCategory8.right
        anchors.rightMargin: 8
        anchors.verticalCenter: achievementFrameSummaryCategoriesCategory8.verticalCenter
        width: 36
        height: 12
    }

    Part {
        id: achievementFrameSummaryCategoriesHeader
        name: "AchievementFrameSummaryCategoriesHeader"
        kind: "Frame"
        anchors.left: achievementFrameSummaryCategories.left
        anchors.top: achievementFrameSummaryCategories.top
        width: 520
        height: 20
    }

    Part {
        id: achievementFrameSummaryCategoriesHeaderTitle
        name: "AchievementFrameSummaryCategoriesHeaderTitle"
        kind: "FontString"
        text: "Progress Overview"
        anchors.left: achievementFrameSummaryCategoriesHeader.left
        anchors.leftMargin: 28
        anchors.verticalCenter: achievementFrameSummaryCategoriesHeader.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 102
        height: 12
    }

    Part {
        id: achievementFrameSummaryCategoriesStatusBar
        name: "AchievementFrameSummaryCategoriesStatusBar"
        kind: "StatusBar"
        anchors.horizontalCenter: achievementFrameSummaryCategoriesHeader.horizontalCenter
        anchors.top: achievementFrameSummaryCategoriesHeader.bottom
        anchors.topMargin: 6
        width: 472
        height: 16
    }

    Part {
        id: achievementFrameSummaryCategoriesStatusBarText
        name: "AchievementFrameSummaryCategoriesStatusBarText"
        kind: "FontString"
        text: "330/1058"
        anchors.right: achievementFrameSummaryCategoriesStatusBar.right
        anchors.rightMargin: 8
        anchors.verticalCenter: achievementFrameSummaryCategoriesStatusBar.verticalCenter
        width: 48
        height: 12
    }

    Part {
        id: achievementFrameSummaryCategoriesStatusBarTitle
        name: "AchievementFrameSummaryCategoriesStatusBarTitle"
        kind: "FontString"
        text: "Achievements Earned"
        anchors.left: achievementFrameSummaryCategoriesStatusBar.left
        anchors.leftMargin: 8
        anchors.verticalCenter: achievementFrameSummaryCategoriesStatusBar.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 114
        height: 12
    }

    Part {
        id: achievementFrameTab1
        name: "AchievementFrameTab1"
        kind: "Button"
        text: "Achievements"
        wowParent: "AchievementFrame"
        anchors.left: achievementFrameDiabolic.left
        anchors.leftMargin: 28
        anchors.top: achievementFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Part {
        id: achievementFrameTab2
        name: "AchievementFrameTab2"
        kind: "Button"
        text: "Statistics"
        wowParent: "AchievementFrame"
        anchors.left: achievementFrameDiabolic.left
        anchors.leftMargin: 86
        anchors.top: achievementFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Part {
        id: achievementFrameTab3
        name: "AchievementFrameTab3"
        kind: "Button"
        text: "Search"
        wowParent: "AchievementFrame"
        anchors.left: achievementFrameDiabolic.left
        anchors.leftMargin: 144
        anchors.top: achievementFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Part {
        id: achievementFrameTab4
        name: "AchievementFrameTab4"
        kind: "Button"
        text: "Suggestions"
        wowParent: "AchievementFrame"
        anchors.left: achievementFrameDiabolic.left
        anchors.leftMargin: 202
        anchors.top: achievementFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Part {
        id: achievementFrameTab5
        name: "AchievementFrameTab5"
        kind: "Button"
        text: "Watch"
        wowParent: "AchievementFrame"
        anchors.left: achievementFrameDiabolic.left
        anchors.leftMargin: 260
        anchors.top: achievementFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Part {
        id: overachiever_LeftFrame
        name: "Overachiever_LeftFrame"
        kind: "Frame"
        wowParent: "AchievementFrameCategories"
        anchors.left: achievementFrameCategories.left
        anchors.leftMargin: 9
        anchors.top: achievementFrameCategories.top
        anchors.topMargin: 5
        width: 179
        height: 448
    }

    Part {
        id: overachiever_LeftFrameText
        name: "Overachiever_LeftFrameText"
        kind: "FontString"
        text: "Clear"
        wowParent: "?"
        anchors.left: overachiever_LeftFrame.left
        anchors.leftMargin: 54.6
        anchors.top: overachiever_LeftFrame.top
        anchors.topMargin: 135.4
        width: 41.9
        height: 11.9
    }

    Part {
        id: overachiever_SearchFrame
        name: "Overachiever_SearchFrame"
        kind: "Frame"
        wowParent: "AchievementFrame"
        anchors.left: achievementFrameAchievements.left
        anchors.top: achievementFrameAchievements.top
        width: 530
        height: 440
    }

    Part {
        id: overachiever_SearchFrameAnyEdit
        name: "Overachiever_SearchFrameAnyEdit"
        kind: "EditBox"
        wowParent: "?"
        anchors.left: overachiever_SearchFrameRewardEdit.left
        anchors.top: overachiever_SearchFrameRewardEdit.bottom
        anchors.topMargin: 23
        width: 170
        height: 16
    }

    Part {
        id: overachiever_SearchFrameContainer
        name: "Overachiever_SearchFrameContainer"
        kind: "ScrollFrame"
        wowParent: "Overachiever_SearchFrame"
        anchors.left: overachiever_SearchFrame.left
        anchors.leftMargin: 4
        anchors.top: overachiever_SearchFrame.top
        anchors.topMargin: 3
        width: 526
        height: 453
    }

    Part {
        id: overachiever_SearchFrameContainerScrollChild
        name: "Overachiever_SearchFrameContainerScrollChild"
        kind: "Frame"
        wowParent: "Overachiever_SearchFrameContainer"
        anchors.left: overachiever_SearchFrameContainer.left
        anchors.top: overachiever_SearchFrameContainer.top
        width: 504
        height: 588
    }

    Part {
        id: overachiever_SearchFrameCriteriaEdit
        name: "Overachiever_SearchFrameCriteriaEdit"
        kind: "EditBox"
        wowParent: "?"
        anchors.left: overachiever_SearchFrameDescEdit.left
        anchors.top: overachiever_SearchFrameDescEdit.bottom
        anchors.topMargin: 23
        width: 170
        height: 16
    }

    Part {
        id: overachiever_SearchFrameDescEdit
        name: "Overachiever_SearchFrameDescEdit"
        kind: "EditBox"
        wowParent: "?"
        anchors.left: overachiever_SearchFrameNameEdit.left
        anchors.top: overachiever_SearchFrameNameEdit.bottom
        anchors.topMargin: 23
        width: 170
        height: 16
    }

    Part {
        id: overachiever_SearchFrameFullListCheckbox
        name: "Overachiever_SearchFrameFullListCheckbox"
        kind: "CheckButton"
        wowParent: "?"
        anchors.left: overachiever_SearchFrameAnyEdit.left
        anchors.leftMargin: -8
        anchors.top: overachiever_SearchFrameAnyEdit.bottom
        anchors.topMargin: 12
        width: 26
        height: 26
    }

    Part {
        id: overachiever_SearchFrameFullListCheckboxText
        name: "Overachiever_SearchFrameFullListCheckboxText"
        kind: "FontString"
        text: "Search all achievements"
        wowParent: "Overachiever_SearchFrameFullListCheckbox"
        anchors.left: overachiever_SearchFrameFullListCheckbox.right
        anchors.verticalCenter: overachiever_SearchFrameFullListCheckbox.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 141.4
        height: 11.9
    }

    Part {
        id: overachiever_SearchFrameNameEdit
        name: "Overachiever_SearchFrameNameEdit"
        kind: "EditBox"
        wowParent: "?"
        anchors.left: overachiever_SearchFrameSortDrop.left
        anchors.leftMargin: 22
        anchors.top: overachiever_SearchFrameSortDrop.bottom
        anchors.topMargin: 19
        width: 170
        height: 16
    }

    Part {
        id: overachiever_SearchFrameRewardEdit
        name: "Overachiever_SearchFrameRewardEdit"
        kind: "EditBox"
        wowParent: "?"
        anchors.left: overachiever_SearchFrameCriteriaEdit.left
        anchors.top: overachiever_SearchFrameCriteriaEdit.bottom
        anchors.topMargin: 23
        width: 170
        height: 16
    }

    Part {
        id: overachiever_SearchFrameSortDrop
        name: "Overachiever_SearchFrameSortDrop"
        kind: "Frame"
        text: "Name"
        wowParent: "?"
        anchors.left: overachiever_LeftFrame.left
        anchors.leftMargin: -15
        anchors.top: overachiever_LeftFrame.top
        anchors.topMargin: 45.9
        width: 165
        height: 32
    }

    Part {
        id: overachiever_SearchFrameSortDropButton
        name: "Overachiever_SearchFrameSortDropButton"
        kind: "Button"
        wowParent: "Overachiever_SearchFrameSortDrop"
        anchors.right: overachiever_SearchFrameSortDropDiabolicField.right
        anchors.rightMargin: 18
        anchors.verticalCenter: overachiever_SearchFrameSortDropDiabolicField.verticalCenter
        width: 18
        height: 18
    }

    Part {
        id: overachiever_SearchFrameSortDropDiabolicField
        name: "Overachiever_SearchFrameSortDropDiabolicField"
        kind: "Frame"
        wowParent: "Overachiever_SearchFrameSortDrop"
        anchors.left: overachiever_SearchFrameSortDrop.left
        anchors.verticalCenter: overachiever_SearchFrameSortDrop.verticalCenter
        anchors.verticalCenterOffset: -4
        width: 165
        height: 22
    }

    Part {
        id: overachiever_SearchFrameSortDropLabel
        name: "Overachiever_SearchFrameSortDropLabel"
        kind: "FontString"
        text: "Sort by:"
        wowParent: "Overachiever_SearchFrameSortDrop"
        anchors.left: overachiever_SearchFrameSortDrop.left
        anchors.leftMargin: 16
        anchors.bottom: overachiever_SearchFrameSortDrop.top
        anchors.bottomMargin: 3
        width: 45.8
        height: 11.9
    }

    Part {
        id: overachiever_SearchFrameSortDropText
        name: "Overachiever_SearchFrameSortDropText"
        kind: "FontString"
        text: "Name"
        wowParent: "Overachiever_SearchFrameSortDrop"
        anchors.left: overachiever_SearchFrameSortDropDiabolicField.left
        anchors.leftMargin: 22
        anchors.verticalCenter: overachiever_SearchFrameSortDropDiabolicField.verticalCenter
        width: 103
        height: 10
    }

    Part {
        id: overachiever_SuggestionsFrame
        name: "Overachiever_SuggestionsFrame"
        kind: "Frame"
        wowParent: "AchievementFrame"
        anchors.left: achievementFrameAchievements.left
        anchors.top: achievementFrameAchievements.top
        width: 530
        height: 440
    }

    Part {
        id: overachiever_SuggestionsFrameContainer
        name: "Overachiever_SuggestionsFrameContainer"
        kind: "ScrollFrame"
        wowParent: "Overachiever_SuggestionsFrame"
        anchors.left: overachiever_SuggestionsFrame.left
        anchors.leftMargin: 4
        anchors.top: overachiever_SuggestionsFrame.top
        anchors.topMargin: 3
        width: 526
        height: 453
    }

    Part {
        id: overachiever_SuggestionsFrameContainerButton1
        name: "Overachiever_SuggestionsFrameContainerButton1"
        kind: "Button"
        wowParent: "Overachiever_SuggestionsFrameContainerScrollChild"
        anchors.left: overachiever_SuggestionsFrameContainerScrollChild.left
        anchors.top: overachiever_SuggestionsFrameContainerScrollChild.top
        anchors.topMargin: 2
        width: 522
        height: 84
    }

    Part {
        id: overachiever_SuggestionsFrameContainerButton1Description
        name: "Overachiever_SuggestionsFrameContainerButton1Description"
        kind: "FontString"
        text: "Kill 50 enemy players in any of your home cities."
        wowParent: "Overachiever_SuggestionsFrameContainerButton1"
        anchors.horizontalCenter: overachiever_SuggestionsFrameContainerButton1.horizontalCenter
        anchors.top: overachiever_SuggestionsFrameContainerButton1.top
        anchors.topMargin: 30
        width: 330
        height: 30
    }

    Part {
        id: overachiever_SuggestionsFrameContainerButton1Icon
        name: "Overachiever_SuggestionsFrameContainerButton1Icon"
        kind: "Frame"
        wowParent: "Overachiever_SuggestionsFrameContainerButton1"
        anchors.left: overachiever_SuggestionsFrameContainerButton1.left
        anchors.leftMargin: 8
        anchors.top: overachiever_SuggestionsFrameContainerButton1.top
        anchors.topMargin: 9
        width: 60
        height: 60
    }

    Part {
        id: overachiever_SuggestionsFrameContainerButton1Label
        name: "Overachiever_SuggestionsFrameContainerButton1Label"
        kind: "FontString"
        text: "City Defender"
        wowParent: "Overachiever_SuggestionsFrameContainerButton1"
        anchors.horizontalCenter: overachiever_SuggestionsFrameContainerButton1TitleBackground.horizontalCenter
        anchors.top: overachiever_SuggestionsFrameContainerButton1TitleBackground.top
        width: 320
        height: 20
    }

    Part {
        id: overachiever_SuggestionsFrameContainerButton1Objectives
        name: "Overachiever_SuggestionsFrameContainerButton1Objectives"
        kind: "Frame"
        wowParent: "Overachiever_SuggestionsFrameContainerButton1"
        anchors.horizontalCenter: overachiever_SuggestionsFrameContainerButton1Description.horizontalCenter
        anchors.horizontalCenterOffset: -2
        anchors.top: overachiever_SuggestionsFrameContainerButton1Description.bottom
        anchors.topMargin: 7.9
        width: 366
        height: -8.4
    }

    Part {
        id: overachiever_SuggestionsFrameContainerButton1Shield
        name: "Overachiever_SuggestionsFrameContainerButton1Shield"
        kind: "Frame"
        wowParent: "Overachiever_SuggestionsFrameContainerButton1"
        anchors.right: overachiever_SuggestionsFrameContainerButton1.right
        anchors.rightMargin: 6
        anchors.top: overachiever_SuggestionsFrameContainerButton1.top
        width: 64
        height: 64
    }

    Part {
        id: overachiever_SuggestionsFrameContainerButton1ShieldPoints
        name: "Overachiever_SuggestionsFrameContainerButton1ShieldPoints"
        kind: "FontString"
        text: "10"
        wowParent: "Overachiever_SuggestionsFrameContainerButton1Shield"
        anchors.right: overachiever_SuggestionsFrameContainerButton1Shield.right
        anchors.rightMargin: 18
        anchors.top: overachiever_SuggestionsFrameContainerButton1Shield.top
        anchors.topMargin: 26
        width: 32
        height: 16
    }

    Part {
        id: overachiever_SuggestionsFrameContainerScrollChild
        name: "Overachiever_SuggestionsFrameContainerScrollChild"
        kind: "Frame"
        wowParent: "Overachiever_SuggestionsFrameContainer"
        anchors.left: overachiever_SuggestionsFrameContainer.left
        anchors.top: overachiever_SuggestionsFrameContainer.top
        width: 504
        height: 588
    }

    Part {
        id: overachiever_SuggestionsFrameSortDrop
        name: "Overachiever_SuggestionsFrameSortDrop"
        kind: "Frame"
        text: "Name"
        wowParent: "?"
        anchors.left: overachiever_LeftFrame.left
        anchors.leftMargin: -15
        anchors.top: overachiever_LeftFrame.top
        anchors.topMargin: 45.9
        width: 165
        height: 32
    }

    Part {
        id: overachiever_SuggestionsFrameSortDropButton
        name: "Overachiever_SuggestionsFrameSortDropButton"
        kind: "Button"
        wowParent: "Overachiever_SuggestionsFrameSortDrop"
        anchors.right: overachiever_SuggestionsFrameSortDropDiabolicField.right
        anchors.rightMargin: 18
        anchors.verticalCenter: overachiever_SuggestionsFrameSortDropDiabolicField.verticalCenter
        width: 18
        height: 18
    }

    Part {
        id: overachiever_SuggestionsFrameSortDropDiabolicField
        name: "Overachiever_SuggestionsFrameSortDropDiabolicField"
        kind: "Frame"
        wowParent: "Overachiever_SuggestionsFrameSortDrop"
        anchors.left: overachiever_SuggestionsFrameSortDrop.left
        anchors.verticalCenter: overachiever_SuggestionsFrameSortDrop.verticalCenter
        anchors.verticalCenterOffset: -4
        width: 165
        height: 22
    }

    Part {
        id: overachiever_SuggestionsFrameSortDropLabel
        name: "Overachiever_SuggestionsFrameSortDropLabel"
        kind: "FontString"
        text: "Sort by:"
        wowParent: "Overachiever_SuggestionsFrameSortDrop"
        anchors.left: overachiever_SuggestionsFrameSortDrop.left
        anchors.leftMargin: 16
        anchors.bottom: overachiever_SuggestionsFrameSortDrop.top
        anchors.bottomMargin: 3
        width: 45.8
        height: 11.9
    }

    Part {
        id: overachiever_SuggestionsFrameSortDropText
        name: "Overachiever_SuggestionsFrameSortDropText"
        kind: "FontString"
        text: "Name"
        wowParent: "Overachiever_SuggestionsFrameSortDrop"
        anchors.left: overachiever_SuggestionsFrameSortDropDiabolicField.left
        anchors.leftMargin: 22
        anchors.verticalCenter: overachiever_SuggestionsFrameSortDropDiabolicField.verticalCenter
        width: 103
        height: 10
    }

    Part {
        id: overachiever_SuggestionsFrameSubzoneDrop
        name: "Overachiever_SuggestionsFrameSubzoneDrop"
        kind: "Frame"
        text: "(unspecified)"
        wowParent: "?"
        anchors.horizontalCenter: overachiever_SuggestionsFrameZoneOverrideEdit.horizontalCenter
        anchors.horizontalCenterOffset: -24
        anchors.top: overachiever_SuggestionsFrameZoneOverrideEdit.bottom
        anchors.topMargin: 21
        width: 166
        height: 32
    }

    Part {
        id: overachiever_SuggestionsFrameSubzoneDropButton
        name: "Overachiever_SuggestionsFrameSubzoneDropButton"
        kind: "Button"
        wowParent: "Overachiever_SuggestionsFrameSubzoneDrop"
        anchors.right: overachiever_SuggestionsFrameSubzoneDropDiabolicField.right
        anchors.rightMargin: 18
        anchors.verticalCenter: overachiever_SuggestionsFrameSubzoneDropDiabolicField.verticalCenter
        width: 18
        height: 18
    }

    Part {
        id: overachiever_SuggestionsFrameSubzoneDropDiabolicField
        name: "Overachiever_SuggestionsFrameSubzoneDropDiabolicField"
        kind: "Frame"
        wowParent: "Overachiever_SuggestionsFrameSubzoneDrop"
        anchors.left: overachiever_SuggestionsFrameSubzoneDrop.left
        anchors.verticalCenter: overachiever_SuggestionsFrameSubzoneDrop.verticalCenter
        anchors.verticalCenterOffset: -4
        width: 166
        height: 22
    }

    Part {
        id: overachiever_SuggestionsFrameSubzoneDropLabel
        name: "Overachiever_SuggestionsFrameSubzoneDropLabel"
        kind: "FontString"
        text: "Subzone:"
        wowParent: "Overachiever_SuggestionsFrameSubzoneDrop"
        anchors.left: overachiever_SuggestionsFrameSubzoneDrop.left
        anchors.leftMargin: 16
        anchors.bottom: overachiever_SuggestionsFrameSubzoneDrop.top
        anchors.bottomMargin: 3
        width: 53.7
        height: 11.9
    }

    Part {
        id: overachiever_SuggestionsFrameSubzoneDropText
        name: "Overachiever_SuggestionsFrameSubzoneDropText"
        kind: "FontString"
        text: "(unspecified)"
        wowParent: "Overachiever_SuggestionsFrameSubzoneDrop"
        anchors.left: overachiever_SuggestionsFrameSubzoneDropDiabolicField.left
        anchors.leftMargin: 22
        anchors.verticalCenter: overachiever_SuggestionsFrameSubzoneDropDiabolicField.verticalCenter
        width: 104
        height: 10
    }

    Part {
        id: overachiever_SuggestionsFrameZoneOverrideEdit
        name: "Overachiever_SuggestionsFrameZoneOverrideEdit"
        kind: "EditBox"
        wowParent: "?"
        anchors.left: overachiever_SuggestionsFrameSortDrop.left
        anchors.leftMargin: 22
        anchors.top: overachiever_SuggestionsFrameSortDrop.bottom
        anchors.topMargin: 19
        width: 170
        height: 16
    }

    Part {
        id: overachiever_WatchFrame
        name: "Overachiever_WatchFrame"
        kind: "Frame"
        wowParent: "AchievementFrame"
        anchors.left: achievementFrameAchievements.left
        anchors.top: achievementFrameAchievements.top
        width: 530
        height: 440
    }

    Part {
        id: overachiever_WatchFrameContainer
        name: "Overachiever_WatchFrameContainer"
        kind: "ScrollFrame"
        wowParent: "Overachiever_WatchFrame"
        anchors.left: overachiever_WatchFrame.left
        anchors.leftMargin: 4
        anchors.top: overachiever_WatchFrame.top
        anchors.topMargin: 3
        width: 526
        height: 453
    }

    Part {
        id: overachiever_WatchFrameContainerScrollChild
        name: "Overachiever_WatchFrameContainerScrollChild"
        kind: "Frame"
        wowParent: "Overachiever_WatchFrameContainer"
        anchors.left: overachiever_WatchFrameContainer.left
        anchors.top: overachiever_WatchFrameContainer.top
        width: 504
        height: 588
    }

    Part {
        id: overachiever_WatchFrameCopyDestCheckbox
        name: "Overachiever_WatchFrameCopyDestCheckbox"
        kind: "CheckButton"
        wowParent: "?"
        anchors.left: overachiever_WatchFrameDefListDrop.left
        anchors.leftMargin: 14
        anchors.top: overachiever_WatchFrameDefListDrop.bottom
        anchors.topMargin: 12
        width: 26
        height: 26
    }

    Part {
        id: overachiever_WatchFrameCopyDestCheckboxText
        name: "Overachiever_WatchFrameCopyDestCheckboxText"
        kind: "FontString"
        text: "Copy To:"
        wowParent: "Overachiever_WatchFrameCopyDestCheckbox"
        anchors.left: overachiever_WatchFrameCopyDestCheckbox.right
        anchors.verticalCenter: overachiever_WatchFrameCopyDestCheckbox.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 52.9
        height: 11.9
    }

    Part {
        id: overachiever_WatchFrameDefListDrop
        name: "Overachiever_WatchFrameDefListDrop"
        kind: "Frame"
        text: "Global"
        wowParent: "?"
        anchors.left: overachiever_LeftFrame.left
        anchors.leftMargin: -15
        anchors.top: overachiever_LeftFrame.top
        anchors.topMargin: 173.9
        width: 166
        height: 32
    }

    Part {
        id: overachiever_WatchFrameDefListDropButton
        name: "Overachiever_WatchFrameDefListDropButton"
        kind: "Button"
        wowParent: "Overachiever_WatchFrameDefListDrop"
        anchors.right: overachiever_WatchFrameDefListDropDiabolicField.right
        anchors.rightMargin: 18
        anchors.verticalCenter: overachiever_WatchFrameDefListDropDiabolicField.verticalCenter
        width: 18
        height: 18
    }

    Part {
        id: overachiever_WatchFrameDefListDropDiabolicField
        name: "Overachiever_WatchFrameDefListDropDiabolicField"
        kind: "Frame"
        wowParent: "Overachiever_WatchFrameDefListDrop"
        anchors.left: overachiever_WatchFrameDefListDrop.left
        anchors.verticalCenter: overachiever_WatchFrameDefListDrop.verticalCenter
        anchors.verticalCenterOffset: -4
        width: 166
        height: 22
    }

    Part {
        id: overachiever_WatchFrameDefListDropLabel
        name: "Overachiever_WatchFrameDefListDropLabel"
        kind: "FontString"
        text: "Default List:"
        wowParent: "Overachiever_WatchFrameDefListDrop"
        anchors.left: overachiever_WatchFrameDefListDrop.left
        anchors.leftMargin: 16
        anchors.bottom: overachiever_WatchFrameDefListDrop.top
        anchors.bottomMargin: 3
        width: 71.9
        height: 11.9
    }

    Part {
        id: overachiever_WatchFrameDefListDropText
        name: "Overachiever_WatchFrameDefListDropText"
        kind: "FontString"
        text: "Global"
        wowParent: "Overachiever_WatchFrameDefListDrop"
        anchors.left: overachiever_WatchFrameDefListDropDiabolicField.left
        anchors.leftMargin: 22
        anchors.verticalCenter: overachiever_WatchFrameDefListDropDiabolicField.verticalCenter
        width: 104
        height: 10
    }

    Part {
        id: overachiever_WatchFrameDestinationListDrop
        name: "Overachiever_WatchFrameDestinationListDrop"
        kind: "Frame"
        text: "Global"
        wowParent: "?"
        anchors.left: overachiever_WatchFrameCopyDestCheckbox.left
        anchors.leftMargin: -14
        anchors.top: overachiever_WatchFrameCopyDestCheckbox.bottom
        anchors.topMargin: -2
        width: 166
        height: 32
    }

    Part {
        id: overachiever_WatchFrameDestinationListDropButton
        name: "Overachiever_WatchFrameDestinationListDropButton"
        kind: "Button"
        wowParent: "Overachiever_WatchFrameDestinationListDrop"
        anchors.right: overachiever_WatchFrameDestinationListDropDiabolicField.right
        anchors.rightMargin: 18
        anchors.verticalCenter: overachiever_WatchFrameDestinationListDropDiabolicField.verticalCenter
        width: 18
        height: 18
    }

    Part {
        id: overachiever_WatchFrameDestinationListDropDiabolicField
        name: "Overachiever_WatchFrameDestinationListDropDiabolicField"
        kind: "Frame"
        wowParent: "Overachiever_WatchFrameDestinationListDrop"
        anchors.left: overachiever_WatchFrameDestinationListDrop.left
        anchors.verticalCenter: overachiever_WatchFrameDestinationListDrop.verticalCenter
        anchors.verticalCenterOffset: -4
        width: 166
        height: 22
    }

    Part {
        id: overachiever_WatchFrameDestinationListDropText
        name: "Overachiever_WatchFrameDestinationListDropText"
        kind: "FontString"
        text: "Global"
        wowParent: "Overachiever_WatchFrameDestinationListDrop"
        anchors.left: overachiever_WatchFrameDestinationListDropDiabolicField.left
        anchors.leftMargin: 22
        anchors.verticalCenter: overachiever_WatchFrameDestinationListDropDiabolicField.verticalCenter
        width: 104
        height: 10
    }

    Part {
        id: overachiever_WatchFrameListDrop
        name: "Overachiever_WatchFrameListDrop"
        kind: "Frame"
        text: "Global"
        wowParent: "?"
        anchors.left: overachiever_WatchFrameSortDrop.left
        anchors.top: overachiever_WatchFrameSortDrop.bottom
        anchors.topMargin: 18
        width: 166
        height: 32
    }

    Part {
        id: overachiever_WatchFrameListDropButton
        name: "Overachiever_WatchFrameListDropButton"
        kind: "Button"
        wowParent: "Overachiever_WatchFrameListDrop"
        anchors.right: overachiever_WatchFrameListDropDiabolicField.right
        anchors.rightMargin: 18
        anchors.verticalCenter: overachiever_WatchFrameListDropDiabolicField.verticalCenter
        width: 18
        height: 18
    }

    Part {
        id: overachiever_WatchFrameListDropDiabolicField
        name: "Overachiever_WatchFrameListDropDiabolicField"
        kind: "Frame"
        wowParent: "Overachiever_WatchFrameListDrop"
        anchors.left: overachiever_WatchFrameListDrop.left
        anchors.verticalCenter: overachiever_WatchFrameListDrop.verticalCenter
        anchors.verticalCenterOffset: -4
        width: 166
        height: 22
    }

    Part {
        id: overachiever_WatchFrameListDropLabel
        name: "Overachiever_WatchFrameListDropLabel"
        kind: "FontString"
        text: "Displayed List:"
        wowParent: "Overachiever_WatchFrameListDrop"
        anchors.left: overachiever_WatchFrameListDrop.left
        anchors.leftMargin: 16
        anchors.bottom: overachiever_WatchFrameListDrop.top
        anchors.bottomMargin: 3
        width: 87.7
        height: 11.9
    }

    Part {
        id: overachiever_WatchFrameListDropText
        name: "Overachiever_WatchFrameListDropText"
        kind: "FontString"
        text: "Global"
        wowParent: "Overachiever_WatchFrameListDrop"
        anchors.left: overachiever_WatchFrameListDropDiabolicField.left
        anchors.leftMargin: 22
        anchors.verticalCenter: overachiever_WatchFrameListDropDiabolicField.verticalCenter
        width: 104
        height: 10
    }

    Part {
        id: overachiever_WatchFrameSortDrop
        name: "Overachiever_WatchFrameSortDrop"
        kind: "Frame"
        text: "Name"
        wowParent: "?"
        anchors.left: overachiever_LeftFrame.left
        anchors.leftMargin: -15
        anchors.top: overachiever_LeftFrame.top
        anchors.topMargin: 45.9
        width: 165
        height: 32
    }

    Part {
        id: overachiever_WatchFrameSortDropButton
        name: "Overachiever_WatchFrameSortDropButton"
        kind: "Button"
        wowParent: "Overachiever_WatchFrameSortDrop"
        anchors.right: overachiever_WatchFrameSortDropDiabolicField.right
        anchors.rightMargin: 18
        anchors.verticalCenter: overachiever_WatchFrameSortDropDiabolicField.verticalCenter
        width: 18
        height: 18
    }

    Part {
        id: overachiever_WatchFrameSortDropDiabolicField
        name: "Overachiever_WatchFrameSortDropDiabolicField"
        kind: "Frame"
        wowParent: "Overachiever_WatchFrameSortDrop"
        anchors.left: overachiever_WatchFrameSortDrop.left
        anchors.verticalCenter: overachiever_WatchFrameSortDrop.verticalCenter
        anchors.verticalCenterOffset: -4
        width: 165
        height: 22
    }

    Part {
        id: overachiever_WatchFrameSortDropLabel
        name: "Overachiever_WatchFrameSortDropLabel"
        kind: "FontString"
        text: "Sort by:"
        wowParent: "Overachiever_WatchFrameSortDrop"
        anchors.left: overachiever_WatchFrameSortDrop.left
        anchors.leftMargin: 16
        anchors.bottom: overachiever_WatchFrameSortDrop.top
        anchors.bottomMargin: 3
        width: 45.8
        height: 11.9
    }

    Part {
        id: overachiever_WatchFrameSortDropText
        name: "Overachiever_WatchFrameSortDropText"
        kind: "FontString"
        text: "Name"
        wowParent: "Overachiever_WatchFrameSortDrop"
        anchors.left: overachiever_WatchFrameSortDropDiabolicField.left
        anchors.leftMargin: 22
        anchors.verticalCenter: overachiever_WatchFrameSortDropDiabolicField.verticalCenter
        width: 103
        height: 10
    }

    Ghost { id: achievementFrameAchievementsContainerButton1RewardBackground; name: "AchievementFrameAchievementsContainerButton1RewardBackground"; x: 0; y: 0; width: 0; height: 0 }
    Ghost { id: achievementFrameAchievementsContainerButton1TitleBackground; name: "AchievementFrameAchievementsContainerButton1TitleBackground"; x: 0; y: 0; width: 0; height: 0 }
    Ghost { id: achievementFrameAchievementsContainerButton2TitleBackground; name: "AchievementFrameAchievementsContainerButton2TitleBackground"; x: 0; y: 0; width: 0; height: 0 }
    Ghost { id: achievementFrameAchievementsContainerButton3RewardBackground; name: "AchievementFrameAchievementsContainerButton3RewardBackground"; x: 0; y: 0; width: 0; height: 0 }
    Ghost { id: achievementFrameAchievementsContainerButton3TitleBackground; name: "AchievementFrameAchievementsContainerButton3TitleBackground"; x: 0; y: 0; width: 0; height: 0 }
    Ghost { id: achievementFrameAchievementsContainerButton4RewardBackground; name: "AchievementFrameAchievementsContainerButton4RewardBackground"; x: 0; y: 0; width: 0; height: 0 }
    Ghost { id: achievementFrameAchievementsContainerButton4TitleBackground; name: "AchievementFrameAchievementsContainerButton4TitleBackground"; x: 0; y: 0; width: 0; height: 0 }
    Ghost { id: achievementFrameAchievementsContainerButton5RewardBackground; name: "AchievementFrameAchievementsContainerButton5RewardBackground"; x: 0; y: 0; width: 0; height: 0 }
    Ghost { id: achievementFrameAchievementsContainerButton5TitleBackground; name: "AchievementFrameAchievementsContainerButton5TitleBackground"; x: 0; y: 0; width: 0; height: 0 }
    Ghost { id: achievementFrameAchievementsContainerButton6RewardBackground; name: "AchievementFrameAchievementsContainerButton6RewardBackground"; x: 0; y: 0; width: 0; height: 0 }
    Ghost { id: achievementFrameAchievementsContainerButton6TitleBackground; name: "AchievementFrameAchievementsContainerButton6TitleBackground"; x: 0; y: 0; width: 0; height: 0 }
    Ghost { id: achievementFrameAchievementsContainerButton7RewardBackground; name: "AchievementFrameAchievementsContainerButton7RewardBackground"; x: 0; y: 0; width: 0; height: 0 }
    Ghost { id: achievementFrameAchievementsContainerButton7TitleBackground; name: "AchievementFrameAchievementsContainerButton7TitleBackground"; x: 0; y: 0; width: 0; height: 0 }
    Ghost { id: achievementFrameSummaryAchievement1TitleBackground; name: "AchievementFrameSummaryAchievement1TitleBackground"; x: 0; y: 0; width: 0; height: 0 }
    Ghost { id: achievementFrameSummaryAchievement2TitleBackground; name: "AchievementFrameSummaryAchievement2TitleBackground"; x: 0; y: 0; width: 0; height: 0 }
    Ghost { id: achievementFrameSummaryAchievement3TitleBackground; name: "AchievementFrameSummaryAchievement3TitleBackground"; x: 0; y: 0; width: 0; height: 0 }
    Ghost { id: achievementFrameSummaryAchievement4TitleBackground; name: "AchievementFrameSummaryAchievement4TitleBackground"; x: 0; y: 0; width: 0; height: 0 }
    Ghost { id: overachiever_SuggestionsFrameContainerButton1TitleBackground; name: "Overachiever_SuggestionsFrameContainerButton1TitleBackground"; x: 483; y: 29; width: 0; height: 0 }
}
