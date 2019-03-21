#ifndef ADDRESS_H
#define ADDRESS_H

#include <QObject>
#include <QGeoAddress>

class Address : public QGeoAddress
{
    private:
        unsigned int number, zip_code;
        std::string street, city, state, country;

    public:
        explicit Address();
        explicit Address(std::string usr_street, unsigned int usr_num, unsigned int usr_zip, std::string usr_city, std::string usr_state);
        void setStreet(std::string usr_street);
        void setNumber(unsigned int usr_num);
        void setZipCode(unsigned int usr_zip);
        void setCity(std::string usr_city);
        void setState(std::string usr_state);
        void setCountry();
        std::string getAddress();
};

#endif // ADDRESS_H
