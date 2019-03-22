#ifndef ADDRESS_H
#define ADDRESS_H

#include <QObject>
#include <QGeoAddress>
#include <QString>

class Address : public QGeoAddress
{
    private:
        unsigned int number;
        unsigned int zip_code;
        QString street;
        QString city;
        QString state;
        QString country;

    public:
        explicit Address();
        explicit Address(QString usr_street, unsigned int usr_num, unsigned int usr_zip, QString usr_city, QString usr_state);
        void setStreet(QString usr_street);
        void setNumber(unsigned int usr_num);
        void setZipCode(unsigned int usr_zip);
        void setCity(QString usr_city);
        void setState(QString usr_state);
        void setCountry();
        QString getAddress();
};

#endif // ADDRESS_H
