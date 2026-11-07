// Written by tools/positions.lua, yours to change (docs: Windows Editor): each part
// is in what it's placed on, buttons next to the one they're on. One with a pin is put in settings/positions.lua ("all",
// or only its "place" or its "size"), the others follow /dui layout's scan.
import QtQuick

WowWindow {
    name: "AchievementFrame"
    width: 768
    height: 500

    Frame {
        name: "AchievementFrameCategories"
        wowParent: "AchievementFrame"
        anchors.left: parent.left
        anchors.leftMargin: 21
        anchors.top: parent.top
        anchors.topMargin: 19
        width: 197
        height: 461

        Frame {
            name: "AchievementFrameAchievements"
            wowParent: "AchievementFrame"
            anchors.left: parent.right
            anchors.top: parent.top
            width: 504
            height: 461

            ScrollFrame {
                name: "AchievementFrameAchievementsContainer"
                wowParent: "AchievementFrameAchievements"
                anchors.left: parent.left
                anchors.leftMargin: 4
                anchors.top: parent.top
                anchors.topMargin: 3
                width: 500
                height: 453

                Slider {
                    name: "AchievementFrameAchievementsContainerScrollBar"
                    wowParent: "AchievementFrameAchievementsContainer"
                    anchors.left: parent.right
                    anchors.leftMargin: 1
                    anchors.top: parent.top
                    anchors.topMargin: 16
                    width: 20
                    height: 425

                    Button {
                        name: "AchievementFrameAchievementsContainerScrollBarScrollDownButton"
                        wowParent: "AchievementFrameAchievementsContainerScrollBar"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.bottom
                        anchors.topMargin: -2
                        width: 16
                        height: 16
                    }

                    Button {
                        name: "AchievementFrameAchievementsContainerScrollBarScrollUpButton"
                        wowParent: "AchievementFrameAchievementsContainerScrollBar"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.top
                        anchors.bottomMargin: -2
                        width: 16
                        height: 16

                        Frame {
                            name: "AchievementFrameAchievementsContainerScrollBarDiabolicTrack"
                            wowParent: "AchievementFrameAchievementsContainerScrollBar"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.top
                            anchors.topMargin: -1
                            width: 18
                            height: 455
                        }
                    }
                }

                Frame {
                    name: "AchievementFrameAchievementsContainerScrollChild"
                    wowParent: "AchievementFrameAchievementsContainer"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.topMargin: -86
                    width: 500
                    height: 593.3

                    Button {
                        id: achievementFrameAchievementsContainerButton1
                        name: "AchievementFrameAchievementsContainerButton1"
                        wowParent: "AchievementFrameAchievementsContainerScrollChild"
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.topMargin: 2
                        width: 496
                        height: 89.3

                        FontString {
                            name: "AchievementFrameAchievementsContainerButton1Description"
                            text: "Show off your sparkling smile by using a Tooth Pick."
                            wowParent: "AchievementFrameAchievementsContainerButton1"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.top
                            anchors.topMargin: 30
                            width: 330
                            height: 30

                            Frame {
                                name: "AchievementFrameAchievementsContainerButton1Objectives"
                                wowParent: "AchievementFrameAchievementsContainerButton1"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.horizontalCenterOffset: -2
                                anchors.top: parent.bottom
                                anchors.topMargin: -76.1
                                width: 340
                                height: -0.7
                            }
                        }

                        FontString {
                            name: "AchievementFrameAchievementsContainerButton1HiddenDescription"
                            text: "Obtain a Sinister Squashling pet and Hallowed Helm."
                            wowParent: "AchievementFrameAchievementsContainerButton1"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.top
                            anchors.topMargin: 30
                            width: 330
                            height: 10.3

                            Frame {
                                name: "AchievementFrameAchievementsObjectives"
                                wowParent: "AchievementFrameAchievementsContainerButton1"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.horizontalCenterOffset: -8.5
                                anchors.top: parent.bottom
                                anchors.topMargin: 8
                                width: 353
                                height: 15

                                Frame {
                                    name: "AchievementFrameCriteria1"
                                    wowParent: "AchievementFrameAchievementsObjectives"
                                    anchors.left: parent.left
                                    anchors.top: parent.top
                                    width: 120.3
                                    height: 15
                                }

                                Frame {
                                    name: "AchievementFrameCriteria2"
                                    wowParent: "AchievementFrameAchievementsObjectives"
                                    anchors.left: parent.left
                                    anchors.leftMargin: 165
                                    anchors.top: parent.top
                                    width: 102.2
                                    height: 15
                                }
                            }
                        }

                        Frame {
                            name: "AchievementFrameAchievementsContainerButton1Highlight"
                            wowParent: "AchievementFrameAchievementsContainerButton1"
                            anchors.left: parent.left
                            anchors.top: parent.top
                            width: 496
                            height: 89.3
                        }

                        Frame {
                            name: "AchievementFrameAchievementsContainerButton1Icon"
                            wowParent: "AchievementFrameAchievementsContainerButton1"
                            anchors.left: parent.left
                            anchors.leftMargin: 8
                            anchors.top: parent.top
                            anchors.topMargin: 9
                            width: 60
                            height: 60
                        }

                        Frame {
                            name: "AchievementFrameAchievementsContainerButton1Shield"
                            wowParent: "AchievementFrameAchievementsContainerButton1"
                            anchors.right: parent.right
                            anchors.rightMargin: 6
                            anchors.top: parent.top
                            width: 64
                            height: 64

                            FontString {
                                name: "AchievementFrameAchievementsContainerButton1DateCompleted"
                                text: "10/22/26"
                                wowParent: "AchievementFrameAchievementsContainerButton1"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.horizontalCenterOffset: -3
                                anchors.top: parent.bottom
                                anchors.topMargin: -6
                                width: 100
                                height: 14
                            }

                            FontString {
                                name: "AchievementFrameAchievementsContainerButton1ShieldPoints"
                                text: "10"
                                wowParent: "AchievementFrameAchievementsContainerButton1Shield"
                                anchors.right: parent.right
                                anchors.rightMargin: 18
                                anchors.top: parent.top
                                anchors.topMargin: 26
                                width: 32
                                height: 16
                            }
                        }
                    }

                    Button {
                        id: achievementFrameAchievementsContainerButton2
                        name: "AchievementFrameAchievementsContainerButton2"
                        wowParent: "AchievementFrameAchievementsContainerScrollChild"
                        anchors.left: achievementFrameAchievementsContainerButton1.left
                        anchors.top: achievementFrameAchievementsContainerButton1.bottom
                        width: 496
                        height: 84

                        FontString {
                            name: "AchievementFrameAchievementsContainerButton2Description"
                            text: "Eat so many Tricky Treats that you get an upset tummy."
                            wowParent: "AchievementFrameAchievementsContainerButton2"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.top
                            anchors.topMargin: 30
                            width: 330
                            height: 30

                            Frame {
                                name: "AchievementFrameAchievementsContainerButton2Objectives"
                                wowParent: "AchievementFrameAchievementsContainerButton2"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.horizontalCenterOffset: -2
                                anchors.top: parent.bottom
                                anchors.topMargin: 8
                                width: 340
                                height: -6
                            }
                        }

                        FontString {
                            name: "AchievementFrameAchievementsContainerButton2HiddenDescription"
                            text: "Obtain a Sinister Squashling pet and Hallowed Helm."
                            wowParent: "AchievementFrameAchievementsContainerButton2"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.top
                            anchors.topMargin: 30
                            width: 330
                            height: 10.3
                        }

                        Frame {
                            name: "AchievementFrameAchievementsContainerButton2Highlight"
                            wowParent: "AchievementFrameAchievementsContainerButton2"
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.topMargin: 78.7
                            width: 496
                            height: 89.3
                        }

                        Frame {
                            name: "AchievementFrameAchievementsContainerButton2Icon"
                            wowParent: "AchievementFrameAchievementsContainerButton2"
                            anchors.left: parent.left
                            anchors.leftMargin: 8
                            anchors.top: parent.top
                            anchors.topMargin: 9
                            width: 60
                            height: 60
                        }

                        Frame {
                            name: "AchievementFrameAchievementsContainerButton2Shield"
                            wowParent: "AchievementFrameAchievementsContainerButton2"
                            anchors.right: parent.right
                            anchors.rightMargin: 6
                            anchors.top: parent.top
                            width: 64
                            height: 64

                            FontString {
                                name: "AchievementFrameAchievementsContainerButton2DateCompleted"
                                text: "10/21/26"
                                wowParent: "AchievementFrameAchievementsContainerButton2"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.horizontalCenterOffset: -3
                                anchors.top: parent.bottom
                                anchors.topMargin: -6
                                width: 100
                                height: 14
                            }

                            FontString {
                                name: "AchievementFrameAchievementsContainerButton2ShieldPoints"
                                text: "10"
                                wowParent: "AchievementFrameAchievementsContainerButton2Shield"
                                anchors.right: parent.right
                                anchors.rightMargin: 18
                                anchors.top: parent.top
                                anchors.topMargin: 26
                                width: 32
                                height: 16
                            }
                        }
                    }

                    Button {
                        id: achievementFrameAchievementsContainerButton3
                        name: "AchievementFrameAchievementsContainerButton3"
                        wowParent: "AchievementFrameAchievementsContainerScrollChild"
                        anchors.left: achievementFrameAchievementsContainerButton2.left
                        anchors.top: achievementFrameAchievementsContainerButton2.bottom
                        width: 496
                        height: 84

                        FontString {
                            name: "AchievementFrameAchievementsContainerButton3Description"
                            text: "Receive a handful of a candy from one of the Candy Buckets located in an inn."
                            wowParent: "AchievementFrameAchievementsContainerButton3"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.top
                            anchors.topMargin: 30
                            width: 330
                            height: 30

                            Frame {
                                name: "AchievementFrameAchievementsContainerButton3Objectives"
                                wowParent: "AchievementFrameAchievementsContainerButton3"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.horizontalCenterOffset: -2
                                anchors.top: parent.bottom
                                anchors.topMargin: 8
                                width: 340
                                height: -6
                            }
                        }

                        Frame {
                            name: "AchievementFrameAchievementsContainerButton3Highlight"
                            wowParent: "AchievementFrameAchievementsContainerButton3"
                            anchors.left: parent.left
                            anchors.top: parent.top
                            width: 496
                            height: 84
                        }

                        Frame {
                            name: "AchievementFrameAchievementsContainerButton3Icon"
                            wowParent: "AchievementFrameAchievementsContainerButton3"
                            anchors.left: parent.left
                            anchors.leftMargin: 8
                            anchors.top: parent.top
                            anchors.topMargin: 9
                            width: 60
                            height: 60
                        }

                        Frame {
                            name: "AchievementFrameAchievementsContainerButton3Shield"
                            wowParent: "AchievementFrameAchievementsContainerButton3"
                            anchors.right: parent.right
                            anchors.rightMargin: 6
                            anchors.top: parent.top
                            width: 64
                            height: 64

                            FontString {
                                name: "AchievementFrameAchievementsContainerButton3DateCompleted"
                                text: "10/21/26"
                                wowParent: "AchievementFrameAchievementsContainerButton3"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.horizontalCenterOffset: -3
                                anchors.top: parent.bottom
                                anchors.topMargin: -6
                                width: 100
                                height: 14
                            }

                            FontString {
                                name: "AchievementFrameAchievementsContainerButton3ShieldPoints"
                                text: "10"
                                wowParent: "AchievementFrameAchievementsContainerButton3Shield"
                                anchors.right: parent.right
                                anchors.rightMargin: 18
                                anchors.top: parent.top
                                anchors.topMargin: 26
                                width: 32
                                height: 16
                            }
                        }
                    }

                    Button {
                        id: achievementFrameAchievementsContainerButton4
                        name: "AchievementFrameAchievementsContainerButton4"
                        wowParent: "AchievementFrameAchievementsContainerScrollChild"
                        anchors.left: achievementFrameAchievementsContainerButton3.left
                        anchors.top: achievementFrameAchievementsContainerButton3.bottom
                        width: 496
                        height: 84

                        FontString {
                            name: "AchievementFrameAchievementsContainerButton4Description"
                            text: "Obtain a Flimsy Mask during Hallow's End."
                            wowParent: "AchievementFrameAchievementsContainerButton4"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.top
                            anchors.topMargin: 30
                            width: 330
                            height: 30

                            Frame {
                                name: "AchievementFrameAchievementsContainerButton4Objectives"
                                wowParent: "AchievementFrameAchievementsContainerButton4"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.horizontalCenterOffset: -2
                                anchors.top: parent.bottom
                                anchors.topMargin: 8
                                width: 340
                                height: -6
                            }
                        }

                        Frame {
                            name: "AchievementFrameAchievementsContainerButton4Highlight"
                            wowParent: "AchievementFrameAchievementsContainerButton4"
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.topMargin: 80.8
                            width: 496
                            height: 84
                        }

                        Frame {
                            name: "AchievementFrameAchievementsContainerButton4Icon"
                            wowParent: "AchievementFrameAchievementsContainerButton4"
                            anchors.left: parent.left
                            anchors.leftMargin: 8
                            anchors.top: parent.top
                            anchors.topMargin: 9
                            width: 60
                            height: 60
                        }

                        Frame {
                            name: "AchievementFrameAchievementsContainerButton4Shield"
                            wowParent: "AchievementFrameAchievementsContainerButton4"
                            anchors.right: parent.right
                            anchors.rightMargin: 6
                            anchors.top: parent.top
                            width: 64
                            height: 64

                            FontString {
                                name: "AchievementFrameAchievementsContainerButton4DateCompleted"
                                text: "10/18/26"
                                wowParent: "AchievementFrameAchievementsContainerButton4"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.horizontalCenterOffset: -3
                                anchors.top: parent.bottom
                                anchors.topMargin: -6
                                width: 100
                                height: 14
                            }

                            FontString {
                                name: "AchievementFrameAchievementsContainerButton4ShieldPoints"
                                text: "10"
                                wowParent: "AchievementFrameAchievementsContainerButton4Shield"
                                anchors.right: parent.right
                                anchors.rightMargin: 18
                                anchors.top: parent.top
                                anchors.topMargin: 26
                                width: 32
                                height: 16
                            }
                        }
                    }

                    Button {
                        id: achievementFrameAchievementsContainerButton5
                        name: "AchievementFrameAchievementsContainerButton5"
                        wowParent: "AchievementFrameAchievementsContainerScrollChild"
                        anchors.left: achievementFrameAchievementsContainerButton4.left
                        anchors.top: achievementFrameAchievementsContainerButton4.bottom
                        width: 496
                        height: 84

                        FontString {
                            name: "AchievementFrameAchievementsContainerButton5Description"
                            text: "Kill the Headless Horseman."
                            wowParent: "AchievementFrameAchievementsContainerButton5"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.top
                            anchors.topMargin: 30
                            width: 330
                            height: 30

                            Frame {
                                name: "AchievementFrameAchievementsContainerButton5Objectives"
                                wowParent: "AchievementFrameAchievementsContainerButton5"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.horizontalCenterOffset: -2
                                anchors.top: parent.bottom
                                anchors.topMargin: 8
                                width: 340
                                height: -6
                            }
                        }

                        Frame {
                            name: "AchievementFrameAchievementsContainerButton5Icon"
                            wowParent: "AchievementFrameAchievementsContainerButton5"
                            anchors.left: parent.left
                            anchors.leftMargin: 8
                            anchors.top: parent.top
                            anchors.topMargin: 9
                            width: 60
                            height: 60
                        }

                        Frame {
                            name: "AchievementFrameAchievementsContainerButton5Shield"
                            wowParent: "AchievementFrameAchievementsContainerButton5"
                            anchors.right: parent.right
                            anchors.rightMargin: 6
                            anchors.top: parent.top
                            width: 64
                            height: 64

                            FontString {
                                name: "AchievementFrameAchievementsContainerButton5DateCompleted"
                                text: "10/18/26"
                                wowParent: "AchievementFrameAchievementsContainerButton5"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.horizontalCenterOffset: -3
                                anchors.top: parent.bottom
                                anchors.topMargin: -6
                                width: 100
                                height: 14
                            }

                            FontString {
                                name: "AchievementFrameAchievementsContainerButton5ShieldPoints"
                                text: "10"
                                wowParent: "AchievementFrameAchievementsContainerButton5Shield"
                                anchors.right: parent.right
                                anchors.rightMargin: 18
                                anchors.top: parent.top
                                anchors.topMargin: 26
                                width: 32
                                height: 16
                            }
                        }
                    }

                    Button {
                        id: achievementFrameAchievementsContainerButton6
                        name: "AchievementFrameAchievementsContainerButton6"
                        wowParent: "AchievementFrameAchievementsContainerScrollChild"
                        anchors.left: achievementFrameAchievementsContainerButton5.left
                        anchors.top: achievementFrameAchievementsContainerButton5.bottom
                        width: 496
                        height: 84

                        FontString {
                            name: "AchievementFrameAchievementsContainerButton6Description"
                            text: "Complete one of the quests to save a village from the Headless Horseman."
                            wowParent: "AchievementFrameAchievementsContainerButton6"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.top
                            anchors.topMargin: 30
                            width: 330
                            height: 30

                            Frame {
                                name: "AchievementFrameAchievementsContainerButton6Objectives"
                                wowParent: "AchievementFrameAchievementsContainerButton6"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.horizontalCenterOffset: -2
                                anchors.top: parent.bottom
                                anchors.topMargin: 8
                                width: 340
                                height: -6
                            }
                        }

                        Frame {
                            name: "AchievementFrameAchievementsContainerButton6Icon"
                            wowParent: "AchievementFrameAchievementsContainerButton6"
                            anchors.left: parent.left
                            anchors.leftMargin: 8
                            anchors.top: parent.top
                            anchors.topMargin: 9
                            width: 60
                            height: 60
                        }

                        Frame {
                            name: "AchievementFrameAchievementsContainerButton6Shield"
                            wowParent: "AchievementFrameAchievementsContainerButton6"
                            anchors.right: parent.right
                            anchors.rightMargin: 6
                            anchors.top: parent.top
                            width: 64
                            height: 64

                            FontString {
                                name: "AchievementFrameAchievementsContainerButton6DateCompleted"
                                text: "10/18/26"
                                wowParent: "AchievementFrameAchievementsContainerButton6"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.horizontalCenterOffset: -3
                                anchors.top: parent.bottom
                                anchors.topMargin: -6
                                width: 100
                                height: 14
                            }

                            FontString {
                                name: "AchievementFrameAchievementsContainerButton6ShieldPoints"
                                text: "10"
                                wowParent: "AchievementFrameAchievementsContainerButton6Shield"
                                anchors.right: parent.right
                                anchors.rightMargin: 18
                                anchors.top: parent.top
                                anchors.topMargin: 26
                                width: 32
                                height: 16
                            }
                        }
                    }

                    Button {
                        name: "AchievementFrameAchievementsContainerButton7"
                        wowParent: "AchievementFrameAchievementsContainerScrollChild"
                        anchors.left: achievementFrameAchievementsContainerButton6.left
                        anchors.top: achievementFrameAchievementsContainerButton6.bottom
                        width: 496
                        height: 84

                        FontString {
                            name: "AchievementFrameAchievementsContainerButton7Description"
                            text: "Collect the 20 unique Flimsy Masks listed below."
                            wowParent: "AchievementFrameAchievementsContainerButton7"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.top
                            anchors.topMargin: 30
                            width: 330
                            height: 30

                            Frame {
                                name: "AchievementFrameAchievementsContainerButton7Objectives"
                                wowParent: "AchievementFrameAchievementsContainerButton7"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.horizontalCenterOffset: -2
                                anchors.top: parent.bottom
                                anchors.topMargin: 8
                                width: 340
                                height: -6
                            }
                        }

                        Frame {
                            name: "AchievementFrameAchievementsContainerButton7Icon"
                            wowParent: "AchievementFrameAchievementsContainerButton7"
                            anchors.left: parent.left
                            anchors.leftMargin: 8
                            anchors.top: parent.top
                            anchors.topMargin: 9
                            width: 60
                            height: 60
                        }

                        Frame {
                            name: "AchievementFrameAchievementsContainerButton7Shield"
                            wowParent: "AchievementFrameAchievementsContainerButton7"
                            anchors.right: parent.right
                            anchors.rightMargin: 6
                            anchors.top: parent.top
                            width: 64
                            height: 64

                            FontString {
                                name: "AchievementFrameAchievementsContainerButton7DateCompleted"
                                text: "5/26/26"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.horizontalCenterOffset: -3
                                anchors.top: parent.bottom
                                anchors.topMargin: -6
                                width: 42
                                height: 12
                            }

                            FontString {
                                name: "AchievementFrameAchievementsContainerButton7ShieldPoints"
                                text: "20"
                                wowParent: "AchievementFrameAchievementsContainerButton7Shield"
                                anchors.right: parent.right
                                anchors.rightMargin: 18
                                anchors.top: parent.top
                                anchors.topMargin: 26
                                width: 32
                                height: 16
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
                    wowParent: "Overachiever_SearchFrame"
                    anchors.left: parent.left
                    anchors.leftMargin: 4
                    anchors.top: parent.top
                    anchors.topMargin: 3
                    width: 526
                    height: 453

                    Frame {
                        name: "Overachiever_SearchFrameContainerScrollChild"
                        wowParent: "Overachiever_SearchFrameContainer"
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
                    wowParent: "Overachiever_SuggestionsFrame"
                    anchors.left: parent.left
                    anchors.leftMargin: 4
                    anchors.top: parent.top
                    anchors.topMargin: 3
                    width: 526
                    height: 453

                    Frame {
                        name: "Overachiever_SuggestionsFrameContainerScrollChild"
                        wowParent: "Overachiever_SuggestionsFrameContainer"
                        anchors.left: parent.left
                        anchors.top: parent.top
                        width: 504
                        height: 588

                        Button {
                            name: "Overachiever_SuggestionsFrameContainerButton1"
                            wowParent: "Overachiever_SuggestionsFrameContainerScrollChild"
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.topMargin: 2
                            width: 522
                            height: 84

                            FontString {
                                name: "Overachiever_SuggestionsFrameContainerButton1Description"
                                text: "Kill 50 enemy players in any of your home cities."
                                wowParent: "Overachiever_SuggestionsFrameContainerButton1"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.top: parent.top
                                anchors.topMargin: 30
                                width: 330
                                height: 30

                                Frame {
                                    name: "Overachiever_SuggestionsFrameContainerButton1Objectives"
                                    wowParent: "Overachiever_SuggestionsFrameContainerButton1"
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.horizontalCenterOffset: -2
                                    anchors.top: parent.bottom
                                    anchors.topMargin: 7.9
                                    width: 366
                                    height: -8.4
                                }
                            }

                            Frame {
                                name: "Overachiever_SuggestionsFrameContainerButton1Icon"
                                wowParent: "Overachiever_SuggestionsFrameContainerButton1"
                                anchors.left: parent.left
                                anchors.leftMargin: 8
                                anchors.top: parent.top
                                anchors.topMargin: 9
                                width: 60
                                height: 60
                            }

                            Frame {
                                name: "Overachiever_SuggestionsFrameContainerButton1Shield"
                                wowParent: "Overachiever_SuggestionsFrameContainerButton1"
                                anchors.right: parent.right
                                anchors.rightMargin: 6
                                anchors.top: parent.top
                                width: 64
                                height: 64

                                FontString {
                                    name: "Overachiever_SuggestionsFrameContainerButton1ShieldPoints"
                                    text: "10"
                                    wowParent: "Overachiever_SuggestionsFrameContainerButton1Shield"
                                    anchors.right: parent.right
                                    anchors.rightMargin: 18
                                    anchors.top: parent.top
                                    anchors.topMargin: 26
                                    width: 32
                                    height: 16
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
                    wowParent: "Overachiever_WatchFrame"
                    anchors.left: parent.left
                    anchors.leftMargin: 4
                    anchors.top: parent.top
                    anchors.topMargin: 3
                    width: 526
                    height: 453

                    Frame {
                        name: "Overachiever_WatchFrameContainerScrollChild"
                        wowParent: "Overachiever_WatchFrameContainer"
                        anchors.left: parent.left
                        anchors.top: parent.top
                        width: 504
                        height: 588
                    }
                }
            }
        }

        ScrollFrame {
            name: "AchievementFrameCategoriesContainer"
            wowParent: "AchievementFrameCategories"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 5
            width: 197
            height: 451

            Slider {
                name: "AchievementFrameCategoriesContainerScrollBar"
                wowParent: "AchievementFrameCategoriesContainer"
                anchors.left: parent.right
                anchors.leftMargin: -21
                anchors.top: parent.top
                anchors.topMargin: 14
                width: 20
                height: 425

                Button {
                    name: "AchievementFrameCategoriesContainerScrollBarScrollDownButton"
                    wowParent: "AchievementFrameCategoriesContainerScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    anchors.topMargin: -2
                    width: 16
                    height: 16
                }

                Button {
                    name: "AchievementFrameCategoriesContainerScrollBarScrollUpButton"
                    wowParent: "AchievementFrameCategoriesContainerScrollBar"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.top
                    anchors.bottomMargin: -2
                    width: 16
                    height: 16

                    Frame {
                        name: "AchievementFrameCategoriesContainerScrollBarDiabolicTrack"
                        wowParent: "AchievementFrameCategoriesContainerScrollBar"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: -1
                        width: 18
                        height: 455
                    }
                }
            }

            Frame {
                name: "AchievementFrameCategoriesContainerScrollChild"
                wowParent: "AchievementFrameCategoriesContainer"
                anchors.left: parent.left
                anchors.top: parent.top
                width: 197
                height: 480

                Button {
                    name: "AchievementFrameCategoriesContainerButton1"
                    wowParent: "AchievementFrameCategoriesContainerScrollChild"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    width: 187
                    height: 24

                    FontString {
                        name: "AchievementFrameCategoriesContainerButton1Label"
                        text: "Summary"
                        wowParent: "AchievementFrameCategoriesContainerButton1"
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
            name: "AchievementFrameStats"
            wowParent: "AchievementFrame"
            anchors.left: parent.right
            anchors.top: parent.top
            width: 504
            height: 461

            Frame {
                name: "AchievementFrameStatsBG"
                wowParent: "AchievementFrameStats"
                anchors.left: parent.left
                anchors.leftMargin: 2
                anchors.top: parent.top
                width: 526
                height: 458
            }

            ScrollFrame {
                name: "AchievementFrameStatsContainer"
                wowParent: "AchievementFrameStats"
                anchors.left: parent.left
                anchors.leftMargin: 3
                anchors.top: parent.top
                anchors.topMargin: 3
                width: 501
                height: 453

                Slider {
                    name: "AchievementFrameStatsContainerScrollBar"
                    wowParent: "AchievementFrameStatsContainer"
                    style: "ScrollBar"
                    anchors.left: parent.right
                    anchors.leftMargin: 1
                    anchors.top: parent.top
                    anchors.topMargin: 16
                    width: 20
                    height: 425

                    Button {
                        name: "AchievementFrameStatsContainerScrollBarScrollDownButton"
                        wowParent: "AchievementFrameStatsContainerScrollBar"
                        style: "ScrollBar"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.bottom
                        anchors.topMargin: -2
                        width: 16
                        height: 16
                    }

                    Button {
                        name: "AchievementFrameStatsContainerScrollBarScrollUpButton"
                        wowParent: "AchievementFrameStatsContainerScrollBar"
                        style: "ScrollBar"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.top
                        anchors.bottomMargin: -2
                        width: 16
                        height: 16

                        Frame {
                            name: "AchievementFrameStatsContainerScrollBarDiabolicTrack"
                            wowParent: "AchievementFrameStatsContainerScrollBar"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.top
                            anchors.topMargin: -1
                            width: 18
                            height: 455
                        }
                    }
                }

                Frame {
                    name: "AchievementFrameStatsContainerScrollChild"
                    wowParent: "AchievementFrameStatsContainer"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 503
                    height: 480

                    Button {
                        name: "AchievementFrameStatsContainerButton1"
                        wowParent: "AchievementFrameStatsContainerScrollChild"
                        anchors.left: parent.left
                        anchors.top: parent.top
                        width: 496
                        height: 24

                        FontString {
                            name: "AchievementFrameStatsContainerButton1Title"
                            text: "Summary"
                            wowParent: "AchievementFrameStatsContainerButton1"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            width: 74.3
                            height: 15.8
                        }

                        FontString {
                            name: "AchievementFrameStatsContainerButton1Value"
                            wowParent: "AchievementFrameStatsContainerButton1"
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
            wowParent: "AchievementFrame"
            anchors.left: parent.right
            anchors.top: parent.top
            width: 530
            height: 461

            Frame {
                name: "AchievementFrameSummaryAchievements"
                wowParent: "AchievementFrameSummary"
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.top: parent.top
                anchors.topMargin: 20
                width: 520
                height: 210

                Frame {
                    name: "AchievementFrameSummaryAchievementsHeader"
                    wowParent: "AchievementFrameSummaryAchievements"
                    style: "Section"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: 520
                    height: 20

                    Button {
                        id: achievementFrameSummaryAchievement1
                        name: "AchievementFrameSummaryAchievement1"
                        wowParent: "AchievementFrameSummaryAchievements"
                        anchors.left: parent.left
                        anchors.leftMargin: 18
                        anchors.top: parent.bottom
                        anchors.topMargin: -2
                        width: 484
                        height: 48

                        FontString {
                            name: "AchievementFrameSummaryAchievement1DateCompleted"
                            text: "10/30/26"
                            wowParent: "AchievementFrameSummaryAchievement1"
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
                            wowParent: "AchievementFrameSummaryAchievement1"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.top
                            anchors.topMargin: 30
                            width: 380
                            height: 13
                        }

                        Frame {
                            name: "AchievementFrameSummaryAchievement1Highlight"
                            wowParent: "AchievementFrameSummaryAchievement1"
                            anchors.left: parent.left
                            anchors.top: parent.top
                            width: 484
                            height: 48
                        }

                        Frame {
                            name: "AchievementFrameSummaryAchievement1Icon"
                            wowParent: "AchievementFrameSummaryAchievement1"
                            anchors.left: parent.left
                            anchors.leftMargin: 3
                            anchors.top: parent.top
                            anchors.topMargin: 3
                            width: 48
                            height: 48
                        }

                        Frame {
                            name: "AchievementFrameSummaryAchievement1Shield"
                            wowParent: "AchievementFrameSummaryAchievement1"
                            anchors.right: parent.right
                            anchors.rightMargin: 10
                            anchors.top: parent.top
                            anchors.topMargin: 4
                            width: 48
                            height: 48

                            FontString {
                                name: "AchievementFrameSummaryAchievement1ShieldPoints"
                                text: "10"
                                wowParent: "AchievementFrameSummaryAchievement1Shield"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.horizontalCenterOffset: -1
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.verticalCenterOffset: -3
                                width: 40
                                height: 26
                            }
                        }
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

                        FontString {
                            name: "AchievementFrameSummaryAchievement2DateCompleted"
                            text: "10/30/26"
                            wowParent: "AchievementFrameSummaryAchievement2"
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
                            wowParent: "AchievementFrameSummaryAchievement2"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.top
                            anchors.topMargin: 30
                            width: 380
                            height: 13
                        }

                        Frame {
                            name: "AchievementFrameSummaryAchievement2Icon"
                            wowParent: "AchievementFrameSummaryAchievement2"
                            anchors.left: parent.left
                            anchors.leftMargin: 3
                            anchors.top: parent.top
                            anchors.topMargin: 3
                            width: 48
                            height: 48
                        }

                        Frame {
                            name: "AchievementFrameSummaryAchievement2Shield"
                            wowParent: "AchievementFrameSummaryAchievement2"
                            anchors.right: parent.right
                            anchors.rightMargin: 10
                            anchors.top: parent.top
                            anchors.topMargin: 4
                            width: 48
                            height: 48

                            FontString {
                                name: "AchievementFrameSummaryAchievement2ShieldPoints"
                                text: "10"
                                wowParent: "AchievementFrameSummaryAchievement2Shield"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.horizontalCenterOffset: -1
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.verticalCenterOffset: -3
                                width: 40
                                height: 26
                            }
                        }
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

                        FontString {
                            name: "AchievementFrameSummaryAchievement3DateCompleted"
                            text: "10/30/26"
                            wowParent: "AchievementFrameSummaryAchievement3"
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
                            wowParent: "AchievementFrameSummaryAchievement3"
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
                            wowParent: "AchievementFrameSummaryAchievement3"
                            anchors.left: parent.left
                            anchors.leftMargin: 3
                            anchors.top: parent.top
                            anchors.topMargin: 3
                            width: 48
                            height: 48
                        }

                        Frame {
                            name: "AchievementFrameSummaryAchievement3Shield"
                            wowParent: "AchievementFrameSummaryAchievement3"
                            anchors.right: parent.right
                            anchors.rightMargin: 10
                            anchors.top: parent.top
                            anchors.topMargin: 4
                            width: 48
                            height: 48

                            FontString {
                                name: "AchievementFrameSummaryAchievement3ShieldPoints"
                                text: "10"
                                wowParent: "AchievementFrameSummaryAchievement3Shield"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.horizontalCenterOffset: -1
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.verticalCenterOffset: -3
                                width: 40
                                height: 26
                            }
                        }
                    }

                    Button {
                        name: "AchievementFrameSummaryAchievement4"
                        wowParent: "AchievementFrameSummaryAchievements"
                        anchors.left: achievementFrameSummaryAchievement3.left
                        anchors.top: achievementFrameSummaryAchievement3.bottom
                        anchors.topMargin: -3
                        width: 484
                        height: 48

                        FontString {
                            name: "AchievementFrameSummaryAchievement4DateCompleted"
                            text: "10/30/26"
                            wowParent: "AchievementFrameSummaryAchievement4"
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
                            wowParent: "AchievementFrameSummaryAchievement4"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.top
                            anchors.topMargin: 30
                            width: 380
                            height: 13
                        }

                        Frame {
                            name: "AchievementFrameSummaryAchievement4Highlight"
                            wowParent: "AchievementFrameSummaryAchievement4"
                            anchors.left: parent.left
                            anchors.top: parent.top
                            width: 484
                            height: 48
                        }

                        Frame {
                            name: "AchievementFrameSummaryAchievement4Icon"
                            wowParent: "AchievementFrameSummaryAchievement4"
                            anchors.left: parent.left
                            anchors.leftMargin: 3
                            anchors.top: parent.top
                            anchors.topMargin: 3
                            width: 48
                            height: 48
                        }

                        Frame {
                            name: "AchievementFrameSummaryAchievement4Shield"
                            wowParent: "AchievementFrameSummaryAchievement4"
                            anchors.right: parent.right
                            anchors.rightMargin: 10
                            anchors.top: parent.top
                            anchors.topMargin: 4
                            width: 48
                            height: 48

                            FontString {
                                name: "AchievementFrameSummaryAchievement4ShieldPoints"
                                text: "10"
                                wowParent: "AchievementFrameSummaryAchievement4Shield"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.horizontalCenterOffset: -1
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.verticalCenterOffset: -3
                                width: 40
                                height: 26
                            }
                        }
                    }

                    FontString {
                        name: "AchievementFrameSummaryAchievementsHeaderTitle"
                        text: "Recent Achievements"
                        wowParent: "AchievementFrameSummaryAchievementsHeader"
                        anchors.left: parent.left
                        anchors.leftMargin: 28
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: -1
                        width: 158.8
                        height: 20
                    }
                }

                Frame {
                    name: "AchievementFrameSummaryCategories"
                    wowParent: "AchievementFrameSummary"
                    anchors.left: parent.left
                    anchors.top: parent.bottom
                    anchors.topMargin: 8
                    width: 520
                    height: 164

                    Frame {
                        name: "AchievementFrameSummaryCategoriesHeader"
                        wowParent: "AchievementFrameSummaryCategories"
                        style: "Section"
                        anchors.left: parent.left
                        anchors.top: parent.top
                        width: 520
                        height: 20

                        FontString {
                            name: "AchievementFrameSummaryCategoriesHeaderTitle"
                            text: "Progress Overview"
                            wowParent: "AchievementFrameSummaryCategoriesHeader"
                            anchors.left: parent.left
                            anchors.leftMargin: 28
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.verticalCenterOffset: -1
                            width: 143.8
                            height: 20
                        }

                        StatusBar {
                            name: "AchievementFrameSummaryCategoriesStatusBar"
                            wowParent: "AchievementFrameSummaryCategories"
                            style: "Bar"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.bottom
                            anchors.topMargin: 6
                            width: 472
                            height: 16

                            StatusBar {
                                name: "AchievementFrameSummaryCategoriesCategory1"
                                wowParent: "AchievementFrameSummaryCategories"
                                style: "Bar"
                                anchors.left: parent.left
                                anchors.top: parent.bottom
                                anchors.topMargin: 24
                                width: 224
                                height: 16

                                Button {
                                    name: "AchievementFrameSummaryCategoriesCategory1Button"
                                    wowParent: "AchievementFrameSummaryCategoriesCategory1"
                                    anchors.left: parent.left
                                    anchors.top: parent.top
                                    width: 224
                                    height: 16
                                }

                                FontString {
                                    name: "AchievementFrameSummaryCategoriesCategory1Label"
                                    text: "General"
                                    wowParent: "AchievementFrameSummaryCategoriesCategory1"
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
                                    wowParent: "AchievementFrameSummaryCategoriesCategory1"
                                    anchors.right: parent.right
                                    anchors.rightMargin: 8
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: 30.8
                                    height: 14
                                }
                            }

                            FontString {
                                name: "AchievementFrameSummaryCategoriesStatusBarText"
                                text: "330/1058"
                                wowParent: "AchievementFrameSummaryCategoriesStatusBar"
                                anchors.right: parent.right
                                anchors.rightMargin: 8
                                anchors.verticalCenter: parent.verticalCenter
                                width: 49
                                height: 14
                            }

                            FontString {
                                name: "AchievementFrameSummaryCategoriesStatusBarTitle"
                                text: "Achievements Earned"
                                wowParent: "AchievementFrameSummaryCategoriesStatusBar"
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
            }
        }

        Frame {
            name: "Overachiever_LeftFrame"
            wowParent: "AchievementFrameCategories"
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

            Frame {
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

                EditBox {
                    name: "Overachiever_SearchFrameNameEdit"
                    wowParent: "?"
                    anchors.left: parent.left
                    anchors.leftMargin: 22
                    anchors.top: parent.bottom
                    anchors.topMargin: 19
                    width: 170
                    height: 16

                    EditBox {
                        name: "Overachiever_SearchFrameDescEdit"
                        wowParent: "?"
                        anchors.left: parent.left
                        anchors.top: parent.bottom
                        anchors.topMargin: 23
                        width: 170
                        height: 16

                        EditBox {
                            name: "Overachiever_SearchFrameCriteriaEdit"
                            wowParent: "?"
                            anchors.left: parent.left
                            anchors.top: parent.bottom
                            anchors.topMargin: 23
                            width: 170
                            height: 16

                            EditBox {
                                name: "Overachiever_SearchFrameRewardEdit"
                                wowParent: "?"
                                anchors.left: parent.left
                                anchors.top: parent.bottom
                                anchors.topMargin: 23
                                width: 170
                                height: 16

                                EditBox {
                                    name: "Overachiever_SearchFrameAnyEdit"
                                    wowParent: "?"
                                    anchors.left: parent.left
                                    anchors.top: parent.bottom
                                    anchors.topMargin: 23
                                    width: 170
                                    height: 16

                                    CheckButton {
                                        name: "Overachiever_SearchFrameFullListCheckbox"
                                        wowParent: "?"
                                        anchors.left: parent.left
                                        anchors.leftMargin: -8
                                        anchors.top: parent.bottom
                                        anchors.topMargin: 12
                                        width: 26
                                        height: 26

                                        FontString {
                                            name: "Overachiever_SearchFrameFullListCheckboxText"
                                            text: "Search all achievements"
                                            wowParent: "Overachiever_SearchFrameFullListCheckbox"
                                            anchors.left: parent.right
                                            anchors.verticalCenter: parent.verticalCenter
                                            anchors.verticalCenterOffset: -1
                                            width: 141.4
                                            height: 11.9
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                Frame {
                    name: "Overachiever_SearchFrameSortDropDiabolicField"
                    wowParent: "Overachiever_SearchFrameSortDrop"
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
                    wowParent: "Overachiever_SearchFrameSortDrop"
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    anchors.bottom: parent.top
                    anchors.bottomMargin: 3
                    width: 45.8
                    height: 11.9
                }
            }

            Frame {
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
                    wowParent: "Overachiever_SuggestionsFrameSortDrop"
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
                    wowParent: "Overachiever_SuggestionsFrameSortDrop"
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    anchors.bottom: parent.top
                    anchors.bottomMargin: 3
                    width: 45.8
                    height: 11.9
                }

                EditBox {
                    name: "Overachiever_SuggestionsFrameZoneOverrideEdit"
                    wowParent: "?"
                    anchors.left: parent.left
                    anchors.leftMargin: 22
                    anchors.top: parent.bottom
                    anchors.topMargin: 19
                    width: 170
                    height: 16

                    Frame {
                        name: "Overachiever_SuggestionsFrameSubzoneDrop"
                        text: "(unspecified)"
                        wowParent: "?"
                        style: "DropDown"
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.horizontalCenterOffset: -24
                        anchors.top: parent.bottom
                        anchors.topMargin: 21
                        width: 166
                        height: 32

                        Frame {
                            name: "Overachiever_SuggestionsFrameSubzoneDropDiabolicField"
                            wowParent: "Overachiever_SuggestionsFrameSubzoneDrop"
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
                            wowParent: "Overachiever_SuggestionsFrameSubzoneDrop"
                            anchors.left: parent.left
                            anchors.leftMargin: 16
                            anchors.bottom: parent.top
                            anchors.bottomMargin: 3
                            width: 53.7
                            height: 11.9
                        }
                    }
                }
            }

            Frame {
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

                CheckButton {
                    name: "Overachiever_WatchFrameCopyDestCheckbox"
                    wowParent: "?"
                    anchors.left: parent.left
                    anchors.leftMargin: 14
                    anchors.top: parent.bottom
                    anchors.topMargin: 12
                    width: 26
                    height: 26

                    FontString {
                        name: "Overachiever_WatchFrameCopyDestCheckboxText"
                        text: "Copy To:"
                        wowParent: "Overachiever_WatchFrameCopyDestCheckbox"
                        anchors.left: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: -1
                        width: 52.9
                        height: 11.9
                    }

                    Frame {
                        name: "Overachiever_WatchFrameDestinationListDrop"
                        text: "Global"
                        wowParent: "?"
                        style: "DropDown"
                        anchors.left: parent.left
                        anchors.leftMargin: -14
                        anchors.top: parent.bottom
                        anchors.topMargin: -2
                        width: 166
                        height: 32

                        Frame {
                            name: "Overachiever_WatchFrameDestinationListDropDiabolicField"
                            wowParent: "Overachiever_WatchFrameDestinationListDrop"
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
                }

                Frame {
                    name: "Overachiever_WatchFrameDefListDropDiabolicField"
                    wowParent: "Overachiever_WatchFrameDefListDrop"
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
                    wowParent: "Overachiever_WatchFrameDefListDrop"
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    anchors.bottom: parent.top
                    anchors.bottomMargin: 3
                    width: 71.9
                    height: 11.9
                }
            }

            Frame {
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
                    name: "Overachiever_WatchFrameListDrop"
                    text: "Global"
                    wowParent: "?"
                    style: "DropDown"
                    anchors.left: parent.left
                    anchors.top: parent.bottom
                    anchors.topMargin: 18
                    width: 166
                    height: 32

                    Frame {
                        name: "Overachiever_WatchFrameListDropDiabolicField"
                        wowParent: "Overachiever_WatchFrameListDrop"
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
                        wowParent: "Overachiever_WatchFrameListDrop"
                        anchors.left: parent.left
                        anchors.leftMargin: 16
                        anchors.bottom: parent.top
                        anchors.bottomMargin: 3
                        width: 87.7
                        height: 11.9
                    }
                }

                Frame {
                    name: "Overachiever_WatchFrameSortDropDiabolicField"
                    wowParent: "Overachiever_WatchFrameSortDrop"
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
                    wowParent: "Overachiever_WatchFrameSortDrop"
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
        name: "AchievementFrameDiabolic"
        wowParent: "AchievementFrame"
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
            wowParent: "AchievementFrameDiabolic"
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
                    wowParent: "AchievementFrameFilterDropDown"
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
                wowParent: "AchievementFrameDiabolicBand"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: 107.4
                height: 38

                FontString {
                    name: "AchievementFrameHeaderPoints"
                    text: "3460"
                    wowParent: "AchievementFrameHeaderPointsDiabolicCartouche"
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
            wowParent: "AchievementFrameDiabolic"
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
                    wowParent: "AchievementFrameDiabolicTitlePlate"
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
            wowParent: "AchievementFrameDiabolic"
            anchors.left: parent.left
            anchors.leftMargin: 18
            anchors.top: parent.bottom
            anchors.topMargin: -19
            width: 304
            height: 18
        }

        Frame {
            name: "AchievementFrameDiabolicSocket"
            wowParent: "AchievementFrameDiabolic"
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 20
            width: 42
            height: 42
        }

        Button {
            name: "AchievementFrameTab1"
            text: "Achievements"
            wowParent: "AchievementFrame"
            style: "Banner"
            anchors.left: parent.left
            anchors.leftMargin: 28
            anchors.top: parent.bottom
            anchors.topMargin: -23
            width: 52
            height: 116
        }

        Button {
            name: "AchievementFrameTab2"
            text: "Statistics"
            wowParent: "AchievementFrame"
            style: "Banner"
            anchors.left: parent.left
            anchors.leftMargin: 86
            anchors.top: parent.bottom
            anchors.topMargin: -23
            width: 52
            height: 116
        }

        Button {
            name: "AchievementFrameTab3"
            text: "Search"
            wowParent: "AchievementFrame"
            style: "Banner"
            anchors.left: parent.left
            anchors.leftMargin: 144
            anchors.top: parent.bottom
            anchors.topMargin: -23
            width: 52
            height: 116
        }

        Button {
            name: "AchievementFrameTab4"
            text: "Suggestions"
            wowParent: "AchievementFrame"
            style: "Banner"
            anchors.left: parent.left
            anchors.leftMargin: 202
            anchors.top: parent.bottom
            anchors.topMargin: -23
            width: 52
            height: 116
        }

        Button {
            name: "AchievementFrameTab5"
            text: "Watch"
            wowParent: "AchievementFrame"
            style: "Banner"
            anchors.left: parent.left
            anchors.leftMargin: 260
            anchors.top: parent.bottom
            anchors.topMargin: -23
            width: 52
            height: 116
        }
    }

    Ghost {
        name: "AchievementFrameAchievementsContainerButton1RewardBackground"
        x: 470
        y: 86
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
        x: 470
        y: -57
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

    Ghost {
        name: "AchievementFrameAchievementsContainerButton2RewardBackground"
        x: 483
        y: 170
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
        x: 470
        y: 32.2
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

    Ghost {
        name: "AchievementFrameAchievementsContainerButton3RewardBackground"
        x: 470
        y: 254
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
        x: 470
        y: 116.2
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

    Ghost {
        name: "AchievementFrameAchievementsContainerButton4RewardBackground"
        x: 483
        y: 338
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
        x: 470
        y: 200.2
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

    Ghost {
        name: "AchievementFrameAchievementsContainerButton5RewardBackground"
        x: 470
        y: 422
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
        x: 470
        y: 284.2
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

    Ghost {
        name: "AchievementFrameAchievementsContainerButton6RewardBackground"
        x: 470
        y: 506
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
        x: 470
        y: 368.2
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

    Ghost {
        name: "AchievementFrameAchievementsContainerButton7RewardBackground"
        x: 470
        y: 590
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
        x: 470
        y: 452.2
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

    Ghost {
        name: "AchievementFrameCriteria1Check"
        x: 323
        y: -3.2
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

    Ghost {
        name: "AchievementFrameCriteria2Check"
        x: 488
        y: -3.2
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

    Ghost {
        name: "AchievementFrameSummaryAchievement1TitleBackground"
        x: 483
        y: 62
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

    Ghost {
        name: "AchievementFrameSummaryAchievement2TitleBackground"
        x: 483
        y: 107
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

    Ghost {
        name: "AchievementFrameSummaryAchievement3TitleBackground"
        x: 483
        y: 152
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

    Ghost {
        name: "AchievementFrameSummaryAchievement4TitleBackground"
        x: 483
        y: 197
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

    Ghost {
        name: "Overachiever_SuggestionsFrameContainerButton1TitleBackground"
        x: 483
        y: 29
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
