/* Techne Engenharia e Sistemas Ltda. */
/* Cliente : Governo do Estado do Rio Grande do Sul */

/* F�rmulas de C�lculo   Gera��o - Data: 29/08/2016 Hora: 15:15 */
/* Mes/Ano de Refer�ncia : De 01/2005 at�  */

@@ID_ARQ [133646]

@@ID_DB [RHEP]

@@GRUPO [GERAL]  
@ [REAL     ][12FORMULA  ][zeraRubricasHVTpFol  ][200501-209912] [A] [20160804-15:15:31]
void zeraRubricasHVTpFol (string strSTARTUP, long PP)
{
/* F�rmula auxiliar para zerar Rubricas a n�o serem calculadas CONTINUA��O  */
  DECLARA_INTEIRO RR;

  // Chamada em: STARTUP_PERIODO/TOTAL Parm:("PER�ODO" ou "TOTAL", PP)
  SE vgTipoEmpresa IGUAL "TRIBUNAL DE JUSTI�A" E cEFE.temEfetividade("PENAS DISCIPLINARES","SMV") E NAOEH getDadoFolhaBool(TFFolhaDecTer) ENTAO
     // Os valores s�o reduzidos pela metade pelo AplicaCoef com base na efetividade que foi colocada no grupo de frequ�ncia FOLHA05
     gravaDbg("|STARTUP_%s| Regime Jur�dico:%s - zerarRubricaHV ",strSTARTUP.c_str(), tbVINC.cREGIMEJUR.c_str() );
     SE  strSTARTUP IGUAL "PER�ODO" ENTAO
        RR = 1;
        CADA_ENQUANTO (RR,RR < ULTIMO_RR - 1)
          SE  RUBRICA IGUAL   1 OU                  // B�sico
              RUBRICA IGUAL 199 OU                  // Aux�lio-Creche
              myfatvantru[rrubr[RR]] IGUAL ZERO OU  // Auxiliares
              myfatvantru[rrubr[RR]] IGUAL -1   OU  // Descontos
             ( getDadoFolhaBool(TFFolhaDecTer) E cRUB.origem13o(RUBRICA,COMPLEMENTO) )
             ENTAO
             // RUBRICAS a calcular cfme regras de neg�cio definadas pelo Cliente
          SENAO
             cZera.zeraCelula(RR,"DESFAZ",false); // N�o zerar la�amentos manuais - comandados
          SEFIM
        CADAFIM
        RR = ZEROI;

     SENAO_SE strSTARTUP IGUAL "L�QUIDO" ENTAO
     SEFIM
  SEFIM


  //--------------------------------------------------------------------------------
  // Chamada em: STARTUP_PERIODO/TOTAL Parm:("PER�ODO" ou "TOTAL", PP)
  SE   ((getDadoFolhaStr(TFTipo) IGUAL "Diss�dio Pagamento") OU
        (getDadoFolhaStr(TFTipo) IGUAL "Diss�dio Pagto RPM")) E
       (vgTipoEmpresa IGUAL "FUND DIREITO P�BLICO" OU
        vgTipoEmpresa IGUAL "AUTARQUIA"            OU
        vgTipoEmpresa IGUAL "FUND PUB DIR PRIVADO") ENTAO
     gravaDbg("|STARTUP_%s| FOLHA: Diss�dio Pagamento - zerarRubricaHV | PF.AnoMesDir:%d | PF.AnoMesPri:%d",strSTARTUP.c_str(),PF.AnoMesDir,PF.AnoMesPri);
     SE  (strSTARTUP IGUAL "PER�ODO" E getDadoFolhaStr(TFTipo) IGUAL "Diss�dio Pagto RPM") OU
         (strSTARTUP IGUAL "PER�ODO" E getDadoFolhaStr(TFTipo) IGUAL "Diss�dio Pagamento" E PF.AnoMesDir DIFERENTE PF.AnoMesPri) OU
         (strSTARTUP IGUAL "TOTAL" E getDadoFolhaStr(TFTipo) IGUAL "Diss�dio Pagto RPM") OU
         (strSTARTUP IGUAL "TOTAL" E getDadoFolhaStr(TFTipo) IGUAL "Diss�dio Pagamento" E PF.AnoMesDir DIFERENTE PF.AnoMesPri) OU
         (strSTARTUP IGUAL "L�QUIDO") ENTAO
        RR = 1;
        CADA_ENQUANTO (RR,RR < ULTIMO_RR - 1)
          SE (RUBRICA DIFERENTE 987 E
              RUBRICA DIFERENTE 988 E
              RUBRICA DIFERENTE 989 E
              RUBRICA DIFERENTE 991 E
              RUBRICA DIFERENTE 997 E
              RUBRICA DIFERENTE 998 E
              RUBRICA DIFERENTE 999 E
              NAOEH rubricaPresenteNoFator (RUBRICA,IXFAT_DISSIDIO_PAGTO)
          ) OU NAOEH tbATRFUNC.temAtributo("Diss�dio Pagto")
    		    OU (getDadoFolhaStr(TFTipo) IGUAL "Diss�dio Pagamento" E strSTARTUP DIFERENTE "L�QUIDO")
           ENTAO
            cZera.zeraCelula(RR,"RATIFICA",true);
          SEFIM
        CADAFIM
        RR = ZEROI;

        // cZera.zerarPorFator (IXFAT_DISSIDIO_PAGTO, AUSENTE, true);
     SEFIM
  SEFIM




  //--------------------------------------------------------------------------------
  // Chamada em: STARTUP_PERIODO/TOTAL Parm:("PER�ODO" ou "TOTAL", PP)
  SE   ( getDadoFolhaStr(TFTipo) IGUAL "RPM"                 OU
         getDadoFolhaStr(TFTipo) IGUAL "RPM NEGATIVOS"       OU
         getDadoFolhaStr(TFTipo) IGUAL "RPM COMPL PODERES"   OU  // Thiago G�z - 11/07/2012 - Retroativos
         getDadoFolhaStr(TFTipo) IGUAL "Diss�dio Apura RPM"      // Thiago G�z - 14/09/2012 - Diss�dio Pr�-Mensal
         )
     E PF.AnoMesDir > 200602
     ENTAO
     gravaDbg("|STARTUP_%s| FOLHA: RPM/RPM NEGATIVOS - zerarRubricaHV | PF.AnoMesDir:%d | PF.AnoMesPri:%d",strSTARTUP.c_str(),PF.AnoMesDir,PF.AnoMesPri);
     SE  strSTARTUP IGUAL "PER�ODO" ENTAO
        RR = 1;
        CADA_ENQUANTO (RR,RR < ULTIMO_RR - 1)
          SE  RUBRICA IGUAL 178 // Etapas de Alimenta��o
             ENTAO
             cZera.zeraCelula(RR,"RATIFICA",true); // manter Lan.Man. & j� Processado
          SEFIM
        CADAFIM
        RR = ZEROI;
     SENAO_SE strSTARTUP IGUAL "TOTAL" ENTAO
        RR = 1;
        CADA_ENQUANTO (RR,RR < ULTIMO_RR - 1)
          SE  RUBRICA IGUAL 178 // Etapas de Alimenta��o
             ENTAO
             cZera.zeraCelula(RR,"RATIFICA",true); // manter Lan.Man. & j� Processado
          SEFIM
        CADAFIM
        RR = ZEROI;
     SENAO_SE strSTARTUP IGUAL "L�QUIDO" ENTAO

     SEFIM
  SEFIM

  //--------------------------------------------------------------------------------
  // Chamada em: STARTUP_PERIODO/TOTAL Parm:("PER�ODO" ou "TOTAL", PP)

  // Thiago G�z - Adequa��o do SuperTipo - 16/04/2012
  /*SE getDadoFolhaStr(TFTipo) IGUAL "13o. PARCELADO" // Chamada em: STARTUP_PERIODO Parm:("PER�ODO", PP)
     ENTAO
     gravaDbg("|STARTUP_%s| FOLHA: 13o.Parcelado - zerarRubricaHV | PF.AnoMesDir:%d | PF.AnoMesPri:%d",strSTARTUP.c_str(),PF.AnoMesDir,PF.AnoMesPri);
     SE  strSTARTUP IGUAL "PER�ODO" ENTAO
        RR = 1;
        CADA_ENQUANTO (RR,RR < ULTIMO_RR - 1)
          SE  RUBRICA IGUAL 299 OU                           // Corre��o monet�ria 13� Venc. Parcelado - temp
              fatPACons.sinalFatorRubrica ("", RUBRICA) == 1 // CONSIGNAT�RIA
             ENTAO
             // RUBRICAS a calcular cfme regras de neg�cio definadas pelo Cliente
          SENAO
            //// cZera.zerarRubrica(RR);
            rVC  = 0.0;   // tabela hv - valor principal
            rVCC = 0.0;   // tabela hv - corre��o monet�ria
          SEFIM
        CADAFIM
        RR = ZEROI;
     SENAO_SE strSTARTUP IGUAL "TOTAL" ENTAO
        RR = 1;
        CADA_ENQUANTO (RR,RR < ULTIMO_RR - 1)
          SE  RUBRICA IGUAL 299 OU RUBRICA IGUAL 997 OU RUBRICA IGUAL 998 OU  RUBRICA IGUAL 999 OU // Corre��o monet�ria 13� Venc. Parcelado - temp
              fatPACons.sinalFatorRubrica ("", RUBRICA) == 1 // CONSIGNAT�RIA
             ENTAO
             // RUBRICAS a calcular cfme regras de neg�cio definadas pelo Cliente
          SENAO
              //--- rubricas calculadas (hv)
              rVC  = rVP;    // tabela hv - valor principal
              rVCC = rVCP;   // tabela hv - corre��o monet�ria

              //-- Zera diferen�a de MOVIMENTOS manuais (mv --> tabela bd: fol-movimentos)
              //-- menos da compet�ncia de dezembro de 2005 ou anteriores
              if (PF.AnoMesDir > 200512){
                 rMC  = rMP;
                 rMCC = rMCP;
              }
              //--- zera diferen�a de valores parcelados (pc --> tabela bd: fichas-parcelas) ---
              rPC  = rPP;
              rPCC = rPCP;

          SEFIM
        CADAFIM
        RR = ZEROI;
     SENAO_SE strSTARTUP IGUAL "L�QUIDO" ENTAO
          RR = 1;
        CADA_ENQUANTO (RR,RR < ULTIMO_RR - 1)
          SE  RUBRICA IGUAL 299  // Corre��o monet�ria 13� Venc. Parcelado - temp
              OU RUBRICA IGUAL 997 OU RUBRICA IGUAL 998 OU  RUBRICA IGUAL 999   ENTAO
             // RUBRICAS a calcular cfme regras de neg�cio definadas pelo Cliente
          SENAO
            SE flrubrcalc[rrubr[RR]] DIFERENTE ZERO ENTAO
              // Eliminar somente as demais rubricas que possuem c�lculo em tempo de l�quido
              rVC  = 0.00;    // tabela hv - valor principal
              rVCC = 0.00;    // tabela hv - corre��o monet�ria
            SEFIM
          SEFIM
        CADAFIM
        RR = ZEROI;
     SEFIM
  SEFIM */

  //--------------------------------------------------------------------------------
  // Chamada em: STARTUP_PERIODO/TOTAL Parm:("PER�ODO" ou "TOTAL", PP)
  SE getDadoFolhaStr(TFTipo) IGUAL "VALE REFEI��O" // Chamada em: STARTUP_PERIODO Parm:("PER�ODO", PP)
     ENTAO
     gravaDbg("|STARTUP_%s| Foha:VALE REFEI��O - zerarRubricaHV *** PF.AnoMesDir:%d | PF.AnoMesPri:%d",strSTARTUP.c_str(), PF.AnoMesDir , PF.AnoMesPri);

     SE PF.AnoMesDir < PF.AnoMesPri ENTAO // Paga-se somente ETAPAS DE ALIMENTA��O
       SE strSTARTUP IGUAL "PER�ODO" ENTAO
          RR = 1;
          CADA_ENQUANTO (RR,RR < ULTIMO_RR - 1)
            SE RUBRICA IGUAL 178 // Etapas de Alimenta��o
              ENTAO
              // RUBRICAS a calcular cfme regras de neg�cio definadas pelo Cliente
            SENAO
              cZera.zeraCelula(RR,"RATIFICA",true); // manter la�amentos manuais - comandados
            SEFIM
          CADAFIM
          RR = ZEROI;
       SENAO_SE strSTARTUP IGUAL "TOTAL" ENTAO
          RR = 1;
          CADA_ENQUANTO (RR,RR < ULTIMO_RR - 1)
            SE RUBRICA IGUAL 178 // Etapas de Alimenta��o
              ENTAO
              // RUBRICAS a calcular cfme regras de neg�cio definadas pelo Cliente
            SENAO
              cZera.zeraCelula(RR,"RATIFICA",true); // manter la�amentos manuais - comandados
            SEFIM
          CADAFIM
          RR = ZEROI;
       SENAO_SE strSTARTUP IGUAL "L�QUIDO" ENTAO
          RR = 1;
          CADA_ENQUANTO (RR,RR < ULTIMO_RR - 1)
            SE RUBRICA IGUAL 178 // Etapas de Alimenta��o
              ENTAO
              // RUBRICAS a calcular cfme regras de neg�cio definadas pelo Cliente
            SENAO
              SE flrubrcalc[rrubr[ixrubr]] != 0 // � rubrica de l�quido
                ENTAO
                //gravaDbg("|zeraRubricasHV| Rubrica:%d | rrubr[ixrubr]:%d | flrubrcalc[rrubr[ixrubr]]:%d ", RR, rrubr[ixrubr], flrubrcalc[rrubr[ixrubr]]);
                cZera.zeraCelula(RR,"RATIFICA",true); // manter la�amentos manuais - comandados
              SEFIM
            SEFIM
          CADAFIM
          RR = ZEROI;
       SEFIM

     SENAO  // Paga-se somente VALE REFEI��O

       SE strSTARTUP IGUAL "PER�ODO" ENTAO
          RR = 1;
          CADA_ENQUANTO (RR,RR < ULTIMO_RR - 1)
            SE RUBRICA IGUAL 174 OU // Vale-refei��o
               RUBRICA IGUAL 801    // Auxiliar Qte de VR a pagar
              ENTAO
              // RUBRICAS a calcular cfme regras de neg�cio definadas pelo Cliente
            SENAO
              cZera.zeraCelula(RR,"RATIFICA",true); // manter la�amentos manuais - comandados
            SEFIM
          CADAFIM
          RR = ZEROI;
       SENAO_SE strSTARTUP IGUAL "TOTAL" ENTAO
          RR = 1;
          CADA_ENQUANTO (RR,RR < ULTIMO_RR - 1)
            SE RUBRICA IGUAL 174 OU // Vale-refei��o
               RUBRICA IGUAL 801    // Auxiliar Qte de VR a pagar
              ENTAO
              // RUBRICAS a calcular cfme regras de neg�cio definadas pelo Cliente
            SENAO
              cZera.zeraCelula(RR,"RATIFICA",true); // manter la�amentos manuais - comandados
            SEFIM
          CADAFIM
          RR = ZEROI;
       SENAO_SE strSTARTUP IGUAL "L�QUIDO" ENTAO

          RR = 1;
          CADA_ENQUANTO (RR,RR < ULTIMO_RR - 1)
            SE RUBRICA IGUAL 174 OU // Vale-refei��o
               RUBRICA IGUAL 801 OU // Auxiliar Qte de VR a pagar
               RUBRICA IGUAL 997 OU // Total de Vantagens
               RUBRICA IGUAL 998 OU // Total de Descontos
               RUBRICA IGUAL 999    // Liqu�do
              ENTAO
              // RUBRICAS a calcular cfme regras de neg�cio definadas pelo Cliente
            SENAO
              SE flrubrcalc[rrubr[ixrubr]] != 0 // � rubrica de l�quido
                ENTAO
                //gravaDbg("|zeraRubricasHV| Rubrica:%d | rrubr[ixrubr]:%d | flrubrcalc[rrubr[ixrubr]]:%d ", RR, rrubr[ixrubr], flrubrcalc[rrubr[ixrubr]]);
                cZera.zeraCelula(RR,"RATIFICA",true); // manter la�amentos manuais - comandados
              SEFIM
            SEFIM
          CADAFIM
          RR = ZEROI;

       SEFIM
     SEFIM
  SEFIM

  //--------------------------------------------------------------------------------
  // Chamada em: STARTUP_PERIODO/TOTAL Parm:("PER�ODO" ou "TOTAL", PP)
 SE strcmp(PF.FinalidadeCalculo, "RETROATIVOS-PODERES")   ==0  OU       // getDadoFolhaStr(TFTipo) IGUAL "RETROATIVOS-PODERES"
	  strcmp(PF.FinalidadeCalculo, "FALECIDOS HABILITADO")  ==0           // getDadoFolhaStr(TFTipo) IGUAL "FALECIDOS HABILITADO"  // Chamada em: STARTUP_... Parm:("...", PP)
 ENTAO
     gravaDbg("|STARTUP_%s| FOLHA: RETROATIVOS-PODERES - zerarRubricaHV | PF.AnoMesDir:%d | PF.AnoMesPri:%d",strSTARTUP.c_str(),PF.AnoMesDir,PF.AnoMesPri);
     SE  strSTARTUP IGUAL "PER�ODO" OU
         strSTARTUP IGUAL "TOTAL"   ENTAO
        RR = 1;
        CADA_ENQUANTO (RR,RR < ULTIMO_RR - 1)
          //gravaDbg("|RETROATIVOS-PODERES| strSTARTUP:%s | RUBRICA:%0.4d | myfatvantru:%d ", strSTARTUP.c_str(), RUBRICA, myfatvantru[rrubr[RR]] );
          SE (RUBRICA >= 1123 E RUBRICA <= 1132 ) // Rubricas de URV
             // OU myfatvantru[rrubr[RR]] IGUAL ZERO   // Auxiliares   // Este myfatvant indica se a rubrica � de:
             // OU myfatvantru[rrubr[RR]] IGUAL -1     // Descontos    // Vantagens (1), Desconto (-1) ou Auxiliar (0)
             OU RUBRICA IGUAL  402  // IPE
             OU RUBRICA IGUAL  411  // INSS
             OU RUBRICA IGUAL  422  // IR
             OU RUBRICA IGUAL  430  // PA
             OU RUBRICA IGUAL  850  // CCD - Pens�o Aliment�cia
             OU RUBRICA IGUAL  1173 // Habilitado Post-Mortem
             OU RUBRICA IGUAL  1174 // Habilitado Post-Mortem
             OU RUBRICA IGUAL  1175 // Dep�sito Judicial
             OU RUBRICA IGUAL  1474 // Habilitado Post-Mortem
             //OU RUBRICA IGUAL  902  // Base IPE
             //OU RUBRICA IGUAL  911  // Base INSS
             //OU RUBRICA IGUAL  920  // Base Mensal IR
             ENTAO
             // RUBRICAS a calcular cfme regras de neg�cio definadas pelo Cliente
             //gravaDbg("|RETROATIVOS-PODERES| RUBRICA:%0.4d - a Calcular", RUBRICA);
          SENAO
             cZera.zeraCelula(RR,"DESFAZ",false); // N�o zerar la�amentos manuais - comandados
          SEFIM
        CADAFIM
        RR = ZEROI;
     SENAO_SE strSTARTUP IGUAL "L�QUIDO" ENTAO
        RR = 1;
        CADA_ENQUANTO (RR,RR < ULTIMO_RR - 1)
          //gravaDbg("|RETROATIVOS-PODERES| strSTARTUP:%s | RUBRICA:%0.4d | flrubrcalc:%d ", strSTARTUP.c_str(), RUBRICA, flrubrcalc[rrubr[RR]] );
          SE flrubrcalc[rrubr[RR]] DIFERENTE ZERO ENTAO
             SE //RUBRICA IGUAL  421    // IR      (Bruno solicitou que n�o seja Calculado 4/1/11 �s 16:15 (via telefone)
                //RUBRICA IGUAL  921 OU // Base IR (Bruno solicitou que n�o seja Calculado 4/1/11 �s 16:15 (via telefone)
                RUBRICA IGUAL  1473 OU // Estorno Post-Morten (para gerar cr�dito extra-or�ament�rio)
                RUBRICA IGUAL   987 OU RUBRICA IGUAL 988 OU RUBRICA IGUAL 989 OU    //  Vantagens / Descontos / L�quido - DEPENDENTES
                RUBRICA IGUAL   997 OU RUBRICA IGUAL 998 OU RUBRICA IGUAL 999 ENTAO //  Vantagens / Descontos / L�quido
                // RUBRICAS a calcular cfme regras de neg�cio definadas pelo Cliente
                //gravaDbg("|RETROATIVOS-PODERES| RUBRICA:%0.4d - a Calcular", RUBRICA);
             SENAO
               // Eliminar somente as demais rubricas (exceto as acima Vant/Desc/L�q) que possuem c�lculo em tempo de l�quido
               rVC  = 0.00;    // tabela hv - valor principal
               rVCC = 0.00;    // tabela hv - corre��o monet�ria
               //gravaDbg("|RETROATIVOS-PODERES| RUBRICA:%0.4d - atribuido ZERO na c�lula da HV", RUBRICA);
             SEFIM
          SEFIM
        CADAFIM
        RR = ZEROI;
     SEFIM
  SEFIM

  SE strcmp(PF.FinalidadeCalculo, "HABILITADOS") ==0  // getDadoFolhaStr(TFTipo) IGUAL "HABILITADOS"              // Chamada em: STARTUP_... Parm:("...", PP)
     ENTAO
     gravaDbg("|STARTUP_%s| FOLHA: RETROATIVOS-PODERES - zerarRubricaHV | PF.AnoMesDir:%d | PF.AnoMesPri:%d",strSTARTUP.c_str(),PF.AnoMesDir,PF.AnoMesPri);
     SE  strSTARTUP IGUAL "PER�ODO" OU
         strSTARTUP IGUAL "TOTAL"   ENTAO
        RR = 1;
        CADA_ENQUANTO (RR,RR < ULTIMO_RR - 1)
          //gravaDbg("|RETROATIVOS-PODERES| strSTARTUP:%s | RUBRICA:%0.4d | myfatvantru:%d ", strSTARTUP.c_str(), RUBRICA, myfatvantru[rrubr[RR]] );
          SE (RUBRICA >= 1023 E RUBRICA <= 1032 ) // Rubricas de URV
             // OU myfatvantru[rrubr[RR]] IGUAL ZERO   // Auxiliares   // Este myfatvant indica se a rubrica � de:
             // OU myfatvantru[rrubr[RR]] IGUAL -1     // Descontos    // Vantagens (1), Desconto (-1) ou Auxiliar (0)
             OU RUBRICA IGUAL  422  // Imposto sobre Renda
             OU RUBRICA IGUAL  421  // Imposto sobre Renda
             OU RUBRICA IGUAL  1173 // Habilitado Post-Mortem
             OU RUBRICA IGUAL  1175 // Dep�sito Judicial
             OU RUBRICA IGUAL  823  // Imposto de Renda 13o - mensal
             OU RUBRICA IGUAL  824  // Auxiliar Mensal de Base de Imposto sobre Renda
             OU RUBRICA IGUAL  920  // Base Mensal IR
             OU RUBRICA IGUAL  1920 // Base Mensal IR
             OU RUBRICA IGUAL  1941 // DIRF RENDA    - RRA
             OU RUBRICA IGUAL  1942 // DIRF DED PREV - RRA
             OU RUBRICA IGUAL  1943 // DIRF DED PA   - RRA
             ENTAO
             // RUBRICAS a calcular cfme regras de neg�cio definadas pelo Cliente
             //gravaDbg("|RETROATIVOS-PODERES| RUBRICA:%0.4d - a Calcular", RUBRICA);
          SENAO
             cZera.zeraCelula(RR,"DESFAZ",false); // N�o zerar la�amentos manuais - comandados
          SEFIM
        CADAFIM
        RR = ZEROI;
     SENAO_SE strSTARTUP IGUAL "L�QUIDO" ENTAO
        RR = 1;
        CADA_ENQUANTO (RR,RR < ULTIMO_RR - 1)
          //gravaDbg("|RETROATIVOS-PODERES| strSTARTUP:%s | RUBRICA:%0.4d | flrubrcalc:%d ", strSTARTUP.c_str(), RUBRICA, flrubrcalc[rrubr[RR]] );
          SE flrubrcalc[rrubr[RR]] DIFERENTE ZERO ENTAO
             SE RUBRICA IGUAL  421  OU  // Imposto sobre Renda
                RUBRICA IGUAL  1421 OU  // Imposto sobre Renda - RRA
                RUBRICA IGUAL  1820 OU  // Quantidade de meses RRA - PRERHE
                RUBRICA IGUAL  1821 OU  // Quantidade de meses RRA - RHE
                RUBRICA IGUAL  1822 OU  // Quantidade de meses RRA - TOTAL
                RUBRICA IGUAL  921  OU  // Base do Imposto sobre Renda
                RUBRICA IGUAL  1921 OU  // Base do Imposto sobre Renda - RRA
                RUBRICA IGUAL   987 OU RUBRICA IGUAL 988 OU RUBRICA IGUAL 989 OU    //  Vantagens / Descontos / L�quido - DEPENDENTES
                RUBRICA IGUAL   997 OU RUBRICA IGUAL 998 OU RUBRICA IGUAL 999 ENTAO //  Vantagens / Descontos / L�quido
                // RUBRICAS a calcular cfme regras de neg�cio definadas pelo Cliente
                //gravaDbg("|RETROATIVOS-PODERES| RUBRICA:%0.4d - a Calcular", RUBRICA);
             SENAO
               // Eliminar somente as demais rubricas (exceto as acima Vant/Desc/L�q) que possuem c�lculo em tempo de l�quido
               rVC  = 0.00;    // tabela hv - valor principal
               rVCC = 0.00;    // tabela hv - corre��o monet�ria
               //gravaDbg("|RETROATIVOS-PODERES| RUBRICA:%0.4d - atribuido ZERO na c�lula da HV", RUBRICA);
             SEFIM
          SEFIM
        CADAFIM
        RR = ZEROI;
     SEFIM
  SEFIM

  //----------------------------------------------------------------------------------------------------------------------
  // Thiago G�z - 04/08/2016 - #124574
  //----------------------------------------------------------------------------------------------------------------------

  SE (getDadoFolhaStr(TFTipo) IGUAL "RESCISAO") ENTAO
     gravaDbg("|STARTUP_%s| FOLHA: RESCISAO - zerarRubricaHV | PF.AnoMesDir:%d | PF.AnoMesPri:%d",strSTARTUP.c_str(),PF.AnoMesDir,PF.AnoMesPri);
     RR = 1;
     CADA_ENQUANTO (RR,RR < ULTIMO_RR - 1)
       SE rubricaPresenteNoFator (RUBRICA,IXFAT_FOLHA_RESCISAO) ENTAO
         cZera.zeraCelula(RR,"RATIFICA",true);
       SEFIM
     CADAFIM
     RR = ZEROI;
  SEFIM

  //----------------------------------------------------------------------------------------------------------------------
  // Thiago G�z - 29/08/2016
  //----------------------------------------------------------------------------------------------------------------------

  SE (getDadoFolhaStr(TFTipo) IGUAL "SIMULACAO") ENTAO
     gravaDbg("|STARTUP_%s| FOLHA: SIMULA��O - zerarRubricaHV | PF.AnoMesDir:%d | PF.AnoMesPri:%d",strSTARTUP.c_str(),PF.AnoMesDir,PF.AnoMesPri);
     RR = 1;
     CADA_ENQUANTO (RR,RR < ULTIMO_RR - 1)
       SE rubricaPresenteNoFator (RUBRICA,IXFAT_FOLHA_LIMPA) ENTAO
         cZera.zeraCelula(RR,"RATIFICA",true);
       SEFIM
     CADAFIM
     RR = ZEROI;
  SEFIM

}