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

/*
Linux compile command:
g++ *.cpp -W -Wall -Wextra -ansi -O3
g++ *.cpp -W -Wall -Wextra -ansi -g3
*/


/*
OOPoker, or "Object Oriented Poker", is a C++ No-Limit Texas Hold'm engine meant
to be used to implement poker AIs for entertainment  or research purposes. These
AIs can be made to battle each other, or a single human can play against the AIs
for his/her enjoyment.
*/

//In all functions below, when cards are sorted, it's always from high to low

#include <vector>
#include <string>
#include <algorithm>
#include <iostream>

#include "ai.h"
#include "ai_blindlimp.h"
#include "ai_call.h"
#include "ai_checkfold.h"
#include "ai_human.h"
#include "ai_my_bot.h"
#include "ai_raise.h"
#include "ai_random.h"
#include "ai_smart.h"
#include "card.h"
#include "combination.h"
#include "game.h"
#include "host_terminal.h"
#include "info.h"
#include "io_terminal.h"
#include "observer.h"
#include "observer_terminal.h"
#include "observer_terminal_quiet.h"
#include "observer_log.h"
#include "pokermath.h"
#include "random.h"
#include "stats.h"
#include "table.h"
#include "tools_terminal.h"
#include "unittest.h"
#include "util.h"


void mexFunction(int nlhs, mxArray *plhs[],
                int nrhs, const mxArray *prhs[])
{

  int bS;
  double *ptrPlayers;
  double *ptrhistoric;
  double *ptrtightness;
  size_t nPlayers;
  char *str;
  mwSize index;
  mwSize elements = mxGetNumberOfElements(prhs[0]);

  ptrhistoric = mxGetPr(prhs[0]);
  bS = (int)mxGetScalar(prhs[1]);
  ptrPlayers = mxGetPr(prhs[2]);
  nPlayers = mxGetN(prhs[2]);
  ptrtightness = mxGetPr(prhs[3]);
  str = mxArrayToString(prhs[4]);

  /*
  char c = 0;

  std::cout << "Choose Game Type\n\
1: human + AI's\n\
2: human + AI heads-up\n\
3: AI battle\n\
4: AI battle heads-up\n\
r: random game (human)\n\
c: calculator\n\
u: unit test" << std::endl;
  c = getChar();
  int gameType = 1;
  if(c == '1') gameType = 1;
  else if(c == '2') gameType = 2;
  else if(c == '3') gameType = 3;
  else if(c == '4') gameType = 4;
  else if(c == 'r') gameType = 5;
  else if(c == 'c')
  {

    std::cout << "Choose Calculator\n\
1: Pot Equity\n\
2: Showdown" << std::endl;

    char c2 = getChar();
    if(c2 == '1') runConsolePotEquityCalculator();
    else runConsoleShowdownCalculator();
    return;
  }
  else if(c == 'u')
  {
    doUnitTest();
    return;
  }
  else if(c == 'q') return;
  */

  Rules rules;
  rules.buyIn = 1000;
  rules.bigBlind = 10;
  rules.ante = 0;
  rules.allowRebuy = false;
  rules.fixedNumberOfDeals = 0;

  HostTerminal host;
  Game game(&host);

  if(bS == 1)      {rules.buyIn = 1000; rules.smallBlind = 5; rules.bigBlind = 10; rules.ante = 0; }
  else if(bS == 2) {rules.buyIn = 1000; rules.smallBlind = 10; rules.bigBlind = 20; rules.ante = 0; }
  else if(bS == 3) {rules.buyIn = 1000; rules.smallBlind = 50; rules.bigBlind = 100; rules.ante = 0; }
  else if(bS == 4) {rules.buyIn = 1000; rules.smallBlind = 100; rules.bigBlind = 200; rules.ante = 0; }
  else if(bS == 5) {rules.buyIn = 100000; rules.smallBlind = 5; rules.bigBlind = 10; rules.ante = 0; }
  else if(bS == 6) {rules.buyIn = 100000; rules.smallBlind = 10; rules.bigBlind = 20; rules.ante = 0; }
  else if(bS == 7) {rules.buyIn = 100000; rules.smallBlind = 50; rules.bigBlind = 100; rules.ante = 0; }
  else if(bS == 8) {rules.buyIn = 100000; rules.smallBlind = 100; rules.bigBlind = 200; rules.ante = 0; }

  game.setRules(rules);

  std::vector<Event> events;

  std::vector<Player> players;
  std::vector<Observer*> observers;

  if (strlen(str) != 1)
  {
    game.addObserver(new ObserverLog(str));
  }

  for (size_t i=0; i < nPlayers; i++)
  {
    if((int)ptrPlayers[i] == 1)        {game.addPlayer(Player(new AISmart(ptrtightness[i]), getRandomName()));}
    else if((int)ptrPlayers[i] == 2)   {game.addPlayer(Player(new AIRandom(), getRandomName())); }
    else if((int)ptrPlayers[i] == 3)   {game.addPlayer(Player(new AICheckFold(), getRandomName())); }
    else if((int)ptrPlayers[i] == 4)   {game.addPlayer(Player(new AICall(), getRandomName())); }
    else if((int)ptrPlayers[i] == 5)   {game.addPlayer(Player(new AIBlindLimp(), getRandomName())); }
    else if((int)ptrPlayers[i] == 6)   {game.addPlayer(Player(new AIRaise(), getRandomName())); }
    else if((int)ptrPlayers[i] == 7)   {game.addPlayer(Player(new AIHuman(&host, (int)nPlayers), getRandomName())); }
    else if((int)ptrPlayers[i] == 11)  {game.addPlayer(Player(new AIMyBot(1, (int)nPlayers), getRandomName())); }
    else if((int)ptrPlayers[i] == 21)  {game.addPlayer(Player(new AIMyBot(2, (int)nPlayers), getRandomName())); }
    else if((int)ptrPlayers[i] == 31)  {game.addPlayer(Player(new AIMyBot(3, (int)nPlayers), getRandomName())); }
    else if((int)ptrPlayers[i] == 41)  {game.addPlayer(Player(new AIMyBot(4, (int)nPlayers), getRandomName())); }
    else if((int)ptrPlayers[i] == 51)  {game.addPlayer(Player(new AIMyBot(5, (int)nPlayers), getRandomName())); }
    else if((int)ptrPlayers[i] == 61)  {game.addPlayer(Player(new AIMyBot(6, (int)nPlayers), getRandomName())); }
    else if((int)ptrPlayers[i] == 71)  {game.addPlayer(Player(new AIMyBot(7, (int)nPlayers), getRandomName())); }
    else if((int)ptrPlayers[i] == 81)  {game.addPlayer(Player(new AIMyBot(8, (int)nPlayers), getRandomName())); }
    else if((int)ptrPlayers[i] == 91)  {game.addPlayer(Player(new AIMyBot(9, (int)nPlayers), getRandomName())); }
    else if((int)ptrPlayers[i] == 101) {game.addPlayer(Player(new AIMyBot(10, (int)nPlayers), getRandomName())); }
  }

  Stats stats(nPlayers, ptrhistoric, elements, players);

  game.doGame(stats);

  plhs[0] = stats.standings;
  plhs[1] = stats.hist;
  plhs[2] = stats.deals;

}
