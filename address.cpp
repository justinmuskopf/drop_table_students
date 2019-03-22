#include "address.h"

Address::Address() : QGeoAddress()
{

}

Address::Address(QString usr_street, unsigned int usr_num, unsigned int usr_zip, QString usr_city, QString usr_state) : QGeoAddress ()
{

}

// set user street
void Address::setStreet(QString usr_street)
{
    street = usr_street;
}

// set user address
void Address::setNumber(unsigned int usr_num)
{
    number = usr_num;
}

// set user zipcode
void Address::setZipCode(unsigned int usr_zip)
{
    zip_code = usr_zip;
}

// set user city
void Address::setCity(QString usr_city)
{
    city = usr_city;
}

// set user state
void Address::setState(QString usr_state)
{
    state = usr_state;
}

// set user country
void Address::setCountry()
{
    country = "USA";
}

// get user address
QString Address::getAddress()
{
    return "";
}
