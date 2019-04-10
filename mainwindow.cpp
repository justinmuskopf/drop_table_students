#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QQmlApplicationEngine>
#include <QWindow>
#include <QApplication>
#include <QtQuick/QQuickItem>
#include <QDebug>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    QQmlApplicationEngine *engine = new QQmlApplicationEngine();
    engine->addImportPath(QStringLiteral(":/imports"));
    engine->load(QUrl(QStringLiteral("qrc:/mapviewer.qml")));

    QWindow *window = qobject_cast<QWindow *>(engine->rootObjects().first());

    QWidget *container = QWidget::createWindowContainer(window, this);
    container->setMinimumSize(window->size());

    map = engine->rootObjects().first();
    Q_ASSERT(map);

    QMetaObject::invokeMethod(map, "providerSelect", Q_ARG(QVariant, "esri"));

    ui->mapLayout->addWidget(container);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_routeButton_clicked()
{
    QString address1 = ui->address1_input->toPlainText();
    QString address2 = ui->address2_input->toPlainText();

    qDebug() << "address 1" << address1;

    parseAddressOne(address1);
    parseAddressTwo(address2);

    ui->address1_input->clear();
    ui->address2_input->clear();
}

void MainWindow::parseAddressOne(QString user_input1)
{
    int street_num = 0;
    int zip = 0;
    int idx = 0;
    QString street_name, _city, _state, tmp;

    street_name.clear();
    _city.clear();
    _state.clear();
    tmp.clear();
    for(int i = 0; i < user_input1.size(); i++)
    {
        qDebug() << "i = " << i;
        if(idx == 0)    // grab street number
        {
            if(user_input1[i] != " ")
            {
                tmp = tmp.append(user_input1[i]);
            }
            else
            {
                idx = i;  // so the next starting parse will be at the street name and not whitespace
                street_num = tmp.toInt();
                qDebug() << "street num: " << street_num;
                tmp.clear();
            }
        }
        if((i == idx) && (i > 0))    // grab street name
        {
            if(user_input1[i] != " ")
            {
                tmp = tmp.append(user_input1[i]);
                qDebug() << "current st name: " << tmp;
            }
            else
            {
                idx = i;
                street_name = street_name.append(tmp);
                qDebug() << "street name: " << street_name;
                tmp.clear();
            }
        }/*
        if(i == idx)    // grab city
        {
            if(user_input1[i] != ',')
            {
                tmp = tmp.append(user_input1[i]);
            }
            else
            {
                idx = i;
                _city = _city.append(tmp);
                qDebug() << " city: " << _city;
            }
        }
        if(i == idx)    // grab state
        {
            if(user_input1[i] != " ")
            {
                tmp = tmp.append(user_input1[i]);
            }
            else
            {
                _state = _state.append(tmp);
                qDebug() << "state: " << _state;
                tmp.clear();
                idx = i;
            }
        }
        if(i == idx)    // grab zip code
        {
            if(user_input1 != " ")
            {
                tmp = tmp.append(user_input1[i]);
            }
            else
            {
                zip = tmp.toInt();
                qDebug() << zip;
                tmp.clear();
            }
        }*/
    }
    idx = 0;
}

void MainWindow::parseAddressTwo(QString user_input2)
{

}
