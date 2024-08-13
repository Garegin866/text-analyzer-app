#ifndef WORDCOUNTMODEL_H
#define WORDCOUNTMODEL_H

#include <QObject>
#include <QHash>
#include <QJsonArray>
#include <QJsonObject>

class WordCountModel : public QObject {
    Q_OBJECT

public:
    explicit WordCountModel(QObject *parent = nullptr);

    Q_INVOKABLE QJsonObject getTopWords(int count = 15) const;

public slots:
    void addWord(const QString& word);
    void reset();

private:
    QHash<QString, int> wordCounts_;
    int totalWords_ = 0;
};

#endif // WORDCOUNTMODEL_H
