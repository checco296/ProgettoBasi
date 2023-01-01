#include <cstdio>
#include <iostream>
#include <iomanip>
#include <fstream>
#include <string>
using namespace std;

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

    for(int i = 0;i<250;++i)
    {
        cout<<"=";
    }
    cout<<endl;

    for(int i=0;i<campi;++i)
    {
        cout << left << setw(40) << PQfname(res,i);
    }
    cout<<endl;
    for(int i = 0;i<tuple;++i)
    {
        for(int j=0;j<campi;++j)
        {
            cout << left << setw(40) << PQgetvalue(res,i,j);
        }
        cout<<endl;
    }
    for(int i = 0;i<250;++i)
    {
        cout<<"=";
    }
    cout<<endl;
}

void hotlap(PGconn* conn)
{
    string pista;
    string query = "SELECT circuito.nome,gara.anno,gara.hot_lap,pilota.nome,pilota.cognome,prestazione.vettura FROM circuito,gara,pilota,prestazione WHERE circuito.nome = $1 AND gara.nome_gara = circuito.nome AND gara.pilota_veloce = pilota.codice_fiscale AND gara.hot_lap = (SELECT MIN(gara.hot_lap) FROM gara WHERE gara.nome_gara = $1) AND gara.pilota_veloce = prestazione.codice_fiscale AND gara.anno = prestazione.anno AND gara.gara_num = prestazione.gara_num;";
    cout<<"Inserire il nome della pista: ";
    cin>>pista;
    const char* parametro1 = pista.c_str();

    PGresult *res = PQprepare(conn,"hot_lap",query.c_str(),1,NULL);

    res = PQexecPrepared(conn,"hot_lap",1,&parametro1,NULL,0,0);
    checkResults(res,conn);
    stampatuple(res);
}

void classifica(PGconn* conn)
{
    int anno;
    int pil_cos;
    cout<<"inserire l'anno di cui si vuole visualizzare la classifica: ";
    cin>>anno;
    string supp = to_string(anno);
    const char* parametro1 = supp.c_str();
    cout<<"0 per classifica piloti, 1 per classifica costruttori: ";
    cin>>pil_cos;
    string query_costruttori = "SELECT squadra.nome, SUM(punti_gara.punti) as punti_totali FROM(SELECT prestazione.codice_fiscale,prestazione.posizione_arrivo,CASE WHEN prestazione.posizione_arrivo = 1 THEN 25 WHEN prestazione.posizione_arrivo = 2 THEN 18 WHEN prestazione.posizione_arrivo = 3 THEN 15 WHEN prestazione.posizione_arrivo = 4 THEN 12 WHEN prestazione.posizione_arrivo = 5 THEN 10 WHEN prestazione.posizione_arrivo = 6 THEN 8 WHEN prestazione.posizione_arrivo = 7 THEN 6 WHEN prestazione.posizione_arrivo = 8 THEN 4 WHEN prestazione.posizione_arrivo = 9 THEN 2 WHEN prestazione.posizione_arrivo = 10 THEN 1 ELSE 0 END punti FROM prestazione WHERE prestazione.anno = $1::int ORDER BY prestazione.gara_num,prestazione.posizione_arrivo)AS punti_gara,pilota,partecipante,autovettura,squadra WHERE punti_gara.codice_fiscale = partecipante.codice_fiscale AND partecipante.vettura = autovettura.nome AND autovettura.anno = $1::int AND autovettura.squadra = squadra.nome AND partecipante.codice_fiscale = pilota.codice_fiscale GROUP BY squadra.nome ORDER BY punti_totali DESC;";
    string query_piloti      = "SELECT pilota.nome,pilota.cognome, SUM(punti_gara.punti) as punti_totali FROM(SELECT prestazione.codice_fiscale,prestazione.posizione_arrivo,CASE WHEN prestazione.posizione_arrivo = 1 THEN 25 WHEN prestazione.posizione_arrivo = 2 THEN 18 WHEN prestazione.posizione_arrivo = 3 THEN 15 WHEN prestazione.posizione_arrivo = 4 THEN 12 WHEN prestazione.posizione_arrivo = 5 THEN 10 WHEN prestazione.posizione_arrivo = 6 THEN 8 WHEN prestazione.posizione_arrivo = 7 THEN 6 WHEN prestazione.posizione_arrivo = 8 THEN 4 WHEN prestazione.posizione_arrivo = 9 THEN 2 WHEN prestazione.posizione_arrivo = 10 THEN 1 ELSE 0 END punti FROM prestazione WHERE prestazione.anno = $1::int ORDER BY prestazione.gara_num,prestazione.posizione_arrivo)AS punti_gara,pilota,partecipante,autovettura WHERE punti_gara.codice_fiscale = partecipante.codice_fiscale AND partecipante.vettura = autovettura.nome AND autovettura.anno = $1::int AND partecipante.codice_fiscale = pilota.codice_fiscale GROUP BY pilota.codice_fiscale ORDER BY punti_totali DESC;";

    PGresult* res;
    if(pil_cos == 1)
    {    
        res = PQprepare(conn,"classifica_costruttori",query_costruttori.c_str(),1,NULL);
        res = PQexecPrepared(conn,"classifica_costruttori",1,&parametro1,NULL,0,0);
    }
    else
    {
        res = PQprepare(conn,"classifica_piloti",query_piloti.c_str(),1,NULL);
        res = PQexecPrepared(conn,"classifica_piloti",1,&parametro1,NULL,0,0);
    }

    checkResults(res,conn);
    stampatuple(res);
}

void DNF(PGconn* conn)
{
    int anno;
    int n_ritiri;
    cout<<"inserire l'anno interessato: ";
    cin>>anno;
    string supp1 = to_string(anno);
    const char* parametro1 = supp1.c_str();
    cout<<"inserire il numero minimo di ritiri: ";
    cin>>n_ritiri;
    string supp2 = to_string(n_ritiri);
    const char* parametro2 = supp2.c_str();
    string query = "SELECT pilota.nome,pilota.cognome, COUNT(*) AS ritiri_stagionali FROM prestazione,partecipante,pilota WHERE prestazione.anno = $1::int AND prestazione.ritiro = 'Y' AND prestazione.codice_fiscale = partecipante.codice_fiscale AND prestazione.vettura = partecipante.vettura AND partecipante.codice_fiscale = pilota.codice_fiscale GROUP BY pilota.codice_fiscale HAVING COUNT(*) >= $2::int ORDER BY ritiri_stagionali DESC;";
    PGresult* res = PQprepare(conn,"DNF",query.c_str(),2,NULL);

    const char* parametri[2] = {parametro1,parametro2};
    res = PQexecPrepared(conn,"DNF",2,parametri,NULL,0,0);
    checkResults(res,conn);
    stampatuple(res);
}

void info(PGconn*conn)
{
    cout<<"Selezionare un team da quelli sottostanti\n";
    PGresult* res = PQexec(conn,"SELECT squadra.nome FROM squadra");
    checkResults(res,conn);
    stampatuple(res);
    string squadra;
    cout<<"inserire il nome: ";
    cin>>squadra;
    const char* parametro1 = squadra.c_str();

    res = PQprepare(conn,"seleziona_anno","SELECT autovettura.anno AS anni_selezionabili FROM squadra,autovettura WHERE squadra.nome = autovettura.squadra AND squadra.nome = $1::varchar;",1,NULL);
    res = PQexecPrepared(conn,"seleziona_anno",1,&parametro1,NULL,0,0);
    checkResults(res,conn);
    stampatuple(res);
    int anno;
    cout<<"inserire l'anno: ";
    cin>>anno;
    string supp = to_string(anno);
    const char* parametro2 = supp.c_str();

    string query = "SELECT autovettura.nome,autovettura.squadra,autovettura.motore,autovettura.pneumatico,pilota.nome,pilota.cognome FROM autovettura,partecipante,squadra,pilota WHERE squadra.nome = $1::varchar AND autovettura.squadra = squadra.nome AND autovettura.anno = $2::int AND partecipante.vettura = autovettura.nome AND partecipante.codice_fiscale = pilota.codice_fiscale;";
    res = PQprepare(conn,"info1",query.c_str(),2,NULL);

    const char* parametri[2] = {parametro1,parametro2};
    res = PQexecPrepared(conn,"info1",2,parametri,NULL,0,0);
    checkResults(res,conn);
    stampatuple(res);

    cout<<"Selezionare il campo del quale si vogliono maggiori informazioni:\n";
    cout<<"[1] info squadra\n"<<"[2] info motore\n"<<"[3] info pneumatico\n"<<"[0]chiudi query\n";
    cout<<"inserire il valore desiderato: ";
    int menu;
    bool input_corretto = false;
    do{
        cin>>menu;
        if(menu<0||menu>3)
        {
            cout<<"inserire un input corretto tra 0 e 3: ";
            input_corretto = false;
        }
        else
            input_corretto = true;
    }while(!input_corretto);

    switch (menu)
    {
    case 1:
        query = "SELECT squadra.* FROM squadra WHERE squadra.nome = $1::varchar;";
        res = PQprepare(conn,"info_squadra",query.c_str(),1,NULL);
        res = PQexecPrepared(conn,"info_squadra",1,&parametro1,NULL,0,0);
        checkResults(res,conn);
        stampatuple(res);
        int select;
        cout<<endl<<"premere 1 se si vuole visualizzare tutti i nomi precedenti del team se presenti :";
        cin>>select;
        if(select == 1)
        {
            query = "WITH RECURSIVE nomi AS (SELECT s1.nome, s1.nome_precedente FROM squadra s1 WHERE s1.nome = $1::varchar UNION ALL SELECT s2.nome, s2.nome_precedente FROM nomi JOIN squadra s2 ON nomi.nome_precedente = s2.nome)SELECT nomi.nome FROM nomi;";
            res = PQprepare(conn,"info_ricorsiva",query.c_str(),1,NULL);
            res = PQexecPrepared(conn,"info_ricorsiva",1,&parametro1,NULL,0,0);
            checkResults(res,conn);
            stampatuple(res);
        }
        break;
    case 2:
        query = "SELECT motore.* FROM motore,squadra,autovettura WHERE squadra.nome = $1::varchar AND autovettura.squadra = squadra.nome AND autovettura.anno = $2::int AND autovettura.motore = motore.nome;";
        res = PQprepare(conn,"info_motore",query.c_str(),2,NULL);
        res = PQexecPrepared(conn,"info_motore",2,parametri,NULL,0,0);
        checkResults(res,conn);
        stampatuple(res);
        break;
    case 3:
        query = "SELECT pneumatico.* FROM pneumatico,autovettura,squadra WHERE squadra.nome = $1::varchar AND autovettura.squadra = squadra.nome AND autovettura.anno = $2::int AND autovettura.pneumatico = pneumatico.nome;";
        res = PQprepare(conn,"info_pneumatico",query.c_str(),2,NULL);
        res = PQexecPrepared(conn,"info_pneumatico",2,parametri,NULL,0,0);
        checkResults(res,conn);
        stampatuple(res);
        break;
    default:
        break;
    }
    cout<<endl<<"chiusura menu info\n";
}

void qualifica(PGconn* conn)
{
    int anno;
    cout<<"inserire l'anno interessato:(inserire gli anni tra 2022-2020 perchè gli altri non esisotno ancora...) ";
    cin>>anno;
    string supp1 = to_string(anno);
    const char* parametro1 = supp1.c_str();

    cout<<"selezionare il numero della gara della quale si vuoile sapere la griglia di partenza: \n";

    string query = "SELECT gara.gara_num AS numero_gara,gara.nome_gara FROM gara WHERE gara.anno = $1::int;";
    PGresult* res = PQprepare(conn,"calendario",query.c_str(),1,NULL);
    res = PQexecPrepared(conn,"calendario",1,&parametro1,NULL,0,0);
    checkResults(res,conn);
    stampatuple(res);
    int gara_num;
    cout<<"inserire il numero: ";
    cin>>gara_num;
    string supp2 = to_string(gara_num);
    const char* parametro2 = supp2.c_str();
    const char* parametri[2] = {parametro1,parametro2};
    query = "SELECT ROW_NUMBER() OVER (ORDER BY prestazione.tempo_q3,prestazione.tempo_q2,prestazione.tempo_q1) AS Posizione_Partenza,pilota.nome,pilota.cognome,pilota.sigla_in_gara,partecipante.numero_in_gara FROM pilota,partecipante,prestazione,autovettura WHERE prestazione.codice_fiscale = partecipante.codice_fiscale AND prestazione.vettura = prestazione.vettura AND partecipante.codice_fiscale = pilota.codice_fiscale AND prestazione.anno = $1::int AND prestazione.gara_num = $2::int AND autovettura.anno = $1::int AND partecipante.vettura = autovettura.nome;";
    res = PQprepare(conn,"griglia",query.c_str(),2,NULL);
    res = PQexecPrepared(conn,"griglia",2,parametri,NULL,0,0);
    checkResults(res,conn);
    stampatuple(res);
}

bool eseguiquery(PGconn*conn,int query)
{
    switch (query)
    {
    case 1:
        hotlap(conn);
        return true;
        break;
    case 2:
        classifica(conn);
        return true;
        break;
    case 3:
        DNF(conn);
        return true;
        break;
    case 4:
        info(conn);
        return true;
        break;
    case 5:
        qualifica(conn);
        return true;
        break;
    case 0:
        return false;
    default:
        return false;
        break;
    }
}