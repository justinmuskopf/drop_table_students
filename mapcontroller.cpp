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

MapController::MapController() : QObject()
{
    engine = new QQmlApplicationEngine("qrc:/mapviewer.qml");
    engine->addImportPath(QStringLiteral(":/imports"));

    map = engine->rootObjects().first();

    signaller = map->findChild<QObject *>("signaller");

    connect(signaller, SIGNAL(addressesChanged(QVariant, QVariant, QVariant, QVariant)), this,
                       SLOT(on_addresses_changed(QVariant, QVariant, QVariant, QVariant)));

    Q_ASSERT(map);

    QMetaObject::invokeMethod(map, "providerSelect", Q_ARG(QVariant, "osm"));


    /*QMetaObject::invokeMethod(map, "initializeProviders",
                              Q_ARG(QVariant, QVariant::fromValue(parameters)));
    */

    QMetaObject::invokeMethod(map, "setAddresses");
}

MapController::~MapController()
{

}

void MapController::parseAddressOne(QString user_input1)
{
    int street_num = 0;
    int zip = 0;
    int idx = 0;
    QString street_name, _city, _state, tmp;

    street_name.clear();
    _city.clear();
    _state.clear();
    tmp.clear();
    for(int i = 0; i < user_input1.size(); i++)
    {
        qDebug() << "i = " << i;
        if(idx == 0)    // grab street number
        {
            if(user_input1[i] != " ")
            {
                tmp = tmp.append(user_input1[i]);
            }
            else
            {
                idx = i;  // so the next starting parse will be at the street name and not whitespace
                street_num = tmp.toInt();
                qDebug() << "street num: " << street_num;
                tmp.clear();
            }
        }
        if((i == idx) && (i > 0))    // grab street name
        {
            if(user_input1[i] != " ")
            {
                tmp = tmp.append(user_input1[i]);
                qDebug() << "current st name: " << tmp;
            }
            else
            {
                idx = i;
                street_name = street_name.append(tmp);
                qDebug() << "street name: " << street_name;
                tmp.clear();
            }
        }/*
        if(i == idx)    // grab city
        {
            if(user_input1[i] != ',')
            {
                tmp = tmp.append(user_input1[i]);
            }
            else
            {
                idx = i;
                _city = _city.append(tmp);
                qDebug() << " city: " << _city;
            }
        }
        if(i == idx)    // grab state
        {
            if(user_input1[i] != " ")
            {
                tmp = tmp.append(user_input1[i]);
            }
            else
            {
                _state = _state.append(tmp);
                qDebug() << "state: " << _state;
                tmp.clear();
                idx = i;
            }
        }
        if(i == idx)    // grab zip code
        {
            if(user_input1 != " ")
            {
                tmp = tmp.append(user_input1[i]);
            }
            else
            {
                zip = tmp.toInt();
                qDebug() << zip;
                tmp.clear();
            }
        }*/
    }
    idx = 0;
}

void MapController::parseAddressTwo(QString user_input2)
{

}


void MapController::on_addresses_changed(const QVariant &from_address,
                                      const QVariant &from_coordinate,
                                      const QVariant &to_address,
                                      const QVariant &to_coordinate)
{
    QObject *fromAddress = from_address.value<QObject *>();

    QGeoLocation fromCoordinate = from_coordinate.value<QGeoLocation>();
    qDebug() << fromCoordinate.address().street();

    QObject *toAddress = to_address.value<QObject *>();
    QObject *toCoordinate = to_coordinate.value<QObject *>();

    QObject *obj = signaller->findChild<QObject *>("fromLocation");
    QGeoLocation loc = obj->property("location").value<QGeoLocation>();
    qDebug() << loc.address().street();

   // QGeoLocation location = fromCoordinate->property("location").value<QGeoLocation>();

    qDebug() << fromAddress->property("street").toString();

}

