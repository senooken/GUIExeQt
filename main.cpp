#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QObject>
#include <QString>
#include <QProcess>

class MyClass : public QObject
{
    Q_OBJECT
public:
//    explicit MyClass(QObject *parent = 0) : QObject(parent){};
//    explicit virtual MyClass();
//    explicit MyClass(QObject *parent = 0 ) : QObject(parent){}
//    Q_INVOKABLE QString exec(QString exe)
    Q_INVOKABLE QString exec(QString exe)
    {
        QProcess process;
        process.start(exe);
        process.waitForFinished(-1);
        qDebug(process.readAllStandardError());
        return process.readAllStandardOutput();
    }
};

#include "main.moc"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<MyClass>("myclass", 1, 0, "MyClass");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
