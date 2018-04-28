#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QProcess>

class MyClass : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE QVariantMap exec(QString exe)
    {
        QProcess process;
        QVariantMap map;

        connect(&process, &QProcess::errorOccurred, [&](QProcess::ProcessError e) {
            map.insert("stderr", QMetaEnum::fromType<QProcess::ProcessError>().key(e));
        });

        process.start(exe);
        process.waitForFinished(-1);

        if (!map.count("stderr"))
          map.insert("stderr", process.readAllStandardError());

        map.insert("stdout", process.readAllStandardOutput());
        map.insert("exit", process.exitCode());

        return map;
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
