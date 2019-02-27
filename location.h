#ifndef LOCATION_H
#define LOCATION_H

#include <QObject>
#include <QPlace>

class Location : public QPlace
{
    Q_OBJECT
public:
    explicit Location(QObject *parent = nullptr);

signals:

public slots:
};

#endif // LOCATION_H
