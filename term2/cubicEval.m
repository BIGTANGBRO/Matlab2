function yInterpVal = cubicEval(x,polyArray,xval)

%cubicEval - Function to evaluate value of polynomial function described by
%array polyArray[] at x-position xval.
%Correct polynomials for xval are selected by using bisection search to
%determine the correct interval in x where xval is located.
%
%OUTPUTS
%yInterpVal - The value of the function evaluated at xval
%INPUTS
%x - Vector containing x-values for sample dataset, in ascending order.
%polyArray - N x 4 Array containing polynomial coefficients for cubic spline at
%            each interval, where N is number of intervals.  Make
%            sure coefficients in each row are ordered in descending order, i.e
%            coefficients of x^3, x^2, x^1, x.  Rows to be ordered by
%            ascending x-position of interval.
%xval - Scalar x-value at which you would like to evaluate the function.

%calculate number of x-values
n=length(x);

%%use bisection search to determine which segment the interpolation "xval"
%%lies in
%initialise search to full range of x
klower = 1;
kupper = n;
%IF statement to check that xval lies within the sample data range
if (xval >= x(1) && xval <= x(n))
while (kupper - klower > 1) %continue search until search interval has reduced to two consecutive points
    kmid = ceil((klower + kupper)/2); %split domain in half and move to the half containing xval
    if (xval < x(kmid))
        kupper=kmid;
    else
        klower=kmid;
    end
end
else
    %If xval not within the x-range of the dataset print error and return
    %NaN
    disp('Error: Please enter an interpolation x-value "xval" that lies within the range of x');
    yInterpVal=NaN;
    return;
end

%use correct set of polynomials from the appropriate row in polyArray to
%evaluate polynomial using polyval() function.
yInterpVal = polyval(polyArray(klower,:),(xval-x(klower)));

end

