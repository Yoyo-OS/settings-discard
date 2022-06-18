#ifndef DIGITALWELLBEING_H
#define DIGITALWELLBEING_H

#include <QObject>
#include <QDBusInterface>
#include <QStandardPaths>
class DigitalWellbeing : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int totalTime READ totalTime NOTIFY totalTimeChanged)
    Q_PROPERTY(QString time READ time NOTIFY timeChanged)
    Q_PROPERTY(QString perAppStatDaily READ perAppStatDaily NOTIFY perAppStatDailyChanged)


public:
    explicit DigitalWellbeing(QObject *parent = nullptr);
    int totalTime();
    QString time();
    QString perAppStatDaily();
signals:
    void totalTimeChanged();
    void timeChanged();
    void perAppStatDailyChanged();
private slots:

private:
    int m_totalTime;
    QString m_time;
    QString m_perAppStatDaily;

};

#endif // DIGITALWELLBEING_H
