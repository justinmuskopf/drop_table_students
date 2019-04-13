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
import QtLocation 5.6
import QtPositioning 5.5

RouteAddressForm {
    property alias plugin : tempGeocodeModel.plugin;
    property variant fromAddress;
    property variant toAddress;

    signal showMessage(string topic, string message)
    signal showRoute(variant startCoordinate,variant endCoordinate)
    signal closeForm()
    //signal addressesChanged(var _fromAddress, var _fromCoordinate, var _toAddress, var _toCoordinate)
    signal addressesChanged(var _fromLocation, var _toLocation)
    Location {
        id: startLocation
    }

    Location {
        id: endLocation
    }

    goButton.onClicked: {
        tempGeocodeModel.reset()
        fromAddress.state =  fromState.text
        fromAddress.street = fromStreet.text
        fromAddress.city =  fromCity.text
        toAddress.state = toState.text
        toAddress.street = toStreet.text
        toAddress.city = toCity.text
        tempGeocodeModel.startCoordinate = QtPositioning.coordinate()
        tempGeocodeModel.endCoordinate = QtPositioning.coordinate()
        tempGeocodeModel.query = fromAddress
        tempGeocodeModel.update();
        goButton.enabled = false;
    }

    clearButton.onClicked: {
        fromStreet.text = ""
        fromCity.text = ""
        fromCountry.text = ""
        toStreet.text = ""
        toCity.text = ""
        toCountry.text = ""
    }

    cancelButton.onClicked: {
        closeForm()
    }

    Component.onCompleted: {
        fromStreet.text  = fromAddress.street
        fromCity.text =  fromAddress.city
        fromState.text = fromAddress.state
        toStreet.text = toAddress.street
        toCity.text = toAddress.city
        toState.text = toAddress.state
    }

    GeocodeModel {
        id: tempGeocodeModel

        property int success: 0
        property variant startCoordinate
        property variant endCoordinate

        onCountChanged: {
            if (success == 1 && count == 1) {
                query = toAddress
                update();
            }
        }

        onStatusChanged: {
            if ((status == GeocodeModel.Ready) && (count == 1)) {
                success++
                if (success == 1) {
                    startCoordinate.latitude = get(0).coordinate.latitude
                    startCoordinate.longitude = get(0).coordinate.longitude
                }
                if (success == 2) {
                    endCoordinate.latitude = get(0).coordinate.latitude
                    endCoordinate.longitude = get(0).coordinate.longitude

                    success = 0
                    if (startCoordinate.isValid && endCoordinate.isValid) {

                        startLocation.coordinate = startCoordinate
                        startLocation.address = fromAddress

                        endLocation.coordinate = endCoordinate
                        endLocation.address = toAddress

                        addressesChanged(startLocation, endLocation)
                        //addressesChanged(fromAddress, startCoordinate, toAddress, endCoordinate)
                        showRoute(startCoordinate,endCoordinate)
                    }
                    else
                        goButton.enabled = true
                }
            } else if ((status == GeocodeModel.Ready) || (status == GeocodeModel.Error)) {
                var st = (success == 0 ) ? "start" : "end"
                success = 0
                if ((status == GeocodeModel.Ready) && (count == 0 )) {
                    showMessage(qsTr("Geocode Error"),qsTr("Unsuccessful geocode"));
                    goButton.enabled = true;
                }
                else if (status == GeocodeModel.Error) {
                    showMessage(qsTr("Geocode Error"),
                                qsTr("Unable to find location for the") + " " +
                                st + " " +qsTr("point"))
                    goButton.enabled = true;
                }
                else if ((status == GeocodeModel.Ready) && (count > 1 )) {
                    showMessage(qsTr("Ambiguous geocode"),
                                count + " " + qsTr("results found for the") +
                                " " + st + " " +qsTr("point, please specify location"))
                    goButton.enabled = true;
                }
            }
        }
    }
}
