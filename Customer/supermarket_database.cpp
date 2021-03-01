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

employeeDatabase:: employeeDatabase() {
    tableName = "EMPLOYEE_INFO";
    elements = "NAME,EMAIL,PASSWORD,GENDER,CONTACT_NUMBER,ADDRESS,DATE_OF_BIRTH,WORKING_SINCE";
    initalize();
}

void employeeDatabase:: initalize() {
    mysql = mysql_init(0);
    mysql = mysql_real_connect(mysql, SERVER, UNAME, PWORD, DBNAME, PORT, NULL, 0);
}

void employeeDatabase:: insertData(string data) {
    stringstream query;
    query << "INSERT INTO " << tableName << "(" << elements << ") VALUES (" << data << ");";
    mysql_query(mysql, query.str().c_str());
}

/*NOTE: 'field' is the table header name (eg ID,NAME), element is the table (eg "mulu") */
void employeeDatabase:: updateData(string field, string element, string field2, string data) {
    stringstream query;
    // query << "UPDATE " << tableName << " SET NAME = 'phone' WHERE NAME = 'laptop';";
    query << "UPDATE " << tableName << " SET " << field <<" = \"" << element << "\" WHERE " << field2 << " = \"" << data << "\";";
    mysql_query(mysql, query.str().c_str());
}

void employeeDatabase:: deleteData(string name) {
    stringstream query;
    // query << "DELETE FROM " << tableName << " WHERE NAME = 'phone';";
    query << "DELETE FROM " << tableName << " WHERE NAME" << " = " << name << ";";
    mysql_query(mysql, query.str().c_str());
}

string employeeDatabase:: retrieveData(string attribute) {
    MYSQL_RES *result;
    MYSQL_ROW row;
    int num_fields, num_records;
    int i = 0, j = 0;
    string attri;
    stringstream query;
    if (attribute == "") {
        query << "SELECT * FROM " << tableName << ";";
    } else {
        query << "SELECT * FROM " << tableName << " WHERE NAME LIKE % \"" << attribute <<"\"%;";
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

int employeeDatabase::authentication(QString name, QString password)
{
    MYSQL_RES* res;
    stringstream query;

    query<<"SELECT * FROM EMPLOYEE_INFO WHERE NAME = \""<<name.toStdString()<<"\" AND PASSWORD =\""<<password.toStdString()<<"\"";
    mysql_query(mysql, query.str().c_str());

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

void productDatabase::makeBill(QString items, QString quantity)
{
    previoustext = items;
    int num_fields, num_records;

    MYSQL_RES *result;
    MYSQL_ROW row;
    stringstream query;
    string query2;
    vector<string> list = toArray(items.toStdString());
    vector<string> listQuantity = toArray(quantity.toStdString());
    query << "SELECT NO_OF_ITEM_SOLD FROM " << tableName << " WHERE ";
    for(int k = 0; k<list.size();k++){
        query<<"S_NO = "<< list[k] <<" OR ";
    }
    query2 = query.str().substr(0,query.str().length()-4);
    query2+=";";
    cout<<query2;
    mysql_query(mysql, query2.c_str());
    query.str(std::string());
    // result contains all the elements name for eg: ID, NAME
    result = mysql_store_result(mysql);

    // num_fields contains number of elements in a row of a table
    num_fields = mysql_num_fields(result);
    num_records = mysql_num_rows(result);

    vector<vector<string>> retrieveArray(num_records, vector<string> (num_fields));

    /* row contanis all the data from the table eg: "ishan", "98412315"
        it will fetch only one row at a time untill it finish the while loop goes on */
    int i = 0, j = 0;
    while ((row = mysql_fetch_row(result)))
        {
            for(i = 0; i < num_fields; i++){
                retrieveArray[j][i] = row[i];
            }
            j++;

        }
    for(int k = 0; k < listQuantity.size(); k++){
        int total = stoi(retrieveArray[k][0]) + stoi(listQuantity[k]);
        query << "UPDATE " << tableName << " SET " <<"NO_OF_ITEM_SOLD = \"" << total << "\" WHERE S_NO = \"" << list[k] <<"\";" ;
        mysql_query(mysql, query.str().c_str());
        query.str(std::string());
    }
}


productDatabase:: productDatabase() {
    tableName = "PRODUCT_INFO";
    elements = "S_NO,NAME,PRICE,DESCRIPTION,ITEM_TYPE,LOCATION,QUANTITY";
    initalize();
}

void productDatabase:: initalize() {
    mysql = mysql_init(0);
    mysql = mysql_real_connect(mysql, SERVER, UNAME, PWORD, DBNAME, PORT, NULL, 0);
}

void productDatabase:: insertData(QString sno, QString name, QString price , QString product, QString description, QString itype, QString location, QString quantity) {
    stringstream query, ss;
    des = description;
    QString product_description = description + ": " + product;
    query << "INSERT INTO " << tableName << "(" << elements << ") VALUES (\"" << sno.toUtf8().constData() << "\""<< ","<< "\""<<name.toUtf8().constData()<<"\""<<","<< "\""<<price.toUtf8().constData()<<"\""<<","<< "\""<<product_description.toUtf8().constData()<<"\"" <<","<< "\""<<itype.toUtf8().constData()<<"\""<<","<< "\""<<location.toUtf8().constData()<<"\""<<","<< "\""<<quantity.toUtf8().constData()<<"\");";
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

void productDatabase:: deleteData(QString id) {
    stringstream query;

    // query << "DELETE FROM " << tableName << " WHERE NAME = 'phone';";

    query << "DELETE FROM " << tableName << " WHERE S_NO" << " = \"" << id.toUtf8().constData() << "\";";

    string temp = query.str();
    //qDebug()<<QString::fromStdString(temp);
    mysql_query(mysql, query.str().c_str());
}

QString productDatabase:: retrieveData(QString a) {
    //cout << attribute << endl;
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
        query << "SELECT * FROM " << tableName << ";";
    } else {
       query << "SELECT * FROM " << tableName << " WHERE NAME LIKE \"%"<< attribute <<"%"<<"\""<<";";
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

Shift_data:: Shift_data() {
    tableName = "SHIFT_DATA";
    elements = "EMPLOYEEID,NAME,AGE,DATEJOINED,MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY,SATURDAY,SUNDAY";
    initalize();
}

void Shift_data:: initalize() {
    mysql = mysql_init(0);
    mysql = mysql_real_connect(mysql, SERVER, UNAME, PWORD, DBNAME, PORT, NULL, 0);
}

void Shift_data:: insertData(string data) {
    stringstream query;
    query << "INSERT INTO " << tableName << "(" << elements << ") VALUES (" << data << ");";
    mysql_query(mysql, query.str().c_str());
}

void Shift_data:: updateData(string field, string element, string field2, string data) {
    stringstream query;
    // query << "UPDATE " << tableName << " SET NAME = 'phone' WHERE NAME = 'laptop';";
    query << "UPDATE " << tableName << " SET " << field <<" = \"" << element << "\" WHERE " << field2 << " = \"" << data << "\";";
    mysql_query(mysql, query.str().c_str());
}

void Shift_data:: deleteData(string name) {
    stringstream query;
    // query << "DELETE FROM " << tableName << " WHERE NAME = 'phone';";
    query << "DELETE FROM " << tableName << " WHERE NAME" << " = " << name << ";";
    mysql_query(mysql, query.str().c_str());
}

QString Shift_data:: retrieveData(QString a) {
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
        query << "SELECT * FROM " << tableName << ";";
    } else {
       query << "SELECT * FROM " << tableName << " WHERE NAME LIKE \"%"<< attribute <<"%"<<"\""<<";";
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
    stringJson = jsonifier(toArray(elements), retrieveArray);
//    return stringJson;
    //qDebug()<<QString::fromStdString(stringJson);
    return QString::fromStdString(stringJson);
}


void closedatabase()
{
    MYSQL* mysql;
    mysql = mysql_init(0);
    mysql = mysql_real_connect(mysql, SERVER, UNAME, PWORD, DBNAME, PORT, NULL, 0);
    mysql_close(mysql);
}
