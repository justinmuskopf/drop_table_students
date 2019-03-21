#include "generatedlocation.h"

GeneratedLocation::GeneratedLocation() : Location()
{

}

QTime GeneratedLocation::getGenerationTime()
{
    return QTime::currentTime();
}
