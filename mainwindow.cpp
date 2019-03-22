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

void MainWindow::on_exit_Btn_clicked()
{
    MainWindow::close();
}


void MainWindow::on_routeButton_clicked()
{
    qDebug() << ui->address1_input->toPlainText();
    ui->address1_input->clear();
    qDebug() << ui->address2_input->toPlainText();
    ui->address2_input->clear();
}
