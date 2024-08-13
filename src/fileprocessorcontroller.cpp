#include "fileprocessorcontroller.h"

FileProcessorController::FileProcessorController(WordCountModel *model, QObject *parent)
    : QObject(parent)
    , wordCountModel_(model)
    , isProcessing_(false) {}

void FileProcessorController::setIsProcessing(bool isProcessing) {
    if (isProcessing_ == isProcessing) {
        return;
    }

    isProcessing_ = isProcessing;
    emit isProcessingChanged();
}

void FileProcessorController::processFile() {
    if (filename_.isEmpty()) {
        qWarning() << "No filename set for processing";
        return;
    }

    QFile file(filename_);
    if (!file.open(QIODevice::ReadOnly)) {
        qWarning() << "Failed to open file for reading: " << filename_ << file.errorString();
        return;
    }

    qint64 bytesRead = 0;
    qint64 totalBytes = file.size();

    QTextStream in(&file);
    while (!in.atEnd()) {
        QString line = in.readLine().trimmed();
        if (!line.isEmpty()) {
            QStringList words = line.split(QRegularExpression("\\W+"), Qt::SkipEmptyParts);
            for (const QString& word : words) {
                QMetaObject::invokeMethod(wordCountModel_, "addWord", Qt::QueuedConnection, Q_ARG(QString, word));
            }
        }
        bytesRead += line.size() + 1;\
        QMetaObject::invokeMethod(this, "progressChanged", Qt::QueuedConnection, Q_ARG(qint64, bytesRead), Q_ARG(qint64, totalBytes));
    }

    file.close();
}
void FileProcessorController::startProcessing() {
    wordCountModel_->reset();

    if (filename_.isEmpty()) {
        qWarning() << "No filename set for processing";
        return;
    }

    if (workerThread_) {
        qWarning() << "Worker thread is already running";
        return;
    }

    workerThread_ = QThread::create([this]() {
        processFile();
    });

    connect(workerThread_, &QThread::finished, this, [this]() {
        setIsProcessing(false);
        workerThread_->deleteLater();
        workerThread_ = nullptr;
    });

    connect(workerThread_, &QThread::started, this, [this]() {
        setIsProcessing(true);
    });

    workerThread_->start();
}

void FileProcessorController::stopProcessing() {
    if (!workerThread_) {
        qWarning() << "No worker thread running";
        return;
    }

    workerThread_->requestInterruption();
    workerThread_->wait();
    workerThread_->quit();
}

QString FileProcessorController::filename() const {
    return filename_;
}

void FileProcessorController::setFilename(const QString &filename) {
    if (filename_ == filename) {
        return;
    }

    filename_ = filename;
    emit filenameChanged();
}

