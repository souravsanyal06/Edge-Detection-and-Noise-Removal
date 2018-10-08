function [filteredIm] = MedianFiltering (im, mask)

       
    [a,b] = size(mask);
    
    [m_orig, n_orig ] = size(im);
    
    if (mod(a,2)==0 || mod(b,2)==0)
        disp('Mask is not right Mask should have odd number of rows and columns');
    end
    
    if (a~=b)
        disp('Mask is not right. Should be a square matrix');
        return;
    end   
    
    for i = 1:a
        for j = 1:b
            if mask(i,j)<0
                disp('Mask is not right. Must have non-negative values only');
                return;
            end
        end
    end   

    
    if mask ~= mask'
        disp('Mask is not right. Mask should be symmetrical about center');
        return;
    end
    
    pad = 0.5*(a-1);
        
    [m,n] = size(im); 
    im = [ [im ;zeros(pad,n)] zeros(m+pad,pad)];
    
    [m,n] = size(im); 
    
    im = [ zeros(m+pad,pad) [zeros(pad,n);im] ];
    
       filteredIm = zeros(m_orig,n_orig,'uint8');
    
    k =double(a-1); 
    
    
    mask = mask(:)';
    
    for i = 1:m_orig
        for j = 1:n_orig
            marray=double([]);
            submatrix = double(im(i:i+k,j:j+k));
            submatrix = submatrix(:)';
            for ii = 1:length(mask)
                x = mask(ii);
                for jj = 1:x
                    marray = [marray,submatrix(ii)];
                end
            end
            filteredIm(i,j) = double(median(marray));
       end
    end    

end
