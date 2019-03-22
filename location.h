#ifndef LOCATION_H
#define LOCATION_H

#include <QObject>
#include <QPlace>
#include <QTime>
#include "address.h"

class Location : public QPlace
{
    private:
        Address address;
        QString name;
        int hours[2];
        QString type;
    public:
        explicit Location();
        int newUser(QString usr_name);
        // list(habit) displayHabits(habits);
        QString getName();
        int openingHour();
        int closingHour();
        const Address getAddress();
        QString getType();
};

#endif // LOCATION_H
