#include "wordcountmodel.h"
#include "QtCore/qthread.h"
#include <QColor>

WordCountModel::WordCountModel(QObject *parent)
    : QObject(parent) {}

void WordCountModel::addWord(const QString &word) {
    if (!wordCounts_.contains(word)) {
        wordCounts_[word] = 0;
    }
    wordCounts_[word]++;

    totalWords_++;
}

void WordCountModel::reset() {
    wordCounts_.clear();
    totalWords_ = 0;
}

QJsonObject WordCountModel::getTopWords(int count) const {
    QVector<QString> topWords = wordCounts_.keys().toVector();
    std::sort(topWords.begin(), topWords.end(),
              [this](const QString &a, const QString &b) {
                  return wordCounts_[a] > wordCounts_[b];
              });

    if (count < topWords.size())
        topWords.resize(count);

    int maxCount = topWords.size() > 0 ? wordCounts_[topWords[0]] : 0;

    QJsonObject topWordsObject;
    QJsonArray topWordsArray;
    for (const QString &word : topWords) {
        QJsonObject wordObject;
        wordObject["word"] = word;
        wordObject["count"] = wordCounts_[word];

        //make random color
        topWordsArray.append(wordObject);
    }


    topWordsObject["words"] = topWordsArray;
    topWordsObject["totalWords"] =maxCount;

    return topWordsObject;
}
