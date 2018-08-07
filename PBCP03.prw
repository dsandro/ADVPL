#INCLUDE "PROTHEUS.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPBCP03    บAutor  ณSandro Delfino      บ Data ณ  13/09/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Pesagem inicial Agregados                                  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PBCP03()

Local cPeso:=U_PesoGAS() 
Local cCodGru := UsrRetGrp(UsrRetName(RetCodUsr()))[1]
Local 	_prod 	:= SPACE(14)
Private cPlaca := space(7) 
Private cPlacac := space(7)
Private cnrnf := space(9)
Private cpesop := space(7)         
Private cProd	:= space(14) 
Private _motorist := space(6)
Private _nforne := space(6)
Private _contrat := space(23) 
Private _ncontra := ""
Private _nprod	 := ""
Private _flaga	 := 0
Private _flagl	 := 0
Private _sair 	 := 0              

  	If alltrim(UsrRetName(RetCodUsr())) = "faturamento" 
		DEFINE MSDIALOG ODLG TITLE "Informe Produto" FROM 000,000 TO 080,300 PIXEL
		
		@001,001 TO 040,150 OF ODLG PIXEL
		@010,010 SAY "Produto" SIZE 55,07 OF ODLG PIXEL
		@020,010 MsGet _oprodt Var cProd Picture "@!" F3 "SB1" of oDlg Pixel 		
		
		DEFINE SBUTTON FROM 010,120 TYPE 1 ENABLE OF ODLG ACTION(ODLG:END())
		
		ACTIVATE MSDIALOG ODLG CENTERED 
	EndIf		

//====================================================================
//Pega dados para gravacao do peso no sz5
//==================================================================== 
			If MsgYesNo("Peso lido pela Balanca: " + cPeso + " Ele estแ correto? ","Atencao!!")
                 Else
                 	return
			EndIf 
		
	IF   cCodGru <> '000000'   		
                             
		If alltrim(UsrRetName(RetCodUsr())) = "faturamento" 
				If alltrim(cprod) = "00160004" 
							DEFINE MSDIALOG ODLG TITLE "Pesagem Agregados" FROM 000,000 TO 250,400 PIXEL
							
							@001,001 TO 040,150 OF ODLG PIXEL
							@010,010 SAY "Peso Bruto" SIZE 55,07 OF ODLG PIXEL
							@010,050 MSGET cPeso SIZE 55,11 OF ODLG PIXEL PICTURE "@R 99.999" //VALID !VAZIO()
							@025,010 SAY "Placa " SIZE 55,07 OF ODLG PIXEL
							@025,050 MsGet _oplacac Var cPlacac Picture "@!" F3 "DA3" Valid ExistCpo("DA3",cPlacac) of oDlg Pixel
							@040,010 SAY "Nro Doc.: " SIZE 55,07 OF ODLG PIXEL
							@040,050 MsGet _onrnf Var cnrnf Picture "@!" of oDlg Pixel
							@055,010 SAY "Produto" SIZE 55,07 OF ODLG PIXEL
							@055,050 MSGET _oprodt Var cProd  Picture "@!" F3 "SB1SC6" Valid ExistCpo("SB1",cProd) of oDlg Pixel //VALID !VAZIO()
							@070,010 SAY "Peso Prod. NF.: " SIZE 55,07 OF ODLG PIXEL
							@070,050 MsGet _opesop Var cpesop PICTURE "@R 99.999" of oDlg Pixel  
							@085,010 SAY "Fornecedor" SIZE 55,07 OF ODLG PIXEL
							@085,050 MsGet _ofornec Var _nforne Picture "@!" F3 "SA2" Valid ExistCpo("SA2",_nforne) of oDlg Pixel 		
					
							DEFINE SBUTTON FROM 010,120 TYPE 1 ENABLE OF ODLG ACTION(ODLG:END())
							
							ACTIVATE MSDIALOG ODLG CENTERED 
						Else
							DEFINE MSDIALOG ODLG TITLE "Pesagem Agregados" FROM 000,000 TO 250,400 PIXEL
							
							@001,001 TO 040,150 OF ODLG PIXEL
							//@010,010 SAY "Peso Bruto" SIZE 55,07 OF ODLG PIXEL
							//@010,050 MSGET cPeso SIZE 55,11 OF ODLG PIXEL PICTURE "@R 99.999" //VALID !VAZIO()
							@025,010 SAY "Placa " SIZE 55,07 OF ODLG PIXEL
							@025,050 MsGet _oplacac Var cPlacac Picture "@!" F3 "DA3" Valid ExistCpo("DA3",cPlacac) of oDlg Pixel
							@040,010 SAY "Nro Doc.: " SIZE 55,07 OF ODLG PIXEL
							@040,050 MsGet _onrnf Var cnrnf Picture "@!" of oDlg Pixel
							@055,010 SAY "Produto" SIZE 55,07 OF ODLG PIXEL
							@055,050 MSGET _oprodt Var cProd  Picture "@!" F3 "SB1SC6" Valid ExistCpo("SB1",cProd) of oDlg Pixel //VALID !VAZIO()
							@070,010 SAY "Peso Prod. NF.: " SIZE 55,07 OF ODLG PIXEL
							@070,050 MsGet _opesop Var cpesop PICTURE "@R 99.999" of oDlg Pixel  
							@085,010 SAY "Fornecedor" SIZE 55,07 OF ODLG PIXEL
							@085,050 MsGet _ofornec Var _nforne Picture "@!" F3 "SA2" Valid ExistCpo("SA2",_nforne) of oDlg Pixel 		
					
							DEFINE SBUTTON FROM 010,120 TYPE 1 ENABLE OF ODLG ACTION(ODLG:END())
							
							ACTIVATE MSDIALOG ODLG CENTERED 
										
				EndIf

            Else
		
					DEFINE MSDIALOG ODLG TITLE "Pesagem Agregados" FROM 000,000 TO 250,400 PIXEL
					
					@001,001 TO 040,150 OF ODLG PIXEL
					//@010,010 SAY "Peso Bruto" SIZE 55,07 OF ODLG PIXEL
					//@010,050 MSGET cPeso SIZE 55,11 OF ODLG PIXEL PICTURE "@R 99.999" //VALID !VAZIO()
					@025,010 SAY "Placa " SIZE 55,07 OF ODLG PIXEL
					@025,050 MsGet _oplacac Var cPlacac Picture "@!" F3 "DA3" Valid ExistCpo("DA3",cPlacac) of oDlg Pixel
					@040,010 SAY "Nro Doc.: " SIZE 55,07 OF ODLG PIXEL
					@040,050 MsGet _onrnf Var cnrnf Picture "@!" of oDlg Pixel
					@055,010 SAY "Produto" SIZE 55,07 OF ODLG PIXEL
					@055,050 MSGET _oprodt Var cProd  Picture "@!" F3 "SB1SC6" Valid ExistCpo("SB1",cProd) of oDlg Pixel //VALID !VAZIO()
					@070,010 SAY "Peso Prod. NF.: " SIZE 55,07 OF ODLG PIXEL
					@070,050 MsGet _opesop Var cpesop PICTURE "@R 99.999" of oDlg Pixel  
					@085,010 SAY "Fornecedor" SIZE 55,07 OF ODLG PIXEL
					@085,050 MsGet _ofornec Var _nforne Picture "@!" F3 "SA2" Valid ExistCpo("SA2",_nforne) of oDlg Pixel 		
			
					DEFINE SBUTTON FROM 010,120 TYPE 1 ENABLE OF ODLG ACTION(ODLG:END())
					
					ACTIVATE MSDIALOG ODLG CENTERED 
			
		            
		EndIf
    	Else
			DEFINE MSDIALOG ODLG TITLE "Pesagem Agregados" FROM 000,000 TO 250,400 PIXEL
			
			@001,001 TO 040,150 OF ODLG PIXEL
			@010,010 SAY "Peso Bruto" SIZE 55,07 OF ODLG PIXEL
			@010,050 MSGET cPeso SIZE 55,11 OF ODLG PIXEL PICTURE "@R 99.999" //VALID !VAZIO()
			@025,010 SAY "Placa " SIZE 55,07 OF ODLG PIXEL
			@025,050 MsGet _oplacac Var cPlacac Picture "@!" F3 "DA3" Valid ExistCpo("DA3",cPlacac) of oDlg Pixel
			@040,010 SAY "Nro Doc.: " SIZE 55,07 OF ODLG PIXEL
			@040,050 MsGet _onrnf Var cnrnf Picture "@!" of oDlg Pixel
			@055,010 SAY "Produto" SIZE 55,07 OF ODLG PIXEL
			@055,050 MSGET _oprodt Var cProd  Picture "@!" F3 "SB1SC6" Valid ExistCpo("SB1",cProd) of oDlg Pixel //VALID !VAZIO()
			@070,010 SAY "Peso Prod. NF.: " SIZE 55,07 OF ODLG PIXEL
			@070,050 MsGet _opesop Var cpesop PICTURE "@R 99.999" of oDlg Pixel  
			@085,010 SAY "Fornecedor" SIZE 55,07 OF ODLG PIXEL
			@085,050 MsGet _ofornec Var _nforne Picture "@!" F3 "SA2" Valid ExistCpo("SA2",_nforne) of oDlg Pixel 		
	
			DEFINE SBUTTON FROM 010,120 TYPE 1 ENABLE OF ODLG ACTION(ODLG:END())
			
			ACTIVATE MSDIALOG ODLG CENTERED 
	EndIf		

cnrnf	:= strzero(val(cnrnf),9)
cPlaca 	:= upper(cPlaca)

//If _contrat > "0" 
DbselectArea("SZ5")
DbSetOrder(1)
		RecLock("SZ5",.T.)
		SZ5->Z5_FILIAL	:= xfilial("SZ5")
		SZ5->Z5_NUM		:= cnrnf
		SZ5->Z5_DATA	:= DDATABASE
		SZ5->Z5_CPESO	:= VAL(cpeso)
		SZ5->Z5_CPLACA	:= cPlacac
		SZ5->Z5_PLACAC	:= cPlacac
		SZ5->Z5_CPESOP	:= VAL(cpesop)
		SZ5->Z5_PRODUTO	:= cProd 
		SZ5->Z5_FORNEC	:= _nforne
		MsUnLock()

  
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPBCP05    บAutor  Sandro Delfino       บ Data ณ  10/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Pesagem final:                                             บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PBCP05()
	Local aSC9 := {}, aSC6 := {}, aPed := {}, aNewPed := {}
	Local aLib := {}, aAux := {}, aNewLib := {}, cSeq := ""
	Local cArea := getNextAlias()
	Local cPeso:=u_PesoGAS()     
	Local aArea := GetArea()
	Local cPlaca := space(7) 
	Local _nforne := space(6)
	Local _seq := 0	
	Local _contrat := space(23)  
	Local _vlunit	:= 0         
	Local cnronf := space(9) 
	Local cCodGru := UsrRetGrp(UsrRetName(RetCodUsr()))[1]
	Private cProd	:= space(14) 
			If MsgYesNo("Peso lido pela Balanca: " + cPeso + " Ele estแ correto? ","Atencao!!")
                 Else
                 	return
			EndIf 

  	If alltrim(UsrRetName(RetCodUsr())) = "faturamento" 
		DEFINE MSDIALOG ODLG TITLE "Informe Produto" FROM 000,000 TO 080,300 PIXEL
		
		@001,001 TO 040,150 OF ODLG PIXEL
		@010,010 SAY "Produto" SIZE 55,07 OF ODLG PIXEL
		@020,010 MsGet _oprodt Var cProd Picture "@!" F3 "SB1" of oDlg Pixel 		
		
		DEFINE SBUTTON FROM 010,120 TYPE 1 ENABLE OF ODLG ACTION(ODLG:END())
		
		ACTIVATE MSDIALOG ODLG CENTERED 
	EndIf		
	IF   cCodGru <> '000000'		
		If alltrim(UsrRetName(RetCodUsr())) = "faturamento" 
				If alltrim(cprod) = "00160004" 
						DEFINE MSDIALOG ODLG TITLE "Peso Final Agregados!" FROM 000,000 TO 250,400 PIXEL
						
						@001,001 TO 040,150 OF ODLG PIXEL
						@010,010 SAY "Pesagem Agregados:" SIZE 55,07 OF ODLG PIXEL
						@010,050 MSGET cPeso SIZE 55,11 OF ODLG PIXEL PICTURE "@R 99.999" //VALID !VAZIO()
						@025,010 SAY "Nro Doc.:" SIZE 55,07 OF ODLG PIXEL
						@025,050 MsGet _onronf Var cnronf Picture "@!" of oDlg Pixel
						@040,010 SAY "Fornecedor" SIZE 55,07 OF ODLG PIXEL
						@040,050 MsGet _ofornec Var _nforne Picture "@!" F3 "SA2" Valid ExistCpo("SA2",_nforne) of oDlg Pixel 							
						
						DEFINE SBUTTON FROM 010,120 TYPE 1 ENABLE OF ODLG ACTION(ODLG:END())
						
						ACTIVATE MSDIALOG ODLG CENTERED 
	
					Else					
						DEFINE MSDIALOG ODLG TITLE "Peso Final Agregados!" FROM 000,000 TO 250,400 PIXEL
						
						@001,001 TO 040,150 OF ODLG PIXEL
						//@010,010 SAY "Pesagem Agregados:" SIZE 55,07 OF ODLG PIXEL
						//@010,050 MSGET cPeso SIZE 55,11 OF ODLG PIXEL PICTURE "@R 99.999" //VALID !VAZIO()
						@025,010 SAY "Nro Doc.:" SIZE 55,07 OF ODLG PIXEL
						@025,050 MsGet _onronf Var cnronf Picture "@!" of oDlg Pixel
						@040,010 SAY "Fornecedor" SIZE 55,07 OF ODLG PIXEL
						@040,050 MsGet _ofornec Var _nforne Picture "@!" F3 "SA2" Valid ExistCpo("SA2",_nforne) of oDlg Pixel 						
						
						DEFINE SBUTTON FROM 010,120 TYPE 1 ENABLE OF ODLG ACTION(ODLG:END())
						
						ACTIVATE MSDIALOG ODLG CENTERED 
	
				EndIf
		
			Else
						DEFINE MSDIALOG ODLG TITLE "Peso Final Agregados!" FROM 000,000 TO 250,400 PIXEL
						
						@001,001 TO 040,150 OF ODLG PIXEL
						//@010,010 SAY "Pesagem Agregados:" SIZE 55,07 OF ODLG PIXEL
						//@010,050 MSGET cPeso SIZE 55,11 OF ODLG PIXEL PICTURE "@R 99.999" //VALID !VAZIO()
						@025,010 SAY "Nro Doc.:" SIZE 55,07 OF ODLG PIXEL
						@025,050 MsGet _onronf Var cnronf Picture "@!" of oDlg Pixel
						@040,010 SAY "Fornecedor" SIZE 55,07 OF ODLG PIXEL
						@040,050 MsGet _ofornec Var _nforne Picture "@!" F3 "SA2" Valid ExistCpo("SA2",_nforne) of oDlg Pixel 						
						
						DEFINE SBUTTON FROM 010,120 TYPE 1 ENABLE OF ODLG ACTION(ODLG:END())
						
						ACTIVATE MSDIALOG ODLG CENTERED 
	
		EndIf	
		Else				
				DEFINE MSDIALOG ODLG TITLE "Peso Final Agregados!" FROM 000,000 TO 250,400 PIXEL
				
				@001,001 TO 040,150 OF ODLG PIXEL
				@010,010 SAY "Pesagem Agregados:" SIZE 55,07 OF ODLG PIXEL
				@010,050 MSGET cPeso SIZE 55,11 OF ODLG PIXEL PICTURE "@R 99.999" //VALID !VAZIO()
				@025,010 SAY "Nro Doc.:" SIZE 55,07 OF ODLG PIXEL
				@025,050 MsGet _onronf Var cnronf Picture "@!" of oDlg Pixel
				@040,010 SAY "Fornecedor" SIZE 55,07 OF ODLG PIXEL
				@040,050 MsGet _ofornec Var _nforne Picture "@!" F3 "SA2" Valid ExistCpo("SA2",_nforne) of oDlg Pixel 				
				
				DEFINE SBUTTON FROM 010,120 TYPE 1 ENABLE OF ODLG ACTION(ODLG:END())
				
				ACTIVATE MSDIALOG ODLG CENTERED
	EndIf
cnronf	:= strzero(val(cnronf),9)
DbselectArea("SZ5")
DbSetOrder(1)                                              
DbSeek( xFilial("SZ5") + cnronf + _nforne)                                            
		If Found() 
			If _nforne = sz5->z5_fornec
					RecLock("SZ5",.F.)
					SZ5->Z5_TARA	:= val(CPESO)
					MsUnLock()              
				Else
					sz5->(dbskip())
					If _nforne = sz5->z5_fornec	
						RecLock("SZ5",.F.)
						SZ5->Z5_TARA	:= val(CPESO)
						MsUnLock() 
					EndIf
			EndIf	
			Else
				return    		
		EndIf
			If  Z5_CPESO- Z5_TARA  < 	SZ5->Z5_CPESOP * 0.995   
				_qtdsz5 := Z5_CPESO - Z5_TARA 
				_valida := 1
				xHTM := '<HTML><BODY>'
				xHTM += '<hr>'
				xHTM += '<p  style="word-spacing: 0; line-height: 100%; margin-top: 0; margin-bottom: 0">'
				xHTM += '<b><font face="Verdana" SIZE=3>Pesagem de Geral incluida com divergencia de peso!</b></p>'
				xHTM += '<b><font face="Verdana" SIZE=3>Origem da Informa็ใo; Pesagem Geral - Empresa, ' + SM0->M0_NOMECOM + ' &nbsp;&nbsp;&nbsp;</b></p>'
				xHTM += '<hr>'
				xHTM += '<br>'
				xHTM += '<table border="1"><tr><td>Nro Nf</td><td>Qtd Pesada</td><td>Qtd da Nota</td><td>Diferen็a entre peso NF e balan็a</td></tr>'	
				xHTM += '<tr><td>' + cnronf + '</td>' 
				xHTM += '<td>' + TRANSFORM(_qtdsz5  , '@E 99,999.99' ) + '</td> '
				xHTM += '<td>' + TRANSFORM(SZ5->Z5_CPESOP  , '@E 99,999.99' ) + '</td>'
				xHTM += '<td>' + TRANSFORM(SZ5->Z5_CPESOP - _qtdsz5  , '@E 99,999.99' ) + '</td></tr>'					      		

		
				xHTM += '</table><br>'
               
		  
				xHTM += '</BODY></HTML>' 
		   	   		u_menvia("felipe@pedreirabritec.com.br",,"Aten็ใo, Pesagem incluida ",xHTM)
				If _valida = 1  
		   	   		u_menvia("helder@pedreirabritec.com.br",,"Aten็ใo, Pesagem incluida com divergencia de quantidade.",xHTM)
			   	EndIf	
						
			EndIf
		
  

		                                                  
		AVISO("Informa็ใo", "Tara confirmada com sucesso!", {"Ok"})
		
		U_PBCP06(cnronf,"2",cPlaca,_nforne)//Imprimir Carregamento
    AVISO("Aten็ใo", "Saida do caminhใo confirmado com sucesso!", {"Ok"})

	RestArea(aArea)
Return

