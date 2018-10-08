function [filteredIm] = AverageFiltering (im, mask)

       
    [a,b] = size(mask);
    
    [m_orig, n_orig ] = size(im);
    
    if (a~=b)
        disp('Mask is not right. Should be a square matrix');
        return;
    end   
    
    for i = 1:a
        for j = 1:b
            if im(i,j)<0
                disp('Mask is not right. Must have non-negative values only');
                return;
            end
        end
    end   

    if (round(sum(mask,'all')) ~= 1)
        disp('Mask is not right. Sum of all elements must be equal to 1');
        return;
    end
    
    
    if (mod(a,2)==0 || mod(b,2)==0)
        disp('Mask is not right Mask should have odd number of rows and columns');
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
    
       filteredIm = zeros(m_orig,n_orig);
    
    k =double(a-1); 
    
    for i = 1:m_orig
        for j = 1:n_orig
            submatrix = double(im(i:i+k,j:j+k));
            filteredIm(i,j) = sum(submatrix.*mask,'all');
        end
    end    

end

            
             
            
    
    
    