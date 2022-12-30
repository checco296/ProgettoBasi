#include <cstdio>
#include <iostream>
#include <fstream>
#include "dependencies/include/libpq-fe.h"
//#include "./funzioni.h"

#define PG_HOST     "127.0.0.1"
#define PG_USER     "postgres"
#define PG_DB       "Progetto_f1"
#define PG_PORT     5432

using namespace std;

int main(int argc, char **argv)
{   
    bool log_in = false;
    int query;

    char password[30];
    char conninfo [250];
    PGconn * conn = PQconnectdb(conninfo);

    while(!log_in)
    {
        cout<<"inserire Password: ";
        cin >> password;
        cout<<endl;
        sprintf(conninfo,"user=%s password=%s dbname=%s hostaddr=%s port=%d",
        PG_USER,password,PG_DB,PG_HOST,PG_PORT);

        conn = PQconnectdb(conninfo);
        if(PQstatus(conn) != CONNECTION_OK)
        {
            cout << "Errore di connessione\n" << PQerrorMessage(conn);
            PQfinish(conn);
            exit(1);
        }
        else
        {
            cout << "connessione avvenuta correttamente\n";
            log_in = true;
        }
    }

    while(log_in)
    {
        cout<<"------------------------------------------------\n";
        cout << "Digita il numero dell'informazione richiesta\n";
        cout << "\t[1] Hot_lap: visualizza chi ha realizzato il miglior giro in assoluto in una determinata pista\n";
        cout << "\t[2] Classifica: visualizza la classifica piloti e costruttori di un anno selezionato\n";
        cout << "\t[3] DNF: visualizza quanti piloti hanno subito un numero di DNF a scelta in una stagione a scelta\n";
        cout << "\t[4] Info: visualizza le informazioni riguardo ai veicoli di ogni squadra\n";
        cout << "\t[5] Risultati Qualifica: visualizza la griglia di partenza di una determinata gara\n"; 
        cout << "\t[6] Da fare\n";
        cout << "\t[0] Esci\n";
        cout << endl << "La query selezionata e': ";
        cin >> query;
        cout<<"------------------------------------------------\n";
        //log_in = queryExecution(conn, query);
    }
    PQfinish(conn);
    return 0;
}

//g++ main.cpp -L dependencies\lib -lpq -o QueryExecutor.exe

/*

cout <<"Query 1\n";
        PGresult *res;
        res = PQexec(conn,"SELECT pilota.nome,pilota.cognome, COUNT(*) AS ritiri_stagionali FROM prestazione,partecipante,pilota WHERE prestazione.anno = 2022 AND prestazione.ritiro = 'Y' AND prestazione.codice_fiscale = partecipante.codice_fiscale AND prestazione.vettura = partecipante.vettura AND partecipante.codice_fiscale = pilota.codice_fiscale GROUP BY pilota.codice_fiscale HAVING COUNT(*) >= 5 ORDER BY ritiri_stagionali DESC;");
        checkResults(res,conn);

        int tuple = PQntuples(res);
        int campi = PQnfields(res);

        for(int i=0;i<campi;++i)
        {
            cout << PQfname(res,i)<<"\t\t\t";
        }
        cout <<endl;

        for(int i = 0;i<tuple;++i)
        {
            for(int j=0;j<campi;++j)
            {
                cout<<PQgetvalue(res,i,j)<<"\t\t\t";
            }
            cout<<endl;
        }

*/