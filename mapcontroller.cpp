#include "mapcontroller.h"
#include <QQmlApplicationEngine>
#include <QWindow>
#include <QApplication>
#include <QtQuick/QQuickItem>
#include <QDebug>
#include <QSslSocket>
#include <QQuickView>
#include <QQuickWidget>
#include <QGeoAddress>
#include <QGeoLocation>
#include <QGeoCoordinate>
#include <QQmlContext>
#include <QtMath>

#define MAP_PROVIDER "osm"

MapController::MapController() : QObject()
{
    engine = new QQmlApplicationEngine("qrc:/mapviewer.qml");
    engine->addImportPath(QStringLiteral(":/imports"));

    rootObject = engine->rootObjects().first();
    map = rootObject->findChild<QObject *>("map");
    signaller = rootObject->findChild<QObject *>("signaller");

    connect(signaller, SIGNAL(addressesChanged(QVariant, QVariant)), this,
                       SLOT(on_addresses_changed(QVariant, QVariant)));

    QMetaObject::invokeMethod(rootObject, "providerSelect", Q_ARG(QVariant, MAP_PROVIDER));

    QMetaObject::invokeMethod(rootObject, "setAddresses");
}

MapController::~MapController()
{
    delete engine;
}

QGeoLocation MapController::getLocationFromVariant(QVariant variant)
{
    QObject *object = variant.value<QObject *>();

    QGeoLocation location = object->property("location").value<QGeoLocation>();

    return location;
}

void MapController::setMapCenter(QGeoCoordinate center)
{

    QMetaObject::invokeMethod(rootObject, "setMapCenter", Q_ARG(QVariant, center.latitude()), Q_ARG(QVariant, center.longitude()));
}

double MapController::squareDouble(double toSquare)
{
    return qPow(toSquare, 2);
}

RadMap MapController::getRadiansFromCoordinate(QGeoCoordinate coordinate)
{
    RadMap radians;

    radians["latitude"] = qDegreesToRadians(coordinate.latitude());
    radians["longitude"] = qDegreesToRadians(coordinate.longitude());

    return radians;
}

double MapController::rootOfSquares(double firstToSquare, double secondToSquare)
{
    double sumOfSquares = squareDouble(firstToSquare) + squareDouble(secondToSquare);
    double root = qSqrt(sumOfSquares);

    return root;
}

QGeoCoordinate MapController::calculateMapCenter(QGeoCoordinate from, QGeoCoordinate to)
{
    RadMap fromRads = getRadiansFromCoordinate(from);
    RadMap toRads = getRadiansFromCoordinate(to);

    double deltaLong = toRads["longitude"] - fromRads["longitude"];

    double changeInLat = qCos(toRads["latitude"]) * qCos(deltaLong);
    double changeInLong = qCos(toRads["latitude"]) * qSin(deltaLong);

    double sinLatSum = qSin(fromRads["latitude"]) + qSin(toRads["latitude"]);
    double cosLatPlusX = qCos(fromRads["latitude"]) + changeInLat;

    double rooted = rootOfSquares(cosLatPlusX, changeInLong);

    double midLat = qAtan2(sinLatSum, rooted);
    double midLong = fromRads["longitude"] + qAtan2(changeInLong, cosLatPlusX);

    double midLatDegrees = qRadiansToDegrees(midLat);
    double midLongDegrees = qRadiansToDegrees(midLong);

    QGeoCoordinate center(midLatDegrees, midLongDegrees);

    return center;
}

void MapController::on_addresses_changed(const QVariant &from_location, const QVariant &to_location)
{
    QGeoLocation fromLocation = getLocationFromVariant(from_location);
    QGeoLocation toLocation = getLocationFromVariant(to_location);

    QGeoCoordinate fromCoordinate = fromLocation.coordinate();
    QGeoCoordinate toCoordinate = toLocation.coordinate();

    QGeoCoordinate center = calculateMapCenter(fromCoordinate, toCoordinate);

    setMapCenter(center);
}

