%Hufman code generating phase
function fhcode(lstn,img)
disp('Code generating phase entered...');
[lm,ln]=size(lstn);
[im,in]=size(img);
idd=input('Enter destination huffman code file name : ','s');
tab=input('Enter the Huff Table name (for decoding purpose): ','s');
tb = fopen(tab,'w+');
idd=fopen(idd,'w+');
fst1='';
fst2='';
t=0;                      % for indexing of hc
ed=0;                     % indexing for dictionary
din=0;
% Traversing the Tree resembling list resulting in reverse Huffman code for a particular character%
disp('Building Huffman Table.........');
for i=1:in
    k=img(i);
    ftemp=img(i);
    a=0;
    for j=1:3:ln
        if(lstn(j+2)==99)
            break;
        end
        if(lstn(j)==k)
            a=a+1;
            ary(a)=lstn(j+1);
            k=lstn(j+2);
        end
    end
    % ary array will have different values at different iterations 
    % ary will have 0 0 1 1 for b in abhimahajan and size will be 32
    
    % Reversing the reverse Huffman Code%
    for b=a:-1:1
        t=t+1;
        hc(t)=ary(b);                % hc is an array which will contain the whole text in binary format
        fprintf(idd,'%d',ary(b));
        fst1=int2str(ary(b));        % the 8 byte integer at ary(b) will be converted to 1 byte character
        fst2=strcat(fst2,fst1);
    end
       
        #{
        final hc for abhimahajan
        01100111110110110111010100100
        sizeof(h) is 29*8 = 232
        #}
        
    %Building Huffman Table for Decoding%
    % dict is like a map in c++
    din=0;
    for z=1:ed
        if dict(z)==ftemp
            din=1;
        end
    end
    if din==0
        ed=ed+1;
        dict(ed)=ftemp;
        fprintf(tb,'%c',' ');
        fprintf(tb,'%c',ftemp);
        fprintf(tb,'%s',fst2);     
    end
    fst1='';
    fst2='';
end
#{
dict for abhimahajan
abhimjn
#}

#{
actual table for abhimahajan
 a0 b1100 h111 i1101 m1011 j1010 n100
size is 37 bytes
 there is a space before a0
#}

fclose(tb);

%Converting 8 bit Binary to ASCII character and storing the result in specified file%
disp('Converting binary huffman codes to ASCII characters......');
nme=input('Enter the destination file name :','s');
disp('Generating the compressed file..........');
id = fopen(nme,'w+');
for i=1:8:t
    ck=t-i+1;
    if(ck>8)
        tp=(hc(i:i+7));
        num=8;
    else
        pad=8-ck;
        tp=(hc(i:t));
        num=ck;
    end    
    temp1=b2d(tp,num);          % temp1 has integer of 8 bytes int64
    temp2=char(temp1);          % temp2 has ascii character corresponding to integer of 1 byte
    fprintf(id,'%c',temp2);
end
temp2 = char(pad);              % appending pad at the end 
fprintf(id,'%c',temp2)
fclose(id); 
fclose(idd);
disp('Generated Compressed file');
endfunction