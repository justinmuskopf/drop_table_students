#ifndef LOCATION_H
#define LOCATION_H

#include <QObject>
#include <QPlace>
#include <QTime>

class Location : public QPlace
{
    private:
        //Address address;  ??
        std::string name;
        int hours[2];
        std::string type;
    public:
        explicit Location();
        int newUser(std::string usr_name);
        // list(habit) displayHabits(habits);
        std::string getName();
        int openingHour();
        int closingHour();
        const Address getAddress();
        std::string getType();
};

#endif // LOCATION_H
