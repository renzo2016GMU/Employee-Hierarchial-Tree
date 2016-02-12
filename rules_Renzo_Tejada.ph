early_empinfo(X,Y,Z) :-empinfo(X,Y,Z), y<1995.
year(Y):- empinfo(_,Y,_).
year(Y,Z):- empinfo(_,Y,Z).
empinfo_aux(W,X,Y,Z) :- empinfo(W,X,Y), manages(Y,Z).

above(Id,Id2) :- empinfo(Id2,_,Yunit2),manages(Yunit2,ManId2),ManId2=Id,Id2\=ManId2;			
				 empinfo(Id2,_,Yunit2),manages(Yunit2,ManId2),Id2\=ManId2,above(Id,ManId2).			  

above(First1,Last1,First2,Last2) :- emp_name(Id,First1,Last1),emp_name(Id2,First2,Last2),above(Id,Id2).

samelastname(Id,Id2) :- integer(Id),integer(Id2),emp_name(Id,_,Last),emp_name(Id2,_,Last);
						emp_name(_,Id,Z),emp_name(_,Id2,Z).
						
notretired(Id) :- not(retired(Id,_)).
/* Did these two people work the same year?*/

overlap(X,Y) :-notretired(X),notretired(Y);
			retired(X,RetiredYear),empinfo(Y,Ystartyear,_),RetiredYear>Ystartyear;
			retired(Y,RetiredYear2),empinfo(X,Xstartyear,_),RetiredYear2>Xstartyear;
			emp_name(ID,X,_),emp_name(ID2,Y,_),overlap(ID,ID2);
			retired(Y,RetiredYear2),empinfo(X,Xstartyear,_),RetiredYear2=Xstartyear;
			retired(X,RetiredYear2),empinfo(Y,Xstartyear,_),RetiredYear2=Xstartyear.

overlap(First,Last,First2,Last2)
			:- emp_name(Id,First,Last),emp_name(Id2,First2,Last2),overlap(Id,Id2).


worktogether(Id,Id2) :- empinfo(Id,_,Department),empinfo(Id2,_,Department2),Department=Department2.
					

worktogether(First,Last,First2,Last2):- emp_name(Id,First,Last),emp_name(Id2,First2,Last2),worktogether(Id,Id2).

senior(X,Y) :- integer(X),integer(Y),overlap(X,Y),empinfo(X,Startx,_),
				empinfo(Y,Starty,_),Startx<Starty;
			   	emp_name(ID,X,_),emp_name(ID2,Y,_),senior(ID,ID2).	

senior(First,Last,First2,Last2):-emp_name(Id,First,Last),emp_name(Id2,First2,Last2),senior(Id,Id2).			   				 			 