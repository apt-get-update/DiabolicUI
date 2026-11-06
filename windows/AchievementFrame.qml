// Written by tools/positions.lua, yours to change (docs: Common Tasks): a part
// with a pin is put in settings/positions.lua ("all", or only its "place" or
// its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    id: achievementFrame
    name: "AchievementFrame"
    width: 768
    height: 500

    Frame {
        id: achievementFrameAchievements
        name: "AchievementFrameAchievements"
        wowParent: "AchievementFrame"
        anchors.left: achievementFrameCategories.right
        anchors.top: achievementFrameCategories.top
        width: 504
        height: 461
    }

    ScrollFrame {
        id: achievementFrameAchievementsContainer
        name: "AchievementFrameAchievementsContainer"
        wowParent: "AchievementFrameAchievements"
        anchors.left: achievementFrameAchievements.left
        anchors.leftMargin: 4
        anchors.top: achievementFrameAchievements.top
        anchors.topMargin: 3
        width: 500
        height: 453
    }

    Button {
        id: achievementFrameAchievementsContainerButton1
        name: "AchievementFrameAchievementsContainerButton1"
        wowParent: "AchievementFrameAchievementsContainerScrollChild"
        anchors.left: achievementFrameAchievementsContainerScrollChild.left
        anchors.top: achievementFrameAchievementsContainerScrollChild.top
        anchors.topMargin: 2
        width: 496
        height: 89.3
    }

    FontString {
        id: achievementFrameAchievementsContainerButton1DateCompleted
        name: "AchievementFrameAchievementsContainerButton1DateCompleted"
        text: "10/22/26"
        wowParent: "AchievementFrameAchievementsContainerButton1"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton1Shield.horizontalCenter
        anchors.horizontalCenterOffset: -3
        anchors.top: achievementFrameAchievementsContainerButton1Shield.bottom
        anchors.topMargin: -6
        width: 100
        height: 14
    }

    FontString {
        id: achievementFrameAchievementsContainerButton1Description
        name: "AchievementFrameAchievementsContainerButton1Description"
        text: "Show off your sparkling smile by using a Tooth Pick."
        wowParent: "AchievementFrameAchievementsContainerButton1"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton1.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton1.top
        anchors.topMargin: 30
        width: 330
        height: 30
    }

    FontString {
        id: achievementFrameAchievementsContainerButton1HiddenDescription
        name: "AchievementFrameAchievementsContainerButton1HiddenDescription"
        text: "Obtain a Sinister Squashling pet and Hallowed Helm."
        wowParent: "AchievementFrameAchievementsContainerButton1"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton1.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton1.top
        anchors.topMargin: 30
        width: 330
        height: 10.3
    }

    Frame {
        id: achievementFrameAchievementsContainerButton1Highlight
        name: "AchievementFrameAchievementsContainerButton1Highlight"
        wowParent: "AchievementFrameAchievementsContainerButton1"
        anchors.left: achievementFrameAchievementsContainerButton1.left
        anchors.top: achievementFrameAchievementsContainerButton1.top
        width: 496
        height: 89.3
    }

    Frame {
        id: achievementFrameAchievementsContainerButton1Icon
        name: "AchievementFrameAchievementsContainerButton1Icon"
        wowParent: "AchievementFrameAchievementsContainerButton1"
        anchors.left: achievementFrameAchievementsContainerButton1.left
        anchors.leftMargin: 8
        anchors.top: achievementFrameAchievementsContainerButton1.top
        anchors.topMargin: 9
        width: 60
        height: 60
    }

    FontString {
        id: achievementFrameAchievementsContainerButton1Label
        name: "AchievementFrameAchievementsContainerButton1Label"
        text: "Sinister Calling"
        wowParent: "AchievementFrameAchievementsContainerButton1"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton1TitleBackground.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton1TitleBackground.top
        width: 320
        height: 20
    }

    Frame {
        id: achievementFrameAchievementsContainerButton1Objectives
        name: "AchievementFrameAchievementsContainerButton1Objectives"
        wowParent: "AchievementFrameAchievementsContainerButton1"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton1Description.horizontalCenter
        anchors.horizontalCenterOffset: -2
        anchors.top: achievementFrameAchievementsContainerButton1Description.bottom
        anchors.topMargin: -76.1
        width: 340
        height: -0.7
    }

    FontString {
        id: achievementFrameAchievementsContainerButton1Reward
        name: "AchievementFrameAchievementsContainerButton1Reward"
        text: "Title Reward: Brewmaster"
        wowParent: "AchievementFrameAchievementsContainerButton1"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton1RewardBackground.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton1RewardBackground.top
        anchors.topMargin: -1
        width: 400
        height: 20
    }

    Frame {
        id: achievementFrameAchievementsContainerButton1Shield
        name: "AchievementFrameAchievementsContainerButton1Shield"
        wowParent: "AchievementFrameAchievementsContainerButton1"
        anchors.right: achievementFrameAchievementsContainerButton1.right
        anchors.rightMargin: 6
        anchors.top: achievementFrameAchievementsContainerButton1.top
        width: 64
        height: 64
    }

    FontString {
        id: achievementFrameAchievementsContainerButton1ShieldPoints
        name: "AchievementFrameAchievementsContainerButton1ShieldPoints"
        text: "10"
        wowParent: "AchievementFrameAchievementsContainerButton1Shield"
        anchors.right: achievementFrameAchievementsContainerButton1Shield.right
        anchors.rightMargin: 18
        anchors.top: achievementFrameAchievementsContainerButton1Shield.top
        anchors.topMargin: 26
        width: 32
        height: 16
    }

    Button {
        id: achievementFrameAchievementsContainerButton2
        name: "AchievementFrameAchievementsContainerButton2"
        wowParent: "AchievementFrameAchievementsContainerScrollChild"
        anchors.left: achievementFrameAchievementsContainerButton1.left
        anchors.top: achievementFrameAchievementsContainerButton1.bottom
        width: 496
        height: 84
    }

    FontString {
        id: achievementFrameAchievementsContainerButton2DateCompleted
        name: "AchievementFrameAchievementsContainerButton2DateCompleted"
        text: "10/21/26"
        wowParent: "AchievementFrameAchievementsContainerButton2"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton2Shield.horizontalCenter
        anchors.horizontalCenterOffset: -3
        anchors.top: achievementFrameAchievementsContainerButton2Shield.bottom
        anchors.topMargin: -6
        width: 100
        height: 14
    }

    FontString {
        id: achievementFrameAchievementsContainerButton2Description
        name: "AchievementFrameAchievementsContainerButton2Description"
        text: "Eat so many Tricky Treats that you get an upset tummy."
        wowParent: "AchievementFrameAchievementsContainerButton2"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton2.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton2.top
        anchors.topMargin: 30
        width: 330
        height: 30
    }

    FontString {
        id: achievementFrameAchievementsContainerButton2HiddenDescription
        name: "AchievementFrameAchievementsContainerButton2HiddenDescription"
        text: "Obtain a Sinister Squashling pet and Hallowed Helm."
        wowParent: "AchievementFrameAchievementsContainerButton2"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton2.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton2.top
        anchors.topMargin: 30
        width: 330
        height: 10.3
    }

    Frame {
        id: achievementFrameAchievementsContainerButton2Highlight
        name: "AchievementFrameAchievementsContainerButton2Highlight"
        wowParent: "AchievementFrameAchievementsContainerButton2"
        anchors.left: achievementFrameAchievementsContainerButton2.left
        anchors.top: achievementFrameAchievementsContainerButton2.top
        anchors.topMargin: 78.7
        width: 496
        height: 89.3
    }

    Frame {
        id: achievementFrameAchievementsContainerButton2Icon
        name: "AchievementFrameAchievementsContainerButton2Icon"
        wowParent: "AchievementFrameAchievementsContainerButton2"
        anchors.left: achievementFrameAchievementsContainerButton2.left
        anchors.leftMargin: 8
        anchors.top: achievementFrameAchievementsContainerButton2.top
        anchors.topMargin: 9
        width: 60
        height: 60
    }

    FontString {
        id: achievementFrameAchievementsContainerButton2Label
        name: "AchievementFrameAchievementsContainerButton2Label"
        text: "Out With It"
        wowParent: "AchievementFrameAchievementsContainerButton2"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton2TitleBackground.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton2TitleBackground.top
        width: 320
        height: 20
    }

    Frame {
        id: achievementFrameAchievementsContainerButton2Objectives
        name: "AchievementFrameAchievementsContainerButton2Objectives"
        wowParent: "AchievementFrameAchievementsContainerButton2"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton2Description.horizontalCenter
        anchors.horizontalCenterOffset: -2
        anchors.top: achievementFrameAchievementsContainerButton2Description.bottom
        anchors.topMargin: 8
        width: 340
        height: -6
    }

    FontString {
        id: achievementFrameAchievementsContainerButton2Reward
        name: "AchievementFrameAchievementsContainerButton2Reward"
        text: "Reward: Tabard of the Explorer"
        wowParent: "AchievementFrameAchievementsContainerButton2"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton2RewardBackground.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton2RewardBackground.top
        anchors.topMargin: -1
        width: 400
        height: 20
    }

    Frame {
        id: achievementFrameAchievementsContainerButton2Shield
        name: "AchievementFrameAchievementsContainerButton2Shield"
        wowParent: "AchievementFrameAchievementsContainerButton2"
        anchors.right: achievementFrameAchievementsContainerButton2.right
        anchors.rightMargin: 6
        anchors.top: achievementFrameAchievementsContainerButton2.top
        width: 64
        height: 64
    }

    FontString {
        id: achievementFrameAchievementsContainerButton2ShieldPoints
        name: "AchievementFrameAchievementsContainerButton2ShieldPoints"
        text: "10"
        wowParent: "AchievementFrameAchievementsContainerButton2Shield"
        anchors.right: achievementFrameAchievementsContainerButton2Shield.right
        anchors.rightMargin: 18
        anchors.top: achievementFrameAchievementsContainerButton2Shield.top
        anchors.topMargin: 26
        width: 32
        height: 16
    }

    Button {
        id: achievementFrameAchievementsContainerButton3
        name: "AchievementFrameAchievementsContainerButton3"
        wowParent: "AchievementFrameAchievementsContainerScrollChild"
        anchors.left: achievementFrameAchievementsContainerButton2.left
        anchors.top: achievementFrameAchievementsContainerButton2.bottom
        width: 496
        height: 84
    }

    FontString {
        id: achievementFrameAchievementsContainerButton3DateCompleted
        name: "AchievementFrameAchievementsContainerButton3DateCompleted"
        text: "10/21/26"
        wowParent: "AchievementFrameAchievementsContainerButton3"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton3Shield.horizontalCenter
        anchors.horizontalCenterOffset: -3
        anchors.top: achievementFrameAchievementsContainerButton3Shield.bottom
        anchors.topMargin: -6
        width: 100
        height: 14
    }

    FontString {
        id: achievementFrameAchievementsContainerButton3Description
        name: "AchievementFrameAchievementsContainerButton3Description"
        text: "Receive a handful of a candy from one of the Candy Buckets located in an inn."
        wowParent: "AchievementFrameAchievementsContainerButton3"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton3.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton3.top
        anchors.topMargin: 30
        width: 330
        height: 30
    }

    Frame {
        id: achievementFrameAchievementsContainerButton3Highlight
        name: "AchievementFrameAchievementsContainerButton3Highlight"
        wowParent: "AchievementFrameAchievementsContainerButton3"
        anchors.left: achievementFrameAchievementsContainerButton3.left
        anchors.top: achievementFrameAchievementsContainerButton3.top
        width: 496
        height: 84
    }

    Frame {
        id: achievementFrameAchievementsContainerButton3Icon
        name: "AchievementFrameAchievementsContainerButton3Icon"
        wowParent: "AchievementFrameAchievementsContainerButton3"
        anchors.left: achievementFrameAchievementsContainerButton3.left
        anchors.leftMargin: 8
        anchors.top: achievementFrameAchievementsContainerButton3.top
        anchors.topMargin: 9
        width: 60
        height: 60
    }

    FontString {
        id: achievementFrameAchievementsContainerButton3Label
        name: "AchievementFrameAchievementsContainerButton3Label"
        text: "Trick or Treat!"
        wowParent: "AchievementFrameAchievementsContainerButton3"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton3TitleBackground.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton3TitleBackground.top
        width: 320
        height: 20
    }

    Frame {
        id: achievementFrameAchievementsContainerButton3Objectives
        name: "AchievementFrameAchievementsContainerButton3Objectives"
        wowParent: "AchievementFrameAchievementsContainerButton3"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton3Description.horizontalCenter
        anchors.horizontalCenterOffset: -2
        anchors.top: achievementFrameAchievementsContainerButton3Description.bottom
        anchors.topMargin: 8
        width: 340
        height: -6
    }

    FontString {
        id: achievementFrameAchievementsContainerButton3Reward
        name: "AchievementFrameAchievementsContainerButton3Reward"
        text: "Title Reward: Flame Warden"
        wowParent: "AchievementFrameAchievementsContainerButton3"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton3RewardBackground.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton3RewardBackground.top
        anchors.topMargin: -1
        width: 400
        height: 20
    }

    Frame {
        id: achievementFrameAchievementsContainerButton3Shield
        name: "AchievementFrameAchievementsContainerButton3Shield"
        wowParent: "AchievementFrameAchievementsContainerButton3"
        anchors.right: achievementFrameAchievementsContainerButton3.right
        anchors.rightMargin: 6
        anchors.top: achievementFrameAchievementsContainerButton3.top
        width: 64
        height: 64
    }

    FontString {
        id: achievementFrameAchievementsContainerButton3ShieldPoints
        name: "AchievementFrameAchievementsContainerButton3ShieldPoints"
        text: "10"
        wowParent: "AchievementFrameAchievementsContainerButton3Shield"
        anchors.right: achievementFrameAchievementsContainerButton3Shield.right
        anchors.rightMargin: 18
        anchors.top: achievementFrameAchievementsContainerButton3Shield.top
        anchors.topMargin: 26
        width: 32
        height: 16
    }

    Button {
        id: achievementFrameAchievementsContainerButton4
        name: "AchievementFrameAchievementsContainerButton4"
        wowParent: "AchievementFrameAchievementsContainerScrollChild"
        anchors.left: achievementFrameAchievementsContainerButton3.left
        anchors.top: achievementFrameAchievementsContainerButton3.bottom
        width: 496
        height: 84
    }

    FontString {
        id: achievementFrameAchievementsContainerButton4DateCompleted
        name: "AchievementFrameAchievementsContainerButton4DateCompleted"
        text: "10/18/26"
        wowParent: "AchievementFrameAchievementsContainerButton4"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton4Shield.horizontalCenter
        anchors.horizontalCenterOffset: -3
        anchors.top: achievementFrameAchievementsContainerButton4Shield.bottom
        anchors.topMargin: -6
        width: 100
        height: 14
    }

    FontString {
        id: achievementFrameAchievementsContainerButton4Description
        name: "AchievementFrameAchievementsContainerButton4Description"
        text: "Obtain a Flimsy Mask during Hallow's End."
        wowParent: "AchievementFrameAchievementsContainerButton4"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton4.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton4.top
        anchors.topMargin: 30
        width: 330
        height: 30
    }

    Frame {
        id: achievementFrameAchievementsContainerButton4Highlight
        name: "AchievementFrameAchievementsContainerButton4Highlight"
        wowParent: "AchievementFrameAchievementsContainerButton4"
        anchors.left: achievementFrameAchievementsContainerButton4.left
        anchors.top: achievementFrameAchievementsContainerButton4.top
        anchors.topMargin: 80.8
        width: 496
        height: 84
    }

    Frame {
        id: achievementFrameAchievementsContainerButton4Icon
        name: "AchievementFrameAchievementsContainerButton4Icon"
        wowParent: "AchievementFrameAchievementsContainerButton4"
        anchors.left: achievementFrameAchievementsContainerButton4.left
        anchors.leftMargin: 8
        anchors.top: achievementFrameAchievementsContainerButton4.top
        anchors.topMargin: 9
        width: 60
        height: 60
    }

    FontString {
        id: achievementFrameAchievementsContainerButton4Label
        name: "AchievementFrameAchievementsContainerButton4Label"
        text: "The Mask Task"
        wowParent: "AchievementFrameAchievementsContainerButton4"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton4TitleBackground.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton4TitleBackground.top
        width: 320
        height: 20
    }

    Frame {
        id: achievementFrameAchievementsContainerButton4Objectives
        name: "AchievementFrameAchievementsContainerButton4Objectives"
        wowParent: "AchievementFrameAchievementsContainerButton4"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton4Description.horizontalCenter
        anchors.horizontalCenterOffset: -2
        anchors.top: achievementFrameAchievementsContainerButton4Description.bottom
        anchors.topMargin: 8
        width: 340
        height: -6
    }

    FontString {
        id: achievementFrameAchievementsContainerButton4Reward
        name: "AchievementFrameAchievementsContainerButton4Reward"
        text: "Title: Bloodsail Admiral"
        wowParent: "AchievementFrameAchievementsContainerButton4"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton4RewardBackground.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton4RewardBackground.top
        anchors.topMargin: -1
        width: 400
        height: 20
    }

    Frame {
        id: achievementFrameAchievementsContainerButton4Shield
        name: "AchievementFrameAchievementsContainerButton4Shield"
        wowParent: "AchievementFrameAchievementsContainerButton4"
        anchors.right: achievementFrameAchievementsContainerButton4.right
        anchors.rightMargin: 6
        anchors.top: achievementFrameAchievementsContainerButton4.top
        width: 64
        height: 64
    }

    FontString {
        id: achievementFrameAchievementsContainerButton4ShieldPoints
        name: "AchievementFrameAchievementsContainerButton4ShieldPoints"
        text: "10"
        wowParent: "AchievementFrameAchievementsContainerButton4Shield"
        anchors.right: achievementFrameAchievementsContainerButton4Shield.right
        anchors.rightMargin: 18
        anchors.top: achievementFrameAchievementsContainerButton4Shield.top
        anchors.topMargin: 26
        width: 32
        height: 16
    }

    Button {
        id: achievementFrameAchievementsContainerButton5
        name: "AchievementFrameAchievementsContainerButton5"
        wowParent: "AchievementFrameAchievementsContainerScrollChild"
        anchors.left: achievementFrameAchievementsContainerButton4.left
        anchors.top: achievementFrameAchievementsContainerButton4.bottom
        width: 496
        height: 84
    }

    FontString {
        id: achievementFrameAchievementsContainerButton5DateCompleted
        name: "AchievementFrameAchievementsContainerButton5DateCompleted"
        text: "10/18/26"
        wowParent: "AchievementFrameAchievementsContainerButton5"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton5Shield.horizontalCenter
        anchors.horizontalCenterOffset: -3
        anchors.top: achievementFrameAchievementsContainerButton5Shield.bottom
        anchors.topMargin: -6
        width: 100
        height: 14
    }

    FontString {
        id: achievementFrameAchievementsContainerButton5Description
        name: "AchievementFrameAchievementsContainerButton5Description"
        text: "Kill the Headless Horseman."
        wowParent: "AchievementFrameAchievementsContainerButton5"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton5.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton5.top
        anchors.topMargin: 30
        width: 330
        height: 30
    }

    Frame {
        id: achievementFrameAchievementsContainerButton5Icon
        name: "AchievementFrameAchievementsContainerButton5Icon"
        wowParent: "AchievementFrameAchievementsContainerButton5"
        anchors.left: achievementFrameAchievementsContainerButton5.left
        anchors.leftMargin: 8
        anchors.top: achievementFrameAchievementsContainerButton5.top
        anchors.topMargin: 9
        width: 60
        height: 60
    }

    FontString {
        id: achievementFrameAchievementsContainerButton5Label
        name: "AchievementFrameAchievementsContainerButton5Label"
        text: "Bring Me The Head of... Oh Wait"
        wowParent: "AchievementFrameAchievementsContainerButton5"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton5TitleBackground.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton5TitleBackground.top
        width: 320
        height: 20
    }

    Frame {
        id: achievementFrameAchievementsContainerButton5Objectives
        name: "AchievementFrameAchievementsContainerButton5Objectives"
        wowParent: "AchievementFrameAchievementsContainerButton5"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton5Description.horizontalCenter
        anchors.horizontalCenterOffset: -2
        anchors.top: achievementFrameAchievementsContainerButton5Description.bottom
        anchors.topMargin: 8
        width: 340
        height: -6
    }

    FontString {
        id: achievementFrameAchievementsContainerButton5Reward
        name: "AchievementFrameAchievementsContainerButton5Reward"
        text: "Title Reward: The Love Fool"
        wowParent: "AchievementFrameAchievementsContainerButton5"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton5RewardBackground.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton5RewardBackground.top
        anchors.topMargin: -1
        width: 400
        height: 20
    }

    Frame {
        id: achievementFrameAchievementsContainerButton5Shield
        name: "AchievementFrameAchievementsContainerButton5Shield"
        wowParent: "AchievementFrameAchievementsContainerButton5"
        anchors.right: achievementFrameAchievementsContainerButton5.right
        anchors.rightMargin: 6
        anchors.top: achievementFrameAchievementsContainerButton5.top
        width: 64
        height: 64
    }

    FontString {
        id: achievementFrameAchievementsContainerButton5ShieldPoints
        name: "AchievementFrameAchievementsContainerButton5ShieldPoints"
        text: "10"
        wowParent: "AchievementFrameAchievementsContainerButton5Shield"
        anchors.right: achievementFrameAchievementsContainerButton5Shield.right
        anchors.rightMargin: 18
        anchors.top: achievementFrameAchievementsContainerButton5Shield.top
        anchors.topMargin: 26
        width: 32
        height: 16
    }

    Button {
        id: achievementFrameAchievementsContainerButton6
        name: "AchievementFrameAchievementsContainerButton6"
        wowParent: "AchievementFrameAchievementsContainerScrollChild"
        anchors.left: achievementFrameAchievementsContainerButton5.left
        anchors.top: achievementFrameAchievementsContainerButton5.bottom
        width: 496
        height: 84
    }

    FontString {
        id: achievementFrameAchievementsContainerButton6DateCompleted
        name: "AchievementFrameAchievementsContainerButton6DateCompleted"
        text: "10/18/26"
        wowParent: "AchievementFrameAchievementsContainerButton6"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton6Shield.horizontalCenter
        anchors.horizontalCenterOffset: -3
        anchors.top: achievementFrameAchievementsContainerButton6Shield.bottom
        anchors.topMargin: -6
        width: 100
        height: 14
    }

    FontString {
        id: achievementFrameAchievementsContainerButton6Description
        name: "AchievementFrameAchievementsContainerButton6Description"
        text: "Complete one of the quests to save a village from the Headless Horseman."
        wowParent: "AchievementFrameAchievementsContainerButton6"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton6.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton6.top
        anchors.topMargin: 30
        width: 330
        height: 30
    }

    Frame {
        id: achievementFrameAchievementsContainerButton6Icon
        name: "AchievementFrameAchievementsContainerButton6Icon"
        wowParent: "AchievementFrameAchievementsContainerButton6"
        anchors.left: achievementFrameAchievementsContainerButton6.left
        anchors.leftMargin: 8
        anchors.top: achievementFrameAchievementsContainerButton6.top
        anchors.topMargin: 9
        width: 60
        height: 60
    }

    FontString {
        id: achievementFrameAchievementsContainerButton6Label
        name: "AchievementFrameAchievementsContainerButton6Label"
        text: "The Savior of Hallow's End"
        wowParent: "AchievementFrameAchievementsContainerButton6"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton6TitleBackground.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton6TitleBackground.top
        width: 320
        height: 20
    }

    Frame {
        id: achievementFrameAchievementsContainerButton6Objectives
        name: "AchievementFrameAchievementsContainerButton6Objectives"
        wowParent: "AchievementFrameAchievementsContainerButton6"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton6Description.horizontalCenter
        anchors.horizontalCenterOffset: -2
        anchors.top: achievementFrameAchievementsContainerButton6Description.bottom
        anchors.topMargin: 8
        width: 340
        height: -6
    }

    FontString {
        id: achievementFrameAchievementsContainerButton6Reward
        name: "AchievementFrameAchievementsContainerButton6Reward"
        text: "Title Reward: the Noble"
        wowParent: "AchievementFrameAchievementsContainerButton6"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton6RewardBackground.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton6RewardBackground.top
        anchors.topMargin: -1
        width: 400
        height: 20
    }

    Frame {
        id: achievementFrameAchievementsContainerButton6Shield
        name: "AchievementFrameAchievementsContainerButton6Shield"
        wowParent: "AchievementFrameAchievementsContainerButton6"
        anchors.right: achievementFrameAchievementsContainerButton6.right
        anchors.rightMargin: 6
        anchors.top: achievementFrameAchievementsContainerButton6.top
        width: 64
        height: 64
    }

    FontString {
        id: achievementFrameAchievementsContainerButton6ShieldPoints
        name: "AchievementFrameAchievementsContainerButton6ShieldPoints"
        text: "10"
        wowParent: "AchievementFrameAchievementsContainerButton6Shield"
        anchors.right: achievementFrameAchievementsContainerButton6Shield.right
        anchors.rightMargin: 18
        anchors.top: achievementFrameAchievementsContainerButton6Shield.top
        anchors.topMargin: 26
        width: 32
        height: 16
    }

    Button {
        id: achievementFrameAchievementsContainerButton7
        name: "AchievementFrameAchievementsContainerButton7"
        wowParent: "AchievementFrameAchievementsContainerScrollChild"
        anchors.left: achievementFrameAchievementsContainerButton6.left
        anchors.top: achievementFrameAchievementsContainerButton6.bottom
        width: 496
        height: 84
    }

    FontString {
        id: achievementFrameAchievementsContainerButton7DateCompleted
        name: "AchievementFrameAchievementsContainerButton7DateCompleted"
        text: "5/26/26"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton7Shield.horizontalCenter
        anchors.horizontalCenterOffset: -3
        anchors.top: achievementFrameAchievementsContainerButton7Shield.bottom
        anchors.topMargin: -6
        width: 42
        height: 12
    }

    FontString {
        id: achievementFrameAchievementsContainerButton7Description
        name: "AchievementFrameAchievementsContainerButton7Description"
        text: "Collect the 20 unique Flimsy Masks listed below."
        wowParent: "AchievementFrameAchievementsContainerButton7"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton7.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton7.top
        anchors.topMargin: 30
        width: 330
        height: 30
    }

    Frame {
        id: achievementFrameAchievementsContainerButton7Icon
        name: "AchievementFrameAchievementsContainerButton7Icon"
        wowParent: "AchievementFrameAchievementsContainerButton7"
        anchors.left: achievementFrameAchievementsContainerButton7.left
        anchors.leftMargin: 8
        anchors.top: achievementFrameAchievementsContainerButton7.top
        anchors.topMargin: 9
        width: 60
        height: 60
    }

    FontString {
        id: achievementFrameAchievementsContainerButton7Label
        name: "AchievementFrameAchievementsContainerButton7Label"
        text: "A Mask for All Occasions"
        wowParent: "AchievementFrameAchievementsContainerButton7"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton7TitleBackground.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton7TitleBackground.top
        width: 320
        height: 20
    }

    Frame {
        id: achievementFrameAchievementsContainerButton7Objectives
        name: "AchievementFrameAchievementsContainerButton7Objectives"
        wowParent: "AchievementFrameAchievementsContainerButton7"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton7Description.horizontalCenter
        anchors.horizontalCenterOffset: -2
        anchors.top: achievementFrameAchievementsContainerButton7Description.bottom
        anchors.topMargin: 8
        width: 340
        height: -6
    }

    FontString {
        id: achievementFrameAchievementsContainerButton7Reward
        name: "AchievementFrameAchievementsContainerButton7Reward"
        text: "Title Reward: Matron/Patron"
        wowParent: "AchievementFrameAchievementsContainerButton7"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton7RewardBackground.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerButton7RewardBackground.top
        anchors.topMargin: -1
        width: 400
        height: 20
    }

    Frame {
        id: achievementFrameAchievementsContainerButton7Shield
        name: "AchievementFrameAchievementsContainerButton7Shield"
        wowParent: "AchievementFrameAchievementsContainerButton7"
        anchors.right: achievementFrameAchievementsContainerButton7.right
        anchors.rightMargin: 6
        anchors.top: achievementFrameAchievementsContainerButton7.top
        width: 64
        height: 64
    }

    FontString {
        id: achievementFrameAchievementsContainerButton7ShieldPoints
        name: "AchievementFrameAchievementsContainerButton7ShieldPoints"
        text: "20"
        wowParent: "AchievementFrameAchievementsContainerButton7Shield"
        anchors.right: achievementFrameAchievementsContainerButton7Shield.right
        anchors.rightMargin: 18
        anchors.top: achievementFrameAchievementsContainerButton7Shield.top
        anchors.topMargin: 26
        width: 32
        height: 16
    }

    Slider {
        id: achievementFrameAchievementsContainerScrollBar
        name: "AchievementFrameAchievementsContainerScrollBar"
        wowParent: "AchievementFrameAchievementsContainer"
        anchors.left: achievementFrameAchievementsContainer.right
        anchors.leftMargin: 1
        anchors.top: achievementFrameAchievementsContainer.top
        anchors.topMargin: 16
        width: 20
        height: 425
    }

    Frame {
        id: achievementFrameAchievementsContainerScrollBarDiabolicTrack
        name: "AchievementFrameAchievementsContainerScrollBarDiabolicTrack"
        wowParent: "AchievementFrameAchievementsContainerScrollBar"
        anchors.horizontalCenter: achievementFrameAchievementsContainerScrollBarScrollUpButton.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 455
    }

    Button {
        id: achievementFrameAchievementsContainerScrollBarScrollDownButton
        name: "AchievementFrameAchievementsContainerScrollBarScrollDownButton"
        wowParent: "AchievementFrameAchievementsContainerScrollBar"
        anchors.horizontalCenter: achievementFrameAchievementsContainerScrollBar.horizontalCenter
        anchors.top: achievementFrameAchievementsContainerScrollBar.bottom
        anchors.topMargin: -2
        width: 16
        height: 16
    }

    Button {
        id: achievementFrameAchievementsContainerScrollBarScrollUpButton
        name: "AchievementFrameAchievementsContainerScrollBarScrollUpButton"
        wowParent: "AchievementFrameAchievementsContainerScrollBar"
        anchors.horizontalCenter: achievementFrameAchievementsContainerScrollBar.horizontalCenter
        anchors.bottom: achievementFrameAchievementsContainerScrollBar.top
        anchors.bottomMargin: -2
        width: 16
        height: 16
    }

    Frame {
        id: achievementFrameAchievementsContainerScrollChild
        name: "AchievementFrameAchievementsContainerScrollChild"
        wowParent: "AchievementFrameAchievementsContainer"
        anchors.left: achievementFrameAchievementsContainer.left
        anchors.top: achievementFrameAchievementsContainer.top
        anchors.topMargin: -86
        width: 500
        height: 593.3
    }

    Frame {
        id: achievementFrameAchievementsObjectives
        name: "AchievementFrameAchievementsObjectives"
        wowParent: "AchievementFrameAchievementsContainerButton1"
        anchors.horizontalCenter: achievementFrameAchievementsContainerButton1HiddenDescription.horizontalCenter
        anchors.horizontalCenterOffset: -8.5
        anchors.top: achievementFrameAchievementsContainerButton1HiddenDescription.bottom
        anchors.topMargin: 8
        width: 353
        height: 15
    }

    Frame {
        id: achievementFrameCategories
        name: "AchievementFrameCategories"
        wowParent: "AchievementFrame"
        anchors.left: achievementFrame.left
        anchors.leftMargin: 21
        anchors.top: achievementFrame.top
        anchors.topMargin: 19
        width: 197
        height: 461
    }

    ScrollFrame {
        id: achievementFrameCategoriesContainer
        name: "AchievementFrameCategoriesContainer"
        wowParent: "AchievementFrameCategories"
        anchors.left: achievementFrameCategories.left
        anchors.top: achievementFrameCategories.top
        anchors.topMargin: 5
        width: 197
        height: 451
    }

    Button {
        id: achievementFrameCategoriesContainerButton1
        name: "AchievementFrameCategoriesContainerButton1"
        wowParent: "AchievementFrameCategoriesContainerScrollChild"
        anchors.horizontalCenter: achievementFrameCategoriesContainerScrollChild.horizontalCenter
        anchors.top: achievementFrameCategoriesContainerScrollChild.top
        width: 187
        height: 24
    }

    FontString {
        id: achievementFrameCategoriesContainerButton1Label
        name: "AchievementFrameCategoriesContainerButton1Label"
        text: "Summary"
        wowParent: "AchievementFrameCategoriesContainerButton1"
        anchors.left: achievementFrameCategoriesContainerButton1.left
        anchors.leftMargin: 14
        anchors.verticalCenter: achievementFrameCategoriesContainerButton1.verticalCenter
        width: 159
        height: 11.9
    }

    Slider {
        id: achievementFrameCategoriesContainerScrollBar
        name: "AchievementFrameCategoriesContainerScrollBar"
        wowParent: "AchievementFrameCategoriesContainer"
        anchors.left: achievementFrameCategoriesContainer.right
        anchors.leftMargin: -21
        anchors.top: achievementFrameCategoriesContainer.top
        anchors.topMargin: 14
        width: 20
        height: 425
    }

    Frame {
        id: achievementFrameCategoriesContainerScrollBarDiabolicTrack
        name: "AchievementFrameCategoriesContainerScrollBarDiabolicTrack"
        wowParent: "AchievementFrameCategoriesContainerScrollBar"
        anchors.horizontalCenter: achievementFrameCategoriesContainerScrollBarScrollUpButton.horizontalCenter
        anchors.top: achievementFrameCategoriesContainerScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 455
    }

    Button {
        id: achievementFrameCategoriesContainerScrollBarScrollDownButton
        name: "AchievementFrameCategoriesContainerScrollBarScrollDownButton"
        wowParent: "AchievementFrameCategoriesContainerScrollBar"
        anchors.horizontalCenter: achievementFrameCategoriesContainerScrollBar.horizontalCenter
        anchors.top: achievementFrameCategoriesContainerScrollBar.bottom
        anchors.topMargin: -2
        width: 16
        height: 16
    }

    Button {
        id: achievementFrameCategoriesContainerScrollBarScrollUpButton
        name: "AchievementFrameCategoriesContainerScrollBarScrollUpButton"
        wowParent: "AchievementFrameCategoriesContainerScrollBar"
        anchors.horizontalCenter: achievementFrameCategoriesContainerScrollBar.horizontalCenter
        anchors.bottom: achievementFrameCategoriesContainerScrollBar.top
        anchors.bottomMargin: -2
        width: 16
        height: 16
    }

    Frame {
        id: achievementFrameCategoriesContainerScrollChild
        name: "AchievementFrameCategoriesContainerScrollChild"
        wowParent: "AchievementFrameCategoriesContainer"
        anchors.left: achievementFrameCategoriesContainer.left
        anchors.top: achievementFrameCategoriesContainer.top
        width: 197
        height: 480
    }

    Button {
        id: achievementFrameCloseButton
        name: "AchievementFrameCloseButton"
        wowParent: "AchievementFrame"
        style: "CloseButton"
        anchors.horizontalCenter: achievementFrameDiabolic.right
        anchors.horizontalCenterOffset: -31
        anchors.verticalCenter: achievementFrameDiabolic.top
        anchors.verticalCenterOffset: 31
        width: 22
        height: 22
    }

    Frame {
        id: achievementFrameCriteria1
        name: "AchievementFrameCriteria1"
        wowParent: "AchievementFrameAchievementsObjectives"
        anchors.left: achievementFrameAchievementsObjectives.left
        anchors.top: achievementFrameAchievementsObjectives.top
        width: 120.3
        height: 15
    }

    FontString {
        id: achievementFrameCriteria1Name
        name: "AchievementFrameCriteria1Name"
        text: "Sinister Squashling"
        wowParent: "AchievementFrameCriteria1"
        anchors.left: achievementFrameCriteria1Check.right
        anchors.verticalCenter: achievementFrameCriteria1Check.verticalCenter
        anchors.verticalCenterOffset: -2
        width: 100.3
        height: 10.3
    }

    Frame {
        id: achievementFrameCriteria2
        name: "AchievementFrameCriteria2"
        wowParent: "AchievementFrameAchievementsObjectives"
        anchors.left: achievementFrameAchievementsObjectives.left
        anchors.leftMargin: 165
        anchors.top: achievementFrameAchievementsObjectives.top
        width: 102.2
        height: 15
    }

    FontString {
        id: achievementFrameCriteria2Name
        name: "AchievementFrameCriteria2Name"
        text: "Hallowed Helm"
        wowParent: "AchievementFrameCriteria2"
        anchors.left: achievementFrameCriteria2Check.right
        anchors.verticalCenter: achievementFrameCriteria2Check.verticalCenter
        anchors.verticalCenterOffset: -2
        width: 82.2
        height: 10.3
    }

    Frame {
        id: achievementFrameDiabolic
        name: "AchievementFrameDiabolic"
        wowParent: "AchievementFrame"
        anchors.left: achievementFrame.left
        anchors.top: achievementFrame.top
        anchors.topMargin: -64
        width: 768
        height: 582
    }

    Frame {
        id: achievementFrameDiabolicBand
        name: "AchievementFrameDiabolicBand"
        wowParent: "AchievementFrameDiabolic"
        anchors.left: achievementFrameDiabolic.left
        anchors.leftMargin: 24
        anchors.top: achievementFrameDiabolic.top
        anchors.topMargin: 24
        width: 720
        height: 48
    }

    Frame {
        id: achievementFrameDiabolicBorder
        name: "AchievementFrameDiabolicBorder"
        wowParent: "AchievementFrameDiabolic"
        anchors.left: achievementFrameDiabolic.left
        anchors.top: achievementFrameDiabolic.top
        width: 768
        height: 582
    }

    Frame {
        id: achievementFrameDiabolicRail
        name: "AchievementFrameDiabolicRail"
        wowParent: "AchievementFrameDiabolic"
        anchors.left: achievementFrameDiabolic.left
        anchors.leftMargin: 18
        anchors.top: achievementFrameDiabolic.bottom
        anchors.topMargin: -19
        width: 304
        height: 18
    }

    Frame {
        id: achievementFrameDiabolicSocket
        name: "AchievementFrameDiabolicSocket"
        wowParent: "AchievementFrameDiabolic"
        anchors.right: achievementFrameDiabolic.right
        anchors.rightMargin: 20
        anchors.top: achievementFrameDiabolic.top
        anchors.topMargin: 20
        width: 42
        height: 42
    }

    Frame {
        id: achievementFrameDiabolicTitlePlate
        name: "AchievementFrameDiabolicTitlePlate"
        wowParent: "AchievementFrameDiabolic"
        anchors.horizontalCenter: achievementFrameDiabolicBorder.horizontalCenter
        anchors.verticalCenter: achievementFrameDiabolicBorder.top
        anchors.verticalCenterOffset: 15
        width: 300
        height: 41
    }

    Frame {
        id: achievementFrameFilterDropDown
        name: "AchievementFrameFilterDropDown"
        wowParent: "AchievementFrame"
        style: "DropDown"
        anchors.left: achievementFrameDiabolicBand.left
        anchors.leftMargin: 18
        anchors.verticalCenter: achievementFrameDiabolicBand.verticalCenter
        width: 110
        height: 32
    }

    Button {
        id: achievementFrameFilterDropDownButton
        name: "AchievementFrameFilterDropDownButton"
        wowParent: "AchievementFrameFilterDropDown"
        anchors.right: achievementFrameFilterDropDownDiabolicField.right
        anchors.rightMargin: -8
        anchors.verticalCenter: achievementFrameFilterDropDownDiabolicField.verticalCenter
        width: 18
        height: 18
    }

    Frame {
        id: achievementFrameFilterDropDownDiabolicField
        name: "AchievementFrameFilterDropDownDiabolicField"
        wowParent: "AchievementFrameFilterDropDown"
        anchors.left: achievementFrameFilterDropDown.left
        anchors.verticalCenter: achievementFrameFilterDropDown.verticalCenter
        anchors.verticalCenterOffset: -4
        width: 110
        height: 22
    }

    FontString {
        id: achievementFrameFilterDropDownText
        name: "AchievementFrameFilterDropDownText"
        text: "All"
        wowParent: "AchievementFrameFilterDropDown"
        anchors.left: achievementFrameFilterDropDownDiabolicField.left
        anchors.leftMargin: -4
        anchors.verticalCenter: achievementFrameFilterDropDownDiabolicField.verticalCenter
        width: 100
        height: 32
    }

    Frame {
        id: achievementFrameHeader
        name: "AchievementFrameHeader"
        wowParent: "AchievementFrame"
        anchors.left: achievementFrameDiabolicBand.left
        anchors.top: achievementFrameDiabolicBand.top
        width: 720
        height: 48
    }

    FontString {
        id: achievementFrameHeaderPoints
        name: "AchievementFrameHeaderPoints"
        text: "3460"
        wowParent: "AchievementFrameHeaderPointsDiabolicCartouche"
        anchors.horizontalCenter: achievementFrameHeaderPointsDiabolicCartouche.horizontalCenter
        anchors.horizontalCenterOffset: 10
        anchors.verticalCenter: achievementFrameHeaderPointsDiabolicCartouche.verticalCenter
        width: 51.4
        height: 12
    }

    Frame {
        id: achievementFrameHeaderPointsDiabolicCartouche
        name: "AchievementFrameHeaderPointsDiabolicCartouche"
        wowParent: "AchievementFrameDiabolicBand"
        anchors.horizontalCenter: achievementFrameDiabolicBand.horizontalCenter
        anchors.verticalCenter: achievementFrameDiabolicBand.verticalCenter
        width: 107.4
        height: 38
    }

    FontString {
        id: achievementFrameHeaderTitle
        name: "AchievementFrameHeaderTitle"
        text: "Achievements"
        wowParent: "AchievementFrameDiabolicTitlePlate"
        anchors.horizontalCenter: achievementFrameDiabolicTitlePlate.horizontalCenter
        anchors.verticalCenter: achievementFrameDiabolicTitlePlate.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 123.3
        height: 14.2
    }

    Frame {
        id: achievementFrameStats
        name: "AchievementFrameStats"
        wowParent: "AchievementFrame"
        anchors.left: achievementFrameCategories.right
        anchors.top: achievementFrameCategories.top
        width: 504
        height: 461
    }

    Frame {
        id: achievementFrameStatsBG
        name: "AchievementFrameStatsBG"
        wowParent: "AchievementFrameStats"
        anchors.left: achievementFrameStats.left
        anchors.leftMargin: 2
        anchors.top: achievementFrameStats.top
        width: 526
        height: 458
    }

    ScrollFrame {
        id: achievementFrameStatsContainer
        name: "AchievementFrameStatsContainer"
        wowParent: "AchievementFrameStats"
        anchors.left: achievementFrameStats.left
        anchors.leftMargin: 3
        anchors.top: achievementFrameStats.top
        anchors.topMargin: 3
        width: 501
        height: 453
    }

    Button {
        id: achievementFrameStatsContainerButton1
        name: "AchievementFrameStatsContainerButton1"
        wowParent: "AchievementFrameStatsContainerScrollChild"
        anchors.left: achievementFrameStatsContainerScrollChild.left
        anchors.top: achievementFrameStatsContainerScrollChild.top
        width: 496
        height: 24
    }

    FontString {
        id: achievementFrameStatsContainerButton17Title
        name: "AchievementFrameStatsContainerButton17Title"
        text: "Professions"
        wowParent: "AchievementFrameStatsContainerButton17"
        anchors.horizontalCenter: achievementFrameStatsContainerButton17.horizontalCenter
        anchors.verticalCenter: achievementFrameStatsContainerButton17.verticalCenter
        width: 89.3
        height: 15.8
    }

    FontString {
        id: achievementFrameStatsContainerButton19Title
        name: "AchievementFrameStatsContainerButton19Title"
        text: "Classic"
        wowParent: "AchievementFrameStatsContainerButton19"
        anchors.horizontalCenter: achievementFrameStatsContainerButton19.horizontalCenter
        anchors.verticalCenter: achievementFrameStatsContainerButton19.verticalCenter
        width: 55.3
        height: 15.8
    }

    FontString {
        id: achievementFrameStatsContainerButton1Title
        name: "AchievementFrameStatsContainerButton1Title"
        text: "Summary"
        wowParent: "AchievementFrameStatsContainerButton1"
        anchors.horizontalCenter: achievementFrameStatsContainerButton1.horizontalCenter
        anchors.verticalCenter: achievementFrameStatsContainerButton1.verticalCenter
        width: 74.3
        height: 15.8
    }

    FontString {
        id: achievementFrameStatsContainerButton1Value
        name: "AchievementFrameStatsContainerButton1Value"
        wowParent: "AchievementFrameStatsContainerButton1"
        anchors.right: achievementFrameStatsContainerButton1.right
        anchors.rightMargin: 5
        anchors.verticalCenter: achievementFrameStatsContainerButton1.verticalCenter
        width: 1
        height: 1
    }

    FontString {
        id: achievementFrameStatsContainerButton4Title
        name: "AchievementFrameStatsContainerButton4Title"
        text: "Creatures"
        wowParent: "AchievementFrameStatsContainerButton4"
        anchors.horizontalCenter: achievementFrameStatsContainerButton4.horizontalCenter
        anchors.verticalCenter: achievementFrameStatsContainerButton4.verticalCenter
        width: 73.5
        height: 15.8
    }

    FontString {
        id: achievementFrameStatsContainerButton6Title
        name: "AchievementFrameStatsContainerButton6Title"
        text: "Secondary Skills"
        wowParent: "AchievementFrameStatsContainerButton6"
        anchors.horizontalCenter: achievementFrameStatsContainerButton6.horizontalCenter
        anchors.verticalCenter: achievementFrameStatsContainerButton6.verticalCenter
        width: 127.2
        height: 15.8
    }

    FontString {
        id: achievementFrameStatsContainerButton9Title
        name: "AchievementFrameStatsContainerButton9Title"
        text: "Honorable Kills"
        wowParent: "AchievementFrameStatsContainerButton9"
        anchors.horizontalCenter: achievementFrameStatsContainerButton9.horizontalCenter
        anchors.verticalCenter: achievementFrameStatsContainerButton9.verticalCenter
        width: 119.3
        height: 15.8
    }

    Slider {
        id: achievementFrameStatsContainerScrollBar
        name: "AchievementFrameStatsContainerScrollBar"
        wowParent: "AchievementFrameStatsContainer"
        style: "ScrollBar"
        anchors.left: achievementFrameStatsContainer.right
        anchors.leftMargin: 1
        anchors.top: achievementFrameStatsContainer.top
        anchors.topMargin: 16
        width: 20
        height: 425
    }

    Frame {
        id: achievementFrameStatsContainerScrollBarDiabolicTrack
        name: "AchievementFrameStatsContainerScrollBarDiabolicTrack"
        wowParent: "AchievementFrameStatsContainerScrollBar"
        anchors.horizontalCenter: achievementFrameStatsContainerScrollBarScrollUpButton.horizontalCenter
        anchors.top: achievementFrameStatsContainerScrollBarScrollUpButton.top
        anchors.topMargin: -1
        width: 18
        height: 455
    }

    Button {
        id: achievementFrameStatsContainerScrollBarScrollDownButton
        name: "AchievementFrameStatsContainerScrollBarScrollDownButton"
        wowParent: "AchievementFrameStatsContainerScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: achievementFrameStatsContainerScrollBar.horizontalCenter
        anchors.top: achievementFrameStatsContainerScrollBar.bottom
        anchors.topMargin: -2
        width: 16
        height: 16
    }

    Button {
        id: achievementFrameStatsContainerScrollBarScrollUpButton
        name: "AchievementFrameStatsContainerScrollBarScrollUpButton"
        wowParent: "AchievementFrameStatsContainerScrollBar"
        style: "ScrollBar"
        anchors.horizontalCenter: achievementFrameStatsContainerScrollBar.horizontalCenter
        anchors.bottom: achievementFrameStatsContainerScrollBar.top
        anchors.bottomMargin: -2
        width: 16
        height: 16
    }

    Frame {
        id: achievementFrameStatsContainerScrollChild
        name: "AchievementFrameStatsContainerScrollChild"
        wowParent: "AchievementFrameStatsContainer"
        anchors.left: achievementFrameStatsContainer.left
        anchors.top: achievementFrameStatsContainer.top
        width: 503
        height: 480
    }

    Frame {
        id: achievementFrameSummary
        name: "AchievementFrameSummary"
        wowParent: "AchievementFrame"
        anchors.left: achievementFrameCategories.right
        anchors.top: achievementFrameCategories.top
        width: 530
        height: 461
    }

    Button {
        id: achievementFrameSummaryAchievement1
        name: "AchievementFrameSummaryAchievement1"
        wowParent: "AchievementFrameSummaryAchievements"
        anchors.left: achievementFrameSummaryAchievementsHeader.left
        anchors.leftMargin: 18
        anchors.top: achievementFrameSummaryAchievementsHeader.bottom
        anchors.topMargin: -2
        width: 484
        height: 48
    }

    FontString {
        id: achievementFrameSummaryAchievement1DateCompleted
        name: "AchievementFrameSummaryAchievement1DateCompleted"
        text: "10/30/26"
        wowParent: "AchievementFrameSummaryAchievement1"
        anchors.right: achievementFrameSummaryAchievement1.right
        anchors.rightMargin: 63
        anchors.top: achievementFrameSummaryAchievement1.top
        anchors.topMargin: 8
        width: 100
        height: 14
    }

    FontString {
        id: achievementFrameSummaryAchievement1Description
        name: "AchievementFrameSummaryAchievement1Description"
        text: "Show off your sparkling smile by using a Tooth Pick."
        wowParent: "AchievementFrameSummaryAchievement1"
        anchors.horizontalCenter: achievementFrameSummaryAchievement1.horizontalCenter
        anchors.top: achievementFrameSummaryAchievement1.top
        anchors.topMargin: 30
        width: 380
        height: 13
    }

    Frame {
        id: achievementFrameSummaryAchievement1Highlight
        name: "AchievementFrameSummaryAchievement1Highlight"
        wowParent: "AchievementFrameSummaryAchievement1"
        anchors.left: achievementFrameSummaryAchievement1.left
        anchors.top: achievementFrameSummaryAchievement1.top
        width: 484
        height: 48
    }

    Frame {
        id: achievementFrameSummaryAchievement1Icon
        name: "AchievementFrameSummaryAchievement1Icon"
        wowParent: "AchievementFrameSummaryAchievement1"
        anchors.left: achievementFrameSummaryAchievement1.left
        anchors.leftMargin: 3
        anchors.top: achievementFrameSummaryAchievement1.top
        anchors.topMargin: 3
        width: 48
        height: 48
    }

    FontString {
        id: achievementFrameSummaryAchievement1Label
        name: "AchievementFrameSummaryAchievement1Label"
        text: "That Sparkling Smile"
        wowParent: "AchievementFrameSummaryAchievement1"
        anchors.horizontalCenter: achievementFrameSummaryAchievement1TitleBackground.horizontalCenter
        anchors.top: achievementFrameSummaryAchievement1TitleBackground.top
        width: 260
        height: 20
    }

    Frame {
        id: achievementFrameSummaryAchievement1Shield
        name: "AchievementFrameSummaryAchievement1Shield"
        wowParent: "AchievementFrameSummaryAchievement1"
        anchors.right: achievementFrameSummaryAchievement1.right
        anchors.rightMargin: 10
        anchors.top: achievementFrameSummaryAchievement1.top
        anchors.topMargin: 4
        width: 48
        height: 48
    }

    FontString {
        id: achievementFrameSummaryAchievement1ShieldPoints
        name: "AchievementFrameSummaryAchievement1ShieldPoints"
        text: "10"
        wowParent: "AchievementFrameSummaryAchievement1Shield"
        anchors.horizontalCenter: achievementFrameSummaryAchievement1Shield.horizontalCenter
        anchors.horizontalCenterOffset: -1
        anchors.verticalCenter: achievementFrameSummaryAchievement1Shield.verticalCenter
        anchors.verticalCenterOffset: -3
        width: 40
        height: 26
    }

    Button {
        id: achievementFrameSummaryAchievement2
        name: "AchievementFrameSummaryAchievement2"
        wowParent: "AchievementFrameSummaryAchievements"
        anchors.left: achievementFrameSummaryAchievement1.left
        anchors.top: achievementFrameSummaryAchievement1.bottom
        anchors.topMargin: -3
        width: 484
        height: 48
    }

    FontString {
        id: achievementFrameSummaryAchievement2DateCompleted
        name: "AchievementFrameSummaryAchievement2DateCompleted"
        text: "10/30/26"
        wowParent: "AchievementFrameSummaryAchievement2"
        anchors.right: achievementFrameSummaryAchievement2.right
        anchors.rightMargin: 63
        anchors.top: achievementFrameSummaryAchievement2.top
        anchors.topMargin: 8
        width: 100
        height: 14
    }

    FontString {
        id: achievementFrameSummaryAchievement2Description
        name: "AchievementFrameSummaryAchievement2Description"
        text: "Earn exalted status with and the right to represent every Alliance race's faction in the Argent Tournament."
        wowParent: "AchievementFrameSummaryAchievement2"
        anchors.horizontalCenter: achievementFrameSummaryAchievement2.horizontalCenter
        anchors.top: achievementFrameSummaryAchievement2.top
        anchors.topMargin: 30
        width: 380
        height: 13
    }

    Frame {
        id: achievementFrameSummaryAchievement2Icon
        name: "AchievementFrameSummaryAchievement2Icon"
        wowParent: "AchievementFrameSummaryAchievement2"
        anchors.left: achievementFrameSummaryAchievement2.left
        anchors.leftMargin: 3
        anchors.top: achievementFrameSummaryAchievement2.top
        anchors.topMargin: 3
        width: 48
        height: 48
    }

    FontString {
        id: achievementFrameSummaryAchievement2Label
        name: "AchievementFrameSummaryAchievement2Label"
        text: "Exalted Argent Champion of the Alliance"
        wowParent: "AchievementFrameSummaryAchievement2"
        anchors.horizontalCenter: achievementFrameSummaryAchievement2TitleBackground.horizontalCenter
        anchors.top: achievementFrameSummaryAchievement2TitleBackground.top
        width: 260
        height: 20
    }

    Frame {
        id: achievementFrameSummaryAchievement2Shield
        name: "AchievementFrameSummaryAchievement2Shield"
        wowParent: "AchievementFrameSummaryAchievement2"
        anchors.right: achievementFrameSummaryAchievement2.right
        anchors.rightMargin: 10
        anchors.top: achievementFrameSummaryAchievement2.top
        anchors.topMargin: 4
        width: 48
        height: 48
    }

    FontString {
        id: achievementFrameSummaryAchievement2ShieldPoints
        name: "AchievementFrameSummaryAchievement2ShieldPoints"
        text: "10"
        wowParent: "AchievementFrameSummaryAchievement2Shield"
        anchors.horizontalCenter: achievementFrameSummaryAchievement2Shield.horizontalCenter
        anchors.horizontalCenterOffset: -1
        anchors.verticalCenter: achievementFrameSummaryAchievement2Shield.verticalCenter
        anchors.verticalCenterOffset: -3
        width: 40
        height: 26
    }

    Button {
        id: achievementFrameSummaryAchievement3
        name: "AchievementFrameSummaryAchievement3"
        wowParent: "AchievementFrameSummaryAchievements"
        anchors.left: achievementFrameSummaryAchievement2.left
        anchors.top: achievementFrameSummaryAchievement2.bottom
        anchors.topMargin: -3
        width: 484
        height: 48
    }

    FontString {
        id: achievementFrameSummaryAchievement3DateCompleted
        name: "AchievementFrameSummaryAchievement3DateCompleted"
        text: "10/30/26"
        wowParent: "AchievementFrameSummaryAchievement3"
        anchors.right: achievementFrameSummaryAchievement3.right
        anchors.rightMargin: 63
        anchors.top: achievementFrameSummaryAchievement3.top
        anchors.topMargin: 8
        width: 100
        height: 14
    }

    FontString {
        id: achievementFrameSummaryAchievement3Description
        name: "AchievementFrameSummaryAchievement3Description"
        text: "Earn exalted status with and the right to represent every Alliance race's faction in the Argent Tournament."
        wowParent: "AchievementFrameSummaryAchievement3"
        anchors.horizontalCenter: achievementFrameSummaryAchievement3.horizontalCenter
        anchors.top: achievementFrameSummaryAchievement3.top
        anchors.topMargin: 30
        width: 380
        height: 13
    }

    Frame {
        id: achievementFrameSummaryAchievement3Highlight
        name: "AchievementFrameSummaryAchievement3Highlight"
        anchors.left: achievementFrameSummaryAchievement3.left
        anchors.top: achievementFrameSummaryAchievement3.top
        width: 484
        height: 48
    }

    Frame {
        id: achievementFrameSummaryAchievement3Icon
        name: "AchievementFrameSummaryAchievement3Icon"
        wowParent: "AchievementFrameSummaryAchievement3"
        anchors.left: achievementFrameSummaryAchievement3.left
        anchors.leftMargin: 3
        anchors.top: achievementFrameSummaryAchievement3.top
        anchors.topMargin: 3
        width: 48
        height: 48
    }

    FontString {
        id: achievementFrameSummaryAchievement3Label
        name: "AchievementFrameSummaryAchievement3Label"
        text: "Exalted Champion of the Alliance"
        wowParent: "AchievementFrameSummaryAchievement3"
        anchors.horizontalCenter: achievementFrameSummaryAchievement3TitleBackground.horizontalCenter
        anchors.top: achievementFrameSummaryAchievement3TitleBackground.top
        width: 260
        height: 20
    }

    Frame {
        id: achievementFrameSummaryAchievement3Shield
        name: "AchievementFrameSummaryAchievement3Shield"
        wowParent: "AchievementFrameSummaryAchievement3"
        anchors.right: achievementFrameSummaryAchievement3.right
        anchors.rightMargin: 10
        anchors.top: achievementFrameSummaryAchievement3.top
        anchors.topMargin: 4
        width: 48
        height: 48
    }

    FontString {
        id: achievementFrameSummaryAchievement3ShieldPoints
        name: "AchievementFrameSummaryAchievement3ShieldPoints"
        text: "10"
        wowParent: "AchievementFrameSummaryAchievement3Shield"
        anchors.horizontalCenter: achievementFrameSummaryAchievement3Shield.horizontalCenter
        anchors.horizontalCenterOffset: -1
        anchors.verticalCenter: achievementFrameSummaryAchievement3Shield.verticalCenter
        anchors.verticalCenterOffset: -3
        width: 40
        height: 26
    }

    Button {
        id: achievementFrameSummaryAchievement4
        name: "AchievementFrameSummaryAchievement4"
        wowParent: "AchievementFrameSummaryAchievements"
        anchors.left: achievementFrameSummaryAchievement3.left
        anchors.top: achievementFrameSummaryAchievement3.bottom
        anchors.topMargin: -3
        width: 484
        height: 48
    }

    FontString {
        id: achievementFrameSummaryAchievement4DateCompleted
        name: "AchievementFrameSummaryAchievement4DateCompleted"
        text: "10/30/26"
        wowParent: "AchievementFrameSummaryAchievement4"
        anchors.right: achievementFrameSummaryAchievement4.right
        anchors.rightMargin: 63
        anchors.top: achievementFrameSummaryAchievement4.top
        anchors.topMargin: 8
        width: 100
        height: 14
    }

    FontString {
        id: achievementFrameSummaryAchievement4Description
        name: "AchievementFrameSummaryAchievement4Description"
        text: "Earn exalted reputation with 5 home cities."
        wowParent: "AchievementFrameSummaryAchievement4"
        anchors.horizontalCenter: achievementFrameSummaryAchievement4.horizontalCenter
        anchors.top: achievementFrameSummaryAchievement4.top
        anchors.topMargin: 30
        width: 380
        height: 13
    }

    Frame {
        id: achievementFrameSummaryAchievement4Highlight
        name: "AchievementFrameSummaryAchievement4Highlight"
        wowParent: "AchievementFrameSummaryAchievement4"
        anchors.left: achievementFrameSummaryAchievement4.left
        anchors.top: achievementFrameSummaryAchievement4.top
        width: 484
        height: 48
    }

    Frame {
        id: achievementFrameSummaryAchievement4Icon
        name: "AchievementFrameSummaryAchievement4Icon"
        wowParent: "AchievementFrameSummaryAchievement4"
        anchors.left: achievementFrameSummaryAchievement4.left
        anchors.leftMargin: 3
        anchors.top: achievementFrameSummaryAchievement4.top
        anchors.topMargin: 3
        width: 48
        height: 48
    }

    FontString {
        id: achievementFrameSummaryAchievement4Label
        name: "AchievementFrameSummaryAchievement4Label"
        text: "Ambassador of the Alliance"
        wowParent: "AchievementFrameSummaryAchievement4"
        anchors.horizontalCenter: achievementFrameSummaryAchievement4TitleBackground.horizontalCenter
        anchors.top: achievementFrameSummaryAchievement4TitleBackground.top
        width: 260
        height: 20
    }

    Frame {
        id: achievementFrameSummaryAchievement4Shield
        name: "AchievementFrameSummaryAchievement4Shield"
        wowParent: "AchievementFrameSummaryAchievement4"
        anchors.right: achievementFrameSummaryAchievement4.right
        anchors.rightMargin: 10
        anchors.top: achievementFrameSummaryAchievement4.top
        anchors.topMargin: 4
        width: 48
        height: 48
    }

    FontString {
        id: achievementFrameSummaryAchievement4ShieldPoints
        name: "AchievementFrameSummaryAchievement4ShieldPoints"
        text: "10"
        wowParent: "AchievementFrameSummaryAchievement4Shield"
        anchors.horizontalCenter: achievementFrameSummaryAchievement4Shield.horizontalCenter
        anchors.horizontalCenterOffset: -1
        anchors.verticalCenter: achievementFrameSummaryAchievement4Shield.verticalCenter
        anchors.verticalCenterOffset: -3
        width: 40
        height: 26
    }

    Frame {
        id: achievementFrameSummaryAchievements
        name: "AchievementFrameSummaryAchievements"
        wowParent: "AchievementFrameSummary"
        anchors.left: achievementFrameSummary.left
        anchors.leftMargin: 5
        anchors.top: achievementFrameSummary.top
        anchors.topMargin: 20
        width: 520
        height: 210
    }

    Frame {
        id: achievementFrameSummaryAchievementsHeader
        name: "AchievementFrameSummaryAchievementsHeader"
        wowParent: "AchievementFrameSummaryAchievements"
        style: "Section"
        anchors.left: achievementFrameSummaryAchievements.left
        anchors.top: achievementFrameSummaryAchievements.top
        width: 520
        height: 20
    }

    FontString {
        id: achievementFrameSummaryAchievementsHeaderTitle
        name: "AchievementFrameSummaryAchievementsHeaderTitle"
        text: "Recent Achievements"
        wowParent: "AchievementFrameSummaryAchievementsHeader"
        anchors.left: achievementFrameSummaryAchievementsHeader.left
        anchors.leftMargin: 28
        anchors.verticalCenter: achievementFrameSummaryAchievementsHeader.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 158.8
        height: 20
    }

    Frame {
        id: achievementFrameSummaryCategories
        name: "AchievementFrameSummaryCategories"
        wowParent: "AchievementFrameSummary"
        anchors.left: achievementFrameSummaryAchievements.left
        anchors.top: achievementFrameSummaryAchievements.bottom
        anchors.topMargin: 8
        width: 520
        height: 164
    }

    StatusBar {
        id: achievementFrameSummaryCategoriesCategory1
        name: "AchievementFrameSummaryCategoriesCategory1"
        wowParent: "AchievementFrameSummaryCategories"
        style: "Bar"
        anchors.left: achievementFrameSummaryCategoriesStatusBar.left
        anchors.top: achievementFrameSummaryCategoriesStatusBar.bottom
        anchors.topMargin: 24
        width: 224
        height: 16
    }

    Button {
        id: achievementFrameSummaryCategoriesCategory1Button
        name: "AchievementFrameSummaryCategoriesCategory1Button"
        wowParent: "AchievementFrameSummaryCategoriesCategory1"
        anchors.left: achievementFrameSummaryCategoriesCategory1.left
        anchors.top: achievementFrameSummaryCategoriesCategory1.top
        width: 224
        height: 16
    }

    FontString {
        id: achievementFrameSummaryCategoriesCategory1Label
        name: "AchievementFrameSummaryCategoriesCategory1Label"
        text: "General"
        wowParent: "AchievementFrameSummaryCategoriesCategory1"
        anchors.left: achievementFrameSummaryCategoriesCategory1.left
        anchors.leftMargin: 8
        anchors.verticalCenter: achievementFrameSummaryCategoriesCategory1.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 52.1
        height: 10.3
    }

    FontString {
        id: achievementFrameSummaryCategoriesCategory1Text
        name: "AchievementFrameSummaryCategoriesCategory1Text"
        text: "29/54"
        wowParent: "AchievementFrameSummaryCategoriesCategory1"
        anchors.right: achievementFrameSummaryCategoriesCategory1.right
        anchors.rightMargin: 8
        anchors.verticalCenter: achievementFrameSummaryCategoriesCategory1.verticalCenter
        width: 30.8
        height: 14
    }

    Frame {
        id: achievementFrameSummaryCategoriesHeader
        name: "AchievementFrameSummaryCategoriesHeader"
        wowParent: "AchievementFrameSummaryCategories"
        style: "Section"
        anchors.left: achievementFrameSummaryCategories.left
        anchors.top: achievementFrameSummaryCategories.top
        width: 520
        height: 20
    }

    FontString {
        id: achievementFrameSummaryCategoriesHeaderTitle
        name: "AchievementFrameSummaryCategoriesHeaderTitle"
        text: "Progress Overview"
        wowParent: "AchievementFrameSummaryCategoriesHeader"
        anchors.left: achievementFrameSummaryCategoriesHeader.left
        anchors.leftMargin: 28
        anchors.verticalCenter: achievementFrameSummaryCategoriesHeader.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 143.8
        height: 20
    }

    StatusBar {
        id: achievementFrameSummaryCategoriesStatusBar
        name: "AchievementFrameSummaryCategoriesStatusBar"
        wowParent: "AchievementFrameSummaryCategories"
        style: "Bar"
        anchors.horizontalCenter: achievementFrameSummaryCategoriesHeader.horizontalCenter
        anchors.top: achievementFrameSummaryCategoriesHeader.bottom
        anchors.topMargin: 6
        width: 472
        height: 16
    }

    FontString {
        id: achievementFrameSummaryCategoriesStatusBarText
        name: "AchievementFrameSummaryCategoriesStatusBarText"
        text: "330/1058"
        wowParent: "AchievementFrameSummaryCategoriesStatusBar"
        anchors.right: achievementFrameSummaryCategoriesStatusBar.right
        anchors.rightMargin: 8
        anchors.verticalCenter: achievementFrameSummaryCategoriesStatusBar.verticalCenter
        width: 49
        height: 14
    }

    FontString {
        id: achievementFrameSummaryCategoriesStatusBarTitle
        name: "AchievementFrameSummaryCategoriesStatusBarTitle"
        text: "Achievements Earned"
        wowParent: "AchievementFrameSummaryCategoriesStatusBar"
        anchors.left: achievementFrameSummaryCategoriesStatusBar.left
        anchors.leftMargin: 8
        anchors.verticalCenter: achievementFrameSummaryCategoriesStatusBar.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 141.4
        height: 10.3
    }

    Button {
        id: achievementFrameTab1
        name: "AchievementFrameTab1"
        text: "Achievements"
        wowParent: "AchievementFrame"
        style: "Banner"
        anchors.left: achievementFrameDiabolic.left
        anchors.leftMargin: 28
        anchors.top: achievementFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        id: achievementFrameTab2
        name: "AchievementFrameTab2"
        text: "Statistics"
        wowParent: "AchievementFrame"
        style: "Banner"
        anchors.left: achievementFrameDiabolic.left
        anchors.leftMargin: 86
        anchors.top: achievementFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        id: achievementFrameTab3
        name: "AchievementFrameTab3"
        text: "Search"
        wowParent: "AchievementFrame"
        style: "Banner"
        anchors.left: achievementFrameDiabolic.left
        anchors.leftMargin: 144
        anchors.top: achievementFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        id: achievementFrameTab4
        name: "AchievementFrameTab4"
        text: "Suggestions"
        wowParent: "AchievementFrame"
        style: "Banner"
        anchors.left: achievementFrameDiabolic.left
        anchors.leftMargin: 202
        anchors.top: achievementFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        id: achievementFrameTab5
        name: "AchievementFrameTab5"
        text: "Watch"
        wowParent: "AchievementFrame"
        style: "Banner"
        anchors.left: achievementFrameDiabolic.left
        anchors.leftMargin: 260
        anchors.top: achievementFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Frame {
        id: overachiever_LeftFrame
        name: "Overachiever_LeftFrame"
        wowParent: "AchievementFrameCategories"
        anchors.left: achievementFrameCategories.left
        anchors.leftMargin: 9
        anchors.top: achievementFrameCategories.top
        anchors.topMargin: 5
        width: 179
        height: 448
    }

    FontString {
        id: overachiever_LeftFrameText
        name: "Overachiever_LeftFrameText"
        text: "Clear"
        wowParent: "?"
        anchors.left: overachiever_LeftFrame.left
        anchors.leftMargin: 54.6
        anchors.top: overachiever_LeftFrame.top
        anchors.topMargin: 135.4
        width: 41.9
        height: 11.9
    }

    Frame {
        id: overachiever_SearchFrame
        name: "Overachiever_SearchFrame"
        wowParent: "AchievementFrame"
        anchors.left: achievementFrameAchievements.left
        anchors.top: achievementFrameAchievements.top
        width: 530
        height: 461
    }

    EditBox {
        id: overachiever_SearchFrameAnyEdit
        name: "Overachiever_SearchFrameAnyEdit"
        wowParent: "?"
        anchors.left: overachiever_SearchFrameRewardEdit.left
        anchors.top: overachiever_SearchFrameRewardEdit.bottom
        anchors.topMargin: 23
        width: 170
        height: 16
    }

    ScrollFrame {
        id: overachiever_SearchFrameContainer
        name: "Overachiever_SearchFrameContainer"
        wowParent: "Overachiever_SearchFrame"
        anchors.left: overachiever_SearchFrame.left
        anchors.leftMargin: 4
        anchors.top: overachiever_SearchFrame.top
        anchors.topMargin: 3
        width: 526
        height: 453
    }

    Frame {
        id: overachiever_SearchFrameContainerScrollChild
        name: "Overachiever_SearchFrameContainerScrollChild"
        wowParent: "Overachiever_SearchFrameContainer"
        anchors.left: overachiever_SearchFrameContainer.left
        anchors.top: overachiever_SearchFrameContainer.top
        width: 504
        height: 588
    }

    EditBox {
        id: overachiever_SearchFrameCriteriaEdit
        name: "Overachiever_SearchFrameCriteriaEdit"
        wowParent: "?"
        anchors.left: overachiever_SearchFrameDescEdit.left
        anchors.top: overachiever_SearchFrameDescEdit.bottom
        anchors.topMargin: 23
        width: 170
        height: 16
    }

    EditBox {
        id: overachiever_SearchFrameDescEdit
        name: "Overachiever_SearchFrameDescEdit"
        wowParent: "?"
        anchors.left: overachiever_SearchFrameNameEdit.left
        anchors.top: overachiever_SearchFrameNameEdit.bottom
        anchors.topMargin: 23
        width: 170
        height: 16
    }

    CheckButton {
        id: overachiever_SearchFrameFullListCheckbox
        name: "Overachiever_SearchFrameFullListCheckbox"
        wowParent: "?"
        anchors.left: overachiever_SearchFrameAnyEdit.left
        anchors.leftMargin: -8
        anchors.top: overachiever_SearchFrameAnyEdit.bottom
        anchors.topMargin: 12
        width: 26
        height: 26
    }

    FontString {
        id: overachiever_SearchFrameFullListCheckboxText
        name: "Overachiever_SearchFrameFullListCheckboxText"
        text: "Search all achievements"
        wowParent: "Overachiever_SearchFrameFullListCheckbox"
        anchors.left: overachiever_SearchFrameFullListCheckbox.right
        anchors.verticalCenter: overachiever_SearchFrameFullListCheckbox.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 141.4
        height: 11.9
    }

    EditBox {
        id: overachiever_SearchFrameNameEdit
        name: "Overachiever_SearchFrameNameEdit"
        wowParent: "?"
        anchors.left: overachiever_SearchFrameSortDrop.left
        anchors.leftMargin: 22
        anchors.top: overachiever_SearchFrameSortDrop.bottom
        anchors.topMargin: 19
        width: 170
        height: 16
    }

    EditBox {
        id: overachiever_SearchFrameRewardEdit
        name: "Overachiever_SearchFrameRewardEdit"
        wowParent: "?"
        anchors.left: overachiever_SearchFrameCriteriaEdit.left
        anchors.top: overachiever_SearchFrameCriteriaEdit.bottom
        anchors.topMargin: 23
        width: 170
        height: 16
    }

    Frame {
        id: overachiever_SearchFrameSortDrop
        name: "Overachiever_SearchFrameSortDrop"
        text: "Name"
        wowParent: "?"
        style: "DropDown"
        anchors.left: overachiever_LeftFrame.left
        anchors.leftMargin: -15
        anchors.top: overachiever_LeftFrame.top
        anchors.topMargin: 45.9
        width: 165
        height: 32
    }

    Button {
        id: overachiever_SearchFrameSortDropButton
        name: "Overachiever_SearchFrameSortDropButton"
        wowParent: "Overachiever_SearchFrameSortDrop"
        anchors.right: overachiever_SearchFrameSortDropDiabolicField.right
        anchors.rightMargin: 18
        anchors.verticalCenter: overachiever_SearchFrameSortDropDiabolicField.verticalCenter
        width: 18
        height: 18
    }

    Frame {
        id: overachiever_SearchFrameSortDropDiabolicField
        name: "Overachiever_SearchFrameSortDropDiabolicField"
        wowParent: "Overachiever_SearchFrameSortDrop"
        anchors.left: overachiever_SearchFrameSortDrop.left
        anchors.verticalCenter: overachiever_SearchFrameSortDrop.verticalCenter
        anchors.verticalCenterOffset: -4
        width: 165
        height: 22
    }

    FontString {
        id: overachiever_SearchFrameSortDropLabel
        name: "Overachiever_SearchFrameSortDropLabel"
        text: "Sort by:"
        wowParent: "Overachiever_SearchFrameSortDrop"
        anchors.left: overachiever_SearchFrameSortDrop.left
        anchors.leftMargin: 16
        anchors.bottom: overachiever_SearchFrameSortDrop.top
        anchors.bottomMargin: 3
        width: 45.8
        height: 11.9
    }

    FontString {
        id: overachiever_SearchFrameSortDropText
        name: "Overachiever_SearchFrameSortDropText"
        text: "Name"
        wowParent: "Overachiever_SearchFrameSortDrop"
        anchors.left: overachiever_SearchFrameSortDropDiabolicField.left
        anchors.leftMargin: 22
        anchors.verticalCenter: overachiever_SearchFrameSortDropDiabolicField.verticalCenter
        width: 103
        height: 10
    }

    Frame {
        id: overachiever_SuggestionsFrame
        name: "Overachiever_SuggestionsFrame"
        wowParent: "AchievementFrame"
        anchors.left: achievementFrameAchievements.left
        anchors.top: achievementFrameAchievements.top
        width: 530
        height: 461
    }

    ScrollFrame {
        id: overachiever_SuggestionsFrameContainer
        name: "Overachiever_SuggestionsFrameContainer"
        wowParent: "Overachiever_SuggestionsFrame"
        anchors.left: overachiever_SuggestionsFrame.left
        anchors.leftMargin: 4
        anchors.top: overachiever_SuggestionsFrame.top
        anchors.topMargin: 3
        width: 526
        height: 453
    }

    Button {
        id: overachiever_SuggestionsFrameContainerButton1
        name: "Overachiever_SuggestionsFrameContainerButton1"
        wowParent: "Overachiever_SuggestionsFrameContainerScrollChild"
        anchors.left: overachiever_SuggestionsFrameContainerScrollChild.left
        anchors.top: overachiever_SuggestionsFrameContainerScrollChild.top
        anchors.topMargin: 2
        width: 522
        height: 84
    }

    FontString {
        id: overachiever_SuggestionsFrameContainerButton1Description
        name: "Overachiever_SuggestionsFrameContainerButton1Description"
        text: "Kill 50 enemy players in any of your home cities."
        wowParent: "Overachiever_SuggestionsFrameContainerButton1"
        anchors.horizontalCenter: overachiever_SuggestionsFrameContainerButton1.horizontalCenter
        anchors.top: overachiever_SuggestionsFrameContainerButton1.top
        anchors.topMargin: 30
        width: 330
        height: 30
    }

    Frame {
        id: overachiever_SuggestionsFrameContainerButton1Icon
        name: "Overachiever_SuggestionsFrameContainerButton1Icon"
        wowParent: "Overachiever_SuggestionsFrameContainerButton1"
        anchors.left: overachiever_SuggestionsFrameContainerButton1.left
        anchors.leftMargin: 8
        anchors.top: overachiever_SuggestionsFrameContainerButton1.top
        anchors.topMargin: 9
        width: 60
        height: 60
    }

    FontString {
        id: overachiever_SuggestionsFrameContainerButton1Label
        name: "Overachiever_SuggestionsFrameContainerButton1Label"
        text: "City Defender"
        wowParent: "Overachiever_SuggestionsFrameContainerButton1"
        anchors.horizontalCenter: overachiever_SuggestionsFrameContainerButton1TitleBackground.horizontalCenter
        anchors.top: overachiever_SuggestionsFrameContainerButton1TitleBackground.top
        width: 320
        height: 20
    }

    Frame {
        id: overachiever_SuggestionsFrameContainerButton1Objectives
        name: "Overachiever_SuggestionsFrameContainerButton1Objectives"
        wowParent: "Overachiever_SuggestionsFrameContainerButton1"
        anchors.horizontalCenter: overachiever_SuggestionsFrameContainerButton1Description.horizontalCenter
        anchors.horizontalCenterOffset: -2
        anchors.top: overachiever_SuggestionsFrameContainerButton1Description.bottom
        anchors.topMargin: 7.9
        width: 366
        height: -8.4
    }

    Frame {
        id: overachiever_SuggestionsFrameContainerButton1Shield
        name: "Overachiever_SuggestionsFrameContainerButton1Shield"
        wowParent: "Overachiever_SuggestionsFrameContainerButton1"
        anchors.right: overachiever_SuggestionsFrameContainerButton1.right
        anchors.rightMargin: 6
        anchors.top: overachiever_SuggestionsFrameContainerButton1.top
        width: 64
        height: 64
    }

    FontString {
        id: overachiever_SuggestionsFrameContainerButton1ShieldPoints
        name: "Overachiever_SuggestionsFrameContainerButton1ShieldPoints"
        text: "10"
        wowParent: "Overachiever_SuggestionsFrameContainerButton1Shield"
        anchors.right: overachiever_SuggestionsFrameContainerButton1Shield.right
        anchors.rightMargin: 18
        anchors.top: overachiever_SuggestionsFrameContainerButton1Shield.top
        anchors.topMargin: 26
        width: 32
        height: 16
    }

    Frame {
        id: overachiever_SuggestionsFrameContainerScrollChild
        name: "Overachiever_SuggestionsFrameContainerScrollChild"
        wowParent: "Overachiever_SuggestionsFrameContainer"
        anchors.left: overachiever_SuggestionsFrameContainer.left
        anchors.top: overachiever_SuggestionsFrameContainer.top
        width: 504
        height: 588
    }

    Frame {
        id: overachiever_SuggestionsFrameSortDrop
        name: "Overachiever_SuggestionsFrameSortDrop"
        text: "Name"
        wowParent: "?"
        style: "DropDown"
        anchors.left: overachiever_LeftFrame.left
        anchors.leftMargin: -15
        anchors.top: overachiever_LeftFrame.top
        anchors.topMargin: 45.9
        width: 165
        height: 32
    }

    Button {
        id: overachiever_SuggestionsFrameSortDropButton
        name: "Overachiever_SuggestionsFrameSortDropButton"
        wowParent: "Overachiever_SuggestionsFrameSortDrop"
        anchors.right: overachiever_SuggestionsFrameSortDropDiabolicField.right
        anchors.rightMargin: 18
        anchors.verticalCenter: overachiever_SuggestionsFrameSortDropDiabolicField.verticalCenter
        width: 18
        height: 18
    }

    Frame {
        id: overachiever_SuggestionsFrameSortDropDiabolicField
        name: "Overachiever_SuggestionsFrameSortDropDiabolicField"
        wowParent: "Overachiever_SuggestionsFrameSortDrop"
        anchors.left: overachiever_SuggestionsFrameSortDrop.left
        anchors.verticalCenter: overachiever_SuggestionsFrameSortDrop.verticalCenter
        anchors.verticalCenterOffset: -4
        width: 165
        height: 22
    }

    FontString {
        id: overachiever_SuggestionsFrameSortDropLabel
        name: "Overachiever_SuggestionsFrameSortDropLabel"
        text: "Sort by:"
        wowParent: "Overachiever_SuggestionsFrameSortDrop"
        anchors.left: overachiever_SuggestionsFrameSortDrop.left
        anchors.leftMargin: 16
        anchors.bottom: overachiever_SuggestionsFrameSortDrop.top
        anchors.bottomMargin: 3
        width: 45.8
        height: 11.9
    }

    FontString {
        id: overachiever_SuggestionsFrameSortDropText
        name: "Overachiever_SuggestionsFrameSortDropText"
        text: "Name"
        wowParent: "Overachiever_SuggestionsFrameSortDrop"
        anchors.left: overachiever_SuggestionsFrameSortDropDiabolicField.left
        anchors.leftMargin: 22
        anchors.verticalCenter: overachiever_SuggestionsFrameSortDropDiabolicField.verticalCenter
        width: 103
        height: 10
    }

    Frame {
        id: overachiever_SuggestionsFrameSubzoneDrop
        name: "Overachiever_SuggestionsFrameSubzoneDrop"
        text: "(unspecified)"
        wowParent: "?"
        style: "DropDown"
        anchors.horizontalCenter: overachiever_SuggestionsFrameZoneOverrideEdit.horizontalCenter
        anchors.horizontalCenterOffset: -24
        anchors.top: overachiever_SuggestionsFrameZoneOverrideEdit.bottom
        anchors.topMargin: 21
        width: 166
        height: 32
    }

    Button {
        id: overachiever_SuggestionsFrameSubzoneDropButton
        name: "Overachiever_SuggestionsFrameSubzoneDropButton"
        wowParent: "Overachiever_SuggestionsFrameSubzoneDrop"
        anchors.right: overachiever_SuggestionsFrameSubzoneDropDiabolicField.right
        anchors.rightMargin: 18
        anchors.verticalCenter: overachiever_SuggestionsFrameSubzoneDropDiabolicField.verticalCenter
        width: 18
        height: 18
    }

    Frame {
        id: overachiever_SuggestionsFrameSubzoneDropDiabolicField
        name: "Overachiever_SuggestionsFrameSubzoneDropDiabolicField"
        wowParent: "Overachiever_SuggestionsFrameSubzoneDrop"
        anchors.left: overachiever_SuggestionsFrameSubzoneDrop.left
        anchors.verticalCenter: overachiever_SuggestionsFrameSubzoneDrop.verticalCenter
        anchors.verticalCenterOffset: -4
        width: 166
        height: 22
    }

    FontString {
        id: overachiever_SuggestionsFrameSubzoneDropLabel
        name: "Overachiever_SuggestionsFrameSubzoneDropLabel"
        text: "Subzone:"
        wowParent: "Overachiever_SuggestionsFrameSubzoneDrop"
        anchors.left: overachiever_SuggestionsFrameSubzoneDrop.left
        anchors.leftMargin: 16
        anchors.bottom: overachiever_SuggestionsFrameSubzoneDrop.top
        anchors.bottomMargin: 3
        width: 53.7
        height: 11.9
    }

    FontString {
        id: overachiever_SuggestionsFrameSubzoneDropText
        name: "Overachiever_SuggestionsFrameSubzoneDropText"
        text: "(unspecified)"
        wowParent: "Overachiever_SuggestionsFrameSubzoneDrop"
        anchors.left: overachiever_SuggestionsFrameSubzoneDropDiabolicField.left
        anchors.leftMargin: 22
        anchors.verticalCenter: overachiever_SuggestionsFrameSubzoneDropDiabolicField.verticalCenter
        width: 104
        height: 10
    }

    EditBox {
        id: overachiever_SuggestionsFrameZoneOverrideEdit
        name: "Overachiever_SuggestionsFrameZoneOverrideEdit"
        wowParent: "?"
        anchors.left: overachiever_SuggestionsFrameSortDrop.left
        anchors.leftMargin: 22
        anchors.top: overachiever_SuggestionsFrameSortDrop.bottom
        anchors.topMargin: 19
        width: 170
        height: 16
    }

    Frame {
        id: overachiever_WatchFrame
        name: "Overachiever_WatchFrame"
        wowParent: "AchievementFrame"
        anchors.left: achievementFrameAchievements.left
        anchors.top: achievementFrameAchievements.top
        width: 530
        height: 461
    }

    ScrollFrame {
        id: overachiever_WatchFrameContainer
        name: "Overachiever_WatchFrameContainer"
        wowParent: "Overachiever_WatchFrame"
        anchors.left: overachiever_WatchFrame.left
        anchors.leftMargin: 4
        anchors.top: overachiever_WatchFrame.top
        anchors.topMargin: 3
        width: 526
        height: 453
    }

    Frame {
        id: overachiever_WatchFrameContainerScrollChild
        name: "Overachiever_WatchFrameContainerScrollChild"
        wowParent: "Overachiever_WatchFrameContainer"
        anchors.left: overachiever_WatchFrameContainer.left
        anchors.top: overachiever_WatchFrameContainer.top
        width: 504
        height: 588
    }

    CheckButton {
        id: overachiever_WatchFrameCopyDestCheckbox
        name: "Overachiever_WatchFrameCopyDestCheckbox"
        wowParent: "?"
        anchors.left: overachiever_WatchFrameDefListDrop.left
        anchors.leftMargin: 14
        anchors.top: overachiever_WatchFrameDefListDrop.bottom
        anchors.topMargin: 12
        width: 26
        height: 26
    }

    FontString {
        id: overachiever_WatchFrameCopyDestCheckboxText
        name: "Overachiever_WatchFrameCopyDestCheckboxText"
        text: "Copy To:"
        wowParent: "Overachiever_WatchFrameCopyDestCheckbox"
        anchors.left: overachiever_WatchFrameCopyDestCheckbox.right
        anchors.verticalCenter: overachiever_WatchFrameCopyDestCheckbox.verticalCenter
        anchors.verticalCenterOffset: -1
        width: 52.9
        height: 11.9
    }

    Frame {
        id: overachiever_WatchFrameDefListDrop
        name: "Overachiever_WatchFrameDefListDrop"
        text: "Global"
        wowParent: "?"
        style: "DropDown"
        anchors.left: overachiever_LeftFrame.left
        anchors.leftMargin: -15
        anchors.top: overachiever_LeftFrame.top
        anchors.topMargin: 173.9
        width: 166
        height: 32
    }

    Button {
        id: overachiever_WatchFrameDefListDropButton
        name: "Overachiever_WatchFrameDefListDropButton"
        wowParent: "Overachiever_WatchFrameDefListDrop"
        anchors.right: overachiever_WatchFrameDefListDropDiabolicField.right
        anchors.rightMargin: 18
        anchors.verticalCenter: overachiever_WatchFrameDefListDropDiabolicField.verticalCenter
        width: 18
        height: 18
    }

    Frame {
        id: overachiever_WatchFrameDefListDropDiabolicField
        name: "Overachiever_WatchFrameDefListDropDiabolicField"
        wowParent: "Overachiever_WatchFrameDefListDrop"
        anchors.left: overachiever_WatchFrameDefListDrop.left
        anchors.verticalCenter: overachiever_WatchFrameDefListDrop.verticalCenter
        anchors.verticalCenterOffset: -4
        width: 166
        height: 22
    }

    FontString {
        id: overachiever_WatchFrameDefListDropLabel
        name: "Overachiever_WatchFrameDefListDropLabel"
        text: "Default List:"
        wowParent: "Overachiever_WatchFrameDefListDrop"
        anchors.left: overachiever_WatchFrameDefListDrop.left
        anchors.leftMargin: 16
        anchors.bottom: overachiever_WatchFrameDefListDrop.top
        anchors.bottomMargin: 3
        width: 71.9
        height: 11.9
    }

    FontString {
        id: overachiever_WatchFrameDefListDropText
        name: "Overachiever_WatchFrameDefListDropText"
        text: "Global"
        wowParent: "Overachiever_WatchFrameDefListDrop"
        anchors.left: overachiever_WatchFrameDefListDropDiabolicField.left
        anchors.leftMargin: 22
        anchors.verticalCenter: overachiever_WatchFrameDefListDropDiabolicField.verticalCenter
        width: 104
        height: 10
    }

    Frame {
        id: overachiever_WatchFrameDestinationListDrop
        name: "Overachiever_WatchFrameDestinationListDrop"
        text: "Global"
        wowParent: "?"
        style: "DropDown"
        anchors.left: overachiever_WatchFrameCopyDestCheckbox.left
        anchors.leftMargin: -14
        anchors.top: overachiever_WatchFrameCopyDestCheckbox.bottom
        anchors.topMargin: -2
        width: 166
        height: 32
    }

    Button {
        id: overachiever_WatchFrameDestinationListDropButton
        name: "Overachiever_WatchFrameDestinationListDropButton"
        wowParent: "Overachiever_WatchFrameDestinationListDrop"
        anchors.right: overachiever_WatchFrameDestinationListDropDiabolicField.right
        anchors.rightMargin: 18
        anchors.verticalCenter: overachiever_WatchFrameDestinationListDropDiabolicField.verticalCenter
        width: 18
        height: 18
    }

    Frame {
        id: overachiever_WatchFrameDestinationListDropDiabolicField
        name: "Overachiever_WatchFrameDestinationListDropDiabolicField"
        wowParent: "Overachiever_WatchFrameDestinationListDrop"
        anchors.left: overachiever_WatchFrameDestinationListDrop.left
        anchors.verticalCenter: overachiever_WatchFrameDestinationListDrop.verticalCenter
        anchors.verticalCenterOffset: -4
        width: 166
        height: 22
    }

    FontString {
        id: overachiever_WatchFrameDestinationListDropText
        name: "Overachiever_WatchFrameDestinationListDropText"
        text: "Global"
        wowParent: "Overachiever_WatchFrameDestinationListDrop"
        anchors.left: overachiever_WatchFrameDestinationListDropDiabolicField.left
        anchors.leftMargin: 22
        anchors.verticalCenter: overachiever_WatchFrameDestinationListDropDiabolicField.verticalCenter
        width: 104
        height: 10
    }

    Frame {
        id: overachiever_WatchFrameListDrop
        name: "Overachiever_WatchFrameListDrop"
        text: "Global"
        wowParent: "?"
        style: "DropDown"
        anchors.left: overachiever_WatchFrameSortDrop.left
        anchors.top: overachiever_WatchFrameSortDrop.bottom
        anchors.topMargin: 18
        width: 166
        height: 32
    }

    Button {
        id: overachiever_WatchFrameListDropButton
        name: "Overachiever_WatchFrameListDropButton"
        wowParent: "Overachiever_WatchFrameListDrop"
        anchors.right: overachiever_WatchFrameListDropDiabolicField.right
        anchors.rightMargin: 18
        anchors.verticalCenter: overachiever_WatchFrameListDropDiabolicField.verticalCenter
        width: 18
        height: 18
    }

    Frame {
        id: overachiever_WatchFrameListDropDiabolicField
        name: "Overachiever_WatchFrameListDropDiabolicField"
        wowParent: "Overachiever_WatchFrameListDrop"
        anchors.left: overachiever_WatchFrameListDrop.left
        anchors.verticalCenter: overachiever_WatchFrameListDrop.verticalCenter
        anchors.verticalCenterOffset: -4
        width: 166
        height: 22
    }

    FontString {
        id: overachiever_WatchFrameListDropLabel
        name: "Overachiever_WatchFrameListDropLabel"
        text: "Displayed List:"
        wowParent: "Overachiever_WatchFrameListDrop"
        anchors.left: overachiever_WatchFrameListDrop.left
        anchors.leftMargin: 16
        anchors.bottom: overachiever_WatchFrameListDrop.top
        anchors.bottomMargin: 3
        width: 87.7
        height: 11.9
    }

    FontString {
        id: overachiever_WatchFrameListDropText
        name: "Overachiever_WatchFrameListDropText"
        text: "Global"
        wowParent: "Overachiever_WatchFrameListDrop"
        anchors.left: overachiever_WatchFrameListDropDiabolicField.left
        anchors.leftMargin: 22
        anchors.verticalCenter: overachiever_WatchFrameListDropDiabolicField.verticalCenter
        width: 104
        height: 10
    }

    Frame {
        id: overachiever_WatchFrameSortDrop
        name: "Overachiever_WatchFrameSortDrop"
        text: "Name"
        wowParent: "?"
        style: "DropDown"
        anchors.left: overachiever_LeftFrame.left
        anchors.leftMargin: -15
        anchors.top: overachiever_LeftFrame.top
        anchors.topMargin: 45.9
        width: 165
        height: 32
    }

    Button {
        id: overachiever_WatchFrameSortDropButton
        name: "Overachiever_WatchFrameSortDropButton"
        wowParent: "Overachiever_WatchFrameSortDrop"
        anchors.right: overachiever_WatchFrameSortDropDiabolicField.right
        anchors.rightMargin: 18
        anchors.verticalCenter: overachiever_WatchFrameSortDropDiabolicField.verticalCenter
        width: 18
        height: 18
    }

    Frame {
        id: overachiever_WatchFrameSortDropDiabolicField
        name: "Overachiever_WatchFrameSortDropDiabolicField"
        wowParent: "Overachiever_WatchFrameSortDrop"
        anchors.left: overachiever_WatchFrameSortDrop.left
        anchors.verticalCenter: overachiever_WatchFrameSortDrop.verticalCenter
        anchors.verticalCenterOffset: -4
        width: 165
        height: 22
    }

    FontString {
        id: overachiever_WatchFrameSortDropLabel
        name: "Overachiever_WatchFrameSortDropLabel"
        text: "Sort by:"
        wowParent: "Overachiever_WatchFrameSortDrop"
        anchors.left: overachiever_WatchFrameSortDrop.left
        anchors.leftMargin: 16
        anchors.bottom: overachiever_WatchFrameSortDrop.top
        anchors.bottomMargin: 3
        width: 45.8
        height: 11.9
    }

    FontString {
        id: overachiever_WatchFrameSortDropText
        name: "Overachiever_WatchFrameSortDropText"
        text: "Name"
        wowParent: "Overachiever_WatchFrameSortDrop"
        anchors.left: overachiever_WatchFrameSortDropDiabolicField.left
        anchors.leftMargin: 22
        anchors.verticalCenter: overachiever_WatchFrameSortDropDiabolicField.verticalCenter
        width: 103
        height: 10
    }

    Ghost { id: achievementFrameAchievementsContainerButton1RewardBackground; name: "AchievementFrameAchievementsContainerButton1RewardBackground"; x: 470; y: 86; width: 0; height: 0 }
    Ghost { id: achievementFrameAchievementsContainerButton1TitleBackground; name: "AchievementFrameAchievementsContainerButton1TitleBackground"; x: 470; y: -57; width: 0; height: 0 }
    Ghost { id: achievementFrameAchievementsContainerButton2RewardBackground; name: "AchievementFrameAchievementsContainerButton2RewardBackground"; x: 483; y: 170; width: 0; height: 0 }
    Ghost { id: achievementFrameAchievementsContainerButton2TitleBackground; name: "AchievementFrameAchievementsContainerButton2TitleBackground"; x: 470; y: 32.2; width: 0; height: 0 }
    Ghost { id: achievementFrameAchievementsContainerButton3RewardBackground; name: "AchievementFrameAchievementsContainerButton3RewardBackground"; x: 470; y: 254; width: 0; height: 0 }
    Ghost { id: achievementFrameAchievementsContainerButton3TitleBackground; name: "AchievementFrameAchievementsContainerButton3TitleBackground"; x: 470; y: 116.2; width: 0; height: 0 }
    Ghost { id: achievementFrameAchievementsContainerButton4RewardBackground; name: "AchievementFrameAchievementsContainerButton4RewardBackground"; x: 483; y: 338; width: 0; height: 0 }
    Ghost { id: achievementFrameAchievementsContainerButton4TitleBackground; name: "AchievementFrameAchievementsContainerButton4TitleBackground"; x: 470; y: 200.2; width: 0; height: 0 }
    Ghost { id: achievementFrameAchievementsContainerButton5RewardBackground; name: "AchievementFrameAchievementsContainerButton5RewardBackground"; x: 470; y: 422; width: 0; height: 0 }
    Ghost { id: achievementFrameAchievementsContainerButton5TitleBackground; name: "AchievementFrameAchievementsContainerButton5TitleBackground"; x: 470; y: 284.2; width: 0; height: 0 }
    Ghost { id: achievementFrameAchievementsContainerButton6RewardBackground; name: "AchievementFrameAchievementsContainerButton6RewardBackground"; x: 470; y: 506; width: 0; height: 0 }
    Ghost { id: achievementFrameAchievementsContainerButton6TitleBackground; name: "AchievementFrameAchievementsContainerButton6TitleBackground"; x: 470; y: 368.2; width: 0; height: 0 }
    Ghost { id: achievementFrameAchievementsContainerButton7RewardBackground; name: "AchievementFrameAchievementsContainerButton7RewardBackground"; x: 470; y: 590; width: 0; height: 0 }
    Ghost { id: achievementFrameAchievementsContainerButton7TitleBackground; name: "AchievementFrameAchievementsContainerButton7TitleBackground"; x: 470; y: 452.2; width: 0; height: 0 }
    Ghost { id: achievementFrameCriteria1Check; name: "AchievementFrameCriteria1Check"; x: 323; y: -3.2; width: 0; height: 0 }
    Ghost { id: achievementFrameCriteria2Check; name: "AchievementFrameCriteria2Check"; x: 488; y: -3.2; width: 0; height: 0 }
    Ghost { id: achievementFrameStatsContainerButton17; name: "AchievementFrameStatsContainerButton17"; x: 221; y: 406; width: 496; height: 24 }
    Ghost { id: achievementFrameStatsContainerButton19; name: "AchievementFrameStatsContainerButton19"; x: 221; y: 454; width: 496; height: 24 }
    Ghost { id: achievementFrameStatsContainerButton4; name: "AchievementFrameStatsContainerButton4"; x: 221; y: 94; width: 496; height: 24 }
    Ghost { id: achievementFrameStatsContainerButton6; name: "AchievementFrameStatsContainerButton6"; x: 221; y: 142; width: 496; height: 24 }
    Ghost { id: achievementFrameStatsContainerButton9; name: "AchievementFrameStatsContainerButton9"; x: 221; y: 214; width: 496; height: 24 }
    Ghost { id: achievementFrameSummaryAchievement1TitleBackground; name: "AchievementFrameSummaryAchievement1TitleBackground"; x: 483; y: 62; width: 0; height: 0 }
    Ghost { id: achievementFrameSummaryAchievement2TitleBackground; name: "AchievementFrameSummaryAchievement2TitleBackground"; x: 483; y: 107; width: 0; height: 0 }
    Ghost { id: achievementFrameSummaryAchievement3TitleBackground; name: "AchievementFrameSummaryAchievement3TitleBackground"; x: 483; y: 152; width: 0; height: 0 }
    Ghost { id: achievementFrameSummaryAchievement4TitleBackground; name: "AchievementFrameSummaryAchievement4TitleBackground"; x: 483; y: 197; width: 0; height: 0 }
    Ghost { id: overachiever_SuggestionsFrameContainerButton1TitleBackground; name: "Overachiever_SuggestionsFrameContainerButton1TitleBackground"; x: 483; y: 29; width: 0; height: 0 }
}
