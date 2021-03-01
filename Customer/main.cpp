#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "supermarket_database.h"
#include"cppbinding.h"
#include <QQmlContext>
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    QScopedPointer<productDatabase>productDatabases(new productDatabase);
    QScopedPointer<Shift_data>shift_datas(new Shift_data);
    QScopedPointer<employeeDatabase>employeedatabases(new employeeDatabase);



    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("pd", productDatabases.data());
    engine.rootContext()->setContextProperty("sd", shift_datas.data());
    engine.rootContext()->setContextProperty("ed",employeedatabases.data());





    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
