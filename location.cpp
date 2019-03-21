#include "location.h"

Location::Location() : QPlace()
{

}

int Location::newUser(QString usr_name)
{

}

// returns the name of the location
QString Location::getName()
{
    return name;
}

// returns the opening hour of the location, saved in hours[0]
int Location::openingHour()
{
    return hours[0];
}

// returns the closing hour of the location, saved in hours[0]
int Location::closingHour()
{
    return hours[1];
}

// returns the address of the location
const Address Location::getAddress()
{
    return address;
}

// returns the type of business of the location
QString Location::getType()
{
    return type;
}
