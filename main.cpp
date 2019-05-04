#include "mapcontroller.h"
#include <QGuiApplication>

int main(int argc, char *argv[])
{
    QGuiApplication a(argc, argv);
    MapController map;

    return a.exec();
}
