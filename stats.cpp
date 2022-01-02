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

#include "player.h"
#include "stats.h"

#include <vector>

Stats::Stats(int nPlayers, double* ptrhistoric, mwSize elements, std::vector<Player> players)
{
  int dims[3] = {6,4,nPlayers};
  hist = mxCreateNumericArray(3, dims, mxDOUBLE_CLASS, mxREAL);
  ptrhist = mxGetPr(hist);
  for (mwSize i = 0; i < elements; i++)
  {
      ptrhist[i] = ptrhistoric[i];
  }
  standings = mxCreateDoubleMatrix(1, nPlayers, mxREAL);
  ptrstandings = mxGetPr(standings);
  deals = mxCreateDoubleMatrix(1, 1, mxREAL);
  ptrdeals = mxGetPr(deals);

  allPlayers = players;

}
