#include <cstdio>
#include <iostream>
#include <fstream>
#include "dependencies/include/libpq-fe.h"

#define PG_HOST     "127.0.0.1"
#define PG_USER     "postgres"
#define PG_DB       "Progetto_f1"
#define PG_PASS     "cucciolotto296"
#define PG_PORT     5432

using namespace std;

void checkResults(PGresult* res,const PGconn* conn)
{
    if(PQresultStatus(res) != PGRES_TUPLES_OK)
    {
        cout << "Risultati inconsistenti" << PQerrorMessage(conn);
        PQclear(res);
        exit(1);
    }
}

int main(int argc, char **argv)
{   
    cout <<"Start"<<endl;

    char conninfo [250];
    sprintf(conninfo,"user=%s password=%s dbname=%s hostaddr=%s port=%d",
    PG_USER,PG_PASS,PG_DB,PG_HOST,PG_PORT);

    PGconn * conn = PQconnectdb(conninfo); //puntatore di tipo PGconn

    if(PQstatus(conn) != CONNECTION_OK)
    {
        cout << "Errore di connessione\n" << PQerrorMessage(conn);
        PQfinish(conn);
        exit(1);
    }

    cout << "connessione avvenuta correttamente\n";


    cout <<"Query 1\n";
    PGresult *res;
    res = PQexec(conn,"SELECT pilota.nome,pilota.cognome, COUNT(*) AS ritiri_stagionali FROM prestazione,partecipante,pilota WHERE prestazione.anno = 2022 AND prestazione.ritiro = 'Y' AND prestazione.codice_fiscale = partecipante.codice_fiscale AND prestazione.vettura = partecipante.vettura AND partecipante.codice_fiscale = pilota.codice_fiscale GROUP BY pilota.codice_fiscale HAVING COUNT(*) >= 5 ORDER BY ritiri_stagionali DESC;");
    checkResults(res,conn);

    int tuple = PQntuples(res);
    int campi = PQnfields(res);

    for(int i=0;i<campi;++i)
    {
        cout << PQfname(res,i)<<"\t\t";
    }
    cout <<endl;

    for(int i = 0;i<tuple;++i)
    {
        for(int j=0;j<campi;++j)
        {
            cout<<PQgetvalue(res,i,j)<<"\t\t";
        }
        cout<<endl;
    }

    PQclear(res);

    PQfinish(conn);
    return 0;
}