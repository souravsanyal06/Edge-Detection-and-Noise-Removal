clc
close all
clear

circuit = imread('Circuit.jpg');
weighted_avg_mask = (1/16.*[ 1 2 1 ; 2 4 2 ; 1 2 1]);
stand_avg_mask = (1/25.*ones(5,5));

average_circuit_std_fil = uint8(AverageFiltering(circuit,stand_avg_mask));
average_circuit_weighted_fil = uint8(AverageFiltering(circuit,weighted_avg_mask));

figure,
subplot(1,3,1)
imshow(circuit)
title('original image');
subplot(1,3,2)
imshow(average_circuit_weighted_fil)
title('image using weighted average 3*3 filter');
subplot(1,3,3)
imshow(average_circuit_std_fil)
title('image using standard average 5*5 filter');

disp('Finished Solving Problem I 1');
pause;

weighted_median_mask = [ 1 2 1 ; 2 4 2 ; 1 2 1 ];
std_median_mask = ones(5,5);

median_circuit_std_fil = MedianFiltering(circuit,std_median_mask);
median_circuit_weighted_fil = MedianFiltering(circuit,weighted_median_mask);

figure,
subplot(1,3,1)
imshow(circuit)
title('original image');
subplot(1,3,2)
imshow(average_circuit_weighted_fil)
title('image using weighted median 3*3 filter');
subplot(1,3,3)
imshow(average_circuit_std_fil)
title('image using standard median 5*5 filter');


disp('Finished Solving Problem I 2');
pause;

moon = imread('Moon.jpg');
lap = [1 1 1; 1 -8 1; 1 1 1]; %// Change - Centre is now positive

resp = imfilter(double(moon), lap, 'conv'); %// Change

resp2 = imfilter(moon,lap,'conv');


maxR = max(resp(:));
minR = min(resp(:));
resp = (resp - minR) / (maxR - minR);

sharpened = double(moon) + resp;


minA = min(sharpened(:));
maxA = max(sharpened(:));
sharpened = (sharpened - minA) / (maxA - minA);


sharpened = imadjust(sharpened, [0/255 255/255], [0 1]);

figure, 
subplot(2,2,1);imshow(moon); title('Original image');
subplot(2,2,2);imshow(resp2); title('Laplacian filtered image');
subplot(2,2,3);imshow(resp); title('Scaled Laplacian filtered image');
subplot(2,2,4);imshow(sharpened); title('Sharpened image');

disp('Finished Solving Problem I 3');
pause;


rice = imread('Rice.jpg');
maskx = [ -1 -2 -1  ; 0 0 0 ; 1 2 1 ];
masky = [ -1 0 1 ; -2 0 2 ; -1 0 1 ];
Gx = double(Convolute(rice,maskx));
Gy = double(Convolute(rice,masky));

G = abs(Gx) + abs(Gy);

disp('I have used trial and error to choose threshold to be 137');
disp('As the image is a little whitish , I wanted a threshold which is slightly more than the median intensity value');
disp('This is because 137 lies a little above the middle value between 0 and 255');


Thresh = 137 ;
Gt = max(G,Thresh);
Gt(Gt == round(Thresh)) = 0;
Gt = uint8(Gt);
disp('Finished Solving Problem II 1');
pause;

HOG = CalEdgeHist(rice,18);

figure,
subplot(1,3,1)
imshow(rice)
title('original image');
subplot(1,3,2)
imshow(Gt);
title('Important Edges');
subplot(1,3,3);
bar(HOG)
title('Histogram of gradient of edges');

disp('Finished Solving Problem II 2');
pause;

text = imread('Text.gif');

disp('I have divided the image into smaller grids of windowsize(ws) n by n.');
disp('I have calculated the local threshold of every subblock by varying the sensitivity and making foreground dark');
disp('I have shown the intermediate images');

clean1 = remove_streaks(text,32,0.5);
clean2 = remove_streaks(text,16,0.4);
clean = remove_streaks(text,16,0.3);

figure,
subplot(2,2,1)
imshow(text)
title('orginal image');
subplot(2,2,2)
imshow(clean1)
title('ws = 32 , s = 0.5');
subplot(2,2,3)
imshow(clean2)
title('ws = 16 , s = 0.4');
subplot(2,2,4)
imshow(clean)
title('ws = 16 , s = 0.3');

pause;

disp('Testing text 1 and tex 2 now ');

text1 = imread('Text1.gif');
text1_clean = remove_streaks(text1,319,0.3);

figure,
subplot(1,2,1)
imshow(text1)
title('original text1')
subplot(1,2,2)
imshow(text1_clean)
title('cleaned text1')

pause;

text2 = imread('Text2.jpg');
text2 = rgb2gray(text2);
text2_clean = remove_streaks(text2,24,0.3);


figure,
subplot(1,2,1)
imshow(text2)
title('original text2')
subplot(1,2,2)
imshow(text2_clean)
title('cleaned text2')

pause;

disp('Finished Solving Problem III');



close all;
clear;







