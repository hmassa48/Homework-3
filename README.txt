Homework 3 Haley Massa Read Me File
=================

Third homework assignment for computer vision Spring 2020.

Files Included: 
===============
runHw3.m
honesty.m
hw3_walkthrough1.m
generateHoughAccumulator.m
lineFinder.m
lineSegmentFinder.m 
saveAnnotatedImg.m


===============
Discuss generateHoughAccumulator.m : 

In this file, I work to generate a hough accumulator. 
The hough accumulator is set with 360 (parameter input) thetas spaced at (180/360) distance apart. 
The rho values chosen were found by taking the square root of the width^2 + height^2 of the image and multiplying that by 2
This will allow us a value from -rho to rho, with that euclidean norm being the largest rho value as it is the radial distance
The accumulator is originally set to zero 
The voting procedure used converts the points into polar coordinates and uses the equation:
x*sin(0) - y*cos(0) + max_rho_value (image diagonal) 
to find the rho index values



===============
Discuss lineFinder.m : 

My lineFinder.m file works with the thresholding method. I originally tried to work with a smarter method, but was unsucessful. 
So, it works fairly simply. 
It iterates through the hough image by rows and columns. These values were set earlier to be our theta and rho indexes.
It checks each value from its iteration and if a value is higher than the threshold set, 
it will consider that set of theta and rho to be a peak coordinate. This means that the theta and rho values
will be used to create a line on the original image. 
To do this: I transform the theta and rho value back to cartesian and create a line using the formula y = mx+b
x in this case becomes the values of the original images height
m = sind(test_theta) / cosd(test_theta);
B = rho / cosd(test_theta)
this is a transformation of y = mx+b and the polar coordinates y = r sin and x = r cos 

===============
Discuss lineSegmentFinder.m : 

My lineSegmentFinder follows the same idea as the lineFinder program. 
I am iterating through the values in the code to see if there are any indexes that are higher than the threshold.
I am then changing those index values to get the real values of theta and rho stored there. 
With the theta and rho values, I am then setting up a line with x relating to a constant dimension of the original image 
and y corresponding to mx+b as defined in lineFinder. 
However, I am now limiting the values of x to only values of x that are part of a line. 
Using a hint someone mentioned in the piazza forum of using the original edge image, I created a method that was comparing
A set-back of this algorithm is that I do not believe that it works for gaps. 
my x and y values with the values in the edge image. 
This method finds all theta and rho values greater than the threshold and loops over those values to test if those values are 1. Valid and 2. Edges in the edge detected image. In order for the image to be a bit better to see in terms of lines and pixels, I dilated the edge detected image using the imdilate. If a point satisfies this, it first saves that point as one endpoint. It then iterates through the rest of the values of the line, saving the last point that satisfies the condition as the other endpoint of the line. It then plots the line on the original image. 