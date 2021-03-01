#include "cppbinding.h"

cppBinding::cppBinding(QObject *parent) : QObject(parent)
{

}

string cppBinding::jsonBuilder(vector<string> attribute, vector<vector<string>> data)
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


