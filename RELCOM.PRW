/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ RELCOM ³   Autor ³ Sandro Delfino     o  ³ Data ³ 11/10/12 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Relatório de compra de produtos por fornecedor             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ ESPECIFICO PARA                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß

Variaveis utilizadas para parametros
mv_par01 Da NF
mv_par02 Até a NF
mv_par03 dA EMISSÃO
mv_par04 aTE A EMISSÃO
*/

#include "rwmake.ch"
#include "topconn.ch"
user function RELCOM()
nordem   :=""
tamanho  :="M"
limite   :=132
titulo   :="Produto x Fornecedor"
cdesc1   :="Este programa ira emitir a relação de NF por fornecedor"
cdesc2   :=""
cdesc3   :=""
cstring  :="SD1"
areturn  :={"Zebrado",1,"Administracao",1,2,1,"",1}
nomeprog :="RELCOM"
wnrel    :="RELCOM"
alinha   :={} 

nlastkey :=0
aordem   :=0
lcontinua:=.t.
_datai := ddatabase - day(ddatabase) + 1

cperg:="HESCOM"
//_pergsx1()
pergunte(cperg,.f.)

wnrel:=setprint(cstring,wnrel,cperg,@titulo,cdesc1,cdesc2,cdesc3,.f.,aordem,.t.,tamanho,"",.F.)

if nlastkey==27
	set filter to
	return
endif

setdefault(areturn,cstring)

ntipo:=if(areturn[4]==1,15,18)
nordem:=areturn[8]

if nlastkey==27
	set filter to
	return
endif

rptstatus({|| rptdetail()})
return

//*******************************************
//Funcao rptdetail - impressao do relatorio
//*******************************************

static function rptdetail()
cbcont:=0
m_pag :=1
li    :=80
cbtxt :=space(10)

titulo:="Relatorio de NF por fornecedor "

cabec1:=" "
cabec2:=" "

_cfilsd1:=xfilial("SD1")
_cfilsf1:=xfilial("SF1")
_cfilsa2:=xfilial("SA2") 


processa({|| _geratmp()})

setprc(0,0)
_forne 	:= {}
_mcub	:= {}
_valor	:= {}
setregua(tmp1->(lastrec()))
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,ntipo) 
		@ prow()+1,000 PSAY replicate("_",limite) 
		@ prow()+1,000 PSAY "Lista de Nf´s por fornecedor "
		@ prow()+1,000 PSAY replicate("_",limite) 
		@ prow()+1,000 PSAY "Emissao        Nr NF        Cod.     Produto                                   QTD PC      QTD M3      Valor Total "    
		@ prow()+1,000 PSAY replicate("_",limite)
tmp1->(dbgotop())
_tqtd	:= 0
_tqtds	:= 0
_tvlr	:= 0

_codant		:= TMP1->FORNECE
_nomeant    := TMP1->NOME
 		@ prow()+1,000 PSAY TMP1->FORNECE 
   		@ prow()  ,012 PSAY " - " + TMP1->NOME
		@ prow()+1,000 PSAY " "//replicate("_",limite)  
			While !eof()
  		   	   		@ prow()+1,000 PSAY TMP1->EMISSAO
  		   	   		@ prow()  ,015 PSAY TMP1->NUM
   			   		@ prow()  ,027 PSAY TMP1->COD
   			   		@ prow()  ,037 PSAY SUBSTR(Posicione("SB1",1,XFILIAL("SB1")+TMP1->COD,"B1_DESC"),1,40)
   					@ prow()  ,079 PSAY TMP1->QTD PICTURE "@E 99,999.99" 
   			   		@ prow()  ,090 PSAY TMP1->QTDS PICTURE "@E 9,999.99" 	
   			   		@ prow()  ,100 PSAY TMP1->VALOR PICTURE "@E 9,999,999.99" 	
					_tqtd	:= _tqtd + TMP1->QTD 
					_tqtds	:= _tqtds + TMP1->QTDS
					_tvlr	:= _tvlr + TMP1->VALOR 
	   		   		    	if prow()>57
								cabec(titulo,cabec1,cabec2,nomeprog,tamanho,ntipo) 
								@ prow()+1,000 PSAY replicate("_",limite) 
								@ prow()+1,000 PSAY "Lista de Nf´s por fornecedor "
								@ prow()+1,000 PSAY replicate("_",limite) 
								@ prow()+1,000 PSAY "Emissao        Nr NF        Cod.     Produto                                   QTD PC      QTD M3      Valor Total "  
								@ prow()+1,000 PSAY replicate("_",limite)
							EndIf 	
 	   		   		If _codant <> TMP1->FORNECE 
					 		@ prow()+1,000 PSAY "Total:" 
		   					@ prow()  ,078 PSAY _tqtd PICTURE "@E 99,999.99" 
		   			   		@ prow()  ,089 PSAY _tqtds PICTURE "@E 9,999.99" 	
		   			   		@ prow()  ,099 PSAY _tvlr PICTURE "@E 9,999,999.99" 
   			   				@ prow()+1,000 PSAY replicate("_",limite)
					 		@ prow()+1,000 PSAY TMP1->FORNECE 
					   		@ prow()  ,012 PSAY " - " + TMP1->NOME
	   						@ prow()+1,000 PSAY " "//replicate("_",limite)
	   						AADD(_forne,_nomeant)
							AADD(_mcub,_tqtds)	
							AADD(_valor,_tvlr) 
							_tqtd	:= 0 
							_tqtds	:= 0 
							_tvlr	:= 0  
							
					EndIf
					_codant		:= TMP1->FORNECE
					_nomeant    := TMP1->NOME 
   		   			tmp1->(dbskip()) 		
	   		   	End Do
					 		@ prow()+1,000 PSAY "Total:" 
		   					@ prow()  ,078 PSAY _tqtd PICTURE "@E 99,999.99" 
		   			   		@ prow()  ,089 PSAY _tqtds PICTURE "@E 9,999.99" 	
		   			   		@ prow()  ,099 PSAY _tvlr PICTURE "@E 9,999,999.99" 
   			   				@ prow()+1,000 PSAY replicate("_",limite)
	   						@ prow()+1,000 PSAY " "//replicate("_",limite)
	   						AADD(_forne,_nomeant)
							AADD(_mcub,_tqtds)	
							AADD(_valor,_tvlr) 
							_tqtd	:= 0 
							_tqtds	:= 0 
							_tvlr	:= 0  	   		   	 
tmp1->(dbclosearea())
								@ prow()+1,000 PSAY replicate("_",limite) 
								@ prow()+1,000 PSAY "Resumo do total por fornecedor "
								@ prow()+1,000 PSAY replicate("_",limite) 
								@ prow()+1,000 PSAY "Fornecedor                                                                                 QTD M3   Valor Total "  
								@ prow()+1,000 PSAY replicate("_",limite)
					 	   		For i = 1 to len(_forne)
						 	   		@ prow()+1,000 PSAY substr(_forne[i] ,1,40)
				   			   		@ prow()  ,089 PSAY _mcub[i] PICTURE "@E 9,999.99" 	
				   			   		@ prow()  ,099 PSAY _valor[i] PICTURE "@E 9,999,999.99" 								
								Next
lcontinua 	:= .t.
	if labortprint
		@ prow()+2,000 PSAY "***** CANCELADO PELO OPERADOR *****"
		lcontinua:=.f.
	endif 

set device to screen

if areturn[5]==1
	set print to
	dbcommitall()
	ourspool(wnrel)
endIf

ms_flush()
return


static function _geratmp()
//-----------------------------------------------------------------
//Cria sql para os pedidos de venda   
//-----------------------------------------------------------------


	incproc("Selecionando notas...")
	cQuery := "SELECT D1_GRUPO GRUPO, D1_EMISSAO EMISSAO, D1_DOC NUM, D1_TOTAL VALOR, D1_FORNECE FORNECE, D1_COD COD, D1_QUANT QTD, D1_QTSEGUM QTDS, A2_NOME NOME"
	cQuery += " FROM "
	cQuery += retsqlname("SD1")+" SD1,"
	cQuery += retsqlname("SA2")+" SA2"
	cQuery += " WHERE "	
	cQuery += "     SD1.D_E_L_E_T_<>'*' " 
	cQuery += " AND SD1.D1_FILIAL='"+_cfilsd1+"'"  
	cQuery += " AND SA2.A2_FILIAL='"+_cfilsa2+"'" 
	cQuery += " AND SD1.D1_EMISSAO BETWEEN '"+dtos(mv_par03)+"' AND '"+dtos(mv_par04)+"' "
	cQuery += " AND SD1.D1_GRUPO BETWEEN '"+ mv_par01 +"' AND '"+ mv_par02 +"' " 
  	cQuery += " AND SD1.D1_FORNECE BETWEEN '"+ mv_par05 +"' AND '"+ mv_par06 +"' "
  	cQuery += " AND SD1.D1_FORNECE = SA2.A2_COD"	
  	cQuery += " AND SD1.D1_QUANT > '0'"  	
   	cQuery += " ORDER BY SD1.D1_FORNECE, SD1.D1_COD"


	cquery:=changequery(cquery)                                                     
	
	tcquery cquery new alias "TMP1"   
	tcsetfield("TMP1","EMISSAO","D") 

	
return	

static function _pergsx1()
_agrpsx1:={}

aadd(_agrpsx1,{cperg,"01","Da Natureza        ?","mv_ch1","C",08,0,0,"G",space(60),"mv_par01"       ,space(15)        ,space(30),space(15),space(15)        ,space(30),space(15),space(15)        ,space(30),space(15),space(15)        ,space(30),space(15),space(15)        ,space(30),"   "})
aadd(_agrpsx1,{cperg,"02","Ate a Natureza     ?","mv_ch2","C",08,0,0,"G",space(60),"mv_par02"       ,space(15)        ,space(30),space(15),space(15)        ,space(30),space(15),space(15)        ,space(30),space(15),space(15)        ,space(30),space(15),space(15)        ,space(30),"   "})
aadd(_agrpsx1,{cperg,"03","Da Emissao         ?","mv_ch3","D",08,0,0,"G",space(60),"mv_par03"       ,space(15)        ,space(30),space(15),space(15)        ,space(30),space(15),space(15)        ,space(30),space(15),space(15)        ,space(30),space(15),space(15)        ,space(30),"   "})
aadd(_agrpsx1,{cperg,"04","Ate Emissao        ?","mv_ch4","D",08,0,0,"G",space(60),"mv_par03"       ,space(15)        ,space(30),space(15),space(15)        ,space(30),space(15),space(15)        ,space(30),space(15),space(15)        ,space(30),space(15),space(15)        ,space(30),"   "})



for _i:=1 to len(_agrpsx1)
	if ! sx1->(dbseek(_agrpsx1[_i,1]+_agrpsx1[_i,2]))
		sx1->(reclock("SX1",.t.))
		sx1->x1_grupo  :=_agrpsx1[_i,01]
		sx1->x1_ordem  :=_agrpsx1[_i,02]
		sx1->x1_pergunt:=_agrpsx1[_i,03]
		sx1->x1_variavl:=_agrpsx1[_i,04]
		sx1->x1_tipo   :=_agrpsx1[_i,05]
		sx1->x1_tamanho:=_agrpsx1[_i,06]
		sx1->x1_decimal:=_agrpsx1[_i,07]
		sx1->x1_presel :=_agrpsx1[_i,08]
		sx1->x1_gsc    :=_agrpsx1[_i,09]
		sx1->x1_valid  :=_agrpsx1[_i,10]
		sx1->x1_var01  :=_agrpsx1[_i,11]
		sx1->x1_def01  :=_agrpsx1[_i,12]
		sx1->x1_cnt01  :=_agrpsx1[_i,13]
		sx1->x1_var02  :=_agrpsx1[_i,14]
		sx1->x1_def02  :=_agrpsx1[_i,15]
		sx1->x1_cnt02  :=_agrpsx1[_i,16]
		sx1->x1_var03  :=_agrpsx1[_i,17]
		sx1->x1_def03  :=_agrpsx1[_i,18]
		sx1->x1_cnt03  :=_agrpsx1[_i,19]
		sx1->x1_var04  :=_agrpsx1[_i,20]
		sx1->x1_def04  :=_agrpsx1[_i,21]
		sx1->x1_cnt04  :=_agrpsx1[_i,22]
		sx1->x1_var05  :=_agrpsx1[_i,23]
		sx1->x1_def05  :=_agrpsx1[_i,24]
		sx1->x1_cnt05  :=_agrpsx1[_i,25]
		sx1->x1_f3     :=_agrpsx1[_i,26]
		sx1->(msunlock())
	endif
next

return


