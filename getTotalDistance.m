function r = getTotalDistance(guess_x,guess_y,true_x,true_y)
    if(length(guess_x) == 2)
        r1 = getDistance(guess_x(1),guess_y(1),true_x(1),true_y(1));
        r2 = getDistance(guess_x(2),guess_y(2),true_x(2),true_y(2));
        sum1 = r1+r2;
        r3 = getDistance(guess_x(1),guess_y(1),true_x(2),true_y(2));
        r4 = getDistance(guess_x(2),guess_y(2),true_x(1),true_y(1));
        sum2 = r3+r4;
        r = min(sum1,sum2);
    end
        