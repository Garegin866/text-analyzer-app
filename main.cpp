#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "src/fileprocessorcontroller.h"
#include "src/wordcountmodel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    WordCountModel* model = new WordCountModel();
    FileProcessorController* controller = new FileProcessorController(model);

    engine.rootContext()->setContextProperty("WordCountModel", model);
    engine.rootContext()->setContextProperty("FileProcessor", controller);

    const QUrl url(QStringLiteral("qrc:/Main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
