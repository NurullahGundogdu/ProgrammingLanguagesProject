%addroom yeni bir oda ekleme komutu
%assign	yeni bir ders ekleme komutu
%enroll ogrencinin hangi kurslra katilabildigi ve girilen kusrsa katilabilecegi kontrolu
%conflicts karisiklik kontrolu komutu
%add_student yeni bir ogrenci eklem komutu
%add_instructor yeni bir hoca ekleme komutu

class(z06,10,equipment(hcapped,projector)).
class(z11,10,equipment(hcapped,smartboard)).

occupancy(z06,8,cse341).
occupancy(z06,9,cse341).
occupancy(z06,10,cse341).
occupancy(z06,11,cse341).
occupancy(z06,12,cse341).
occupancy(z11,8,cse343).
occupancy(z11,9,cse343).
occupancy(z11,10,cse343).
occupancy(z11,11,cse343).
occupancy(z11,14,cse321).
occupancy(z11,15,cse321).
occupancy(z11,16,cse321).
occupancy(z06,13).
occupancy(z06,14).
occupancy(z06,15).
occupancy(z06,16).
occupancy(z11,12).
occupancy(z11,13).

instructor(genc,cse341,projector).
instructor(turker,cse343,smartboard).
instructor(gozupek,cse321,smartboard).
instructor(bayrakci,cse331).

course(cse341,genc,10,4,z06).
course(cse343,turker,6,3,z11).
course(cse331,bayrakci,5,3,z06).
course(cse321,gozupek,10,4,z11).

equipment_fact(hcapped,projector).
equipment_fact(hcapped,smartboard).
equipment_fact(smartboard,projector).
equipment_fact(projector).
equipment_fact(smartboard).

student(6,cse341,cse343,cse331,yes).
student(1,cse341,cse343,cse331,no).
student(7,cse341,cse343,no).
student(2,cse341,cse343,no).
student(3,cse331,cse331,no).
student(5,cse343,cse331,no).
student(8,cse341,cse331,yes).
student(10,cse341,cse321,no).
student(11,cse341,cse321,no).
student(12,cse343,cse321,no).
student(13,cse343,cse321,no).
student(14,cse343,cse321,no).
student(15,cse343,cse321,yes).
student(4,cse341,no).
student(9,cse341,no).


assign(RId,CId) :- course(CId,_,_,Hour,RId), check1(RId,Hour).
assign(RId,CId) :- course(CId,_,_,Hour,RId), check2(RId,Hour).
check1(RId,Hour):- RId = z06, Hour=<4.
check2(RId,Hour):- RId = z11, Hour=<2.

addRoom(X,Y,Z,W):- not(class(X,_,equipment(_,_))), equipment(Z,W),Y > 0.

conflicts(ID1,ID2):- check_Room_conflict(R1,R2),conflicts_control(ID1,ID2),course(ID1,_,_,_,R1),course(ID2,_,_,_,R2).

add_instructor(X,Y):-  not(instructor(X,Y)),not(course(Y,_,_,_,_)),not(course(_,X,_,_,_)).
add_instructor(X,Y,Z):-  not(instructor(_,Y,_)),not(course(Y,_,_,_,_)),not(course(_,X,_,_,_)),needs(Z).

add_student(Id,C,Hcapped) :- handicapped_check(Hcapped),not(student(Id,_,_)),not(student(Id,_,_,_)),course(C,_,_,_,_),not(student(Id,_,_,_,_)).
add_student(Id,C1,C2,Hcapped) :- handicapped_check(Hcapped),course(C2,_,_,_,_),course(C1,_,_,_,_),not(student(Id,_,_,_)),not(student(Id,_,_)),not(student(Id,_,_,_,_)).
add_student(Id,C1,C2,C3,Hcapped) :- handicapped_check(Hcapped),course(C3,_,_,_,_),course(C1,_,_,_,_),course(C2,_,_,_,_),not(student(Id,_,_,_)),not(student(Id,_,_,_,_)), not(student(Id,_,_)).

enroll(SId,CId) :- check_no_handicapped(Handicapped,CId),student(SId,_,_,Handicapped).
enroll(SId,CId) :- check_no_handicapped(Handicapped,CId),student(SId,_,_,_,Handicapped).
enroll(SId,CId) :- check_no_handicapped(Handicapped,CId),student(SId,_,Handicapped).
enroll(SId,CId) :- student_check(RId,Handicapped),course(CId,_,_,_,RId),student(SId,_,Handicapped).
enroll(SId,CId) :- student_check(RId,Handicapped),course(CId,_,_,_,RId),student(SId,_,_,Handicapped).
enroll(SId,CId) :- student_check(RId,Handicapped),course(CId,_,_,_,RId),student(SId,_,_,_,Handicapped).

needs(X) :- equipment(X);equipment_fact(X).

equipment(X,Y) :- equipment_fact(X,Y);equipment_fact(Y,X).

student_check(RId,Handicapped) :- class(RId,_,equipment(Hcapped,_)),enroll_check(Hcapped,Handicapped).
check_no_handicapped(Handicapped,CId):- Handicapped = no, course(CId,_,_,_,_).
conflicts_control(ID1,ID2) :- occupancy(_,X,ID1),occupancy(_,Y,ID2),check_time(X,Y).
enroll_check(Hcapped,Handicapped) :- Hcapped = hcapped, Handicapped = yes.
handicapped_check(Hcapped) :- Hcapped = yes;Hcapped = no.
check_Room_conflict(Room1,Room2) :- Room1 = Room2.
check_time(X,Y) :- X = Y.

