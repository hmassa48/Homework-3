function line_detected_img = lineFinder(orig_img, hough_img, hough_threshold)
    
    %get sizes of original and hough image
    [l,n] = size(orig_img);
    [len_theta, len_rho] = size(hough_img);
    
    %main diagonal length rho and then steps in rho
    %diag_len = len_rho;
    diag_len = sqrt(l^2 + n^2); %need original image 
    drho = 2*diag_len/(len_rho-1);
    
    %steps in theta 
    dtheta = 180/ len_theta;
    
    %set up figure to draw on 
    fh = figure; 
    imshow(orig_img);
    hold on;
    
    %find thetas and rhos that are bigger than threshold
    [thetas, rhos] = find(hough_img > hough_threshold);
    
    %iterate through the values 
    for i = 1:numel(thetas)
        %get theta and rho values from index value
        test_theta = thetas(i) * dtheta; %test each step of theta
        test_rho = drho* (rhos(i) - len_rho/2); %test each step of rho
                
        %convert back to cartesian coordinates
        %equations explained in the read me file 
        x = 1 : n;
        m = sind(test_theta) / cosd(test_theta);
        b = test_rho / cosd(test_theta);
        y = m*x + b;
                
        %plot the line
        plot(y, x,'red', 'LineWidth', 1);
        
     end
   
    
    line_detected_img = SaveAnnotatedImg(fh);
 end
            
                