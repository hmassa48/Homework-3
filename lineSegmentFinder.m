function cropped_line_img = lineSegmentFinder(orig_img, hough_img, hough_threshold)
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
    
    %based on piazza post, I am choosing to compare edge image 
    %can't load in the edge image so I have to rewrite it 
    edge_img = edge(orig_img,'canny');
    
    %dilate the image a little to see better 
    se = strel('line',9,9);
    edge_img = imdilate(edge_img,se);
    
    %to be able to use values
    edge_img = im2double(edge_img);
    
    %iterate through the values 
    for i = 1:numel(thetas)
        %get theta and rho values from index value
        test_theta = thetas(i) * dtheta; %test each step of theta
        test_rho = drho* (rhos(i) - len_rho/2); %test each step of rho
                
        %boolean variable to test to see if first endpoint has been found
        %for each possible line 
        first_point = false;
        
        %create endpoints for line
        %plot xs and ys together plot([x1,x2],[y1,y2])
        x_points = [0, 0];
        y_points = [0, 0];
        
        %convert back to cartesian coordinates
        %iterate through all the possible x's to check which ones are on
        %the edge points in the edge detected image. not just infinite x
        for x = 1:l
            
            %convert first x=1 to cartesian
            m = sind(test_theta) / cosd(test_theta);
            b = test_rho / cosd(test_theta);
            y = m*x + b;
            y = round(y); %for indexing
            
            %check for valid y points
            if ((y > 0) && (y < n) && (edge_img(x, y) > 0))
                %check for edges to find a point to start the line
                if (first_point == false)
                    %found edge 
                    %start the line. 
                    x_points(1) = x; %first x endpoint
                    y_points(1) = y; %first y endpoint
                    m = sind(test_theta) / cosd(test_theta);
                    b = test_rho / cosd(test_theta);
                    y = m*x + b;
                    y = round(y); %indexing
                    first_point = true;
                end
                
                m = sind(test_theta) / cosd(test_theta);
                b = test_rho / cosd(test_theta);
                y = m*x + b;
                y = round(y); %indexing 
                %finish the line
                %last endpoints
                x_points(2) = x;
                y_points(2) = y;
                
            end
            
        end
        
       plot(y_points, x_points, 'Color', 'red', 'LineWidth', 1.5);
                              
    end
    
    cropped_line_img = SaveAnnotatedImg(fh);
 end

