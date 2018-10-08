function[CleanIm] = remove_streaks(im,ws,sensitivity)


[a, b] = size(im);

CleanIm = zeros(a,b);

for i = 1:ws:a
    for j = 1:ws:b
        sub = im(i:i+ws-1,j:j+ws-1);
        T = adaptthresh(sub,sensitivity,'ForegroundPolarity','dark');
        CleanIm(i:i+ws-1,j:j+ws-1) = imbinarize(sub,T);
    end   
end



