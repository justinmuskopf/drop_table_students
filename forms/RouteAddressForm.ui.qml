

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
    property alias toStreet: toStreet
    property alias toCity: toCity
    property alias fromCity: fromCity
    property alias goButton: goButton
    property alias clearButton: clearButton
    property alias cancelButton: cancelButton
    property alias toState: toState
    property alias fromState: fromState
    property alias fromStreet: fromStreet

    Rectangle {
        id: tabRectangle
        y: 20
        height: tabTitle.height * 2
        color: "#46a2da"
        visible: false
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.left: parent.left
        anchors.right: parent.right

        Label {
            id: tabTitle
            color: "#ffffff"
            text: qsTr("Route Address")
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Item {
        id: item2
        anchors.rightMargin: 20
        anchors.leftMargin: 20
        anchors.bottomMargin: 20
        anchors.topMargin: 20
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: tabRectangle.bottom

        Image {
            id: rect
            x: -20
            y: 32
            width: 636
            height: 241
            source: "../resources/rectangleFORM.png"
            fillMode: Image.PreserveAspectFit
        }

        Label {
            id: label1
            x: 258
            y: 116
            text: qsTr("Address One")
            anchors.horizontalCenterOffset: 8
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            Layout.columnSpan: 2
        }


        Item {
            x: -12
            y: 315
            Layout.fillHeight: true
            Layout.columnSpan: 2
        }

        Button {
            id: cancelButton
            x: 355
            y: 211
            text: qsTr("Cancel")
        }

        Button {
            id: clearButton
            x: 283
            y: 211
            text: qsTr("Clear")
        }

        Button {
            id: goButton
            x: 192
            y: 211
            text: qsTr("Proceed")
        }

        RowLayout {
            id: rowLayout1
            x: 371
            y: 279
            Layout.columnSpan: 2
            Layout.alignment: Qt.AlignRight
        }


        TextField {
            id: toState
            x: 512
            y: 183
            width: 80
            Layout.fillWidth: true
        }

        Label {
            id: label8
            x: 469
            y: 186
            text: qsTr("State")
        }

        TextField {
            id: toCity
            x: 373
            y: 183
            width: 80
            Layout.fillWidth: true
        }


        Label {
            id: label5
            x: 343
            y: 186
            text: qsTr("City")
        }

        TextField {
            id: toStreet
            x: 52
            y: 183
            width: 280
            Layout.fillWidth: true
        }

        Label {
            id: label4
            x: 8
            y: 186
            text: qsTr("Street")
        }


        Label {
            id: label6
            x: 257
            y: 166
            text: qsTr("Address Two")
            anchors.horizontalCenterOffset: 9
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            Layout.columnSpan: 2
        }

        TextField {
            id: fromState
            x: 512
            y: 138
            width: 80
            Layout.fillWidth: true
        }

        Label {
            id: label7
            x: 469
            y: 141
            text: qsTr("State")
        }

        TextField {
            id: fromCity
            x: 373
            y: 138
            width: 80
            Layout.preferredWidth: 80
            Layout.fillWidth: false
        }


        Label {
            id: label3
            x: 343
            y: 141
            height: 16
            text: qsTr("City")
            elide: Text.ElideRight
        }

        TextField {
            id: fromStreet
            x: 50
            y: 138
            width: 280
            Layout.preferredWidth: 280
            Layout.fillWidth: false
        }

        Label {
            id: label2
            x: 8
            y: 141
            text: qsTr("Street")
        }

        Image {
            id: image1
            x: 109
            y: -41
            width: 399
            height: 242
            source: "../resources/meetmehalfway.png"
            fillMode: Image.PreserveAspectFit
        }

    }

    Image {
        id: image
        anchors.fill: parent
        z: -3
        source: "../resources/Screen Shot 2019-04-13 at 7.37.29 PM.png"
        fillMode: Image.PreserveAspectFit
    }
}










/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:24;anchors_height:242;anchors_width:399;anchors_x:109;anchors_y:-41}
D{i:25;anchors_height:508;anchors_width:672;anchors_x:-22;anchors_y:0}
}
 ##^##*/
