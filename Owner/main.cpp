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
    QScopedPointer<request_suggest_complain_Database>requestandsuggestion(new request_suggest_complain_Database);
    QScopedPointer<Shift_data>shift_datas(new Shift_data);
    QScopedPointer<ownerDatabase>ownerDatabases(new ownerDatabase);
    QScopedPointer<employeeDatabase>employeeDatabases(new employeeDatabase);
    QScopedPointer<request_suggest_complain_Database>request_suggest_complain_Databases(new request_suggest_complain_Database);
//        createDatabaseTable();

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("pd", productDatabases.data());
    engine.rootContext()->setContextProperty("rands", requestandsuggestion.data());
    engine.rootContext()->setContextProperty("sd", shift_datas.data());
    engine.rootContext()->setContextProperty("od",ownerDatabases.data());
    engine.rootContext()->setContextProperty("ed", employeeDatabases.data());
    engine.rootContext()->setContextProperty("rsd", request_suggest_complain_Databases.data());

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
