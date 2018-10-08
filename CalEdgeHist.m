function edgeHist = CalEdgeHist(im, bin)

im = double(im);
maskx = [ -1 -2 -1  ; 0 0 0 ; 1 2 1 ];
masky = [ -1 0 1 ; -2 0 2 ; -1 0 1];
Gx = Convolute(im,maskx);
Gy = Convolute(im,masky);

gradient = atan2d(Gx,Gy)+ 360*(Gx<0); % to make the range 0 to 360 %
edgeHist = histcounts(gradient,bin);