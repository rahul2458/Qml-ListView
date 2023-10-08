#ifndef FILEMANAGEBACKEND_H
#define FILEMANAGEBACKEND_H

#include <QObject>
#include <QDir>

class FileManageBackend : public QObject
{
    Q_OBJECT
public:
    explicit FileManageBackend(QObject *parent = nullptr);

   Q_INVOKABLE QStringList fileSearch(const QString &path);
   Q_INVOKABLE QStringList removeItems(const int &index);

private:
    QStringList m_List;

};

#endif // FILEMANAGEBACKEND_H
