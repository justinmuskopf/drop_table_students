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
import QtLocation 5.6
import QtPositioning 5.5
import QtQuick.Window 2.12
import QtQuick.Dialogs 1.3
import "map"
import "menus"
import "helper.js" as Helper

ApplicationWindow {
    id: appWindow
    property variant map
    property variant minimap
    property variant parameters
    //property variant searchQuery

    function isOffline() {
        stackView.showFatalMessage("OFFLINE", "ERROR: You must have a valid internet connection to use this application!");//, stackView.currentItem);
        //Qt.quit()
    }

    function createMap(provider)
    {
        var plugin

        if (parameters && parameters.length>0)
            plugin = Qt.createQmlObject ('import QtLocation 5.6; Plugin{ name:"' + provider + '"; parameters: appWindow.parameters}', appWindow)
        else
            plugin = Qt.createQmlObject ('import QtLocation 5.6; Plugin{ name:"' + provider + '"}', appWindow)

        if (minimap) {
            minimap.destroy()
            minimap = null
        }

        var zoomLevel = null
        var center = null
        var panelExpanded = null
        if (map) {
            zoomLevel = map.zoomLevel
            center = map.center
            panelExpanded = map.slidersExpanded
            map.destroy()
        }

        map = mapComponent.createObject(page);
        map.plugin = plugin;

        if (zoomLevel != null) {
            map.zoomLevel = zoomLevel
            map.center = center
            map.slidersExpanded = panelExpanded
        } else {
            // Use an integer ZL to enable nearest interpolation, if possible.
            map.zoomLevel = Math.floor((map.maximumZoomLevel - map.minimumZoomLevel)/2)
            // defaulting to 45 degrees, if possible.
            //map.fieldOfView = Math.min(Math.max(45.0, map.minimumFieldOfView), map.maximumFieldOfView)
        }

        map.forceActiveFocus()
    }

    Plugin {
        id: myPlugin
        name:"osm"
    }

    PlaceSearchModel {
        signal searchCompleted(var _count)

        id: searchModel
        plugin: myPlugin
        Component.onCompleted: {
            searchCompleted(count)
            update()
        }
    }

    function setMapCenter(latitude, longitude)
    {
        var centerCoordinate = QtPositioning.coordinate(latitude, longitude)

        map.zoomLevel = 10
        map.center = centerCoordinate

        console.log("Map zoom level: ", map.zoomLevel)
        console.log("Map Center: ", map.center.latitude, map.center.longitude)

        searchModel.searchTerm = searchQuery.query
        searchModel.searchArea = QtPositioning.circle(centerCoordinate, searchQuery.radius)
        //searchModel.plugin = map.plugin

        searchModel.update()

        map.setCenterCoordinate(centerCoordinate, searchQuery.radius)

        map.calculateCoordinateRoute(calcFromLocation.coordinate, centerCoordinate)
        map.calculateCoordinateRoute(calcToLocation.coordinate, centerCoordinate)

        map.update()
    }

    function providerSelect(provider)
    {
        createMap(provider)
    }

    function getPlugins()
    {
        var plugin = Qt.createQmlObject ('import QtLocation 5.6; Plugin {}', appWindow)
        var myArray = new Array()
        for (var i = 0; i<plugin.availableServiceProviders.length; i++) {
            var tempPlugin = Qt.createQmlObject ('import QtLocation 5.6; Plugin {name: "' + plugin.availableServiceProviders[i]+ '"}', appWindow)
            if (tempPlugin.supportsMapping())
                myArray.push(tempPlugin.name)
        }
        myArray.sort()
        return myArray
    }

    function initializeProviders(pluginParameters)
    {
        var parameters = new Array()
        for (var prop in pluginParameters){
            var parameter = Qt.createQmlObject('import QtLocation 5.6; PluginParameter{ name: "'+ prop + '"; value: "' + pluginParameters[prop]+'"}',appWindow)
            parameters.push(parameter)
        }
        appWindow.parameters = parameters
        var plugins = getPlugins()
        mainMenu.providerMenu.createMenu(plugins)
        for (var i = 0; i<plugins.length; i++) {
            if (plugins[i] === "osm")
                mainMenu.selectProvider(plugins[i])
        }
    }

    function shareLocations() {
        var toWrite = new String;

        for (var i = 0; i < searchModel.count; i++) {
            //var name = searchModel.data(i, "name")

            var name = searchModel.data(i, "name");
            var place = searchModel.data(i, "place");
            var address = place.location.address;

            toWrite += name + "\n" + address.street + "\n" + address.city + ", " + address.state + " " + address.postalCode + "\n\n";

            //var address = searchModel.data(i, "location").address
            console.log(toWrite)
        }

        fileio.write("MMHA_Locations.txt", toWrite);
    }

    function setAddresses() {
        stackView.pop({item:page, immediate: true})
        stackView.push({ item: Qt.resolvedUrl("forms/RouteAddress.qml") ,
                           properties: { "plugin": map.plugin,
                               "toAddress": toAddress,
                               "fromAddress": fromAddress}})
        stackView.currentItem.showMessage.connect(stackView.showMessage)
        stackView.currentItem.closeForm.connect(stackView.closeForm)
        stackView.currentItem.addressesChanged.connect(signaller.setAddresses)
    }

    title: qsTr("Mapviewer")
    height: 500
    width: 670
    visible: true

    Location {
        id: calcFromLocation
    }

    Location {
        id: calcToLocation
    }

    Item {
        id: searchQuery
        property string query: "";
        property real radius: 0;
        property bool searched: false;
    }



    Item {
        objectName: "signaller"
        id: signaller
        signal addressesChanged(var _fromLocation, var _toLocation)

        function setAddresses(_fromLocation, _toLocation, _searchFor, _radius) {
            map.setFromCoordinate(_fromLocation.coordinate)
            map.setToCoordinate(_toLocation.coordinate)

            calcFromLocation.coordinate = _fromLocation.coordinate
            calcToLocation.coordinate = _toLocation.coordinate

            searchQuery.query = _searchFor
            searchQuery.radius = _radius

            addressesChanged(_fromLocation, _toLocation)

            //appWindow.showFullScreen()
        }
    }

    //! [geocode0]
    Address {
        objectName: "fromAddress"
        id : fromAddress
    }
    //! [geocode0]

    Address {
        id: toAddress
    }

    MapPopupMenu {
        id: mapPopupMenu

        function show(coordinate)
        {
            stackView.pop(page)
            mapPopupMenu.coordinate = coordinate
            mapPopupMenu.markersCount = map.markers.length
            mapPopupMenu.mapItemsCount = map.mapItems.length
            mapPopupMenu.update()
            mapPopupMenu.popup()
        }

        onItemClicked: {
            stackView.pop(page)
            switch (item) {
            case "addMarker":
                map.addMarker()
                break
            case "getCoordinate":
                map.coordinatesCaptured(coordinate.latitude, coordinate.longitude)
                break
            case "fitViewport":
                map.fitViewportToMapItems()
                break
            case "deleteMarkers":
                map.deleteMarkers()
                break
            case "deleteItems":
                map.deleteMapItems()
                break
            default:
                console.log("Unsupported operation")
            }
        }
    }

    MarkerPopupMenu {
        id: markerPopupMenu

        function show(coordinate)
        {
            stackView.pop(page)
            markerPopupMenu.markersCount = map.markers.length
            markerPopupMenu.update()
            markerPopupMenu.popup()
        }

        function askForCoordinate()
        {
            stackView.push({ item: Qt.resolvedUrl("forms/ReverseGeocode.qml") ,
                               properties: { "title": qsTr("New Coordinate"),
                                   "coordinate":   map.markers[map.currentMarker].coordinate}})
            stackView.currentItem.showPlace.connect(moveMarker)
            stackView.currentItem.closeForm.connect(stackView.closeForm)
        }

        function moveMarker(coordinate)
        {
            map.markers[map.currentMarker].coordinate = coordinate;
            map.center = coordinate;
            stackView.pop(page)
        }

        onItemClicked: {
            stackView.pop(page)
            switch (item) {
            case "deleteMarker":
                map.deleteMarker(map.currentMarker)
                break;
            case "getMarkerCoordinate":
                map.coordinatesCaptured(map.markers[map.currentMarker].coordinate.latitude, map.markers[map.currentMarker].coordinate.longitude)
                break;
            case "moveMarkerTo":
                askForCoordinate()
                break;
            case "routeToNextPoint":
            case "routeToNextPoints":
                map.calculateMarkerRoute()
                break
            case "distanceToNextPoint":
                var coordinate1 = map.markers[currentMarker].coordinate;
                var coordinate2 = map.markers[currentMarker+1].coordinate;
                var distance = Helper.formatDistance(coordinate1.distanceTo(coordinate2));
                stackView.showMessage(qsTr("Distance"),"<b>" + qsTr("Distance:") + "</b> " + distance)
                break
            case "drawImage":
                map.addGeoItem("ImageItem")
                break
            case "drawRectangle":
                map.addGeoItem("RectangleItem")
                break
            case "drawCircle":
                map.addGeoItem("CircleItem")
                break;
            case "drawPolyline":
                map.addGeoItem("PolylineItem")
                break;
            case "drawPolygonMenu":
                map.addGeoItem("PolygonItem")
                break
            default:
                console.log("Unsupported operation")
            }
        }
    }

    ItemPopupMenu {
        id: itemPopupMenu

        function show(type,coordinate)
        {
            stackView.pop(page)
            itemPopupMenu.type = type
            itemPopupMenu.update()
            itemPopupMenu.popup()
        }

        onItemClicked: {
            stackView.pop(page)
            switch (item) {
            case "showRouteInfo":
                stackView.showRouteListPage()
                break;
            case "deleteRoute":
                map.routeModel.reset();
                break;
            case "showPointInfo":
                map.showGeocodeInfo()
                break;
            case "deletePoint":
                map.geocodeModel.reset()
                break;
            default:
                console.log("Unsupported operation")
            }
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        focus: true
        initialItem: Item {
            id: page
        }

        function showMessage(title,message,backPage)
        {
            push({ item: Qt.resolvedUrl("forms/Message.qml") ,
                               properties: {
                                   "title" : title,
                                   "message" : message,
                                   "backPage" : backPage
                               }})
            currentItem.closeForm.connect(closeMessage)
        }

        function showFatalMessage(title, message) {
            push({ item: Qt.resolvedUrl("forms/Message.qml") ,
                               properties: {
                                   "title" : title,
                                   "message" : message,
                                   "backPage" : stackView.currentItem
                               }})
            currentItem.closeForm.connect(Qt.quit)
        }

        function closeMessage(backPage)
        {
            pop(backPage)
        }

        function closeForm()
        {
            pop(page)
        }

        function showRouteListPage()
        {
            /*push({ item: Qt.resolvedUrl("forms/RouteList.qml") ,
                               properties: {
                                   "routeModel" : map.routeModel
                               }})*/
            /*push({ item: Qt.resolvedUrl("forms/RouteList.qml") ,
                               properties: {
                                   "searchModel" : searchModel,
                                   "routeModel": map.routeModel
                               }})

            currentItem.closeForm.connect(closeForm)*/
            closeForm()
        }

        MessageDialog {
            id: noPlacesDialog
            visible: false
            title: "Empty Search Results"
            text: "No locations were found with the query \"" + searchQuery.query + "\" within a radius of " + searchQuery.radius + " meters!"
            onAccepted: {
                setAddresses()
                visible = false
            }

            function show() {
                visible = true
            }
        }

        Connections {
                target: searchModel
                onStatusChanged: {
                    if (searchModel.status == PlaceSearchModel.Error) {
                        return
                    }

                    if (searchModel.status == PlaceSearchModel.Ready) {
                        console.log(searchModel.errorString());
                        console.log("Places found: ", searchModel.count)
                        if (searchModel.count == 0) {
                            noPlacesDialog.show()
                        }
                    }
                }
            }
    }


    Component {
        id: mapComponent

        MapComponent{
            width: page.width
            height: page.height
            onFollowmeChanged: mainMenu.isFollowMe = map.followme
            //onSupportedMapTypesChanged: mainMenu.mapTypeMenu.createMenu(map)
            onCoordinatesCaptured: {
                var text = "<b>" + qsTr("Latitude:") + "</b> " + Helper.roundNumber(latitude,4) + "<br/><b>" + qsTr("Longitude:") + "</b> " + Helper.roundNumber(longitude,4)
                stackView.showMessage(qsTr("Coordinates"),text);
            }
            onGeocodeFinished:{
                if (map.geocodeModel.status == GeocodeModel.Ready) {
                    if (map.geocodeModel.count == 0) {
                        stackView.showMessage(qsTr("Address Geocoding Error"), qsTr("Unsuccessful geocode... Are your addresses correct?"))
                    } else if (map.geocodeModel.count > 1) {
                        stackView.showMessage(qsTr("Ambiguous geocode"), map.geocodeModel.count + " " +
                                              qsTr("results found for the given address, please specify location"))
                    } else {
                        stackView.showMessage(qsTr("Location"), geocodeMessage(),page)
                    }
                } else if (map.geocodeModel.status == GeocodeModel.Error) {
                    stackView.showMessage(qsTr("Address Geocoding Error"), qsTr("Unsuccessful geocode... Are your addresses correct?"))
                    //stackView.showMessage(qsTr("Geocode Error"),qsTr("Unsuccessful geocode"))
                }
            }
            //onRouteError: stackView.showMessage(qsTr("Route Error"),qsTr("Unable to find a route for the given points"),page)

            onShowGeocodeInfo: stackView.showMessage(qsTr("Location"),geocodeMessage(),page)

            onErrorChanged: {
                if (map.error != Map.NoError) {
                    var title = qsTr("ProviderError")
                    var message =  map.errorString + "<br/><br/><b>" + qsTr("Try to select other provider") + "</b>"
                    if (map.error == Map.MissingRequiredParameterError)
                        message += "<br/>" + qsTr("or see") + " \'mapviewer --help\' "
                                + qsTr("how to pass plugin parameters.")
                    stackView.showMessage(title,message);
                }
            }
            onShowMainMenu: mapPopupMenu.show(coordinate)
            onShowMarkerMenu: markerPopupMenu.show(coordinate)
            onShowRouteMenu: itemPopupMenu.show("Route",coordinate)
            onShowPointMenu: itemPopupMenu.show("Point",coordinate)
            onShowRouteList: stackView.showRouteListPage()
        }        
    }
}
