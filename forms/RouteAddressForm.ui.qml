

/****************************************************************************
**
** Copyright (C) 2017 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/
import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2

Item {
    id: element
    property alias goButton: goButton
    property alias clearButton: clearButton
    property alias cancelButton: cancelButton
    property alias query: query
    property alias slider: slider
    property alias toState: toState
    property alias fromCity: fromCity
    property alias fromState: fromState
    property alias fromStreet: fromStreet
    property alias toStreet: toStreet
    property alias toCity: toCity


    Image {
        id: image
        anchors.fill: parent
        z: -3
        source: "../resources/Screen Shot 2019-04-13 at 7.37.29 PM.png"
        fillMode: Image.Stretch
    }

    Image {
        id: rect
        x: -6
        y: 74
        width: 654
        height: 271
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        source: "../resources/rectangleFORM.png"
        fillMode: Image.Stretch

        ColumnLayout {
            id: columnLayout
            x: 26
            y: 8
            width: 600
            height: 234
            spacing: 6.5

            Image {
                id: image1
                width: 399
                height: 242
                transformOrigin: Item.Center
                Layout.fillWidth: false
                Layout.fillHeight: false
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.maximumHeight: 70
                Layout.maximumWidth: 400
                source: "../resources/meetmehalfway.png"
                fillMode: Image.PreserveAspectFit
            }

            Label {
                id: label1
                text: qsTr("Address One")
                anchors.horizontalCenterOffset: 8
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
                Layout.columnSpan: 2
            }


            RowLayout {
                id: addressOneLayout
                width: 589
                height: 34
                Label {
                    id: label4
                    text: qsTr("Street")
                }

                TextField {
                    id: fromStreet
                    width: 280
                    Layout.preferredWidth: 280
                    Layout.fillWidth: false
                }

                Label {
                    id: label5
                    height: 16
                    text: qsTr("City")
                    elide: Text.ElideRight
                }

                TextField {
                    id: fromCity
                    width: 80
                    Layout.preferredWidth: 80
                    Layout.fillWidth: false
                }

                Label {
                    id: label8
                    text: qsTr("State")
                }

                TextField {
                    id: fromState
                    width: 80
                    Layout.fillWidth: true
                }
            }

            Label {
                id: label6
                text: qsTr("Address Two")
                anchors.horizontalCenterOffset: 9
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
                Layout.columnSpan: 2
            }

            RowLayout {
                id: addressTwoLayout
                width: 589
                height: 34

                Label {
                    id: label2
                    text: qsTr("Street")
                }




                TextField {
                    id: toStreet
                    width: 280
                    Layout.preferredWidth: 280
                    Layout.fillWidth: false
                }



                Label {
                    id: label3
                    height: 16
                    text: qsTr("City")
                    elide: Text.ElideRight
                }

                TextField {
                    id: toCity
                    width: 80
                    Layout.preferredWidth: 80
                    Layout.fillWidth: false
                }

                Label {
                    id: label7
                    text: qsTr("State")
                }

                TextField {
                    id: toState
                    width: 80
                    Layout.fillWidth: true
                }


            }

            RowLayout {
                id: searchLayout
                width: 589
                height: 34
                spacing: 4.2


                Label {
                    id: label9
                    text: qsTr("Search")
                }

                TextField {
                    id: query
                    width: 280
                    Layout.fillWidth: true
                }

                Label {
                    id: label10
                    text: qsTr("Radius (m)")
                }


                Slider {
                    id: slider
                    width: 156
                    height: 22
                    Layout.fillWidth: true
                    tickmarksEnabled: false
                    stepSize: 50
                    minimumValue: 100
                    value: 100
                    maximumValue: 10000

                }

                Text {
                    id: sliderText
                    font.pixelSize: 12
                    text: slider.value
                }

            }

            RowLayout {
                id: buttonLayout
                width: 273
                height: 65
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter

                Button {
                    id: goButton
                    text: qsTr("Proceed")
                }

                Button {
                    id: clearButton
                    text: qsTr("Clear")
                }

                Button {
                    id: cancelButton
                    text: qsTr("Cancel")
                }
            }



        }







    }
}
























/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:2;anchors_height:271;anchors_width:654;anchors_x:-6;anchors_y:74}
}
 ##^##*/
