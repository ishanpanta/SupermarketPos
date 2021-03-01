#include "supermarket_database.h"

#include <iostream>
#include <mysql/mysql.h>
#include <string>
#include <vector>
#include <sstream>
#include <QObject>
#include <QtDebug>
#include<string.h>
#include <stdio.h>
#include <QDebug>

using namespace std;

vector<string> toArray(string fields){
    bool flag = true;
    int arraySize = 1;
    vector<string> convertedArray(arraySize);
    int commaPosition;
    string rightStrip;

    if (fields.find(',') == string::npos){
        convertedArray[arraySize-1] = fields;
        return convertedArray;
    }

    while(flag){
        if(fields.find(',') == string::npos){
            flag = false;
        }
        commaPosition = fields.find(',');
        rightStrip = fields.substr(0, commaPosition);
        fields = fields.substr(commaPosition+1, fields.length()-commaPosition-1);
        convertedArray[arraySize-1] = rightStrip;
        if(flag != false){
            arraySize++;
            convertedArray.resize(arraySize);
        }
    }

    return convertedArray;
}

string jsonifier(vector<string> attribute, vector<vector<string>> data)
{
    stringstream json;
    json << "[";
    for(unsigned int i = 0; i< data.size(); i++){
        json << "{";
        for(unsigned int j =0; j< attribute.size(); j++) {
            json << "\"" << attribute[j] << "\"" << ":" << "\"" << data[i][j] << "\"";
            if(j==attribute.size()-1) {
                break;
            }
            json << ",";
        }
        json << "}";
        if(i==data.size()-1) {
            break;
        }
        json << ",";
    }
    json << "]";
    return json.str();
}


//base database
QString employeeDatabase::previoussearch()
{
    return previoustext;
}

void employeeDatabase::inputtext(QString text)
{
    previoustext = text;
}

QString employeeDatabase::outputdata()
{
    return "";
}

employeeDatabase:: employeeDatabase() {
    tableName = "EMPLOYEE_INFO";
    elements = "ID,NAME,EMAIL,PASSWORD,GENDER,CONTACT_NUMBER,ADDRESS,DATE_OF_BIRTH,WORKING_SINCE";
    initalize();
}

void employeeDatabase:: initalize() {
    mysql = mysql_init(0);
    mysql = mysql_real_connect(mysql, SERVER, UNAME, PWORD, DBNAME, PORT, NULL, 0);
}

// not working
void employeeDatabase:: insertData(QString sno, QString name, QString email , QString password, QString gender, QString contact_number, QString address, QString date_of_birth, QString working_since) {
    stringstream query, ss;
    QString data = sno+","+name+","+email+","+password+","+gender+"," +contact_number+","+address+","+date_of_birth+","+working_since;
    query << "INSERT INTO " << tableName << "(" << elements << ") VALUES (\"" << sno.toUtf8().constData() << "\""<< ","<< "\""<<name.toUtf8().constData()<<"\""<<","<< "\""<<email.toUtf8().constData()<<"\""<<","<< "\""<<password.toUtf8().constData()<<"\"" <<","<< "\""<<gender.toUtf8().constData()<<"\""<<","<< "\""<<contact_number.toUtf8().constData()<<"\""<<","<< "\""<<address.toUtf8().constData()<<"\""<<","<< "\""<<date_of_birth.toUtf8().constData()<<"\""<<","<< "\""<<working_since.toUtf8().constData()<<"\");";
    string test = query.str();
    //qDebug()<<QString::fromStdString(test);
    mysql_query(mysql, query.str().c_str());
}

/*NOTE: 'field' is the table header name (eg ID,NAME), element is the table (eg "mulu") */
void employeeDatabase:: updateData(QString sno, QString name, QString email , QString password, QString gender, QString contact_number, QString address, QString date_of_birth, QString working_since) {
    stringstream query;
    query << "UPDATE " << tableName << " SET " <<"ID = \"" << sno.toUtf8().constData() << "\""<< ","<< " NAME = \""<<name.toUtf8().constData()<<"\""<<","<<" EMAIL=\""<<email.toUtf8().constData()<<"\""","<<" PASSWORD=\""<< password.toUtf8().constData()<<"\"" <<","<<" GENDER=\""<<gender.toUtf8().constData()<<"\""<<","<< " CONTACT_NUMBER=\""<<contact_number.toUtf8().constData()<<"\""","<< " ADDRESS=\""<<address.toUtf8().constData()<<"\""","<<" DATE_OF_BIRTH = \""<<date_of_birth.toUtf8().constData()<<"\""","<<" WORKING_SINCE = \""<<working_since.toUtf8().constData()<<"\""<<" WHERE ID = \""<<sno.toUtf8().constData()<<"\";";
    mysql_query(mysql, query.str().c_str());
}

void employeeDatabase:: deleteData(QString id) {
    stringstream query;
    query << "DELETE FROM " << tableName << " WHERE ID" << " = \"" << id.toUtf8().constData() << "\";";
    cout << query.str();
    mysql_query(mysql, query.str().c_str());
}

QString employeeDatabase:: retrieveData(QString a) {
    previoustext = a;
    string attribute = a.toStdString();
    string tester;
    MYSQL_RES *result;
    MYSQL_ROW row;
    int num_fields, num_records;
    int i = 0, j = 0;
    string attri;
    stringstream query;
    if (attribute == "") {
        query << "SELECT * FROM " << tableName << ";";
    } else {
       query << "SELECT * FROM " << tableName<<" WHERE NAME = \""<<attribute<<"\""<<";";
        //tester = query.str();
       //qDebug()<<QString::fromStdString(tester);
    }

    mysql_query(mysql, query.str().c_str());

    // result contains all the elements name for eg: ID, NAME
    result = mysql_store_result(mysql);

    // num_fields contains number of elements in a row of a table
    num_fields = mysql_num_fields(result);
    num_records = mysql_num_rows(result);


    vector<vector<string>> retrieveArray(num_records, vector<string> (num_fields));

    /* row contanis all the data from the table eg: "ishan", "98412315"
        it will fetch only one row at a time untill it finish the while loop goes on */
    while ((row = mysql_fetch_row(result)))
        {
            for(i = 0; i < num_fields; i++){
                retrieveArray[j][i] = row[i];
            }
            j++;
        }

    inputtext(a);
    stringJson = jsonifier(toArray(elements), retrieveArray);
//    return stringJson;
//    qDebug()<<QString::fromStdString(stringJson);
    return QString::fromStdString(stringJson);
}

ownerDatabase:: ownerDatabase() {
    tableName = "OWNER_INFO";
    elements = "NAME,EMAIL,PASSWORD,GENDER,CONTACT_NUMBER,DATE_OF_BIRTH,ADDRESS";
    initalize();
}

void ownerDatabase:: initalize() {
    mysql = mysql_init(0);
    mysql = mysql_real_connect(mysql, SERVER, UNAME, PWORD, DBNAME, PORT, NULL, 0);
}

void ownerDatabase:: insertData(string data) {
    stringstream query;
    query << "INSERT INTO " << tableName << "(" << elements << ") VALUES (" << data << ");";
    mysql_query(mysql, query.str().c_str());
}

void ownerDatabase:: updateData(string field, string element, string field2, string data) {
    stringstream query;
    // query << "UPDATE " << tableName << " SET NAME = 'phone' WHERE NAME = 'laptop';";
    query << "UPDATE " << tableName << " SET " << field <<" = \"" << element << "\" WHERE " << field2 << " = \"" << data << "\";";
    mysql_query(mysql, query.str().c_str());
}

void ownerDatabase:: deleteData(string name) {
    stringstream query;
    // query << "DELETE FROM " << tableName << " WHERE NAME = 'phone';";
    query << "DELETE FROM " << tableName << " WHERE NAME" << " = " << name << ";";
    mysql_query(mysql, query.str().c_str());
}

string ownerDatabase:: retrieveData(string attribute) {
    MYSQL_RES *result;
    MYSQL_ROW row;
    int num_fields, num_records;
    int i = 0, j = 0;
    string attri;
    stringstream query;
    if (attribute == "") {
        query << "SELECT * FROM " << tableName << ";";
    } else {
        query << "SELECT * FROM " << tableName << " WHERE NAME = \"" << attribute <<"\";";
    }

    mysql_query(mysql, query.str().c_str());

    // result contains all the elements name for eg: ID, NAME
    result = mysql_store_result(mysql);

    // num_fields contains number of elements in a row of a table
    num_fields = mysql_num_fields(result);
    num_records = mysql_num_rows(result);

    vector<vector<string>> retrieveArray(num_records, vector<string> (num_fields));

    /* row contanis all the data from the table eg: "ishan", "98412315"
        it will fetch only one row at a time untill it finish the while loop goes on */
    while ((row = mysql_fetch_row(result)))
        {
            for(i = 0; i < num_fields; i++){
                retrieveArray[j][i] = row[i];
            }
            j++;
        }
    string stringJson;
    stringJson = jsonifier(toArray(elements), retrieveArray);
    return stringJson;
}

int ownerDatabase::authentication(QString name, QString password)
{
    MYSQL_RES* res;
    stringstream query;
    string tester;
    //qDebug()<<name;
    //qDebug()<<password;

    query<<"SELECT * FROM OWNER_INFO WHERE NAME = \""<<name.toStdString()<<"\" AND PASSWORD =\""<<password.toStdString()<<"\"";
    mysql_query(mysql, query.str().c_str());
    //tester = query.str();
   //qDebug()<<QString::fromStdString(tester);

    res = mysql_store_result(mysql);

        int num_records = mysql_num_rows(res);

        if(num_records == 0){

            return 0;

        }else{

            return 1;

        }
}

QString productDatabase::previoussearch()
{
    return previoustext;
}

void productDatabase::inputtext(QString text)
{
    previoustext = text;
}

QString productDatabase::outputdata()
{
    return "";
}


QString productDatabase::description(QString value)
{
    des = "";
    string lol =value.toUtf8().constData();
    int len = value.size();
    for (int i = 0; i < len;i++)
    {
        if(lol[i] == ':')
        {
            break;
        }
        else
        {
            des = des+lol[i];
        }

    }
    qDebug()<<des;
    return des;
}


productDatabase:: productDatabase() {
    tableName = "product_info";
    elements = "S_NO,NAME,PRICE,DESCRIPTION,ITEM_TYPE,LOCATION,QUANTITY,NO_OF_ITEM_SOLD";
    elementsu = "S_NO,NAME,PRICE,DESCRIPTION,ITEM_TYPE,LOCATION,QUANTITY";
    initalize();
}

void productDatabase:: initalize() {
    mysql = mysql_init(0);
    mysql = mysql_real_connect(mysql, SERVER, UNAME, PWORD, DBNAME, PORT, NULL, 0);
}

void productDatabase:: insertData(QString sno, QString name, QString price , QString product, QString description, QString itype, QString location, QString quantity) {
    stringstream query, ss;

    QString product_description = description + ": " + product;

    query << "INSERT INTO " << tableName << "(" << elementsu << ") VALUES (\"" << sno.toUtf8().constData() << "\""<< ","<< "\""<<name.toUtf8().constData()<<"\""<<","<< "\""<<price.toUtf8().constData()<<"\""<<","<< "\""<<product_description.toUtf8().constData()<<"\"" <<","<< "\""<<itype.toUtf8().constData()<<"\""<<","<< "\""<<location.toUtf8().constData()<<"\""<<","<< "\""<<quantity.toUtf8().constData()<<"\");";
    cout << query.str();
    mysql_query(mysql, query.str().c_str());
}

int productDatabase:: updateData(QString sno, QString name, QString price , QString product, QString description, QString itype, QString location, QString quantity) {
    stringstream query;
     QString product_description = description + ": " + product;
     if (description == "")
     {
         qDebug()<<product;
        query << "UPDATE " << tableName << " SET " <<"S_NO = \"" << sno.toUtf8().constData() << "\""<< ","<< "NAME = \""<<name.toUtf8().constData()<<"\""<<","<<"PRICE=\""<<price.toUtf8().constData()<<"\""","<<"DESCRIPTION=\""<< product.toUtf8().constData()<<"\"" <<","<<"ITEM_TYPE=\""<<itype.toUtf8().constData()<<"\""<<","<< "LOCATION=\""<<location.toUtf8().constData()<<"\""","<< "QUANTITY=\""<<quantity.toUtf8().constData()<<"\""<<" WHERE S_NO = \""<<sno.toUtf8().constData()<<"\";";
        mysql_query(mysql, query.str().c_str());
        qDebug()<<"KIK";
        return 0;
     }
     qDebug()<<"no";
       string lol = product.toUtf8().constData();
       int len = product.size();
     des = "";
     for (int i = 0; i < len;i++)
     {
         if(lol[i] == ':')
         {
             i++;
             while(i<len)
             {
                 des = des+lol[i];
                 i++;
             }
         }
     }
     if (des == "")
     {
         des = product;
     }
    qDebug()<<description;
    product_description = description +':'+des;

    query << "UPDATE " << tableName << " SET " <<"S_NO = \"" << sno.toUtf8().constData() << "\""<< ","<< "NAME = \""<<name.toUtf8().constData()<<"\""<<","<<"PRICE=\""<<price.toUtf8().constData()<<"\""","<<"DESCRIPTION=\""<< product_description.toUtf8().constData()<<"\"" <<","<<"ITEM_TYPE=\""<<itype.toUtf8().constData()<<"\""<<","<< "LOCATION=\""<<location.toUtf8().constData()<<"\""","<< "QUANTITY=\""<<quantity.toUtf8().constData()<<"\""<<" WHERE S_NO = \""<<sno.toUtf8().constData()<<"\";";

    mysql_query(mysql, query.str().c_str());
    return 0;
}

void productDatabase:: deleteData(QString sno) {
    stringstream query;
    query << "DELETE FROM " << tableName << " WHERE S_NO" << " = \"" << sno.toUtf8().constData() << "\";";
    cout << query.str();
    mysql_query(mysql, query.str().c_str());
}

QString productDatabase:: retrieveData(QString a) {
    previoustext = a;
    string attribute = a.toStdString();
    string tester;
    MYSQL_RES *result;
    MYSQL_ROW row;
    int num_fields, num_records;
    int i = 0, j = 0;
    string attri;
    stringstream query;
    if (attribute == "") {
        query << "SELECT * FROM " << tableName << ";";
    } else {
       query << "SELECT * FROM " << tableName << " WHERE NAME LIKE \"%"<< attribute <<"%"<<"\""<<";";
        tester = query.str();
       qDebug()<<QString::fromStdString(tester);
    }

    mysql_query(mysql, query.str().c_str());

    // result contains all the elements name for eg: ID, NAME
    result = mysql_store_result(mysql);

    // num_fields contains number of elements in a row of a table
    num_fields = mysql_num_fields(result);
    num_records = mysql_num_rows(result);

    vector<vector<string>> retrieveArray(num_records, vector<string> (num_fields));

    /* row contanis all the data from the table eg: "ishan", "98412315"
        it will fetch only one row at a time untill it finish the while loop goes on */
    while ((row = mysql_fetch_row(result)))
        {
            for(i = 0; i < num_fields; i++){
                retrieveArray[j][i] = row[i];
            }
            j++;
        }
    inputtext(a);
    stringJson = jsonifier(toArray(elements), retrieveArray);
//    return stringJson;
//    qDebug()<<QString::fromStdString(stringJson);
    return QString::fromStdString(stringJson);
}

QString request_suggest_complain_Database::previoussearch()
{
    return previoustext;
}

void request_suggest_complain_Database::inputtext(QString text)
{
    previoustext = text;
}

QString request_suggest_complain_Database::outputdata()
{
    return "";
}

request_suggest_complain_Database:: request_suggest_complain_Database() {
    tableName = "suggestion";
    elementsu = "REQUEST_ITEM";
    tableNamesu = "request_item";
    elements = "SUGGESTION,SUGGESTION_TYPE";
    initalize();
}
/*request_suggest_complain_Database:: request_suggest_complain_Database(QString type) {
    elements = tableName ;

    initalize();
}*/
void request_suggest_complain_Database:: initalize() {
    mysql = mysql_init(0);
    mysql = mysql_real_connect(mysql, SERVER, UNAME, PWORD, DBNAME, PORT, NULL, 0);
}

void request_suggest_complain_Database:: insertData(QString a) {
    stringstream query;
    string data = a.toStdString();
    query << "INSERT INTO " << tableName << "(" << elements << ") VALUES (\"" << data << "\");";
    mysql_query(mysql, query.str().c_str());
}

void request_suggest_complain_Database::insertDatasu(QString a, QString b)
{
    stringstream query;
    string data = a.toStdString();
    string type = b.toStdString();
    query << "INSERT INTO " << tableNamesu << "(" << elementsu <<"," <<elementtype<<") VALUES (\"" << data<<"\""   <<", "<<"\"" <<type<<"\");";
    string test = query.str();
    //qDebug()<<QString::fromStdString(test);
    mysql_query(mysql, query.str().c_str());
}

void request_suggest_complain_Database:: updateData(string field, string element, string field2, string data) {
    stringstream query;
    // query << "UPDATE " << tableName << " SET NAME = 'phone' WHERE NAME = 'laptop';";
    query << "UPDATE " << tableName << " SET " << field <<" = \"" << element << "\" WHERE " << field2 << " = \"" << data << "\";";
    mysql_query(mysql, query.str().c_str());
}

void request_suggest_complain_Database:: deleteData(string name) {
    stringstream query;
    // query << "DELETE FROM " << tableName << " WHERE NAME = 'phone';";
    query << "DELETE FROM " << tableName << " WHERE NAME" << " = " << name << ";";
    mysql_query(mysql, query.str().c_str());
}

QString request_suggest_complain_Database:: retrieveDataSuggestion(QString a) {
    previoustext = a;
    string attribute = a.toStdString();
    string tester;
    MYSQL_RES *result;
    MYSQL_ROW row;
    int num_fields, num_records;
    int i = 0, j = 0;
    string attri;
    stringstream query;
    if (attribute == "") {
        query << "SELECT * FROM " << attribute << ";";
    } else {
        query << "SELECT * FROM " << attribute<< ";";
        tester = query.str();
        qDebug()<<QString::fromStdString(tester);
    }

    mysql_query(mysql, query.str().c_str());

    // result contains all the elements name for eg: ID, NAME
    result = mysql_store_result(mysql);

    // num_fields contains number of elements in a row of a table
    num_fields = mysql_num_fields(result);
    num_records = mysql_num_rows(result);

    vector<vector<string>> retrieveArray(num_records, vector<string> (num_fields));

    /* row contanis all the data from the table eg: "ishan", "98412315"
        it will fetch only one row at a time untill it finish the while loop goes on */
    while ((row = mysql_fetch_row(result)))
        {
            for(i = 0; i < num_fields; i++){
                retrieveArray[j][i] = row[i];
            }
            j++;
        }
    inputtext(a);
    stringJson = jsonifier(toArray("S_NO,"+elements), retrieveArray);
    //return stringJson;
    return QString::fromStdString(stringJson);

}

QString request_suggest_complain_Database:: retrieveDataItemRequest(QString a) {
    previoustext = a;
    string attribute = a.toStdString();
    //string tester;
    MYSQL_RES *result;
    MYSQL_ROW row;
    int num_fields, num_records;
    int i = 0, j = 0;
    string attri;
    stringstream query;
    if (attribute == "") {
        query << "SELECT * FROM " << tableNamesu << ";";
    } else {
        query << "SELECT * FROM " << tableNamesu<<";";
        //tester = query.str();
       // qDebug()<<QString::fromStdString(tester);
    }

    mysql_query(mysql, query.str().c_str());

    // result contains all the elements name for eg: ID, NAME
    result = mysql_store_result(mysql);

    // num_fields contains number of elements in a row of a table
    num_fields = mysql_num_fields(result);
    num_records = mysql_num_rows(result);

    vector<vector<string>> retrieveArray(num_records, vector<string> (num_fields));

    /* row contanis all the data from the table eg: "ishan", "98412315"
        it will fetch only one row at a time untill it finish the while loop goes on */
    while ((row = mysql_fetch_row(result)))
        {
            for(i = 0; i < num_fields; i++){
                retrieveArray[j][i] = row[i];
            }
            j++;
        }
    inputtext(a);
    stringJson = jsonifier(toArray("S_NO,"+elementsu), retrieveArray);
    //return stringJson;
    return QString::fromStdString(stringJson);

}



Shift_data:: Shift_data() {
    tableName = "SHIFT_DATA";
    elements = "EMPLOYEE_ID,NAME,AGE,DATEJOINED,MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY,SATURDAY,SUNDAY";
    initalize();
}

QString Shift_data::previoussearch()
{
    return previoustext;
}

void Shift_data::inputtext(QString text)
{
    previoustext = text;
}

QString Shift_data::outputdata()
{
    return "";
}

void Shift_data:: initalize() {
    mysql = mysql_init(0);
    mysql = mysql_real_connect(mysql, SERVER, UNAME, PWORD, DBNAME, PORT, NULL, 0);
}

void Shift_data:: insertData(QString EMPLOYEE_ID, QString NAME,QString AGE, QString DATEJOINED, QString MONDAY,QString TUESDAY,QString WEDNESDAY,QString THURSDAY,QString FRIDAY,QString SATURDAY,QString SUNDAY) {
    stringstream query;
    query << "INSERT INTO " << tableName << "(" << elements << ") VALUES (\"" << EMPLOYEE_ID.toUtf8().constData() << "\""<< ","<< "\""<<NAME.toUtf8().constData()<<"\""<<","<< "\""<<AGE.toUtf8().constData()<<"\""<<","<< "\""<<DATEJOINED.toUtf8().constData()<<"\""<<","<< "\""<<MONDAY.toUtf8().constData()<<"\""<<","<< "\""<<TUESDAY.toUtf8().constData()<<"\"" <<","<< "\""<<WEDNESDAY.toUtf8().constData()<<"\""<<","<< "\""<<THURSDAY.toUtf8().constData()<<"\""<<","<< "\""<<FRIDAY.toUtf8().constData()<<"\""<<","<< "\""<<SATURDAY.toUtf8().constData()<<"\""<<","<< "\""<<SUNDAY.toUtf8().constData()<<"\");";
    cout<<query.str();
    mysql_query(mysql, query.str().c_str());
}

void Shift_data:: updateData(QString EMPLOYEE_ID, QString NAME,QString AGE, QString DATEJOINED,QString MONDAY,QString TUESDAY,QString WEDNESDAY,QString THURSDAY,QString FRIDAY,QString SATURDAY,QString SUNDAY) {
    stringstream query;
    query << "UPDATE " << tableName << " SET " <<"EMPLOYEE_ID = \"" << EMPLOYEE_ID.toUtf8().constData() << "\""<< ","<< "NAME = \""<<NAME.toUtf8().constData()<<"\""<<","<< "AGE = \""<<AGE.toUtf8().constData()<<"\""<<","<< "DATEJOINED = \""<<DATEJOINED.toUtf8().constData()<<"\""<<","<<"MONDAY=\""<<MONDAY.toUtf8().constData()<<"\""","<<"TUESDAY=\""<< TUESDAY.toUtf8().constData()<<"\"" <<","<<"WEDNESDAY=\""<<WEDNESDAY.toUtf8().constData()<<"\""<<","<< "THURSDAY=\""<<THURSDAY.toUtf8().constData()<<"\""","<< "FRIDAY=\""<<FRIDAY.toUtf8().constData()<<"\""","<< "SATURDAY=\""<<SATURDAY.toUtf8().constData()<<"\""","<< "SUNDAY=\""<<SUNDAY.toUtf8().constData()<<"\""<<" WHERE EMPLOYEE_ID = \""<<EMPLOYEE_ID.toUtf8().constData()<<"\";";
    mysql_query(mysql, query.str().c_str());
}

void Shift_data:: deleteData(QString s_no) {
    stringstream query;
    query << "DELETE FROM " << tableName << " WHERE EMPLOYEE_ID" << " = \"" << s_no.toUtf8().constData() << "\";";
    mysql_query(mysql, query.str().c_str());
}

QString Shift_data:: retrieveData(QString a) {
    previoustext = a;
    string attribute = a.toStdString();
    string tester;
    MYSQL_RES *result;
    MYSQL_ROW row;
    int num_fields, num_records;
    int i = 0, j = 0;
    string attri;
    stringstream query;
    if (attribute == "") {
        query << "SELECT * FROM " << tableName << ";";
    } else {
       query << "SELECT * FROM " << tableName <<" WHERE NAME = \""<<attribute<<"\""<<";";
        //tester = query.str();
        string ishan = "xue";
       //qDebug()<<QString::fromStdString(tester);
    }

    mysql_query(mysql, query.str().c_str());

    // result contains all the elements name for eg: ID, NAME
    result = mysql_store_result(mysql);

    // num_fields contains number of elements in a row of a table
    num_fields = mysql_num_fields(result);
    num_records = mysql_num_rows(result);

    vector<vector<string>> retrieveArray(num_records, vector<string> (num_fields));

    /* row contanis all the data from the table eg: "ishan", "98412315"
        it will fetch only one row at a time untill it finish the while loop goes on */
    while ((row = mysql_fetch_row(result)))
        {
            for(i = 0; i < num_fields; i++){
                retrieveArray[j][i] = row[i];
            }
            j++;
        }
    inputtext(a);
    stringJson = jsonifier(toArray(elements), retrieveArray);
//    return stringJson;
//    qDebug()<<QString::fromStdString(stringJson);
    return QString::fromStdString(stringJson);
}

void createDatabaseTable() {
    MYSQL* mysql;
    mysql = mysql_init(0);
     mysql = mysql_real_connect(mysql, SERVER, UNAME, PWORD, "", PORT, NULL, 0);
    mysql_query(mysql, "DROP DATABASE SUPERMARKET_DB");
    mysql_query(mysql, "CREATE DATABASE SUPERMARKET_DB");
    mysql = mysql_init(0);
    mysql = mysql_real_connect(mysql, SERVER, UNAME, PWORD, DBNAME, PORT, NULL, 0);

    if(mysql) {
        //creating a table
       mysql_query(mysql, "CREATE TABLE CUSTOMER_INFO(ID int NOT NULL AUTO_INCREMENT, NAME varchar(20) NOT NULL, PRIMARY KEY(ID))");
       mysql_query(mysql, "CREATE TABLE EMPLOYEE_INFO ( ID int NOT NULL AUTO_INCREMENT, NAME "
                           "varchar(30) NOT NULL, EMAIL varchar(35) NOT NULL, PASSWORD "
                           "varchar(16) NOT NULL, GENDER varchar(1) NOT NULL, CONTACT_NUMBER varchar(12)"
                           "NOT NULL, ADDRESS varchar(15) NOT NULL, DATE_OF_BIRTH varchar(12) NOT NULL,"
                           "WORKING_SINCE varchar(12) NOT NULL, PRIMARY KEY (ID))");

        mysql_query(mysql, "CREATE TABLE OWNER_INFO ( ID int NOT NULL AUTO_INCREMENT, NAME "
                           "varchar(30) NOT NULL, EMAIL varchar(35) NOT NULL, PASSWORD "
                           "varchar(20) NOT NULL, GENDER varchar(1) NOT NULL, CONTACT_NUMBER varchar(12)"
                           "NOT NULL,  DATE_OF_BIRTH varchar(12) NOT NULL, ADDRESS varchar(15)"
                           "NOT NULL, PRIMARY KEY (ID))");

        mysql_query(mysql, "CREATE TABLE PRODUCT_INFO ( S_NO int NOT NULL AUTO_INCREMENT, NAME "
                           "varchar(40) NOT NULL, PRICE FLOAT(8,2) NOT NULL, DESCRIPTION  varchar(30)"
                           " NOT NULL, ITEM_TYPE varchar(25) NOT NULL, LOCATION varchar(20)"
                           " NOT NULL, QUANTITY INT, NO_OF_ITEM_SOLD INT DEFAULT 0, PRIMARY KEY(S_NO))");

        mysql_query(mysql, "CREATE TABLE REQUEST_ITEM (S_NO int NOT NULL AUTO_INCREMENT, REQUEST_ITEM varchar(30)"
                           "NOT NULL, PRIMARY KEY(S_NO))");

        mysql_query(mysql, "CREATE TABLE SUGGESTION (S_NO int NOT NULL AUTO_INCREMENT, SUGGESTION varchar(200), SUGGESTION_TYPE varchar(100)"
                           "NOT NULL, PRIMARY KEY(S_NO))");

        mysql_query(mysql, "CREATE TABLE COMPLAIN_PRODUCT (S_NO int NOT NULL AUTO_INCREMENT, COMPLAIN_PRODUCT varchar(200)"
                           "NOT NULL, PRIMARY KEY(S_NO))");

        mysql_query(mysql, "CREATE TABLE COMPLAIN_EMPLOYEE (S_NO int NOT NULL AUTO_INCREMENT, COMPLAIN_EMPLOYEE varchar(200)"
                           "NOT NULL, PRIMARY KEY(S_NO))");

        mysql_query(mysql, "CREATE TABLE SHIFT_DATA (EMPLOYEE_ID int NOT NULL AUTO_INCREMENT, NAME varchar(30) "
                           "NOT NULL, AGE int NOT NULL, DATEJOINED varchar(25) NOT NULL, MONDAY varchar(25), "
                           "TUESDAY varchar(25), WEDNESDAY varchar(25), THURSDAY varchar(25), FRIDAY varchar(25), SATURDAY varchar(25),"
                           "SUNDAY varchar(25), "
                           "PRIMARY KEY(EMPLOYEE_ID))");
        //ending

        insertDataIntoDatabase();
        insertEmployeeDataIntoDatabase();
        insertShiftDataIntoDatabase();

        mysql_close(mysql);
    }
}

void insertDataIntoDatabase() {
    MYSQL* mysql;
    mysql = mysql_init(0);
    mysql = mysql_real_connect(mysql, SERVER, UNAME, PWORD, DBNAME, PORT, NULL, 0);

    stringstream query;

    query << "INSERT INTO PRODUCT_INFO(NAME, PRICE, DESCRIPTION, ITEM_TYPE, LOCATION, QUANTITY) VALUES " <<
        "('Mango', 150, 'Shipping Date: 2020-03-26', 'Groceries', 'Section A', '9'), "

        "('Cauliflower', 90, 'Shipping Date: 2020-04-06', 'Groceries', 'Section A', '7'), "

        "('Chicken', 360, 'Shipping Date: 2020-05-15', 'Groceries', 'Section A', '3'), "

        "('Milk', 90, 'Shipping Date: 2020-04-24', 'Groceries', 'Section A', '8'), "

        "('Milk Curd', 120, 'Shipping Date: 2020-04-24', 'Groceries', 'Section A', '10'), "

        "('Rice', 365, 'Shipping Date: 2020-04-16', 'Groceries', 'Section A', '12'), "

        "('Light Blue Colored Fancy Pen', 150, 'Shipping Date: 2019-12-26', 'Stationery', 'Section B', '7'), "

        "('Black Pen', 150, 'Shipping Date: 2019-12-26', 'Stationery', 'Section B', '6'), "

        "('Summer Love', 450, 'Shipping Date: 2020-07-28', 'Stationery', 'Section B', '8'), "

        "('You Dont Know JS', 1200, 'Shipping Date: 2020-11-27', 'Stationery', 'Section B', '9'), "

        "('Stationery Box', 600, 'Shipping Date: 2019-10-10', 'Stationery', 'Section B', '4'), "

        "('Nataraj Pencils', 70, 'Shipping Date: 2020-09-24', 'Stationery', 'Section B', '6'), "

        "('Samsung Galaxy A50', 35999, 'Warranty: 1 Year', 'Electronics', 'Section C', '1'), "

        "('Laptop DELL Inspiron 5583', 80200, 'Warranty: 3 Year', 'Electronics', 'Section C', '10'), "

        "('Laptop Lenovo 268', 75000, 'Warranty: 2 Year', 'Electronics', 'Section C', '15'), "

        "('Laptop Acer 5XT', 100200, 'Warranty: 3 Year', 'Electronics', 'Section C', '6'), "

        "('Laptop Mac Book', 150000, 'Warranty: 2 Year', 'Electronics', 'Section C', '2'), "

        "('Fridge', 65250, 'Warranty: 2 Year', 'Electronics', 'Section C', '12'), "

        "('Sony Bravia R202G HD LED TV', 16999, 'Warranty: 1.5 Year', 'Electronics', 'Section C', '4'), "

        "('Samsung Solo Microwave Oven', 13999, 'Warranty: 6 Month', 'Electronics', 'Section C', '3'), "

        "('Coca-cola', 120, 'Expiry-date: 2021-02-26', 'Beverage', 'Section D', '5'), "

        "('Red Wine', 4500, 'Expiry-date: 2021-05-16', 'Beverage', 'Section D', '6'), "

        "('Tubrog', 400, 'Expiry-date: 2021-01-16', 'Beverage', 'Section D', '10'), "

        "('Fanta', 140, 'Expiry-date: 2021-05-16', 'Beverage', 'Section D', '3'), "

        "('Vodka', 1200, 'Expiry-date: 2022-01-14', 'Beverage', 'Section D', '2'), "

        "('Nike hat', 550, 'Manufacture-date: 2019-01-14', 'Clothing', 'Section E', '10'), "

        "('Adidas Shoes', 3500, 'Manufacture-date: 2018-11-06', 'Clothing', 'Section E', '1'), "

        "('Belly Pant', 2500, 'Manufacture-date: 2020-01-14', 'Clothing', 'Section E', '7'), "

        "('Black T-Shirt', 1400, 'Manufacture-date: 2019-11-16', 'Clothing', 'Section E', '8'), "

        "('Gucci belt', 12000, 'Manufacture-date: 2019-05-26', 'Clothing', 'Section E', '3');";

    mysql_query(mysql, query.str().c_str());
}

void insertEmployeeDataIntoDatabase() {
    MYSQL* mysql;
    mysql = mysql_init(0);
    mysql = mysql_real_connect(mysql, SERVER, UNAME, PWORD, DBNAME, PORT, NULL, 0);

    stringstream query;
    stringstream ownerquery;
    stringstream dab;

    query << "INSERT INTO EMPLOYEE_INFO(NAME, EMAIL, PASSWORD, GENDER, CONTACT_NUMBER, ADDRESS, DATE_OF_BIRTH, WORKING_SINCE) VALUES " <<
        "('Ishan Panta', 'ishan.panta@gmail.com', 'password', 'M', '9841234629', 'banepa', '12-10-2000', '06-08-2016'), "
        "('Mulyankan Sharma', 'mulyankan.sharma@gmail.com', 'password', 'M', '9841234567', 'butwal', '12-10-2001', '01-16-2017'), "
        "('Abiral Banjade', 'abiral.banjade@gmail.com', 'password', 'M', '9861234598', 'kathmandu', '12-10-2001', '01-12-2018'), "
        "('Sangharsha Paudel', 'sangharsha.paudel@gmail.com', 'password', 'M', '9841123456', 'hetauda', '12-10-2001', '01-12-2018'), "
        "('Rushab Humagain', 'rushab.humagain@gmail.com', 'password', 'M', '9841984532', 'palpa', '12-10-2000', '01-12-2018'), "
        "('Aatish Shrestha', 'aatish.shrestha@gmail.com', 'password', 'M', '9868234685', 'illam', '12-10-2000', '01-12-2018'), "
        "('Yugesh Luitel', 'yugesh.luitel@gmail.com', 'password', 'M', '9841354795', 'dhulikhel', '12-10-2000', '01-12-2018'), "
        "('Arpan Koirala', 'arpan.koirala@gmail.com', 'password', 'M', '9841678954', 'kathmandu', '12-10-2001', '01-12-2018'), "
        "('Abijeet Sharma', 'abiral.sharma@gmail.com', 'password', 'M', '9861597634', 'japan', '12-10-2000', '01-12-2018'), "
        "('Manisha Sharma', 'manisha.sharma@gmail.com', 'password', 'F', '9841364795', 'india', '12-10-2001', '01-12-2018'), "
        "('Bijay Shahi', 'bijay.shahi@gmail.com', 'password', 'M', '9868953176', 'mustang', '12-10-2000', '01-12-2018'), "
        "('John Cena', 'john.cena@gmail.com', 'password', 'F', '9867597236', 'america', '12-10-2001', '01-12-2018');";

    ownerquery<<"INSERT INTO OWNER_INFO(NAME, EMAIL, PASSWORD, GENDER, CONTACT_NUMBER, DATE_OF_BIRTH, ADDRESS) VALUES "<<
                "('Ishan', 'ishan@gmail.com', 'password', 'M', '9841234629', '12-10-2000', 'banepa'), "
                "('Mulyankan', 'mulyankan@gmail.com', 'password', 'M', '9841234567', '12-10-2001', 'butwal'), "
                "('Sangharsha', 'sangharsha@gmail.com', 'password', 'M', '9841123456', '12-10-2001', 'hetauda'), "
                "('Abiral', 'abiral@gmail.com', 'password', 'M', '9841354795','12-10-2000','kathmandu');";

    mysql_query(mysql, query.str().c_str());
    mysql_query(mysql, ownerquery.str().c_str());
}

void insertShiftDataIntoDatabase() {
    MYSQL* mysql;
    mysql = mysql_init(0);
    mysql = mysql_real_connect(mysql, SERVER, UNAME, PWORD, DBNAME, PORT, NULL, 0);

    stringstream query;

    query << "INSERT INTO SHIFT_DATA(NAME,AGE,DATEJOINED,MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY,SATURDAY,SUNDAY) VALUES " <<
             "('Ishan Panta', '19', '01-12-2018', '9AM-5PM', '8AM-3PM', '11AM-1PM', '8PM-11PM', '9AM-1PM', '3PM-7AM', '8AM-3AM'), "
             "('Mulyankan Sharma', '20', '01-12-2018', '10AM-5PM', '8AM-3PM', '11AM-1PM', '8PM-11PM', '9AM-1PM', '3PM-7AM', '8AM-3AM'), "
             "('Abiral Banjade', '24', '06-21-2016', '11AM-5PM', '8AM-3PM', '11AM-1PM', '4PM-11PM', '9AM-1PM', '3PM-7AM', '8AM-3AM'), "
             "('Sangharsha Paudel', '26', '01-12-2018', '9AM-5PM', '8AM-3PM', '11AM-1PM', '8PM-11PM', '9AM-1PM', '3PM-7AM', '8AM-3AM'), "
             "('Rushab Humagain', '18', '01-12-2018', '9AM-5PM', '8AM-3PM', '11AM-1PM', '8PM-11PM', '9AM-1PM', '3PM-7AM', '8AM-3AM'), "
             "('Aatish Shrestha', '26', '01-12-2018', '9AM-5PM', '8AM-3PM', '11AM-1PM', '8PM-11PM', '9AM-1PM', '3PM-7AM', '8AM-3AM'), "
             "('Yugesh Luitel', '19', '01-12-2018', '9AM-5PM', '8AM-3PM', '11AM-1PM', '8PM-11PM', '9AM-1PM', '3PM-7AM', '8AM-3AM'), "
             "('Arpan Koirala', '22', '01-12-2018', '9AM-5PM', '8AM-3PM', '11AM-1PM', '8PM-11PM', '9AM-1PM', '3PM-7AM', '8AM-3AM'), "
             "('Abijeet Sharma', '23', '01-12-2018', '9AM-5PM', '8AM-3PM', '11AM-1PM', '8PM-11PM', '9AM-1PM', '3PM-7AM', '8AM-3AM'), "
             "('Manisha Sharma', '24', '01-12-2018', '9AM-5PM', '8AM-3PM', '11AM-1PM', '8PM-11PM', '9AM-1PM', '3PM-7AM', '8AM-3AM'), "
             "('Bijay Shahi', '21', '01-12-2018', '9AM-5PM', '8AM-3PM', '11AM-1PM', '8PM-11PM', '9AM-1PM', '3PM-7AM', '8AM-3AM'), "
             "('Johny Cena', '24', '01-12-2018', '9AM-5PM', '8AM-3PM', '11AM-1PM', '8PM-11PM', '9AM-1PM', '3PM-7AM', '8AM-3AM');";
    mysql_query(mysql, query.str().c_str());
}



void closedatabase()
{
    MYSQL* mysql;
    mysql = mysql_init(0);
    mysql = mysql_real_connect(mysql, SERVER, UNAME, PWORD, DBNAME, PORT, NULL, 0);
    mysql_close(mysql);
}
