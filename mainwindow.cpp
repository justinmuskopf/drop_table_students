#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    // Here is a change so that we can see it in the PR
    ui->setupUi(this);
}

MainWindow::~MainWindow()
{
    delete ui;
}
