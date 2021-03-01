#ifndef SUPERMARKET_DATABASE
#define SUPERMARKET_DATABASE

#include <iostream>
#include <mysql/mysql.h>
#include <string>
#include <vector>
#include <sstream>
#include <QObject>
#include <QtDebug>

#define SERVER "127.0.0.1"
#define UNAME "root"
#define PWORD "password"
#define DBNAME "SUPERMARKET_DB"
#define PORT 3306


using namespace std;
void insertDataIntoDatabase();
void insertEmployeeDataIntoDatabase();
void insertShiftDataIntoDatabase();

void createDatabaseTable();
void closedatabase();

class employeeDatabase: public QObject{
    Q_OBJECT
private:
    string elements, tableName, stringJson;
    QString previoustext;
    MYSQL* mysql;
public:
    Q_INVOKABLE employeeDatabase();
    Q_INVOKABLE void initalize();
    Q_INVOKABLE void insertData(QString, QString, QString, QString,QString, QString, QString, QString, QString);
    Q_INVOKABLE void updateData(QString, QString, QString, QString,QString, QString, QString, QString, QString);
    Q_INVOKABLE void deleteData(QString);
    Q_INVOKABLE QString retrieveData(QString);
    Q_INVOKABLE QString previoussearch();
    Q_INVOKABLE void inputtext(QString);
    Q_INVOKABLE QString outputdata();
    ~employeeDatabase(){
        mysql_close(mysql);
    }
};

class ownerDatabase: public QObject{
    Q_OBJECT
private:
    string elements, tableName;
    MYSQL* mysql;
public:
    Q_INVOKABLE ownerDatabase();
    Q_INVOKABLE void initalize();
    Q_INVOKABLE void insertData(string);
    Q_INVOKABLE void updateData(string, string, string, string);
    Q_INVOKABLE void deleteData(string);
    Q_INVOKABLE string retrieveData(string);
    Q_INVOKABLE int authentication(QString, QString);
    ~ownerDatabase(){
        mysql_close(mysql);
    }
};

class productDatabase: public QObject{
    Q_OBJECT
private:
    string elements, tableName, stringJson, elementsu;
    QString des;
    QString previoustext;
    MYSQL* mysql;
public:
    Q_INVOKABLE productDatabase();
    Q_INVOKABLE void initalize();
    Q_INVOKABLE void insertData(QString, QString, QString, QString, QString, QString, QString, QString);
    Q_INVOKABLE int updateData(QString, QString, QString, QString, QString, QString, QString, QString);
    Q_INVOKABLE void deleteData(QString);
    Q_INVOKABLE QString retrieveData(QString);
    Q_INVOKABLE QString previoussearch();
    Q_INVOKABLE void inputtext(QString);
    Q_INVOKABLE QString outputdata();
    Q_INVOKABLE QString description(QString);
    ~productDatabase(){
        mysql_close(mysql);
    }
};

class request_suggest_complain_Database: public QObject{
    Q_OBJECT
private:
    string elements, tableName, stringJson, elementsu, elementtype, tableNamesu; // elementsu and tableNamesu is for the suggestion table
    QString previoustext;
    MYSQL* mysql;
public:
    Q_INVOKABLE request_suggest_complain_Database();
    //Q_INVOKABLE request_suggest_complain_Database(QString);
    Q_INVOKABLE void initalize();
    Q_INVOKABLE void insertData(QString);
    Q_INVOKABLE void insertDatasu(QString, QString);
    Q_INVOKABLE void updateData(string, string, string, string);
    Q_INVOKABLE void deleteData(string);
    Q_INVOKABLE QString retrieveDataSuggestion(QString);
    Q_INVOKABLE QString retrieveDataItemRequest(QString);
    Q_INVOKABLE QString previoussearch();
    Q_INVOKABLE void inputtext(QString);
    Q_INVOKABLE QString outputdata();
    ~request_suggest_complain_Database(){
        mysql_close(mysql);
    }
};

class Shift_data: public QObject{
    Q_OBJECT
private:
    string elements, tableName, stringJson;
    QString previoustext;
    MYSQL* mysql;
public:
    Q_INVOKABLE Shift_data();
    Q_INVOKABLE void initalize();
    Q_INVOKABLE void insertData(QString,QString, QString,QString, QString, QString, QString,QString, QString, QString, QString);
    Q_INVOKABLE void updateData(QString,QString, QString,QString, QString, QString, QString,QString, QString, QString, QString);
    Q_INVOKABLE void deleteData(QString);
    Q_INVOKABLE QString previoussearch();
    Q_INVOKABLE QString retrieveData(QString);
    Q_INVOKABLE void inputtext(QString text);
    Q_INVOKABLE QString outputdata();
    ~Shift_data(){
        mysql_close(mysql);
    }
};

vector<string> toArray(string);
string jsonifier(vector<string>, vector<vector<string>>);
#endif
