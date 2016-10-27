@@ID_ARQ [133646]

@@ID_DB [RHEP]

@@GRUPO [GERAL]  
@ [REAL     ][12FORMULA  ][zeraRubricasHVTpFol  ][200501-209912] [A] [20160804-15:15:31]
void zeraRubricasHVTpFol (string strSTARTUP, long PP)
{
/* Fórmula auxiliar para zerar Rubricas a não serem calculadas CONTINUAÇÃO  */
  DECLARA_INTEIRO RR;

  // Chamada em: STARTUP_PERIODO/TOTAL Parm:("PERÍODO" ou "TOTAL", PP)
  SE vgTipoEmpresa IGUAL "TRIBUNAL DE JUSTIÇA" E cEFE.temEfetividade("PENAS DISCIPLINARES","SMV") E NAOEH getDadoFolhaBool(TFFolhaDecTer) ENTAO
     // Os valores são reduzidos pela metade pelo AplicaCoef com base na efetividade que foi colocada no grupo de frequência FOLHA05
     gravaDbg("|STARTUP_%s| Regime Jurídico:%s - zerarRubricaHV ",strSTARTUP.c_str(), tbVINC.cREGIMEJUR.c_str() );
     SE  strSTARTUP IGUAL "PERÍODO" ENTAO
        RR = 1;
        CADA_ENQUANTO (RR,RR < ULTIMO_RR - 1)
          SE  RUBRICA IGUAL   1 OU                  // Básico
              RUBRICA IGUAL 199 OU                  // Auxílio-Creche
              myfatvantru[rrubr[RR]] IGUAL ZERO OU  // Auxiliares
              myfatvantru[rrubr[RR]] IGUAL -1   OU  // Descontos
             ( getDadoFolhaBool(TFFolhaDecTer) E cRUB.origem13o(RUBRICA,COMPLEMENTO) )
             ENTAO
             // RUBRICAS a calcular cfme regras de negócio definadas pelo Cliente
          SENAO
             cZera.zeraCelula(RR,"DESFAZ",false); // Não zerar laçamentos manuais - comandados
          SEFIM
        CADAFIM
        RR = ZEROI;

     SENAO_SE strSTARTUP IGUAL "LÍQUIDO" ENTA
     SEFIM
  SEFIM


  //--------------------------------------------------------------------------------
  // Chamada em: STARTUP_PERIODO/TOTAL Parm:("PERÍODO" ou "TOTAL", PP)
  SE   ((getDadoFolhaStr(TFTipo) IGUAL "Dissídio Pagamento") OU
        (getDadoFolhaStr(TFTipo) IGUAL "Dissídio Pagto RPM")) E
       (vgTipoEmpresa IGUAL "FUND DIREITO PÚBLICO" OU
        vgTipoEmpresa IGUAL "AUTARQUIA"            OU
        vgTipoEmpresa IGUAL "FUND PUB DIR PRIVADO") ENTAO
     gravaDbg("|STARTUP_%s| FOLHA: Dissídio Pagamento - zerarRubricaHV | PF.AnoMesDir:%d | PF.AnoMesPri:%d",strSTARTUP.c_str(),PF.AnoMesDir,PF.AnoMesPri);
     SE  (strSTARTUP IGUAL "PERÍODO" E getDadoFolhaStr(TFTipo) IGUAL "Dissídio Pagto RPM") OU
         (strSTARTUP IGUAL "PERÍODO" E getDadoFolhaStr(TFTipo) IGUAL "Dissídio Pagamento" E PF.AnoMesDir DIFERENTE PF.AnoMesPri) OU
         (strSTARTUP IGUAL "TOTAL" E getDadoFolhaStr(TFTipo) IGUAL "Dissídio Pagto RPM") OU
         (strSTARTUP IGUAL "TOTAL" E getDadoFolhaStr(TFTipo) IGUAL "Dissídio Pagamento" E PF.AnoMesDir DIFERENTE PF.AnoMesPri) OU
         (strSTARTUP IGUAL "LÍQUIDO") ENTAO
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
          ) OU NAOEH tbATRFUNC.temAtributo("Dissídio Pagto")
    		    OU (getDadoFolhaStr(TFTipo) IGUAL "Dissídio Pagamento" E strSTARTUP DIFERENTE "LÍQUIDO")
           ENTAO
            cZera.zeraCelula(RR,"RATIFICA",true);
          SEFIM
        CADAFIM
        RR = ZEROI;

        // cZera.zerarPorFator (IXFAT_DISSIDIO_PAGTO, AUSENTE, true);
     SEFIM
  SEFIM




  //--------------------------------------------------------------------------------
  // Chamada em: STARTUP_PERIODO/TOTAL Parm:("PERÍODO" ou "TOTAL", PP)
  SE   ( getDadoFolhaStr(TFTipo) IGUAL "RPM"                 OU
         getDadoFolhaStr(TFTipo) IGUAL "RPM NEGATIVOS"       OU
         getDadoFolhaStr(TFTipo) IGUAL "RPM COMPL PODERES"   OU  // Thiago Góz - 11/07/2012 - Retroativos
         getDadoFolhaStr(TFTipo) IGUAL "Dissídio Apura RPM"      // Thiago Góz - 14/09/2012 - Dissídio Pré-Mensal
         )
     E PF.AnoMesDir > 200602
     ENTAO
     gravaDbg("|STARTUP_%s| FOLHA: RPM/RPM NEGATIVOS - zerarRubricaHV | PF.AnoMesDir:%d | PF.AnoMesPri:%d",strSTARTUP.c_str(),PF.AnoMesDir,PF.AnoMesPri);
     SE  strSTARTUP IGUAL "PERÍODO" ENTAO
        RR = 1;
        CADA_ENQUANTO (RR,RR < ULTIMO_RR - 1)
          SE  RUBRICA IGUAL 178 // Etapas de Alimentação
             ENTAO
             cZera.zeraCelula(RR,"RATIFICA",true); // manter Lan.Man. & já Processado
          SEFIM
        CADAFIM
        RR = ZEROI;
     SENAO_SE strSTARTUP IGUAL "TOTAL" ENTAO
        RR = 1;
        CADA_ENQUANTO (RR,RR < ULTIMO_RR - 1)
          SE  RUBRICA IGUAL 178 // Etapas de Alimentação
             ENTAO
             cZera.zeraCelula(RR,"RATIFICA",true); // manter Lan.Man. & já Processado
          SEFIM
        CADAFIM
        RR = ZEROI;
     SENAO_SE strSTARTUP IGUAL "LÍQUIDO" ENTAO

     SEFIM
  SEFIM

  //--------------------------------------------------------------------------------
  // Chamada em: STARTUP_PERIODO/TOTAL Parm:("PERÍODO" ou "TOTAL", PP)

  // Thiago Góz - Adequação do SuperTipo - 16/04/2012
  /*SE getDadoFolhaStr(TFTipo) IGUAL "13o. PARCELADO" // Chamada em: STARTUP_PERIODO Parm:("PERÍODO", PP)
     ENTAO
     gravaDbg("|STARTUP_%s| FOLHA: 13o.Parcelado - zerarRubricaHV | PF.AnoMesDir:%d | PF.AnoMesPri:%d",strSTARTUP.c_str(),PF.AnoMesDir,PF.AnoMesPri);
     SE  strSTARTUP IGUAL "PERÍODO" ENTAO
        RR = 1;
        CADA_ENQUANTO (RR,RR < ULTIMO_RR - 1)
          SE  RUBRICA IGUAL 299 OU                           // Correção monetária 13º Venc. Parcelado - temp
              fatPACons.sinalFatorRubrica ("", RUBRICA) == 1 // CONSIGNATÁRIA
             ENTAO
             // RUBRICAS a calcular cfme regras de negócio definadas pelo Cliente
          SENAO
            //// cZera.zerarRubrica(RR);
            rVC  = 0.0;   // tabela hv - valor principal
            rVCC = 0.0;   // tabela hv - correção monetária
          SEFIM
        CADAFIM
        RR = ZEROI;
     SENAO_SE strSTARTUP IGUAL "TOTAL" ENTAO
        RR = 1;
        CADA_ENQUANTO (RR,RR < ULTIMO_RR - 1)
          SE  RUBRICA IGUAL 299 OU RUBRICA IGUAL 997 OU RUBRICA IGUAL 998 OU  RUBRICA IGUAL 999 OU // Correção monetária 13º Venc. Parcelado - temp
              fatPACons.sinalFatorRubrica ("", RUBRICA) == 1 // CONSIGNATÁRIA
             ENTAO
             // RUBRICAS a calcular cfme regras de negócio definadas pelo Cliente
          SENAO
              //--- rubricas calculadas (hv)
              rVC  = rVP;    // tabela hv - valor principal
              rVCC = rVCP;   // tabela hv - correção monetária

              //-- Zera diferença de MOVIMENTOS manuais (mv --> tabela bd: fol-movimentos)
              //-- menos da competência de dezembro de 2005 ou anteriores
              if (PF.AnoMesDir > 200512){
                 rMC  = rMP;
                 rMCC = rMCP;
              }
              //--- zera diferença de valores parcelados (pc --> tabela bd: fichas-parcelas) ---
              rPC  = rPP;
              rPCC = rPCP;

          SEFIM
        CADAFIM
        RR = ZEROI;
     SENAO_SE strSTARTUP IGUAL "LÍQUIDO" ENTAO
          RR = 1;
        CADA_ENQUANTO (RR,RR < ULTIMO_RR - 1)
          SE  RUBRICA IGUAL 299  // Correção monetária 13º Venc. Parcelado - temp
              OU RUBRICA IGUAL 997 OU RUBRICA IGUAL 998 OU  RUBRICA IGUAL 999   ENTAO
             // RUBRICAS a calcular cfme regras de negócio definadas pelo Cliente
          SENAO
            SE flrubrcalc[rrubr[RR]] DIFERENTE ZERO ENTAO
              // Eliminar somente as demais rubricas que possuem cálculo em tempo de líquido
              rVC  = 0.00;    // tabela hv - valor principal
              rVCC = 0.00;    // tabela hv - correção monetária
            SEFIM
          SEFIM
        CADAFIM
        RR = ZEROI;
     SEFIM
  SEFIM */

  //--------------------------------------------------------------------------------
  // Chamada em: STARTUP_PERIODO/TOTAL Parm:("PERÍODO" ou "TOTAL", PP)
  SE getDadoFolhaStr(TFTipo) IGUAL "VALE REFEIÇÃO" // Chamada em: STARTUP_PERIODO Parm:("PERÍODO", PP)
     ENTAO
     gravaDbg("|STARTUP_%s| Foha:VALE REFEIÇÃO - zerarRubricaHV *** PF.AnoMesDir:%d | PF.AnoMesPri:%d",strSTARTUP.c_str(), PF.AnoMesDir , PF.AnoMesPri);

     SE PF.AnoMesDir < PF.AnoMesPri ENTAO // Paga-se somente ETAPAS DE ALIMENTAÇÃO
       SE strSTARTUP IGUAL "PERÍODO" ENTAO
          RR = 1;
          CADA_ENQUANTO (RR,RR < ULTIMO_RR - 1)
            SE RUBRICA IGUAL 178 // Etapas de Alimentação
              ENTAO
              // RUBRICAS a calcular cfme regras de negócio definadas pelo Cliente
            SENAO
              cZera.zeraCelula(RR,"RATIFICA",true); // manter laçamentos manuais - comandados
            SEFIM
          CADAFIM
          RR = ZEROI;
       SENAO_SE strSTARTUP IGUAL "TOTAL" ENTAO
          RR = 1;
          CADA_ENQUANTO (RR,RR < ULTIMO_RR - 1)
            SE RUBRICA IGUAL 178 // Etapas de Alimentação
              ENTAO
              // RUBRICAS a calcular cfme regras de negócio definadas pelo Cliente
            SENAO
              cZera.zeraCelula(RR,"RATIFICA",true); // manter laçamentos manuais - comandados
            SEFIM
          CADAFIM
          RR = ZEROI;
       SENAO_SE strSTARTUP IGUAL "LÍQUIDO" ENTAO
          RR = 1;
          CADA_ENQUANTO (RR,RR < ULTIMO_RR - 1)
            SE RUBRICA IGUAL 178 // Etapas de Alimentação
              ENTAO
              // RUBRICAS a calcular cfme regras de negócio definadas pelo Cliente
            SENAO
              SE flrubrcalc[rrubr[ixrubr]] != 0 // É rubrica de líquido
                ENTAO
                //gravaDbg("|zeraRubricasHV| Rubrica:%d | rrubr[ixrubr]:%d | flrubrcalc[rrubr[ixrubr]]:%d ", RR, rrubr[ixrubr], flrubrcalc[rrubr[ixrubr]]);
                cZera.zeraCelula(RR,"RATIFICA",true); // manter laçamentos manuais - comandados
              SEFIM
            SEFIM
          CADAFIM
          RR = ZEROI;
       SEFIM

     SENAO  // Paga-se somente VALE REFEIÇÂO

       SE strSTARTUP IGUAL "PERÍODO" ENTAO
          RR = 1;
          CADA_ENQUANTO (RR,RR < ULTIMO_RR - 1)
            SE RUBRICA IGUAL 174 OU // Vale-refeição
               RUBRICA IGUAL 801    // Auxiliar Qte de VR a pagar
              ENTAO
              // RUBRICAS a calcular cfme regras de negócio definadas pelo Cliente
            SENAO
              cZera.zeraCelula(RR,"RATIFICA",true); // manter laçamentos manuais - comandados
            SEFIM
          CADAFIM
          RR = ZEROI;
       SENAO_SE strSTARTUP IGUAL "TOTAL" ENTAO
          RR = 1;
          CADA_ENQUANTO (RR,RR < ULTIMO_RR - 1)
            SE RUBRICA IGUAL 174 OU // Vale-refeição
               RUBRICA IGUAL 801    // Auxiliar Qte de VR a pagar
              ENTAO
              // RUBRICAS a calcular cfme regras de negócio definadas pelo Cliente
            SENAO
              cZera.zeraCelula(RR,"RATIFICA",true); // manter laçamentos manuais - comandados
            SEFIM
          CADAFIM
          RR = ZEROI;
       SENAO_SE strSTARTUP IGUAL "LÍQUIDO" ENTAO

          RR = 1;
          CADA_ENQUANTO (RR,RR < ULTIMO_RR - 1)
            SE RUBRICA IGUAL 174 OU // Vale-refeição
               RUBRICA IGUAL 801 OU // Auxiliar Qte de VR a pagar
               RUBRICA IGUAL 997 OU // Total de Vantagens
               RUBRICA IGUAL 998 OU // Total de Descontos
               RUBRICA IGUAL 999    // Liquído
              ENTAO
              // RUBRICAS a calcular cfme regras de negócio definadas pelo Cliente
            SENAO
              SE flrubrcalc[rrubr[ixrubr]] != 0 // É rubrica de líquido
                ENTAO
                //gravaDbg("|zeraRubricasHV| Rubrica:%d | rrubr[ixrubr]:%d | flrubrcalc[rrubr[ixrubr]]:%d ", RR, rrubr[ixrubr], flrubrcalc[rrubr[ixrubr]]);
                cZera.zeraCelula(RR,"RATIFICA",true); // manter laçamentos manuais - comandados
              SEFIM
            SEFIM
          CADAFIM
          RR = ZEROI;

       SEFIM
     SEFIM
  SEFIM

  //--------------------------------------------------------------------------------
  // Chamada em: STARTUP_PERIODO/TOTAL Parm:("PERÍODO" ou "TOTAL", PP)
 SE strcmp(PF.FinalidadeCalculo, "RETROATIVOS-PODERES")   ==0  OU       // getDadoFolhaStr(TFTipo) IGUAL "RETROATIVOS-PODERES"
	  strcmp(PF.FinalidadeCalculo, "FALECIDOS HABILITADO")  ==0           // getDadoFolhaStr(TFTipo) IGUAL "FALECIDOS HABILITADO"  // Chamada em: STARTUP_... Parm:("...", PP)
 ENTAO
     gravaDbg("|STARTUP_%s| FOLHA: RETROATIVOS-PODERES - zerarRubricaHV | PF.AnoMesDir:%d | PF.AnoMesPri:%d",strSTARTUP.c_str(),PF.AnoMesDir,PF.AnoMesPri);
     SE  strSTARTUP IGUAL "PERÍODO" OU
         strSTARTUP IGUAL "TOTAL"   ENTAO
        RR = 1;
        CADA_ENQUANTO (RR,RR < ULTIMO_RR - 1)
          //gravaDbg("|RETROATIVOS-PODERES| strSTARTUP:%s | RUBRICA:%0.4d | myfatvantru:%d ", strSTARTUP.c_str(), RUBRICA, myfatvantru[rrubr[RR]] );
          SE (RUBRICA >= 1123 E RUBRICA <= 1132 ) // Rubricas de URV
             // OU myfatvantru[rrubr[RR]] IGUAL ZERO   // Auxiliares   // Este myfatvant indica se a rubrica é de:
             // OU myfatvantru[rrubr[RR]] IGUAL -1     // Descontos    // Vantagens (1), Desconto (-1) ou Auxiliar (0)
             OU RUBRICA IGUAL  402  // IPE
             OU RUBRICA IGUAL  411  // INSS
             OU RUBRICA IGUAL  422  // IR
             OU RUBRICA IGUAL  430  // PA
             OU RUBRICA IGUAL  850  // CCD - Pensão Alimentícia
             OU RUBRICA IGUAL  1173 // Habilitado Post-Mortem
             OU RUBRICA IGUAL  1174 // Habilitado Post-Mortem
             OU RUBRICA IGUAL  1175 // Depósito Judicial
             OU RUBRICA IGUAL  1474 // Habilitado Post-Mortem
             //OU RUBRICA IGUAL  902  // Base IPE
             //OU RUBRICA IGUAL  911  // Base INSS
             //OU RUBRICA IGUAL  920  // Base Mensal IR
             ENTAO
             // RUBRICAS a calcular cfme regras de negócio definadas pelo Cliente
             //gravaDbg("|RETROATIVOS-PODERES| RUBRICA:%0.4d - a Calcular", RUBRICA);
          SENAO
             cZera.zeraCelula(RR,"DESFAZ",false); // Não zerar laçamentos manuais - comandados
          SEFIM
        CADAFIM
        RR = ZEROI;
     SENAO_SE strSTARTUP IGUAL "LÍQUIDO" ENTAO
        RR = 1;
        CADA_ENQUANTO (RR,RR < ULTIMO_RR - 1)
          //gravaDbg("|RETROATIVOS-PODERES| strSTARTUP:%s | RUBRICA:%0.4d | flrubrcalc:%d ", strSTARTUP.c_str(), RUBRICA, flrubrcalc[rrubr[RR]] );
          SE flrubrcalc[rrubr[RR]] DIFERENTE ZERO ENTAO
             SE //RUBRICA IGUAL  421    // IR      (Bruno solicitou que não seja Calculado 4/1/11 às 16:15 (via telefone)
                //RUBRICA IGUAL  921 OU // Base IR (Bruno solicitou que não seja Calculado 4/1/11 às 16:15 (via telefone)
                RUBRICA IGUAL  1473 OU // Estorno Post-Morten (para gerar crédito extra-orçamentário)
                RUBRICA IGUAL   987 OU RUBRICA IGUAL 988 OU RUBRICA IGUAL 989 OU    //  Vantagens / Descontos / Líquido - DEPENDENTES
                RUBRICA IGUAL   997 OU RUBRICA IGUAL 998 OU RUBRICA IGUAL 999 ENTAO //  Vantagens / Descontos / Líquido
                // RUBRICAS a calcular cfme regras de negócio definadas pelo Cliente
                //gravaDbg("|RETROATIVOS-PODERES| RUBRICA:%0.4d - a Calcular", RUBRICA);
             SENAO
               // Eliminar somente as demais rubricas (exceto as acima Vant/Desc/Líq) que possuem cálculo em tempo de líquido
               rVC  = 0.00;    // tabela hv - valor principal
               rVCC = 0.00;    // tabela hv - correção monetária
               //gravaDbg("|RETROATIVOS-PODERES| RUBRICA:%0.4d - atribuido ZERO na célula da HV", RUBRICA);
             SEFIM
          SEFIM
        CADAFIM
        RR = ZEROI;
     SEFIM
  SEFIM

  SE strcmp(PF.FinalidadeCalculo, "HABILITADOS") ==0  // getDadoFolhaStr(TFTipo) IGUAL "HABILITADOS"              // Chamada em: STARTUP_... Parm:("...", PP)
     ENTAO
     gravaDbg("|STARTUP_%s| FOLHA: RETROATIVOS-PODERES - zerarRubricaHV | PF.AnoMesDir:%d | PF.AnoMesPri:%d",strSTARTUP.c_str(),PF.AnoMesDir,PF.AnoMesPri);
     SE  strSTARTUP IGUAL "PERÍODO" OU
         strSTARTUP IGUAL "TOTAL"   ENTAO
        RR = 1;
        CADA_ENQUANTO (RR,RR < ULTIMO_RR - 1)
          //gravaDbg("|RETROATIVOS-PODERES| strSTARTUP:%s | RUBRICA:%0.4d | myfatvantru:%d ", strSTARTUP.c_str(), RUBRICA, myfatvantru[rrubr[RR]] );
          SE (RUBRICA >= 1023 E RUBRICA <= 1032 ) // Rubricas de URV
             // OU myfatvantru[rrubr[RR]] IGUAL ZERO   // Auxiliares   // Este myfatvant indica se a rubrica é de:
             // OU myfatvantru[rrubr[RR]] IGUAL -1     // Descontos    // Vantagens (1), Desconto (-1) ou Auxiliar (0)
             OU RUBRICA IGUAL  422  // Imposto sobre Renda
             OU RUBRICA IGUAL  421  // Imposto sobre Renda
             OU RUBRICA IGUAL  1173 // Habilitado Post-Mortem
             OU RUBRICA IGUAL  1175 // Depósito Judicial
             OU RUBRICA IGUAL  823  // Imposto de Renda 13o - mensal
             OU RUBRICA IGUAL  824  // Auxiliar Mensal de Base de Imposto sobre Renda
             OU RUBRICA IGUAL  920  // Base Mensal IR
             OU RUBRICA IGUAL  1920 // Base Mensal IR
             OU RUBRICA IGUAL  1941 // DIRF RENDA    - RRA
             OU RUBRICA IGUAL  1942 // DIRF DED PREV - RRA
             OU RUBRICA IGUAL  1943 // DIRF DED PA   - RRA
             ENTAO
             // RUBRICAS a calcular cfme regras de negócio definadas pelo Cliente
             //gravaDbg("|RETROATIVOS-PODERES| RUBRICA:%0.4d - a Calcular", RUBRICA);
          SENAO
             cZera.zeraCelula(RR,"DESFAZ",false); // Não zerar laçamentos manuais - comandados
          SEFIM
        CADAFIM
        RR = ZEROI;
     SENAO_SE strSTARTUP IGUAL "LÍQUIDO" ENTAO
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
                RUBRICA IGUAL   987 OU RUBRICA IGUAL 988 OU RUBRICA IGUAL 989 OU    //  Vantagens / Descontos / Líquido - DEPENDENTES
                RUBRICA IGUAL   997 OU RUBRICA IGUAL 998 OU RUBRICA IGUAL 999 ENTAO //  Vantagens / Descontos / Líquido
                // RUBRICAS a calcular cfme regras de negócio definadas pelo Cliente
                //gravaDbg("|RETROATIVOS-PODERES| RUBRICA:%0.4d - a Calcular", RUBRICA);
             SENAO
               // Eliminar somente as demais rubricas (exceto as acima Vant/Desc/Líq) que possuem cálculo em tempo de líquido
               rVC  = 0.00;    // tabela hv - valor principal
               rVCC = 0.00;    // tabela hv - correção monetária
               //gravaDbg("|RETROATIVOS-PODERES| RUBRICA:%0.4d - atribuido ZERO na célula da HV", RUBRICA);
             SEFIM
          SEFIM
        CADAFIM
        RR = ZEROI;
     SEFIM
  SEFIM

  //----------------------------------------------------------------------------------------------------------------------
  // Thiago Góz - 04/08/2016 - #124574
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
  // Thiago Góz - 29/08/2016
  //----------------------------------------------------------------------------------------------------------------------

  SE (getDadoFolhaStr(TFTipo) IGUAL "SIMULACAO") ENTAO
     gravaDbg("|STARTUP_%s| FOLHA: SIMULAÇÃO - zerarRubricaHV | PF.AnoMesDir:%d | PF.AnoMesPri:%d",strSTARTUP.c_str(),PF.AnoMesDir,PF.AnoMesPri);
     RR = 1;
     CADA_ENQUANTO (RR,RR < ULTIMO_RR - 1)
       SE rubricaPresenteNoFator (RUBRICA,IXFAT_FOLHA_LIMPA) ENTAO
         cZera.zeraCelula(RR,"RATIFICA",true);
       SEFIM
     CADAFIM
     RR = ZEROI;
  SEFIM

}