
#INCLUDE "topconn.ch"
#INCLUDE "Protheus.ch"
#INCLUDE "TbiConn.ch"
#INCLUDE "rwmake.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออออออปฑฑ
ฑฑบPrograma  ณ PBCP02  บ Autor ณ SANDRO DELFINO     	บ Data ณ  13/09/2013  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออออออนฑฑ
ฑฑบDescricao ณ Ordem de Carregamento Cap         	                 	 	  บฑฑ
ฑฑบ          ณ                                                         		  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณPedreira Britec		                                  		  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function FATR088(cNumPd,cViaImp,cPlaca)
////////////////////// FONTES PARA SEREM UTILIZADAS NO RELATORIO ///////////////////////////

Private cNumpdEm    := cNumPd  
Private cViaImpr    := cViaImp  
Private _Placa		:= cPlaca
Private nPesoL		:= 0                        
 

Private oFont6		:= TFONT():New("Arial",,6,.T.,.F.,5,.T.,5,.T.,.F.	) //Fonte 6 Normal
Private oFont6N 	:= TFONT():New("Arial",,6,,.T.,,,,.T.,.F.			) //Fonte 6 Negrito
Private oFont8		:= TFONT():New('Arial',,8,,.F.,,,,.F.,.F.		) //Fonte 9 Normal
Private oFont8N		:= TFONT():New('Arial',,8,,.T.,,,,.F.,.F.		) //Fonte 9 Negrito
Private oFont8NI	:= TFONT():New('Times New Roman',,8,,.T.,,,,.F.,.F.,.T.) //Fonte 8 Negrito e Itแlico
Private oFont10		:= TFONT():New('Arial',,10,,.F.,,,,.F.,.F.	) //Fonte 10 Normal
Private oFont10N	:= TFONT():New('Arial',,10,,.T.,,,,.F.,.F.	) //Fonte 10 Negrito
Private oFont12N	:= TFONT():New('Arial',,12,,.T.,,,,.F.,.F.	) //Fonte 12 Negrito
Private oFont12 	:= TFONT():New('Arial',,12,,.F.,,,,.F.,.F.	) //Fonte 12 Negrito
Private oFont14N	:= TFONT():New('Times New Roman',,16,,.T.,,,,.F.,.F.	) //Fonte 14 Negrito
Private oFont14NI	:= TFONT():New('Times New Roman',,14,,.T.,,,,.F.,.F.,.T.) //Fonte 14 Negrito e Itแlico
Private oFont16N	:= TFONT():New('Arial',,16,,.T.,,,,.F.,.F.	) //Fonte 16 Negrito
Private oFont16NI	:= TFONT():New('Times New Roman',,16,,.T.,,,,.F.,.F.,.T.) //Fonte 16 Negrito e Itแlico

////////////////////////////////////////////////////////////////////////////////////////////
Private cStartPath
Private nLin 		:= 50
Private oPrint		:= TMSPRINTER():New("")
Private oBrush		:= TBrush():New( , CLR_HGRAY ) 
Private oBrush2		:= TBrush():New( , RGB(50,50,205) )
Private nPag		:= 1
  

Private lPerguntaOK := .F.
                                 
///////////////////// DEFINE O TAMANHO DO PAPEL /////////////////////////

#define DMPAPER_A4 9 //Papel A4
oPrint:setPaperSize( DMPAPER_A4 )

/////////////////// DEFINE A ORIENTAวรO DO PAPEL ////////////////////////

oPrint:SetPortrait()///Define a orientacao da impressao como retrato
//oPrint:SetLandscape() ///Define a orientacao da impressao como paisagem


Processa({|| CorpoTexto() })

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRELATORIO1บAutor  ณSandro Delfino        Data ณ  13/09/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Fun็ใo que cria o babe็alho do relatorio                   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function Cabecalho( cCOD_PESO, cPLACA, cDESC_VEICULO )

//oPrint:Setup() Se der erro exexutar procedimento

oPrint:StartPage() // Inicia uma nova pagina
cStartPath := GetPvProfString(GetEnvServer(),"StartPath","ERROR",GetAdv97())
cStartPath += If(Right(cStartPath, 1) <> "\", "\", "")

nLin+=100


oPrint:Box(nLin,120,nLin+220,450)
oPrint:SayBitmap(nLin+10, 190, cStartPath + "logo.jpg", 240, 200)///Impressao da Logo

oPrint:Box(nLin,460,nLin+80,2200)
oPrint:Say(nLin+10, 900, "Tickte de pesagem CAP" , oFont14N) 
//<nTop>, <nLeft>, <nBottom>, <nRight>, 

oPrint:Box(nLin,2200,nLin+80,2330)
oPrint:Say(nLin+25, 2210, "Pag: " , oFont8N)
oPrint:Say(nLin+25, 2275, strzero(nPag,3), oFont8) 

oPrint:Box(nLin+90,460,nLin+220,2330)      

nLin += 110
oPrint:Say(nLin, 480, "C๓digo Pesagem" , oFont10N)
//oPrint:Say(nLin, 660, cxFilDe , oFont10) 		

oPrint:Say(nLin, 950, "Placa Veiculo" , oFont10N)
//oPrint:Say(nLin, 1130, CVALTOCHAR(cxDtDe) , oFont10)

oPrint:Say(nLin, 1470, "Descri็ใo Veiculo" , oFont10N)
//oPrint:Say(nLin, 1700, cxGerDe , oFont10)

nLin+=50
oPrint:Say(nLin, 480,  cCOD_PESO , oFont10)
//oPrint:Say(nLin, 660, cxFilAte , oFont10)   

oPrint:Say(nLin, 950, cPLACA , oFont10)
//oPrint:Say(nLin, 1130, CVALTOCHAR(cxDtAte) , oFont10) 
        
oPrint:Say(nLin, 1470, cDESC_VEICULO , oFont10)
//oPrint:Say(nLin, 1700, cxGerAte , oFont10)

oPrint:Box(nLin+60,120,nLin+150,2330)
oPrint:Say(nLin+85, 130, "PEDREIRA HVB LTDA" , oFont16N) 
oPrint:Say(nLin+85, 1650, DTOC(ddatabase)+" "+TIME(), oFont16N)

nLin += 150
                                                           
//, , 
Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRod		บAutor  ณSandro Delfino        Data ณ  13/09/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Fun็ใo para criar o rodap้ do relatorio                   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function Rod()

	cStartPath := GetPvProfString(GetEnvServer(),"StartPath","ERROR",GetAdv97())
	cStartPath += If(Right(cStartPath, 1) <> "\", "\", "")

	nLin:=3500

	//oPrint:SayBitmap(nLin, 100, cStartPath + "logo_totvs.gif", 228, 050)///Impressao da Logo
	oPrint:Say(nLin, 150, "Microsiga Protheus", oFont10N)
	oPrint:Say(nLin, 2250, TIME(), oFont8N)
	nLin+=50
	oPrint:Line (nLin, 150, nLin, 2360)                                   
	
Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCorpoTexto บAutor  ณSandro Delfino      บ Data ณ  01/16/12  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Fun็ใo para preencher o relatorio                          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CorpoTexto()

Local cQuery   	 := ""
Local cPulaLinha := chr(13)+chr(10)
_cfilsz4:=xfilial("SZ4")                     


 	cQuery := "SELECT Z4_NUM COD_PESO, Z4_CPLACA PLACA, Z4_CLIENT CLIENTE, DA3_DESC DESC_VEICULO,  "
    cQuery += "Z4_CONTRAT COD_PRODUTO, C6_DESCRI DESC_PRODUTO, Z4_DATA DATA_INICIAL, "
	cQuery += "Z4_DATA DATA_FINAL, C5_XTARA PESO_INICIAL, Z4_CPESO PESO_FINAL, Z4_CPESOP PESO_LIQUIDO "
	cQuery += "FROM "
	cQuery +=  retsqlname("SZ4")+" SZ4 "
	cQuery += "WHERE "	
	cQuery += "SZ4.D_E_L_E_T_<>'*' " 
	cQuery += "AND Z4_FILIAL='"+_cfilsz4+"' "
	cQuery += "AND Z4_NUM = '" + cNumpdEm + "' "
	 	
	MemoWrite("C:\TEMP\FATR088.sql",cQuery)

	If Select("TMP") > 0 
	    TMP->(dbCloseArea()) 
	EndIf
     
	dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery), "TMP", .F., .T.)
    dbSelectArea("TMP")
    nPesoL :=TMP->PESO_LIQUIDO
	cGerente := ""
                                                  
    cDiExtenso  := substr(DTOC(ddatabase),1,2)                                
    cMExtenso   := MesExtenso(substr(DTOC(ddatabase),4,2))
    cAnoExtenso := substr(DTOC(ddatabase),7,4)
    
	Cabecalho(TMP->COD_PESO, TMP->PLACA, TMP->DESC_VEICULO ) 
    
	//While TMP->(!EOF())
	
		lLen := .T.
		if nLin > 3200
			Rod()
			NovaPagina()
		endif
	

		oPrint:Box(nLin,120,nLin+60,2330)
		oPrint:Say(nLin+5, 130, "Produto: "+ alltrim(TMP->COD_PRODUTO)+"-" +alltrim(Posicione("SB1",1,xFilial("SB1")+TMP->COD_PRODUTO,"B1_DESC") ), oFont12N)
		nLin += 60
				
		oPrint:Box(nLin,120,nLin+60,1670)
		oPrint:Say(nLin+10, 130, "Data Inicial: " , oFont10N,,CLR_BLACK)
		oPrint:Say(nLin+10, 340, SUBSTRING(TMP->DATA_INICIAL,7,2) +'/'+SUBSTRING(TMP->DATA_INICIAL,5,2) +'/'+SUBSTRING(TMP->DATA_INICIAL,1,4)  , oFont10,,CLR_BLACK)
		oPrint:Say(nLin+10, 700, "Data Final: "   , oFont10N,,CLR_BLACK)
		oPrint:Say(nLin+10, 910, SUBSTRING(TMP->DATA_INICIAL,7,2) +'/'+SUBSTRING(TMP->DATA_INICIAL,5,2) +'/'+SUBSTRING(TMP->DATA_INICIAL,1,4)  , oFont10,,CLR_BLACK)
				
		oPrint:Box(nLin,1670,nLin+120,2330)
		oPrint:Say(nLin+30, 1720, "Peso Liquido: " , oFont10N,,CLR_BLACK)
		oPrint:Say(nLin+30, 1735, 	Transform (TMP->PESO_LIQUIDO,"@E 999,999,999,999,999,999.99")+" TN" , oFont16NI,,CLR_BLACK)
			
		nLin += 60
		                                   
		oPrint:Box(nLin,120,nLin+60,1670)
	    
		oPrint:Say(nLin+10, 130, "Peso Inicial: " , oFont10N,,CLR_BLACK)
		oPrint:Say(nLin+10, 340, alltrim(Transform (TMP->PESO_INICIAL,"@E 999,999,999,999,999,999.99")) + " KG"  , oFont10,,CLR_BLACK)
		oPrint:Say(nLin+10, 700, "Peso Final: "   , oFont10N,,CLR_BLACK)
		oPrint:Say(nLin+10, 910, alltrim(Transform (tmp->PESO_FINAL*1000,"@E 999,999,999,999,999,999.99"))+" KG"  , oFont10,,CLR_BLACK)
		
		nLin += 60
		
		oPrint:Box(nLin,120,nLin+480,2330)

		oPrint:Say(nLin+10, 130, "Cliente: " , oFont10N,,CLR_BLACK)
		oPrint:Say(nLin+10, 340, POSICIONE("SA1",1,xFilial("SA1")+TMP->CLIENTE,"A1_NOME") , oFont10,,CLR_BLACK)
		
		nLin += 60
		
		oPrint:Box(nLin,120,nLin+480,2330)
				 
		oPrint:Say(nLin+20, 200, "Atrav้s deste ticket confirmamos a entrega do produto adquirido e por ser verdade firmamos o presente.", oFont12)
		nLin += 200
		oPrint:Say(nLin, 500, "BELA VISTA DE GOIมS / GO, "+cDiExtenso +" de "+cMExtenso+" de "+ cAnoExtenso+".", oFont12) 
		                        
		
    
    
		nLin += 100
		oPrint:Say(nLin, 150, "______________________________________", oFont12) 
		oPrint:Say(nLin+40, 250, TMP->PLACA+" "+TMP->DESC_VEICULO, oFont12)

	   	oPrint:Say(nLin, 1470, "______________________________________", oFont12) 
		oPrint:Say(nLin+40, 1600, "PEDREIRA HVB LTDA", oFont12)
		
		oPrint:Say(nLin+100, 2200, "1ฐ VIA", oFont12N) 
		
	
		if cViaImpr == "2"
	
			nLin := nLin + 200
			 
			Cabecalho(TMP->COD_PESO, TMP->PLACA, TMP->DESC_VEICULO ) 	
	
			oPrint:Box(nLin,120,nLin+60,2330)
			oPrint:Say(nLin+5, 130, "Produto: "+ alltrim(TMP->COD_PRODUTO)+"-" +alltrim(TMP->DESC_PRODUTO), oFont12N)
			nLin += 60
					
			oPrint:Box(nLin,120,nLin+60,1670)
			oPrint:Say(nLin+10, 130, "Data Inicial: " , oFont10N,,CLR_BLACK)
			oPrint:Say(nLin+10, 340, SUBSTRING(TMP->DATA_INICIAL,7,2) +'/'+SUBSTRING(TMP->DATA_INICIAL,5,2) +'/'+SUBSTRING(TMP->DATA_INICIAL,1,4)  , oFont10,,CLR_BLACK)
			oPrint:Say(nLin+10, 700, "Data Final: "   , oFont10N,,CLR_BLACK)
			oPrint:Say(nLin+10, 910, SUBSTRING(TMP->DATA_INICIAL,7,2) +'/'+SUBSTRING(TMP->DATA_INICIAL,5,2) +'/'+SUBSTRING(TMP->DATA_INICIAL,1,4)  , oFont10,,CLR_BLACK)
					
			oPrint:Box(nLin,1670,nLin+120,2330)
			oPrint:Say(nLin+30, 1720, "Peso Liquido: " , oFont10N,,CLR_BLACK)
			oPrint:Say(nLin+30, 1735, 	Transform (TMP->PESO_LIQUIDO,"@E 999,999,999,999,999,999.99")+" TN" , oFont16NI,,CLR_BLACK)
				
			nLin += 60
			                                   
			oPrint:Box(nLin,120,nLin+60,1670)
		    
			oPrint:Say(nLin+10, 130, "Peso Inicial: " , oFont10N,,CLR_BLACK)
   			oPrint:Say(nLin+10, 340, alltrim(Transform (TMP->PESO_INICIAL,"@E 999,999,999,999,999,999.99")) + " KG"  , oFont10,,CLR_BLACK)
			oPrint:Say(nLin+10, 700, "Peso Final: "   , oFont10N,,CLR_BLACK)
			oPrint:Say(nLin+10, 910, alltrim(Transform (tmp->PESO_FINAL*1000,"@E 999,999,999,999,999,999.99"))+" KG"    , oFont10,,CLR_BLACK)
			
			nLin += 60
			
			oPrint:Box(nLin,120,nLin+480,2330) 


			oPrint:Say(nLin+10, 130, "Cliente: " , oFont10N,,CLR_BLACK)
			oPrint:Say(nLin+10, 340, POSICIONE("SA1",1,xFilial("SA1")+TMP->CLIENTE,"A1_NOME") , oFont10,,CLR_BLACK)
		
			nLin += 60			
			oPrint:Box(nLin,120,nLin+480,2330)
						 
			oPrint:Say(nLin+20, 200, "Atrav้s deste ticket confirmamos a entrega do produto adquirido e por ser verdade firmamos o presente.", oFont12)
			nLin += 200
			oPrint:Say(nLin, 500, "BELA VISTA DE GOIมS / GO, "+cDiExtenso +" de "+cMExtenso+" de "+ cAnoExtenso+".", oFont12)
			
			nLin += 100
			oPrint:Say(nLin, 150, "______________________________________", oFont12) 
			oPrint:Say(nLin+40, 250, TMP->PLACA+" "+TMP->DESC_VEICULO, oFont12)
	
		   	oPrint:Say(nLin, 1470, "______________________________________", oFont12) 
			oPrint:Say(nLin+40, 1600, "PEDREIRA HVB LTDA", oFont12)
			
			oPrint:Say(nLin+100, 2200, "2ฐ VIA", oFont12N) 
			
		endif
	TMP->(DbSkip())

//EndDo

//INICIO TOTALIZADOR GERAL
        
if nLin > 2000
	Rod()
	NovaPagina()
else
	nLin += 150 
endif
Rod()
//FIM TOTALIZADOR GERAL

//oPrint:Preview()  Alterado por sandro para que a impressใo seja automatica.
oPrint:Print( {1}, 1 )

TMP->(dbCloseArea()) // fecha a แrea criada

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRELATORIO1บAutor  ณSandro Delfino      บ Data ณ  01/16/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Fun็ใo que cria uma nova pแgina                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function NovaPagina()  // fun็ใo que cria uma nova pแgina montando o cabe็alho

oPrint:endPage()
nLin := 50
nPag += 1
//Cabecalho(TMP->GERENTE, cxDtDe, cxDtAte, cxFilDe, cxFilAte ) 
	
Return()
