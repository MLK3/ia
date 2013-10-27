% Definitions

P.W = 0; % Wall
P.E = 1;  %empty space
P.D = 2;  %door (not used)
P.Df = 3; %far door
P.Sc = 4; %see corridor
P.Sr = 5; %see room
P.R = 6; %room
P.C = 7; %corridor 

ACTION.N = 1;
ACTION.S = 2;
ACTION.E = 3;
ACTION.W = 4;

%Abstract States
%Oposite to Goal
%Empty 1
%Far Door 2
%See Room 4
%See Corridor 8

%Head to Goal
%Empty 16
%Far Door 32
%See Room 64
%See Corridor 128

%In Room 256

%Near to Goal 512
