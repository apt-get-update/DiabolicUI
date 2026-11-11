// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on, one next to it beside it, on its id. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "AchievementFrame"
    width: 768
    height: 500

    Frame {
        name: "AchievementFrameAchievements"
        anchors.left: achievementFrameCategories.right
        anchors.top: achievementFrameCategories.top
        width: 504
        height: 461

        ScrollFrame {
            name: "AchievementFrameAchievementsContainer"
            anchors.left: parent.left
            anchors.leftMargin: 4
            anchors.top: parent.top
            anchors.topMargin: 3
            width: 500
            height: 453

            Slider {
                name: "AchievementFrameAchievementsContainerScrollBar"
                anchors.left: parent.right
                anchors.leftMargin: 1
                anchors.top: parent.top
                anchors.topMargin: 16
                width: 20
                height: 425

                Frame {
                    name: "AchievementFrameAchievementsContainerScrollBarDiabolicTrack"
                    anchors.horizontalCenter: achievementFrameAchievementsContainerScrollBarScrollUpButton.horizontalCenter
                    anchors.top: achievementFrameAchievementsContainerScrollBarScrollUpButton.top
                    anchors.topMargin: -1
                    width: 18
                    height: 455
                }

                Button {
                    name: "AchievementFrameAchievementsContainerScrollBarScrollDownButton"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    anchors.topMargin: -2
                    width: 16
                    height: 16
                }

                Button {
                    id: achievementFrameAchievementsContainerScrollBarScrollUpButton
                    name: "AchievementFrameAchievementsContainerScrollBarScrollUpButton"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    anchors.bottomMargin: -2
                    width: 16
                    height: 16
                }
            }

            Frame {
                name: "AchievementFrameAchievementsContainerScrollChild"
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: -86
                width: 500
                height: 593.3

                Button {
                    id: achievementFrameAchievementsContainerButton1
                    name: "AchievementFrameAchievementsContainerButton1"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: 2
                    width: 496
                    height: 89.3

                    FontString {
                        name: "AchievementFrameAchievementsContainerButton1DateCompleted"
                        text: "10/22/26"
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
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: 30
                        width: 330
                        height: 30
                    }

                    FontString {
                        id: achievementFrameAchievementsContainerButton1HiddenDescription
                        name: "AchievementFrameAchievementsContainerButton1HiddenDescription"
                        text: "Obtain a Sinister Squashling pet and Hallowed Helm."
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: 30
                        width: 330
                        height: 10.3
                    }

                    Frame {
                        name: "AchievementFrameAchievementsContainerButton1Highlight"
                        anchors.left: parent.left
                        anchors.top: parent.top
                        width: 496
                        height: 89.3
                    }

                    Frame {
                        name: "AchievementFrameAchievementsContainerButton1Icon"
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        anchors.top: parent.top
                        anchors.topMargin: 9
                        width: 60
                        height: 60
                    }

                    Frame {
                        name: "AchievementFrameAchievementsContainerButton1Objectives"
                        anchors.horizontalCenter: achievementFrameAchievementsContainerButton1Description.horizontalCenter
                        anchors.horizontalCenterOffset: -2
                        anchors.top: achievementFrameAchievementsContainerButton1Description.bottom
                        anchors.topMargin: -76.1
                        width: 340
                        height: -0.7
                    }

                    Frame {
                        id: achievementFrameAchievementsContainerButton1Shield
                        name: "AchievementFrameAchievementsContainerButton1Shield"
                        anchors.right: parent.right
                        anchors.rightMargin: 6
                        anchors.top: parent.top
                        width: 64
                        height: 64

                        FontString {
                            name: "AchievementFrameAchievementsContainerButton1ShieldPoints"
                            text: "10"
                            anchors.right: parent.right
                            anchors.rightMargin: 18
                            anchors.top: parent.top
                            anchors.topMargin: 26
                            width: 32
                            height: 16
                        }
                    }

                    Frame {
                        name: "AchievementFrameAchievementsObjectives"
                        anchors.horizontalCenter: achievementFrameAchievementsContainerButton1HiddenDescription.horizontalCenter
                        anchors.horizontalCenterOffset: -8.5
                        anchors.top: achievementFrameAchievementsContainerButton1HiddenDescription.bottom
                        anchors.topMargin: 8
                        width: 353
                        height: 15

                        Frame {
                            name: "AchievementFrameCriteria1"
                            anchors.left: parent.left
                            anchors.top: parent.top
                            width: 120.3
                            height: 15

                            Ghost {
                                name: "AchievementFrameCriteria1Check"
                                x: 38
                                y: 10.6
                                width: 0
                                height: 0

                                FontString {
                                    name: "AchievementFrameCriteria1Name"
                                    text: "Sinister Squashling"
                                    wowParent: "AchievementFrameCriteria1"
                                    anchors.left: parent.right
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.verticalCenterOffset: -2
                                    width: 100.3
                                    height: 10.3
                                }
                            }
                        }

                        Frame {
                            name: "AchievementFrameCriteria2"
                            anchors.left: parent.left
                            anchors.leftMargin: 165
                            anchors.top: parent.top
                            width: 102.2
                            height: 15

                            Ghost {
                                name: "AchievementFrameCriteria2Check"
                                x: 38
                                y: 10.6
                                width: 0
                                height: 0

                                FontString {
                                    name: "AchievementFrameCriteria2Name"
                                    text: "Hallowed Helm"
                                    wowParent: "AchievementFrameCriteria2"
                                    anchors.left: parent.right
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.verticalCenterOffset: -2
                                    width: 82.2
                                    height: 10.3
                                }
                            }
                        }
                    }

                    Ghost {
                        name: "AchievementFrameAchievementsContainerButton1RewardBackground"
                        x: 248
                        y: 148.1
                        width: 0
                        height: 0

                        FontString {
                            name: "AchievementFrameAchievementsContainerButton1Reward"
                            text: "Title Reward: Brewmaster"
                            wowParent: "AchievementFrameAchievementsContainerButton1"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.top
                            anchors.topMargin: -1
                            width: 400
                            height: 20
                        }
                    }

                    Ghost {
                        name: "AchievementFrameAchievementsContainerButton1TitleBackground"
                        x: 248
                        y: 5.1
                        width: 0
                        height: 0

                        FontString {
                            name: "AchievementFrameAchievementsContainerButton1Label"
                            text: "Sinister Calling"
                            wowParent: "AchievementFrameAchievementsContainerButton1"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.top
                            width: 320
                            height: 20
                        }
                    }
                }

                Button {
                    id: achievementFrameAchievementsContainerButton2
                    name: "AchievementFrameAchievementsContainerButton2"
                    anchors.left: achievementFrameAchievementsContainerButton1.left
                    anchors.top: achievementFrameAchievementsContainerButton1.bottom
                    width: 496
                    height: 84

                    FontString {
                        name: "AchievementFrameAchievementsContainerButton2DateCompleted"
                        text: "10/21/26"
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
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: 30
                        width: 330
                        height: 30
                    }

                    FontString {
                        name: "AchievementFrameAchievementsContainerButton2HiddenDescription"
                        text: "Obtain a Sinister Squashling pet and Hallowed Helm."
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: 30
                        width: 330
                        height: 10.3
                    }

                    Frame {
                        name: "AchievementFrameAchievementsContainerButton2Highlight"
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.topMargin: 78.7
                        width: 496
                        height: 89.3
                    }

                    Frame {
                        name: "AchievementFrameAchievementsContainerButton2Icon"
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        anchors.top: parent.top
                        anchors.topMargin: 9
                        width: 60
                        height: 60
                    }

                    Frame {
                        name: "AchievementFrameAchievementsContainerButton2Objectives"
                        anchors.horizontalCenter: achievementFrameAchievementsContainerButton2Description.horizontalCenter
                        anchors.horizontalCenterOffset: -2
                        anchors.top: achievementFrameAchievementsContainerButton2Description.bottom
                        anchors.topMargin: 8
                        width: 340
                        height: -6
                    }

                    Frame {
                        id: achievementFrameAchievementsContainerButton2Shield
                        name: "AchievementFrameAchievementsContainerButton2Shield"
                        anchors.right: parent.right
                        anchors.rightMargin: 6
                        anchors.top: parent.top
                        width: 64
                        height: 64

                        FontString {
                            name: "AchievementFrameAchievementsContainerButton2ShieldPoints"
                            text: "10"
                            anchors.right: parent.right
                            anchors.rightMargin: 18
                            anchors.top: parent.top
                            anchors.topMargin: 26
                            width: 32
                            height: 16
                        }
                    }

                    Ghost {
                        name: "AchievementFrameAchievementsContainerButton2RewardBackground"
                        x: 261
                        y: 142.8
                        width: 0
                        height: 0

                        FontString {
                            name: "AchievementFrameAchievementsContainerButton2Reward"
                            text: "Reward: Tabard of the Explorer"
                            wowParent: "AchievementFrameAchievementsContainerButton2"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.top
                            anchors.topMargin: -1
                            width: 400
                            height: 20
                        }
                    }

                    Ghost {
                        name: "AchievementFrameAchievementsContainerButton2TitleBackground"
                        x: 248
                        y: 5
                        width: 0
                        height: 0

                        FontString {
                            name: "AchievementFrameAchievementsContainerButton2Label"
                            text: "Out With It"
                            wowParent: "AchievementFrameAchievementsContainerButton2"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.top
                            width: 320
                            height: 20
                        }
                    }
                }

                Button {
                    id: achievementFrameAchievementsContainerButton3
                    name: "AchievementFrameAchievementsContainerButton3"
                    anchors.left: achievementFrameAchievementsContainerButton2.left
                    anchors.top: achievementFrameAchievementsContainerButton2.bottom
                    width: 496
                    height: 84

                    FontString {
                        name: "AchievementFrameAchievementsContainerButton3DateCompleted"
                        text: "10/21/26"
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
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: 30
                        width: 330
                        height: 30
                    }

                    Frame {
                        name: "AchievementFrameAchievementsContainerButton3Highlight"
                        anchors.left: parent.left
                        anchors.top: parent.top
                        width: 496
                        height: 84
                    }

                    Frame {
                        name: "AchievementFrameAchievementsContainerButton3Icon"
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        anchors.top: parent.top
                        anchors.topMargin: 9
                        width: 60
                        height: 60
                    }

                    Frame {
                        name: "AchievementFrameAchievementsContainerButton3Objectives"
                        anchors.horizontalCenter: achievementFrameAchievementsContainerButton3Description.horizontalCenter
                        anchors.horizontalCenterOffset: -2
                        anchors.top: achievementFrameAchievementsContainerButton3Description.bottom
                        anchors.topMargin: 8
                        width: 340
                        height: -6
                    }

                    Frame {
                        id: achievementFrameAchievementsContainerButton3Shield
                        name: "AchievementFrameAchievementsContainerButton3Shield"
                        anchors.right: parent.right
                        anchors.rightMargin: 6
                        anchors.top: parent.top
                        width: 64
                        height: 64

                        FontString {
                            name: "AchievementFrameAchievementsContainerButton3ShieldPoints"
                            text: "10"
                            anchors.right: parent.right
                            anchors.rightMargin: 18
                            anchors.top: parent.top
                            anchors.topMargin: 26
                            width: 32
                            height: 16
                        }
                    }

                    Ghost {
                        name: "AchievementFrameAchievementsContainerButton3RewardBackground"
                        x: 248
                        y: 142.8
                        width: 0
                        height: 0

                        FontString {
                            name: "AchievementFrameAchievementsContainerButton3Reward"
                            text: "Title Reward: Flame Warden"
                            wowParent: "AchievementFrameAchievementsContainerButton3"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.top
                            anchors.topMargin: -1
                            width: 400
                            height: 20
                        }
                    }

                    Ghost {
                        name: "AchievementFrameAchievementsContainerButton3TitleBackground"
                        x: 248
                        y: 5
                        width: 0
                        height: 0

                        FontString {
                            name: "AchievementFrameAchievementsContainerButton3Label"
                            text: "Trick or Treat!"
                            wowParent: "AchievementFrameAchievementsContainerButton3"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.top
                            width: 320
                            height: 20
                        }
                    }
                }

                Button {
                    id: achievementFrameAchievementsContainerButton4
                    name: "AchievementFrameAchievementsContainerButton4"
                    anchors.left: achievementFrameAchievementsContainerButton3.left
                    anchors.top: achievementFrameAchievementsContainerButton3.bottom
                    width: 496
                    height: 84

                    FontString {
                        name: "AchievementFrameAchievementsContainerButton4DateCompleted"
                        text: "10/18/26"
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
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: 30
                        width: 330
                        height: 30
                    }

                    Frame {
                        name: "AchievementFrameAchievementsContainerButton4Highlight"
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.topMargin: 80.8
                        width: 496
                        height: 84
                    }

                    Frame {
                        name: "AchievementFrameAchievementsContainerButton4Icon"
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        anchors.top: parent.top
                        anchors.topMargin: 9
                        width: 60
                        height: 60
                    }

                    Frame {
                        name: "AchievementFrameAchievementsContainerButton4Objectives"
                        anchors.horizontalCenter: achievementFrameAchievementsContainerButton4Description.horizontalCenter
                        anchors.horizontalCenterOffset: -2
                        anchors.top: achievementFrameAchievementsContainerButton4Description.bottom
                        anchors.topMargin: 8
                        width: 340
                        height: -6
                    }

                    Frame {
                        id: achievementFrameAchievementsContainerButton4Shield
                        name: "AchievementFrameAchievementsContainerButton4Shield"
                        anchors.right: parent.right
                        anchors.rightMargin: 6
                        anchors.top: parent.top
                        width: 64
                        height: 64

                        FontString {
                            name: "AchievementFrameAchievementsContainerButton4ShieldPoints"
                            text: "10"
                            anchors.right: parent.right
                            anchors.rightMargin: 18
                            anchors.top: parent.top
                            anchors.topMargin: 26
                            width: 32
                            height: 16
                        }
                    }

                    Ghost {
                        name: "AchievementFrameAchievementsContainerButton4RewardBackground"
                        x: 261
                        y: 142.8
                        width: 0
                        height: 0

                        FontString {
                            name: "AchievementFrameAchievementsContainerButton4Reward"
                            text: "Title: Bloodsail Admiral"
                            wowParent: "AchievementFrameAchievementsContainerButton4"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.top
                            anchors.topMargin: -1
                            width: 400
                            height: 20
                        }
                    }

                    Ghost {
                        name: "AchievementFrameAchievementsContainerButton4TitleBackground"
                        x: 248
                        y: 5
                        width: 0
                        height: 0

                        FontString {
                            name: "AchievementFrameAchievementsContainerButton4Label"
                            text: "The Mask Task"
                            wowParent: "AchievementFrameAchievementsContainerButton4"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.top
                            width: 320
                            height: 20
                        }
                    }
                }

                Button {
                    id: achievementFrameAchievementsContainerButton5
                    name: "AchievementFrameAchievementsContainerButton5"
                    anchors.left: achievementFrameAchievementsContainerButton4.left
                    anchors.top: achievementFrameAchievementsContainerButton4.bottom
                    width: 496
                    height: 84

                    FontString {
                        name: "AchievementFrameAchievementsContainerButton5DateCompleted"
                        text: "10/18/26"
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
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: 30
                        width: 330
                        height: 30
                    }

                    Frame {
                        name: "AchievementFrameAchievementsContainerButton5Icon"
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        anchors.top: parent.top
                        anchors.topMargin: 9
                        width: 60
                        height: 60
                    }

                    Frame {
                        name: "AchievementFrameAchievementsContainerButton5Objectives"
                        anchors.horizontalCenter: achievementFrameAchievementsContainerButton5Description.horizontalCenter
                        anchors.horizontalCenterOffset: -2
                        anchors.top: achievementFrameAchievementsContainerButton5Description.bottom
                        anchors.topMargin: 8
                        width: 340
                        height: -6
                    }

                    Frame {
                        id: achievementFrameAchievementsContainerButton5Shield
                        name: "AchievementFrameAchievementsContainerButton5Shield"
                        anchors.right: parent.right
                        anchors.rightMargin: 6
                        anchors.top: parent.top
                        width: 64
                        height: 64

                        FontString {
                            name: "AchievementFrameAchievementsContainerButton5ShieldPoints"
                            text: "10"
                            anchors.right: parent.right
                            anchors.rightMargin: 18
                            anchors.top: parent.top
                            anchors.topMargin: 26
                            width: 32
                            height: 16
                        }
                    }

                    Ghost {
                        name: "AchievementFrameAchievementsContainerButton5RewardBackground"
                        x: 248
                        y: 142.8
                        width: 0
                        height: 0

                        FontString {
                            name: "AchievementFrameAchievementsContainerButton5Reward"
                            text: "Title Reward: The Love Fool"
                            wowParent: "AchievementFrameAchievementsContainerButton5"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.top
                            anchors.topMargin: -1
                            width: 400
                            height: 20
                        }
                    }

                    Ghost {
                        name: "AchievementFrameAchievementsContainerButton5TitleBackground"
                        x: 248
                        y: 5
                        width: 0
                        height: 0

                        FontString {
                            name: "AchievementFrameAchievementsContainerButton5Label"
                            text: "Bring Me The Head of... Oh Wait"
                            wowParent: "AchievementFrameAchievementsContainerButton5"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.top
                            width: 320
                            height: 20
                        }
                    }
                }

                Button {
                    id: achievementFrameAchievementsContainerButton6
                    name: "AchievementFrameAchievementsContainerButton6"
                    anchors.left: achievementFrameAchievementsContainerButton5.left
                    anchors.top: achievementFrameAchievementsContainerButton5.bottom
                    width: 496
                    height: 84

                    FontString {
                        name: "AchievementFrameAchievementsContainerButton6DateCompleted"
                        text: "10/18/26"
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
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: 30
                        width: 330
                        height: 30
                    }

                    Frame {
                        name: "AchievementFrameAchievementsContainerButton6Icon"
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        anchors.top: parent.top
                        anchors.topMargin: 9
                        width: 60
                        height: 60
                    }

                    Frame {
                        name: "AchievementFrameAchievementsContainerButton6Objectives"
                        anchors.horizontalCenter: achievementFrameAchievementsContainerButton6Description.horizontalCenter
                        anchors.horizontalCenterOffset: -2
                        anchors.top: achievementFrameAchievementsContainerButton6Description.bottom
                        anchors.topMargin: 8
                        width: 340
                        height: -6
                    }

                    Frame {
                        id: achievementFrameAchievementsContainerButton6Shield
                        name: "AchievementFrameAchievementsContainerButton6Shield"
                        anchors.right: parent.right
                        anchors.rightMargin: 6
                        anchors.top: parent.top
                        width: 64
                        height: 64

                        FontString {
                            name: "AchievementFrameAchievementsContainerButton6ShieldPoints"
                            text: "10"
                            anchors.right: parent.right
                            anchors.rightMargin: 18
                            anchors.top: parent.top
                            anchors.topMargin: 26
                            width: 32
                            height: 16
                        }
                    }

                    Ghost {
                        name: "AchievementFrameAchievementsContainerButton6RewardBackground"
                        x: 248
                        y: 142.8
                        width: 0
                        height: 0

                        FontString {
                            name: "AchievementFrameAchievementsContainerButton6Reward"
                            text: "Title Reward: the Noble"
                            wowParent: "AchievementFrameAchievementsContainerButton6"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.top
                            anchors.topMargin: -1
                            width: 400
                            height: 20
                        }
                    }

                    Ghost {
                        name: "AchievementFrameAchievementsContainerButton6TitleBackground"
                        x: 248
                        y: 5
                        width: 0
                        height: 0

                        FontString {
                            name: "AchievementFrameAchievementsContainerButton6Label"
                            text: "The Savior of Hallow's End"
                            wowParent: "AchievementFrameAchievementsContainerButton6"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.top
                            width: 320
                            height: 20
                        }
                    }
                }

                Button {
                    name: "AchievementFrameAchievementsContainerButton7"
                    anchors.left: achievementFrameAchievementsContainerButton6.left
                    anchors.top: achievementFrameAchievementsContainerButton6.bottom
                    width: 496
                    height: 84

                    FontString {
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
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: 30
                        width: 330
                        height: 30
                    }

                    Frame {
                        name: "AchievementFrameAchievementsContainerButton7Icon"
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        anchors.top: parent.top
                        anchors.topMargin: 9
                        width: 60
                        height: 60
                    }

                    Frame {
                        name: "AchievementFrameAchievementsContainerButton7Objectives"
                        anchors.horizontalCenter: achievementFrameAchievementsContainerButton7Description.horizontalCenter
                        anchors.horizontalCenterOffset: -2
                        anchors.top: achievementFrameAchievementsContainerButton7Description.bottom
                        anchors.topMargin: 8
                        width: 340
                        height: -6
                    }

                    Frame {
                        id: achievementFrameAchievementsContainerButton7Shield
                        name: "AchievementFrameAchievementsContainerButton7Shield"
                        anchors.right: parent.right
                        anchors.rightMargin: 6
                        anchors.top: parent.top
                        width: 64
                        height: 64

                        FontString {
                            name: "AchievementFrameAchievementsContainerButton7ShieldPoints"
                            text: "20"
                            anchors.right: parent.right
                            anchors.rightMargin: 18
                            anchors.top: parent.top
                            anchors.topMargin: 26
                            width: 32
                            height: 16
                        }
                    }

                    Ghost {
                        name: "AchievementFrameAchievementsContainerButton7RewardBackground"
                        x: 248
                        y: 142.8
                        width: 0
                        height: 0

                        FontString {
                            name: "AchievementFrameAchievementsContainerButton7Reward"
                            text: "Title Reward: Matron/Patron"
                            wowParent: "AchievementFrameAchievementsContainerButton7"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.top
                            anchors.topMargin: -1
                            width: 400
                            height: 20
                        }
                    }

                    Ghost {
                        name: "AchievementFrameAchievementsContainerButton7TitleBackground"
                        x: 248
                        y: 5
                        width: 0
                        height: 0

                        FontString {
                            name: "AchievementFrameAchievementsContainerButton7Label"
                            text: "A Mask for All Occasions"
                            wowParent: "AchievementFrameAchievementsContainerButton7"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.top
                            width: 320
                            height: 20
                        }
                    }
                }
            }
        }

        Frame {
            name: "Overachiever_SearchFrame"
            wowParent: "AchievementFrame"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 530
            height: 461

            ScrollFrame {
                name: "Overachiever_SearchFrameContainer"
                anchors.left: parent.left
                anchors.leftMargin: 4
                anchors.top: parent.top
                anchors.topMargin: 3
                width: 526
                height: 453

                Frame {
                    name: "Overachiever_SearchFrameContainerScrollChild"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 504
                    height: 588
                }
            }
        }

        Frame {
            name: "Overachiever_SuggestionsFrame"
            wowParent: "AchievementFrame"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 530
            height: 461

            ScrollFrame {
                name: "Overachiever_SuggestionsFrameContainer"
                anchors.left: parent.left
                anchors.leftMargin: 4
                anchors.top: parent.top
                anchors.topMargin: 3
                width: 526
                height: 453

                Frame {
                    name: "Overachiever_SuggestionsFrameContainerScrollChild"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 504
                    height: 588

                    Button {
                        name: "Overachiever_SuggestionsFrameContainerButton1"
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.topMargin: 2
                        width: 522
                        height: 84

                        FontString {
                            id: overachiever_SuggestionsFrameContainerButton1Description
                            name: "Overachiever_SuggestionsFrameContainerButton1Description"
                            text: "Kill 50 enemy players in any of your home cities."
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.top
                            anchors.topMargin: 30
                            width: 330
                            height: 30
                        }

                        Frame {
                            name: "Overachiever_SuggestionsFrameContainerButton1Icon"
                            anchors.left: parent.left
                            anchors.leftMargin: 8
                            anchors.top: parent.top
                            anchors.topMargin: 9
                            width: 60
                            height: 60
                        }

                        Frame {
                            name: "Overachiever_SuggestionsFrameContainerButton1Objectives"
                            anchors.horizontalCenter: overachiever_SuggestionsFrameContainerButton1Description.horizontalCenter
                            anchors.horizontalCenterOffset: -2
                            anchors.top: overachiever_SuggestionsFrameContainerButton1Description.bottom
                            anchors.topMargin: 7.9
                            width: 366
                            height: -8.4
                        }

                        Frame {
                            name: "Overachiever_SuggestionsFrameContainerButton1Shield"
                            anchors.right: parent.right
                            anchors.rightMargin: 6
                            anchors.top: parent.top
                            width: 64
                            height: 64

                            FontString {
                                name: "Overachiever_SuggestionsFrameContainerButton1ShieldPoints"
                                text: "10"
                                anchors.right: parent.right
                                anchors.rightMargin: 18
                                anchors.top: parent.top
                                anchors.topMargin: 26
                                width: 32
                                height: 16
                            }
                        }

                        Ghost {
                            name: "Overachiever_SuggestionsFrameContainerButton1TitleBackground"
                            x: 261
                            y: 5
                            width: 0
                            height: 0

                            FontString {
                                name: "Overachiever_SuggestionsFrameContainerButton1Label"
                                text: "City Defender"
                                wowParent: "Overachiever_SuggestionsFrameContainerButton1"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.top: parent.top
                                width: 320
                                height: 20
                            }
                        }
                    }
                }
            }
        }

        Frame {
            name: "Overachiever_WatchFrame"
            wowParent: "AchievementFrame"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 530
            height: 461

            ScrollFrame {
                name: "Overachiever_WatchFrameContainer"
                anchors.left: parent.left
                anchors.leftMargin: 4
                anchors.top: parent.top
                anchors.topMargin: 3
                width: 526
                height: 453

                Frame {
                    name: "Overachiever_WatchFrameContainerScrollChild"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 504
                    height: 588
                }
            }
        }
    }

    Frame {
        id: achievementFrameCategories
        name: "AchievementFrameCategories"
        anchors.left: parent.left
        anchors.leftMargin: 21
        anchors.top: parent.top
        anchors.topMargin: 19
        width: 197
        height: 461

        ScrollFrame {
            name: "AchievementFrameCategoriesContainer"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 5
            width: 197
            height: 451

            Slider {
                name: "AchievementFrameCategoriesContainerScrollBar"
                anchors.left: parent.right
                anchors.leftMargin: -21
                anchors.top: parent.top
                anchors.topMargin: 14
                width: 20
                height: 425

                Frame {
                    name: "AchievementFrameCategoriesContainerScrollBarDiabolicTrack"
                    anchors.horizontalCenter: achievementFrameCategoriesContainerScrollBarScrollUpButton.horizontalCenter
                    anchors.top: achievementFrameCategoriesContainerScrollBarScrollUpButton.top
                    anchors.topMargin: -1
                    width: 18
                    height: 455
                }

                Button {
                    name: "AchievementFrameCategoriesContainerScrollBarScrollDownButton"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    anchors.topMargin: -2
                    width: 16
                    height: 16
                }

                Button {
                    id: achievementFrameCategoriesContainerScrollBarScrollUpButton
                    name: "AchievementFrameCategoriesContainerScrollBarScrollUpButton"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    anchors.bottomMargin: -2
                    width: 16
                    height: 16
                }
            }

            Frame {
                name: "AchievementFrameCategoriesContainerScrollChild"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 197
                height: 480

                Button {
                    name: "AchievementFrameCategoriesContainerButton1"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    width: 187
                    height: 24

                    FontString {
                        name: "AchievementFrameCategoriesContainerButton1Label"
                        text: "Summary"
                        anchors.left: parent.left
                        anchors.leftMargin: 14
                        anchors.verticalCenter: parent.verticalCenter
                        width: 159
                        height: 11.9
                    }
                }
            }
        }

        Frame {
            name: "Overachiever_LeftFrame"
            anchors.left: parent.left
            anchors.leftMargin: 9
            anchors.top: parent.top
            anchors.topMargin: 5
            width: 179
            height: 448

            FontString {
                name: "Overachiever_LeftFrameText"
                text: "Clear"
                wowParent: "?"
                anchors.left: parent.left
                anchors.leftMargin: 54.6
                anchors.top: parent.top
                anchors.topMargin: 135.4
                width: 41.9
                height: 11.9
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
                name: "Overachiever_SearchFrameFullListCheckbox"
                wowParent: "?"
                anchors.left: overachiever_SearchFrameAnyEdit.left
                anchors.leftMargin: -8
                anchors.top: overachiever_SearchFrameAnyEdit.bottom
                anchors.topMargin: 12
                width: 26
                height: 26

                FontString {
                    name: "Overachiever_SearchFrameFullListCheckboxText"
                    text: "Search all achievements"
                    anchors.left: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 141.4
                    height: 11.9
                }
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
                anchors.left: parent.left
                anchors.leftMargin: -15
                anchors.top: parent.top
                anchors.topMargin: 45.9
                width: 165
                height: 32

                Frame {
                    name: "Overachiever_SearchFrameSortDropDiabolicField"
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -4
                    width: 165
                    height: 22

                    Button {
                        name: "Overachiever_SearchFrameSortDropButton"
                        wowParent: "Overachiever_SearchFrameSortDrop"
                        anchors.right: parent.right
                        anchors.rightMargin: 18
                        anchors.verticalCenter: parent.verticalCenter
                        width: 18
                        height: 18
                    }

                    FontString {
                        name: "Overachiever_SearchFrameSortDropText"
                        text: "Name"
                        wowParent: "Overachiever_SearchFrameSortDrop"
                        anchors.left: parent.left
                        anchors.leftMargin: 22
                        anchors.verticalCenter: parent.verticalCenter
                        width: 103
                        height: 10
                    }
                }

                FontString {
                    name: "Overachiever_SearchFrameSortDropLabel"
                    text: "Sort by:"
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    anchors.bottom: parent.top
                    anchors.bottomMargin: 3
                    width: 45.8
                    height: 11.9
                }
            }

            Frame {
                id: overachiever_SuggestionsFrameSortDrop
                name: "Overachiever_SuggestionsFrameSortDrop"
                text: "Name"
                wowParent: "?"
                style: "DropDown"
                anchors.left: parent.left
                anchors.leftMargin: -15
                anchors.top: parent.top
                anchors.topMargin: 45.9
                width: 165
                height: 32

                Frame {
                    name: "Overachiever_SuggestionsFrameSortDropDiabolicField"
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -4
                    width: 165
                    height: 22

                    Button {
                        name: "Overachiever_SuggestionsFrameSortDropButton"
                        wowParent: "Overachiever_SuggestionsFrameSortDrop"
                        anchors.right: parent.right
                        anchors.rightMargin: 18
                        anchors.verticalCenter: parent.verticalCenter
                        width: 18
                        height: 18
                    }

                    FontString {
                        name: "Overachiever_SuggestionsFrameSortDropText"
                        text: "Name"
                        wowParent: "Overachiever_SuggestionsFrameSortDrop"
                        anchors.left: parent.left
                        anchors.leftMargin: 22
                        anchors.verticalCenter: parent.verticalCenter
                        width: 103
                        height: 10
                    }
                }

                FontString {
                    name: "Overachiever_SuggestionsFrameSortDropLabel"
                    text: "Sort by:"
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    anchors.bottom: parent.top
                    anchors.bottomMargin: 3
                    width: 45.8
                    height: 11.9
                }
            }

            Frame {
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

                Frame {
                    name: "Overachiever_SuggestionsFrameSubzoneDropDiabolicField"
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -4
                    width: 166
                    height: 22

                    Button {
                        name: "Overachiever_SuggestionsFrameSubzoneDropButton"
                        wowParent: "Overachiever_SuggestionsFrameSubzoneDrop"
                        anchors.right: parent.right
                        anchors.rightMargin: 18
                        anchors.verticalCenter: parent.verticalCenter
                        width: 18
                        height: 18
                    }

                    FontString {
                        name: "Overachiever_SuggestionsFrameSubzoneDropText"
                        text: "(unspecified)"
                        wowParent: "Overachiever_SuggestionsFrameSubzoneDrop"
                        anchors.left: parent.left
                        anchors.leftMargin: 22
                        anchors.verticalCenter: parent.verticalCenter
                        width: 104
                        height: 10
                    }
                }

                FontString {
                    name: "Overachiever_SuggestionsFrameSubzoneDropLabel"
                    text: "Subzone:"
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    anchors.bottom: parent.top
                    anchors.bottomMargin: 3
                    width: 53.7
                    height: 11.9
                }
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

                FontString {
                    name: "Overachiever_WatchFrameCopyDestCheckboxText"
                    text: "Copy To:"
                    anchors.left: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 52.9
                    height: 11.9
                }
            }

            Frame {
                id: overachiever_WatchFrameDefListDrop
                name: "Overachiever_WatchFrameDefListDrop"
                text: "Global"
                wowParent: "?"
                style: "DropDown"
                anchors.left: parent.left
                anchors.leftMargin: -15
                anchors.top: parent.top
                anchors.topMargin: 173.9
                width: 166
                height: 32

                Frame {
                    name: "Overachiever_WatchFrameDefListDropDiabolicField"
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -4
                    width: 166
                    height: 22

                    Button {
                        name: "Overachiever_WatchFrameDefListDropButton"
                        wowParent: "Overachiever_WatchFrameDefListDrop"
                        anchors.right: parent.right
                        anchors.rightMargin: 18
                        anchors.verticalCenter: parent.verticalCenter
                        width: 18
                        height: 18
                    }

                    FontString {
                        name: "Overachiever_WatchFrameDefListDropText"
                        text: "Global"
                        wowParent: "Overachiever_WatchFrameDefListDrop"
                        anchors.left: parent.left
                        anchors.leftMargin: 22
                        anchors.verticalCenter: parent.verticalCenter
                        width: 104
                        height: 10
                    }
                }

                FontString {
                    name: "Overachiever_WatchFrameDefListDropLabel"
                    text: "Default List:"
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    anchors.bottom: parent.top
                    anchors.bottomMargin: 3
                    width: 71.9
                    height: 11.9
                }
            }

            Frame {
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

                Frame {
                    name: "Overachiever_WatchFrameDestinationListDropDiabolicField"
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -4
                    width: 166
                    height: 22

                    Button {
                        name: "Overachiever_WatchFrameDestinationListDropButton"
                        wowParent: "Overachiever_WatchFrameDestinationListDrop"
                        anchors.right: parent.right
                        anchors.rightMargin: 18
                        anchors.verticalCenter: parent.verticalCenter
                        width: 18
                        height: 18
                    }

                    FontString {
                        name: "Overachiever_WatchFrameDestinationListDropText"
                        text: "Global"
                        wowParent: "Overachiever_WatchFrameDestinationListDrop"
                        anchors.left: parent.left
                        anchors.leftMargin: 22
                        anchors.verticalCenter: parent.verticalCenter
                        width: 104
                        height: 10
                    }
                }
            }

            Frame {
                name: "Overachiever_WatchFrameListDrop"
                text: "Global"
                wowParent: "?"
                style: "DropDown"
                anchors.left: overachiever_WatchFrameSortDrop.left
                anchors.top: overachiever_WatchFrameSortDrop.bottom
                anchors.topMargin: 18
                width: 166
                height: 32

                Frame {
                    name: "Overachiever_WatchFrameListDropDiabolicField"
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -4
                    width: 166
                    height: 22

                    Button {
                        name: "Overachiever_WatchFrameListDropButton"
                        wowParent: "Overachiever_WatchFrameListDrop"
                        anchors.right: parent.right
                        anchors.rightMargin: 18
                        anchors.verticalCenter: parent.verticalCenter
                        width: 18
                        height: 18
                    }

                    FontString {
                        name: "Overachiever_WatchFrameListDropText"
                        text: "Global"
                        wowParent: "Overachiever_WatchFrameListDrop"
                        anchors.left: parent.left
                        anchors.leftMargin: 22
                        anchors.verticalCenter: parent.verticalCenter
                        width: 104
                        height: 10
                    }
                }

                FontString {
                    name: "Overachiever_WatchFrameListDropLabel"
                    text: "Displayed List:"
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    anchors.bottom: parent.top
                    anchors.bottomMargin: 3
                    width: 87.7
                    height: 11.9
                }
            }

            Frame {
                id: overachiever_WatchFrameSortDrop
                name: "Overachiever_WatchFrameSortDrop"
                text: "Name"
                wowParent: "?"
                style: "DropDown"
                anchors.left: parent.left
                anchors.leftMargin: -15
                anchors.top: parent.top
                anchors.topMargin: 45.9
                width: 165
                height: 32

                Frame {
                    name: "Overachiever_WatchFrameSortDropDiabolicField"
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -4
                    width: 165
                    height: 22

                    Button {
                        name: "Overachiever_WatchFrameSortDropButton"
                        wowParent: "Overachiever_WatchFrameSortDrop"
                        anchors.right: parent.right
                        anchors.rightMargin: 18
                        anchors.verticalCenter: parent.verticalCenter
                        width: 18
                        height: 18
                    }

                    FontString {
                        name: "Overachiever_WatchFrameSortDropText"
                        text: "Name"
                        wowParent: "Overachiever_WatchFrameSortDrop"
                        anchors.left: parent.left
                        anchors.leftMargin: 22
                        anchors.verticalCenter: parent.verticalCenter
                        width: 103
                        height: 10
                    }
                }

                FontString {
                    name: "Overachiever_WatchFrameSortDropLabel"
                    text: "Sort by:"
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    anchors.bottom: parent.top
                    anchors.bottomMargin: 3
                    width: 45.8
                    height: 11.9
                }
            }
        }
    }

    Frame {
        id: achievementFrameDiabolic
        name: "AchievementFrameDiabolic"
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: -64
        width: 768
        height: 582

        Button {
            name: "AchievementFrameCloseButton"
            wowParent: "AchievementFrame"
            style: "CloseButton"
            anchors.horizontalCenter: parent.right
            anchors.horizontalCenterOffset: -31
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: 31
            width: 22
            height: 22
        }

        Frame {
            name: "AchievementFrameDiabolicBand"
            anchors.left: parent.left
            anchors.leftMargin: 24
            anchors.top: parent.top
            anchors.topMargin: 24
            width: 720
            height: 48

            Frame {
                name: "AchievementFrameFilterDropDown"
                wowParent: "AchievementFrame"
                style: "DropDown"
                anchors.left: parent.left
                anchors.leftMargin: 18
                anchors.verticalCenter: parent.verticalCenter
                width: 110
                height: 32

                Frame {
                    name: "AchievementFrameFilterDropDownDiabolicField"
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -4
                    width: 110
                    height: 22

                    Button {
                        name: "AchievementFrameFilterDropDownButton"
                        wowParent: "AchievementFrameFilterDropDown"
                        anchors.right: parent.right
                        anchors.rightMargin: -8
                        anchors.verticalCenter: parent.verticalCenter
                        width: 18
                        height: 18
                    }

                    FontString {
                        name: "AchievementFrameFilterDropDownText"
                        text: "All"
                        wowParent: "AchievementFrameFilterDropDown"
                        anchors.left: parent.left
                        anchors.leftMargin: -4
                        anchors.verticalCenter: parent.verticalCenter
                        width: 100
                        height: 32
                    }
                }
            }

            Frame {
                name: "AchievementFrameHeader"
                wowParent: "AchievementFrame"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 720
                height: 48
            }

            Frame {
                name: "AchievementFrameHeaderPointsDiabolicCartouche"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: 107.4
                height: 38

                FontString {
                    name: "AchievementFrameHeaderPoints"
                    text: "3460"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: 10
                    anchors.verticalCenter: parent.verticalCenter
                    width: 51.4
                    height: 12
                }
            }
        }

        Frame {
            name: "AchievementFrameDiabolicBorder"
            anchors.left: parent.left
            anchors.top: parent.top
            width: 768
            height: 582

            Frame {
                name: "AchievementFrameDiabolicTitlePlate"
                wowParent: "AchievementFrameDiabolic"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.top
                anchors.verticalCenterOffset: 15
                width: 300
                height: 41

                FontString {
                    name: "AchievementFrameHeaderTitle"
                    text: "Achievements"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 123.3
                    height: 14.2
                }
            }
        }

        Frame {
            name: "AchievementFrameDiabolicRail"
            anchors.left: parent.left
            anchors.leftMargin: 18
            anchors.top: parent.bottom
            anchors.topMargin: -19
            width: 304
            height: 18
        }

        Frame {
            name: "AchievementFrameDiabolicSocket"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 20
            width: 42
            height: 42
        }
    }

    Frame {
        name: "AchievementFrameStats"
        anchors.left: achievementFrameCategories.right
        anchors.top: achievementFrameCategories.top
        width: 504
        height: 461

        Frame {
            name: "AchievementFrameStatsBG"
            anchors.left: parent.left
            anchors.leftMargin: 2
            anchors.top: parent.top
            width: 526
            height: 458
        }

        ScrollFrame {
            name: "AchievementFrameStatsContainer"
            anchors.left: parent.left
            anchors.leftMargin: 3
            anchors.top: parent.top
            anchors.topMargin: 3
            width: 501
            height: 453

            Slider {
                name: "AchievementFrameStatsContainerScrollBar"
                style: "ScrollBar"
                anchors.left: parent.right
                anchors.leftMargin: 1
                anchors.top: parent.top
                anchors.topMargin: 16
                width: 20
                height: 425

                Frame {
                    name: "AchievementFrameStatsContainerScrollBarDiabolicTrack"
                    anchors.horizontalCenter: achievementFrameStatsContainerScrollBarScrollUpButton.horizontalCenter
                    anchors.top: achievementFrameStatsContainerScrollBarScrollUpButton.top
                    anchors.topMargin: -1
                    width: 18
                    height: 455
                }

                Button {
                    name: "AchievementFrameStatsContainerScrollBarScrollDownButton"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    anchors.topMargin: -2
                    width: 16
                    height: 16
                }

                Button {
                    id: achievementFrameStatsContainerScrollBarScrollUpButton
                    name: "AchievementFrameStatsContainerScrollBarScrollUpButton"
                    style: "ScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    anchors.bottomMargin: -2
                    width: 16
                    height: 16
                }
            }

            Frame {
                name: "AchievementFrameStatsContainerScrollChild"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 503
                height: 480

                Button {
                    name: "AchievementFrameStatsContainerButton1"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 496
                    height: 24

                    FontString {
                        name: "AchievementFrameStatsContainerButton1Title"
                        text: "Summary"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: 74.3
                        height: 15.8
                    }

                    FontString {
                        name: "AchievementFrameStatsContainerButton1Value"
                        anchors.right: parent.right
                        anchors.rightMargin: 5
                        anchors.verticalCenter: parent.verticalCenter
                        width: 1
                        height: 1
                    }
                }
            }
        }
    }

    Frame {
        name: "AchievementFrameSummary"
        anchors.left: achievementFrameCategories.right
        anchors.top: achievementFrameCategories.top
        width: 530
        height: 461

        Frame {
            id: achievementFrameSummaryAchievements
            name: "AchievementFrameSummaryAchievements"
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.top: parent.top
            anchors.topMargin: 20
            width: 520
            height: 210

            Button {
                id: achievementFrameSummaryAchievement1
                name: "AchievementFrameSummaryAchievement1"
                anchors.left: achievementFrameSummaryAchievementsHeader.left
                anchors.leftMargin: 18
                anchors.top: achievementFrameSummaryAchievementsHeader.bottom
                anchors.topMargin: -2
                width: 484
                height: 48

                FontString {
                    name: "AchievementFrameSummaryAchievement1DateCompleted"
                    text: "10/30/26"
                    anchors.right: parent.right
                    anchors.rightMargin: 63
                    anchors.top: parent.top
                    anchors.topMargin: 8
                    width: 100
                    height: 14
                }

                FontString {
                    name: "AchievementFrameSummaryAchievement1Description"
                    text: "Show off your sparkling smile by using a Tooth Pick."
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 30
                    width: 380
                    height: 13
                }

                Frame {
                    name: "AchievementFrameSummaryAchievement1Highlight"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 484
                    height: 48
                }

                Frame {
                    name: "AchievementFrameSummaryAchievement1Icon"
                    anchors.left: parent.left
                    anchors.leftMargin: 3
                    anchors.top: parent.top
                    anchors.topMargin: 3
                    width: 48
                    height: 48
                }

                Frame {
                    name: "AchievementFrameSummaryAchievement1Shield"
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    anchors.top: parent.top
                    anchors.topMargin: 4
                    width: 48
                    height: 48

                    FontString {
                        name: "AchievementFrameSummaryAchievement1ShieldPoints"
                        text: "10"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.horizontalCenterOffset: -1
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: -3
                        width: 40
                        height: 26
                    }
                }

                Ghost {
                    name: "AchievementFrameSummaryAchievement1TitleBackground"
                    x: 242
                    y: 5
                    width: 0
                    height: 0

                    FontString {
                        name: "AchievementFrameSummaryAchievement1Label"
                        text: "That Sparkling Smile"
                        wowParent: "AchievementFrameSummaryAchievement1"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        width: 260
                        height: 20
                    }
                }
            }

            Button {
                id: achievementFrameSummaryAchievement2
                name: "AchievementFrameSummaryAchievement2"
                anchors.left: achievementFrameSummaryAchievement1.left
                anchors.top: achievementFrameSummaryAchievement1.bottom
                anchors.topMargin: -3
                width: 484
                height: 48

                FontString {
                    name: "AchievementFrameSummaryAchievement2DateCompleted"
                    text: "10/30/26"
                    anchors.right: parent.right
                    anchors.rightMargin: 63
                    anchors.top: parent.top
                    anchors.topMargin: 8
                    width: 100
                    height: 14
                }

                FontString {
                    name: "AchievementFrameSummaryAchievement2Description"
                    text: "Earn exalted status with and the right to represent every Alliance race's faction in the Argent Tournament."
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 30
                    width: 380
                    height: 13
                }

                Frame {
                    name: "AchievementFrameSummaryAchievement2Icon"
                    anchors.left: parent.left
                    anchors.leftMargin: 3
                    anchors.top: parent.top
                    anchors.topMargin: 3
                    width: 48
                    height: 48
                }

                Frame {
                    name: "AchievementFrameSummaryAchievement2Shield"
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    anchors.top: parent.top
                    anchors.topMargin: 4
                    width: 48
                    height: 48

                    FontString {
                        name: "AchievementFrameSummaryAchievement2ShieldPoints"
                        text: "10"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.horizontalCenterOffset: -1
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: -3
                        width: 40
                        height: 26
                    }
                }

                Ghost {
                    name: "AchievementFrameSummaryAchievement2TitleBackground"
                    x: 242
                    y: 5
                    width: 0
                    height: 0

                    FontString {
                        name: "AchievementFrameSummaryAchievement2Label"
                        text: "Exalted Argent Champion of the Alliance"
                        wowParent: "AchievementFrameSummaryAchievement2"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        width: 260
                        height: 20
                    }
                }
            }

            Button {
                id: achievementFrameSummaryAchievement3
                name: "AchievementFrameSummaryAchievement3"
                anchors.left: achievementFrameSummaryAchievement2.left
                anchors.top: achievementFrameSummaryAchievement2.bottom
                anchors.topMargin: -3
                width: 484
                height: 48

                FontString {
                    name: "AchievementFrameSummaryAchievement3DateCompleted"
                    text: "10/30/26"
                    anchors.right: parent.right
                    anchors.rightMargin: 63
                    anchors.top: parent.top
                    anchors.topMargin: 8
                    width: 100
                    height: 14
                }

                FontString {
                    name: "AchievementFrameSummaryAchievement3Description"
                    text: "Earn exalted status with and the right to represent every Alliance race's faction in the Argent Tournament."
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 30
                    width: 380
                    height: 13
                }

                Frame {
                    name: "AchievementFrameSummaryAchievement3Highlight"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 484
                    height: 48
                }

                Frame {
                    name: "AchievementFrameSummaryAchievement3Icon"
                    anchors.left: parent.left
                    anchors.leftMargin: 3
                    anchors.top: parent.top
                    anchors.topMargin: 3
                    width: 48
                    height: 48
                }

                Frame {
                    name: "AchievementFrameSummaryAchievement3Shield"
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    anchors.top: parent.top
                    anchors.topMargin: 4
                    width: 48
                    height: 48

                    FontString {
                        name: "AchievementFrameSummaryAchievement3ShieldPoints"
                        text: "10"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.horizontalCenterOffset: -1
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: -3
                        width: 40
                        height: 26
                    }
                }

                Ghost {
                    name: "AchievementFrameSummaryAchievement3TitleBackground"
                    x: 242
                    y: 5
                    width: 0
                    height: 0

                    FontString {
                        name: "AchievementFrameSummaryAchievement3Label"
                        text: "Exalted Champion of the Alliance"
                        wowParent: "AchievementFrameSummaryAchievement3"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        width: 260
                        height: 20
                    }
                }
            }

            Button {
                name: "AchievementFrameSummaryAchievement4"
                anchors.left: achievementFrameSummaryAchievement3.left
                anchors.top: achievementFrameSummaryAchievement3.bottom
                anchors.topMargin: -3
                width: 484
                height: 48

                FontString {
                    name: "AchievementFrameSummaryAchievement4DateCompleted"
                    text: "10/30/26"
                    anchors.right: parent.right
                    anchors.rightMargin: 63
                    anchors.top: parent.top
                    anchors.topMargin: 8
                    width: 100
                    height: 14
                }

                FontString {
                    name: "AchievementFrameSummaryAchievement4Description"
                    text: "Earn exalted reputation with 5 home cities."
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 30
                    width: 380
                    height: 13
                }

                Frame {
                    name: "AchievementFrameSummaryAchievement4Highlight"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 484
                    height: 48
                }

                Frame {
                    name: "AchievementFrameSummaryAchievement4Icon"
                    anchors.left: parent.left
                    anchors.leftMargin: 3
                    anchors.top: parent.top
                    anchors.topMargin: 3
                    width: 48
                    height: 48
                }

                Frame {
                    name: "AchievementFrameSummaryAchievement4Shield"
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    anchors.top: parent.top
                    anchors.topMargin: 4
                    width: 48
                    height: 48

                    FontString {
                        name: "AchievementFrameSummaryAchievement4ShieldPoints"
                        text: "10"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.horizontalCenterOffset: -1
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: -3
                        width: 40
                        height: 26
                    }
                }

                Ghost {
                    name: "AchievementFrameSummaryAchievement4TitleBackground"
                    x: 242
                    y: 5
                    width: 0
                    height: 0

                    FontString {
                        name: "AchievementFrameSummaryAchievement4Label"
                        text: "Ambassador of the Alliance"
                        wowParent: "AchievementFrameSummaryAchievement4"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        width: 260
                        height: 20
                    }
                }
            }

            Frame {
                id: achievementFrameSummaryAchievementsHeader
                name: "AchievementFrameSummaryAchievementsHeader"
                style: "Section"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 520
                height: 20

                FontString {
                    name: "AchievementFrameSummaryAchievementsHeaderTitle"
                    text: "Recent Achievements"
                    anchors.left: parent.left
                    anchors.leftMargin: 28
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 158.8
                    height: 20
                }
            }
        }

        Frame {
            name: "AchievementFrameSummaryCategories"
            anchors.left: achievementFrameSummaryAchievements.left
            anchors.top: achievementFrameSummaryAchievements.bottom
            anchors.topMargin: 8
            width: 520
            height: 164

            StatusBar {
                name: "AchievementFrameSummaryCategoriesCategory1"
                style: "Bar"
                anchors.left: achievementFrameSummaryCategoriesStatusBar.left
                anchors.top: achievementFrameSummaryCategoriesStatusBar.bottom
                anchors.topMargin: 24
                width: 224
                height: 16

                Button {
                    name: "AchievementFrameSummaryCategoriesCategory1Button"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 224
                    height: 16
                }

                FontString {
                    name: "AchievementFrameSummaryCategoriesCategory1Label"
                    text: "General"
                    anchors.left: parent.left
                    anchors.leftMargin: 8
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 52.1
                    height: 10.3
                }

                FontString {
                    name: "AchievementFrameSummaryCategoriesCategory1Text"
                    text: "29/54"
                    anchors.right: parent.right
                    anchors.rightMargin: 8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 30.8
                    height: 14
                }
            }

            Frame {
                id: achievementFrameSummaryCategoriesHeader
                name: "AchievementFrameSummaryCategoriesHeader"
                style: "Section"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 520
                height: 20

                FontString {
                    name: "AchievementFrameSummaryCategoriesHeaderTitle"
                    text: "Progress Overview"
                    anchors.left: parent.left
                    anchors.leftMargin: 28
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 143.8
                    height: 20
                }
            }

            StatusBar {
                id: achievementFrameSummaryCategoriesStatusBar
                name: "AchievementFrameSummaryCategoriesStatusBar"
                style: "Bar"
                anchors.horizontalCenter: achievementFrameSummaryCategoriesHeader.horizontalCenter
                anchors.top: achievementFrameSummaryCategoriesHeader.bottom
                anchors.topMargin: 6
                width: 472
                height: 16

                FontString {
                    name: "AchievementFrameSummaryCategoriesStatusBarText"
                    text: "330/1058"
                    anchors.right: parent.right
                    anchors.rightMargin: 8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 49
                    height: 14
                }

                FontString {
                    name: "AchievementFrameSummaryCategoriesStatusBarTitle"
                    text: "Achievements Earned"
                    anchors.left: parent.left
                    anchors.leftMargin: 8
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -1
                    width: 141.4
                    height: 10.3
                }
            }
        }
    }

    Button {
        name: "AchievementFrameTab1"
        text: "Achievements"
        style: "Banner"
        anchors.left: achievementFrameDiabolic.left
        anchors.leftMargin: 28
        anchors.top: achievementFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        name: "AchievementFrameTab2"
        text: "Statistics"
        style: "Banner"
        anchors.left: achievementFrameDiabolic.left
        anchors.leftMargin: 86
        anchors.top: achievementFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        name: "AchievementFrameTab3"
        text: "Search"
        style: "Banner"
        anchors.left: achievementFrameDiabolic.left
        anchors.leftMargin: 144
        anchors.top: achievementFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        name: "AchievementFrameTab4"
        text: "Suggestions"
        style: "Banner"
        anchors.left: achievementFrameDiabolic.left
        anchors.leftMargin: 202
        anchors.top: achievementFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Button {
        name: "AchievementFrameTab5"
        text: "Watch"
        style: "Banner"
        anchors.left: achievementFrameDiabolic.left
        anchors.leftMargin: 260
        anchors.top: achievementFrameDiabolic.bottom
        anchors.topMargin: -23
        width: 52
        height: 116
    }

    Ghost {
        name: "AchievementFrameStatsContainerButton17"
        x: 221
        y: 406
        width: 496
        height: 24

        FontString {
            name: "AchievementFrameStatsContainerButton17Title"
            text: "Professions"
            wowParent: "AchievementFrameStatsContainerButton17"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 89.3
            height: 15.8
        }
    }

    Ghost {
        name: "AchievementFrameStatsContainerButton19"
        x: 221
        y: 454
        width: 496
        height: 24

        FontString {
            name: "AchievementFrameStatsContainerButton19Title"
            text: "Classic"
            wowParent: "AchievementFrameStatsContainerButton19"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 55.3
            height: 15.8
        }
    }

    Ghost {
        name: "AchievementFrameStatsContainerButton4"
        x: 221
        y: 94
        width: 496
        height: 24

        FontString {
            name: "AchievementFrameStatsContainerButton4Title"
            text: "Creatures"
            wowParent: "AchievementFrameStatsContainerButton4"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 73.5
            height: 15.8
        }
    }

    Ghost {
        name: "AchievementFrameStatsContainerButton6"
        x: 221
        y: 142
        width: 496
        height: 24

        FontString {
            name: "AchievementFrameStatsContainerButton6Title"
            text: "Secondary Skills"
            wowParent: "AchievementFrameStatsContainerButton6"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 127.2
            height: 15.8
        }
    }

    Ghost {
        name: "AchievementFrameStatsContainerButton9"
        x: 221
        y: 214
        width: 496
        height: 24

        FontString {
            name: "AchievementFrameStatsContainerButton9Title"
            text: "Honorable Kills"
            wowParent: "AchievementFrameStatsContainerButton9"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 119.3
            height: 15.8
        }
    }
}
