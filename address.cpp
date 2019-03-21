#include "address.h"

Address::Address() : QGeoAddress()
{

}

Address::Address(std::string usr_street, unsigned int usr_num, unsigned int usr_zip, std::string usr_city, std::string usr_state) : QGeoAddress ()
{

}

// set user street
void Address::setStreet(std::string usr_street)
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
void Address::setCity(std::string usr_city)
{
    city = usr_city;
}

// set user state
void Address::setState(std::string usr_state)
{
    state = usr_state;
}

// set user country
void Address::setCountry()
{
    country = "USA";
}

// get user address
std::string Address::getAddress()
{

}
