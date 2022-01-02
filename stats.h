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

#pragma once

#include "game.h"
#include "matrix.h"

#include <vector>

//WARNING: all percentages are given as values in range 0.0-1.0, NOT values in range 0-100! So 1.0 means 100%.

struct Stats
{

  std::vector<Player> allPlayers;

  double *ptrhist;
  double *ptrstandings;
  double *ptrdeals;

  mxArray *hist;
  mxArray *standings;
  mxArray *deals;

  Stats(int, double*, mwSize, std::vector<Player>);

};
