%Hufman coding algorithm
%Author : Abhi Mahajan
% Total program is divided into three modules
% (1) Histogram building & Probability calculation (fhstart.m)
% (2) Huffman Tree drawing phase(fhtree1.m)
% (3) Huffman Code generating module(fhcode.m)

%%%% USAGE %%%%%%%
% Run the program fhstart.m
% The filename entered should be a Text file

clc;
clear all;
k=input('Enter the file name :','s');
fid = fopen(k,'r');
F = fread(fid);  % a column matrix(2-d array) with integer(8 byte) int64 type entries and no of rows equal to no of characters in file%
#{
For abhimahajan
F = 97
    98
   104
   105
   109
    97
   104
    97
   106
    97
   110
#}
img = char(F');  % a row matrix(2-d array) with character(1 byte) type entries and transpose of F%
%{
img = abhimahajan
%}
mx=255;
[x y]=size(img);
h(1:mx)=0;    % h is a row matrix(2-d array) with 255 columns and integer(8 byte) int64 type entries
              % h=zeros(1,mx);
disp('Histogram building phase started....');
% h will contain the count of each character
% h will have value 4 at 97 for abhimahajan
for i=1:y
        iy=img(i);
        val=double(iy);           %double converts the character(1 byte) to integer(8 byte) int64
        h(val)=h(val)+1;
end
disp('Probability calculating phase started...');
%p is a row matrix(2-d array) with 255 columns and integer(8 byte) int64 type entries
% p=zeros(1,mx);
% p will have probabilities of each character
% p will have value 0.36364 at 97 for abhimahajan
p(1:mx)=0;
for i=1:mx
p(i)=h(i)/(x*y);
end 

j=1;
for i=1:mx
        if(p(i)~=0)
         lst(j)=i;
         lst(j+1)=p(i);
         j=j+2;
        end
 end
#{
lst contains index and the probability at that index which is non-zeros
For abhimahajan
lst =

 Columns 1 through 4:

  9.7000e+001  3.6364e-001  9.8000e+001  9.0909e-002

 Columns 5 through 8:

  1.0400e+002  1.8182e-001  1.0500e+002  9.0909e-002

 Columns 9 through 12:

  1.0600e+002  9.0909e-002  1.0900e+002  9.0909e-002

 Columns 13 and 14:

  1.1000e+002  9.0909e-002
  #}
  
[tt,mx]=size(lst);
disp('sorting phase started....');
%sorting lst on the increasing order of probabilities
for i=2:2:mx
    for j=i:2:mx
        if (lst(i)>lst(j))
            temp1=lst(i-1);
            temp2=lst(i);
            lst(i-1)=lst(j-1);
            lst(i)=lst(j);
            lst(j-1)=temp1;
            lst(j)=temp2;
        end
    end
end
#{
sorted lst is
lst =

 Columns 1 through 4:

  9.8000e+001  9.0909e-002  1.0500e+002  9.0909e-002

 Columns 5 through 8:

  1.0600e+002  9.0909e-002  1.0900e+002  9.0909e-002

 Columns 9 through 12:

  1.1000e+002  9.0909e-002  1.0400e+002  1.8182e-001

 Columns 13 and 14:

  9.7000e+001  3.6364e-001
#}
  
disp('Building Huffman Tree.....');
fhtree1(lst,img);


