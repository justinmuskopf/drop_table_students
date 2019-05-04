#ifndef MAPCONTROLLER_H
#define MAPCONTROLLER_H

#include <QObject>
#include <QQmlApplicationEngine>
#include <QGeoLocation>
#include <QVariant>
#include <QGeoCoordinate>
#include "fileio.h"

typedef QMap<QString, double> RadMap;

class MapController : public QObject
{
public:
    Q_OBJECT

public:
    explicit MapController();
    ~MapController();

private slots:
    void on_addresses_changed(const QVariant &from_location, const QVariant &to_location);
    QGeoCoordinate calculateMapCenter(QGeoCoordinate from, QGeoCoordinate to);

private:
    QGeoLocation getLocationFromVariant(QVariant variant);
    void setMapCenter(QGeoCoordinate center);
    double squareDouble(double toSquare);
    RadMap getRadiansFromCoordinate(QGeoCoordinate);
    double rootOfSquares(double firstToSquare, double csecondToSquare);

    QObject *map;
    QObject *signaller;
    QObject *rootObject;
    QQmlApplicationEngine *engine;

    FileIO fileio;
};

#endif // MAPCONTROLLER_H
