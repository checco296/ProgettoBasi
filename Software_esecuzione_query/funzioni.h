/*
bool checkQuery(PGconn *connection, std::string query); //vedere se serve

bool checkIfIsValid(PGconn *connection, std::string select_value, std::string from_value, std::string value_to_find);//vedere se serve

bool queryUno(PGconn *connection);

bool queryDue(PGconn *connection);

bool queryTre(PGconn *connection);

bool queryQuattro(PGconn *connection);

bool queryCinque(PGconn *connection);

bool querySei(PGconn *connection);

bool queryExecution(PGconn *connection, char operation);
*/

void checkResults(PGresult* res,const PGconn* conn) //da cambiare nome
{
    if(PQresultStatus(res) != PGRES_TUPLES_OK)
    {
        cout << "Risultati inconsistenti" << PQerrorMessage(conn);
        PQclear(res);
        exit(1);
    }
}

void stampatuple(PGresult* res)
{
    int tuple = PQntuples(res);
    int campi = PQnfields(res);

    for(int i=0;i<campi;++i)
    {
        cout << PQfname(res,i)<<"\t\t\t";
    }
    cout<<endl;
    for(int i = 0;i<tuple;++i)
    {
        for(int j=0;j<campi;++j)
        {
            cout<<PQgetvalue(res,i,j)<<"\t\t\t";
        }
        cout<<endl;
    }
}

void hotlap(PGconn* conn)
{
    char pista[30];
    cout<<"Inserire il nome della pista: ";
    cin>>pista;

    cout <<"Query 1\n";
        PGresult *res;
        res = PQexec(conn,"SELECT pilota.nome,pilota.cognome, COUNT(*) AS ritiri_stagionali FROM prestazione,partecipante,pilota WHERE prestazione.anno = 2022 AND prestazione.ritiro = 'Y' AND prestazione.codice_fiscale = partecipante.codice_fiscale AND prestazione.vettura = partecipante.vettura AND partecipante.codice_fiscale = pilota.codice_fiscale GROUP BY pilota.codice_fiscale HAVING COUNT(*) >= 5 ORDER BY ritiri_stagionali DESC;");
        checkResults(res,conn);
}