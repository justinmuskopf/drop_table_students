#ifndef ADDRESS_H
#define ADDRESS_H

#include <QObject>
#include <QGeoAddress>

class Address : public QGeoAddress
{
    Q_OBJECT
public:
    explicit Address(QObject *parent = nullptr);

signals:

public slots:
};

#endif // ADDRESS_H
