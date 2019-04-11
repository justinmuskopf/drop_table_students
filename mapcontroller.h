#ifndef MAPCONTROLLER_H
#define MAPCONTROLLER_H

#include <QObject>
#include <QQmlApplicationEngine>

class MapController : public QObject
{
public:
    Q_OBJECT

public:
    explicit MapController();
    void parseAddressOne(QString user_input1);
    void parseAddressTwo(QString user_input2);
    ~MapController();

private slots:
    void on_addresses_changed(const QVariant &from_address,
                              const QVariant &from_coordinate,
                              const QVariant &to_address,
                              const QVariant &to_coordinate);

private:
    QObject *map;
    QQmlApplicationEngine *engine;
    QObject *signaller;
};

#endif // MAPCONTROLLER_H
