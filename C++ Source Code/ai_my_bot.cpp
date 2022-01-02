/*
OOPoker

Copyright (c) 2010 Lode Vandevenne
All rights reserved.

This file is part of OOPoker.

OOPoker is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

OOPoker is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with OOPoker.  If not, see <http://www.gnu.org/licenses/>.
*/


#include "ai_my_bot.h"
#include "event.h"
#include "info.h"
#include "matrix.h"
#include "mex.h"
#include "random.h"
#include "player.h"

#include <vector>
#include <iostream>
#include <string>
#include <sstream>

AIMyBot::AIMyBot(int ident, int numPlayers)
{
  ID = ident;
  cartas = mxCreateDoubleMatrix(1, 7, mxREAL);
  dados = mxCreateDoubleMatrix(1, 12, mxREAL);
  estado = mxCreateDoubleMatrix(4, numPlayers, mxREAL);
  ptrcartas = mxGetPr(cartas);
  ptrdados = mxGetPr(dados);
  ptrestado = mxGetPr(estado);
}

Action AIMyBot::doTurn(const Info& info, const Stats& stats)
{
  std::vector<Player> allPlayers = stats.allPlayers;

  int situacao;
  int amount;
  int newIndexDealer;
  int newYourIndex;

  if(info.round == R_PRE_FLOP)
  {
    situacao = 1;
    ptrcartas[2] = -1;
    ptrcartas[3] = -1;
    ptrcartas[4] = -1;
    ptrcartas[5] = -1;
    ptrcartas[6] = -1;
    Card holeCard1 = info.getHoleCards()[0];
    Card holeCard2 = info.getHoleCards()[1];
    ptrcartas[0] = holeCard1.getIndex();
    ptrcartas[1] = holeCard2.getIndex();
  }
  else if(info.round == R_FLOP)
  {
    situacao = 2;
    Card boardCard1 = info.boardCards[0];
    Card boardCard2 = info.boardCards[1];
    Card boardCard3 = info.boardCards[2];
    ptrcartas[2] = boardCard1.getIndex();
    ptrcartas[3] = boardCard2.getIndex();
    ptrcartas[4] = boardCard3.getIndex();
  }
  else if(info.round == R_TURN)
  {
    situacao = 3;
    Card boardCard4 = info.boardCards[3];
    ptrcartas[5] = boardCard4.getIndex();
  }
  else if(info.round == R_RIVER)
  {
    situacao = 4;
    Card boardCard5 = info.boardCards[4];
    ptrcartas[6] = boardCard5.getIndex();
  }

  //estado dos oponentes
  for (int i=0; i<info.getNumPlayers(); i++)
  {
    for(int j=0; j<allPlayers.size(); j++)
    {
      if(allPlayers[j].name == info.players[i].name)
      {
        if(info.getPosition(i) == 0) {newIndexDealer = j;}
        if(info.getPosition(i) == info.getPosition()) {newYourIndex = j;}
        ptrestado[j*4] = info.getPosition(i)+1;
        ptrestado[j*4+1] = info.getStack(i);
        ptrestado[j*4+2] = info.getWager(i);
        ptrestado[j*4+3] = info.players[i].isFolded();
      }
    }
  }

  ptrdados[0] = info.getBigBlind();
  ptrdados[1] = info.getStack();
  ptrdados[2] = info.getPosition() + 1;
  ptrdados[3] = newIndexDealer + 1;
  ptrdados[4] = newYourIndex + 1;
  ptrdados[5] = situacao;
  ptrdados[6] = info.getPot();
  ptrdados[7] = info.getWager();
  ptrdados[8] = info.getCallAmount();
  ptrdados[9] = info.getMinChipsToRaise();
  ptrdados[10] = info.getNumActivePlayers();
  ptrdados[11] = info.getNumDecidingPlayers();

  mae[0] = cartas;
  mae[1] = dados;
  mae[2] = estado;
  mae[3] = stats.hist;

  switch (ID)
  {
    case 1:
        mexCallMATLAB(1,p,4,mae,"AI1");
        break;

    case 2:
        mexCallMATLAB(1,p,4,mae,"AI2");
        break;

    case 3:
        mexCallMATLAB(1,p,4,mae,"AI3");
        break;

    case 4:
        mexCallMATLAB(1,p,4,mae,"AI4");
        break;

    case 5:
        mexCallMATLAB(1,p,4,mae,"AI5");
        break;

    case 6:
        mexCallMATLAB(1,p,4,mae,"AI6");
        break;

    case 7:
        mexCallMATLAB(1,p,4,mae,"AI7");
        break;

    case 8:
        mexCallMATLAB(1,p,4,mae,"AI8");
        break;

    case 9:
        mexCallMATLAB(1,p,4,mae,"AI9");
        break;

    case 10:
        mexCallMATLAB(1,p,4,mae,"AI10");
        break;
  }

  for(int j=0; j<allPlayers.size(); j++)
  {
    ptrestado[j*4] = 0;
    ptrestado[j*4+1] = 0;
    ptrestado[j*4+2] = 0;
    ptrestado[j*4+3] = 0;
  }

  /*
  switch((int)mxGetScalar(p[0]))
  {
    case 0:
        return info.getCheckFoldAction();
        break;

    case 1:
        return info.getCallAction();
        break;

    case 2:
        return info.amountToAction((int)mxGetScalar(p[1]));
        break;

    case 3:
        return info.getAllInAction();
        break;
  }
  */

  amount = (int)mxGetScalar(p[0]);

  return info.amountToAction(amount);
}


std::string AIMyBot::getAIName()
{
  switch (ID)
  {
    case 1:
        return "AIMyBot1";
        break;

    case 2:
        return "AIMyBot2";
        break;

    case 3:
        return "AIMyBot3";
        break;

    case 4:
        return "AIMyBot4";
        break;

    case 5:
        return "AIMyBot5";
        break;

    case 6:
        return "AIMyBot6";
        break;

    case 7:
        return "AIMyBot7";
        break;

    case 8:
        return "AIMyBot8";
        break;

    case 9:
        return "AIMyBot9";
        break;

    case 10:
        return "AIMyBot10";
        break;
  }
  return "AIMyBot";
}
