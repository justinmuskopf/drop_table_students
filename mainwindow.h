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
    ~MainWindow();

private slots:
    void on_exit_Btn_clicked();

    void on_routeButton_clicked();

private:
    Ui::MainWindow *ui;
    QObject *map;
};

#endif // MAINWINDOW_H
