set(0,'DefaultFigureWindowStyle','docked')
close all;
clear variables GLOBALS;
QTGlobals

Blocks = {};
nBlocks = 0;

LEFT = 1;
LEFT_DOWN = 1;
LEFT_UP = 2;
LEFT_MIN = 2;

UP = 3;
UP_LEFT = 3;
UP_RIGHT = 4;
UP_MIN = 4;

RIGHT_UP = 5;
RIGHT = 5;
RIGHT_DOWN = 6;
RIGHT_MIN = 6;

DOWN_RIGHT= 7;
DOWN = 7;
DOWN_LEFT = 8;
DOWN_MIN = 8;

MAX_NUM_BR = 8;