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

MapController::MapController() : QObject()
{
    engine = new QQmlApplicationEngine("qrc:/mapviewer.qml");
    engine->addImportPath(QStringLiteral(":/imports"));

    rootObject = engine->rootObjects().first();
    map = rootObject->findChild<QObject *>("map");
    signaller = rootObject->findChild<QObject *>("signaller");

    connect(signaller, SIGNAL(addressesChanged(QVariant, QVariant)), this,
                       SLOT(on_addresses_changed(QVariant, QVariant)));

    QMetaObject::invokeMethod(rootObject, "providerSelect", Q_ARG(QVariant, "osm"));

    QMetaObject::invokeMethod(rootObject, "setAddresses");
}

MapController::~MapController()
{

}

QGeoLocation MapController::getLocationFromVariant(QVariant variant)
{
    QObject *object = variant.value<QObject *>();

    QGeoLocation location = object->property("location").value<QGeoLocation>();

    return location;
}

void MapController::setMapCenter(double latitude, double longitude)
{
    QGeoCoordinate midCoordinate(latitude, longitude);

    QMetaObject::invokeMethod(rootObject, "setMapCenter", Q_ARG(QVariant, latitude), Q_ARG(QVariant, longitude));
}

void MapController::on_addresses_changed(const QVariant &from_location, const QVariant &to_location)
{
    QGeoLocation fromLocation = getLocationFromVariant(from_location);
    QGeoLocation toLocation = getLocationFromVariant(to_location);

    QGeoCoordinate fromCoordinate = fromLocation.coordinate();
    QGeoCoordinate toCooridnate = toLocation.coordinate();

    double fromLat = qDegreesToRadians(fromCoordinate.latitude());
    double fromLong = qDegreesToRadians(fromCoordinate.longitude());

    double toLat = qDegreesToRadians(toCooridnate.latitude());
    double toLong = qDegreesToRadians(toCooridnate.longitude());

    double deltaLong = toLong - fromLong;

    double x = qCos(toLat) * qCos(deltaLong);
    double y = qCos(toLat) * qSin(deltaLong);

    double sinLatSum = qSin(fromLat) + qSin(toLat);

    double cosLatPlusX = qCos(fromLat) + x;

    double rooted = qSqrt(qPow(cosLatPlusX, 2) + qPow(y, 2));

    double midLat = qAtan2(sinLatSum, rooted);
    double midLong = fromLong + qAtan2(y, cosLatPlusX);

    double midLatDegrees = qRadiansToDegrees(midLat);
    double midLongDegrees = qRadiansToDegrees(midLong);

    setMapCenter(midLatDegrees, midLongDegrees);

    qDebug() << midLatDegrees << midLongDegrees;
}

