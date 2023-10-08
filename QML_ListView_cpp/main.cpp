#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QQmlContext>
#include "filemanagebackend.h"


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    FileManageBackend filemanage;
    //qDebug () << filemanage.fileSearch("D:/QML git hub");

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("FileManageBackend", &filemanage);

    const QUrl url(u"qrc:/QML_ListView_cpp/Main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
