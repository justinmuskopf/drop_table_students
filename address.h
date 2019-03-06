#ifndef ADDRESS_H
#define ADDRESS_H

#include <QObject>
#include <QGeoAddress>

class Address : public QGeoAddress
{
public:
    explicit Address();
};

#endif // ADDRESS_H
