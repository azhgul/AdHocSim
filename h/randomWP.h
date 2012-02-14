//
#ifndef MOBILITY_H
#define MOBILITY_H

#include "omnetpp.h"
#include "costants.h"

#include "physic.h"

class RandomWP : public cSimpleModule
{

	//Macro that contains the costructor,destructor
	//and other Omnett++ stuff
	Module_Class_Members(RandomWP,cSimpleModule,0)

	virtual void initialize();
	virtual void handleMessage(cMessage* );
	virtual void finish();
	//
	
   private:
	//returns the time intervall
	//to the next move
	double randomWaypoint(int&, int&);

	//quoantum of time between to moves
	//e.g. 1s if the speed is in m/sec
	cPar* moveInterval;
	cPar* pauseTime;
	cPar* moveKind;
	
	cPar* maxSpeed;
	cPar* minSpeed;

	//pointer of the physic module wich
	//store the actual <x,y> position
	Physic* physic;

	//size of the movement field
	int minX,maxX,minY,maxY;

	//direction flag
	int dX, dY;
	//number of steps to reach
	//the destination
	int steps;

	//statistics vars
	int stepsNum;
	double partial;
};
	
#endif	
