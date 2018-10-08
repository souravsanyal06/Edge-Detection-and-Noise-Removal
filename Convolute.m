function [filteredIm] = Convolute(im, mask)

       
    [a,~] = size(mask);
    
    [m_orig, n_orig ] = size(im);
    
       
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