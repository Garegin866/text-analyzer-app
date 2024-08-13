#ifndef FILEPROCESSORCONTROLLER_H
#define FILEPROCESSORCONTROLLER_H

#include <QObject>
#include <QFile>
#include <QRegularExpression>
#include <QThread>

#include "wordcountmodel.h"

class FileProcessorController : public QObject {
    Q_OBJECT
    Q_PROPERTY(bool isProcessing MEMBER isProcessing_ NOTIFY isProcessingChanged)
    Q_PROPERTY(QString filename READ filename WRITE setFilename NOTIFY filenameChanged)

public:
    explicit FileProcessorController(WordCountModel *model, QObject *parent = nullptr);

    QString filename() const;
    void setFilename(const QString& filename);

public slots:
    void startProcessing();
    void stopProcessing();

signals:
    void isProcessingChanged();
    void filenameChanged();
    void progressChanged(qint64 bytesRead, qint64 totalBytes);

private:
    QString filename_;
    bool isProcessing_;
    QThread* workerThread_;
    WordCountModel *wordCountModel_;

private:
    void processFile();
    void setIsProcessing(bool isProcessing);
};

#endif // FILEPROCESSORCONTROLLER_H
