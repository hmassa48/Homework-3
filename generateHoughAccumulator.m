function hough_img = generateHoughAccumulator(img, theta_num_bins, rho_num_bins)
    
    %get the length of the thetas and rhos
    num_rhos = int64(2*rho_num_bins); %-rho to rho
    num_thetas = theta_num_bins;
    
    %create zero accumulator
    accumulator = zeros(num_thetas,num_rhos);
    
    %get step sizes 
    d_theta = 180 / num_thetas;
    
    %get nonzero values in the image
    [nz_y, nz_x] = find(img);
    
    for i = 1:numel(nz_x)
        for t_idx = 1:num_thetas
            %voting procedure
             %voting theta is each iteration of theta
             vote_theta = d_theta*t_idx;
             %rho equation described in the notes and read me file
             vote_rho = nz_x(i) * cosd(vote_theta) -nz_y(i) * sind(vote_theta);
             %we have to add the diagonal value of rho (or our max rho
             %value) before we add it into accumulator for final index
             r_idx = round(vote_rho + rho_num_bins);
             
             %add to accumulator 
             accumulator(t_idx, r_idx) = accumulator(t_idx, r_idx) + 1;
             
          end
    end
        
    %regulate the accumulator to be from 0 to 255
    accumulator = (accumulator - min(min(accumulator))) *255 / max(max(accumulator));
    hough_img = accumulator;
    hough_img(hough_img<0) = 0;
end
    
            
       