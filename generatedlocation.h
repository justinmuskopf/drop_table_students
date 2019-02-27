#ifndef GENERATEDLOCATION_H
#define GENERATEDLOCATION_H

#include <QObject>
#include "location.h"

class GeneratedLocation : public Location
{
    Q_OBJECT
public:
    explicit GeneratedLocation(QObject *parent = nullptr);

signals:

public slots:
};

#endif // GENERATEDLOCATION_H
