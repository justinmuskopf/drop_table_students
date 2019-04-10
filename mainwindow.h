#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QObject>

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = nullptr);
    void parseAddressOne(QString user_input1);
    void parseAddressTwo(QString user_input2);
    ~MainWindow();

private slots:
    void on_routeButton_clicked();

private:
    Ui::MainWindow *ui;
    QObject *map;
};

#endif // MAINWINDOW_H
