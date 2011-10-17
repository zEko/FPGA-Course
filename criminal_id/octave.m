#!/usr/bin/octave

% Author: Kai
% Software : Octave 3.4.0
% Licence : LGPL
% Date : 30.4.2011
% Functions : extractData - extracts Rch,Gch,Bch,Ych,imgdata,row,column data form image
%   showAndTell : display image and title

function [Rch,Bch,Gch,Ych,crimImage,row,column] =  extractData (photo)
  crimImage=imread(photo);
  [row,column,dim]=size(crimImage);
  Rch=crimImage(:,:,1);
  Gch=crimImage(:,:,2);
  Bch=crimImage(:,:,3);
Ych=zeros(row,column,'uint8');
  for i=1:row
    for j=1:column
        Ych(i,j)=0.299*Rch(i,j)+0.5878*Gch(i,j)+0.144*Bch(i,j);
    end
  end
endfunction

function showAndTell(gfimg,gftitle)
  imshow(gfimg)
  title(gftitle)
endfunction


% extract relevant data from the images
% Use delimiter ',' because the shell script cant parse a space. me weak in re :(
[Rch1,Bch1,Gch1,Ych1,img1,row1,column1] =  extractData ('img/1.bmp');
[Rch2,Bch2,Gch2,Ych2,img2,row2,column2] =  extractData ('img/2.bmp');
dlmwrite('data/Rch1.txt', Rch1, 'delimiter', ',', 'newline' ,'unix');
dlmwrite('data/Gch1.txt', Gch1, 'delimiter', ',', 'newline' ,'unix');
dlmwrite('data/Bch1.txt', Bch1, 'delimiter', ',', 'newline' ,'unix');
dlmwrite('data/Ych1.txt', Ych1, 'delimiter', ',', 'newline' ,'unix');
dlmwrite('data/Rch2.txt', Rch2, 'delimiter', ',', 'newline' ,'unix');
dlmwrite('data/Gch2.txt', Gch2, 'delimiter', ',', 'newline' ,'unix');
dlmwrite('data/Bch2.txt', Bch2, 'delimiter', ',', 'newline' ,'unix');
dlmwrite('data/Ych2.txt', Ych2, 'delimiter', ',', 'newline' ,'unix');

% find the difference matrix
diff=Ych1-Ych2;
simpix=0

% To find the difference between the images
THRESHOLD = 0
for i=1:row1
  for j=1:column1
    if(abs(diff(i,j)) == THRESHOLD)
      simpix++;
    end
  end
end

% similar Pixel count
simpix
difpix=(row1*column1)-simpix
% similar Pix Percent count
simper=(simpix/(row1*column1))*100

figure,
subplot(321)
showAndTell(img1,'Mugshot')
subplot(322)
showAndTell(Ych1,'Mugshot(Greyscale)')
subplot(323)
showAndTell(img2,'CCTV capture')
subplot(324)
showAndTell(Ych2,'CCTV capture(Greyscale)')
subplot(325)
showAndTell(diff,'difference')


 