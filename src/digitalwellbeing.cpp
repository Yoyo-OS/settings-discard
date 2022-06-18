#include "digitalwellbeing.h"
#include "dbushelper.h"
DigitalWellbeing::DigitalWellbeing(QObject *parent)
    : QObject{parent}
{
    QString json = dcall(QDBusMessage::createMethodCall("com.yoyo.DigitalWellbeing","/DigitalWellbeing","com.yoyo.DigitalWellbeing","getBasicStatJson")).first().toString();
    QJsonDocument document;
    QJsonParseError parseJsonErr;
    document = QJsonDocument::fromJson(json.toUtf8(),&parseJsonErr);
    if(document.isObject())
    {
        QJsonObject obj = document.object();
        if(obj.contains("totalTime"))
        {
            QJsonValue totalTime_value = obj.take("totalTime");
            m_totalTime = totalTime_value.toInt();
        }
    }
    int H = m_totalTime / (60*60);
    int M = (m_totalTime- (H * 60 * 60)) / 60;
    QString hour = QString::number(H);
    QString min = QString::number(M);
    m_time = hour + " "+tr("h")+" " + min + " "+tr("m");
    m_perAppStatDaily = dcall(QDBusMessage::createMethodCall("com.yoyo.DigitalWellbeing","/DigitalWellbeing","com.yoyo.DigitalWellbeing","getPerAppStatJson")).first().toString();
}
int DigitalWellbeing::totalTime()
{
    return m_totalTime;
}

QString DigitalWellbeing::time()
{
    return m_time;
}

QString DigitalWellbeing::perAppStatDaily()
{
    return m_perAppStatDaily;
}
