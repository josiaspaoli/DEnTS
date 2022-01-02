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

#include "ai.h"
#include "matrix.h"
#include "mex.h"


#include <vector>

class AIMyBot : public AI
{

  public:

    int ID;

    double *ptrcartas;
    double *ptrdados;
    double *ptrestado;

    mxArray *mae[4];
    mxArray *cartas;
    mxArray *dados;
    mxArray *estado;

    mxArray *p[1];

    AIMyBot(int, int);

    virtual Action doTurn(const Info& info, const Stats& stats);

    virtual std::string getAIName();

};

