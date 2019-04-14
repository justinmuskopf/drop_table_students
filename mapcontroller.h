#ifndef MAPCONTROLLER_H
#define MAPCONTROLLER_H

#include <QObject>
#include <QQmlApplicationEngine>
#include <QGeoLocation>
#include <QVariant>

class MapController : public QObject
{
public:
    Q_OBJECT

public:
    explicit MapController();
    ~MapController();

private slots:
    void on_addresses_changed(const QVariant &from_location, const QVariant &to_location);

private:
    QGeoLocation getLocationFromVariant(QVariant variant);
    void setMapCenter(double latitude, double longitude);

    QObject *map;
    QObject *signaller;
    QObject *rootObject;
    QQmlApplicationEngine *engine;
};

#endif // MAPCONTROLLER_H
