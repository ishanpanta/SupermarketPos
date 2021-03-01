#ifndef CPPBINDING_H
#define CPPBINDING_H

#include <QObject>
#include <vector>
#include <string>
#include <iostream>
#include "supermarket_database.h"

using namespace std;

class cppBinding : public QObject
{
    Q_OBJECT
public:
    explicit cppBinding(QObject *parent = nullptr);
    Q_INVOKABLE string jsonBuilder(vector<string>, vector<vector<string>>);

signals:

};

#endif // CPPBINDING_H
