#ifndef GENERATEDLOCATION_H
#define GENERATEDLOCATION_H

#include "location.h"

class GeneratedLocation : public Location
{
    private:
        QTime generationTime;
    public:
        explicit GeneratedLocation();
        QTime getGenerationTime();
};

#endif // GENERATEDLOCATION_H
