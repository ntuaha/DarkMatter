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
    if(length(guess_x) == 3)
        I = [1 2 3];
        J = [1 2 3];
        r1 = getDistance(guess_x(I(1)),guess_y(I(1)),true_x(J(1)),true_y(J(1)));
        r2 = getDistance(guess_x(I(2)),guess_y(I(2)),true_x(J(2)),true_y(J(2)));
        r3 = getDistance(guess_x(I(3)),guess_y(I(3)),true_x(J(3)),true_y(J(3)));
        sum1 = r1+r2+r3;
        J = [1 3 2];
        r1 = getDistance(guess_x(I(1)),guess_y(I(1)),true_x(J(1)),true_y(J(1)));
        r2 = getDistance(guess_x(I(2)),guess_y(I(2)),true_x(J(2)),true_y(J(2)));
        r3 = getDistance(guess_x(I(3)),guess_y(I(3)),true_x(J(3)),true_y(J(3)));
        sum2 = r1+r2+r3;

        J = [2 1 3];
        r1 = getDistance(guess_x(I(1)),guess_y(I(1)),true_x(J(1)),true_y(J(1)));
        r2 = getDistance(guess_x(I(2)),guess_y(I(2)),true_x(J(2)),true_y(J(2)));
        r3 = getDistance(guess_x(I(3)),guess_y(I(3)),true_x(J(3)),true_y(J(3)));
        sum3 = r1+r2+r3;

        J = [2 3 1];
        r1 = getDistance(guess_x(I(1)),guess_y(I(1)),true_x(J(1)),true_y(J(1)));
        r2 = getDistance(guess_x(I(2)),guess_y(I(2)),true_x(J(2)),true_y(J(2)));
        r3 = getDistance(guess_x(I(3)),guess_y(I(3)),true_x(J(3)),true_y(J(3)));
        sum4 = r1+r2+r3;

        J = [3 1 2];
        r1 = getDistance(guess_x(I(1)),guess_y(I(1)),true_x(J(1)),true_y(J(1)));
        r2 = getDistance(guess_x(I(2)),guess_y(I(2)),true_x(J(2)),true_y(J(2)));
        r3 = getDistance(guess_x(I(3)),guess_y(I(3)),true_x(J(3)),true_y(J(3)));
        sum5 = r1+r2+r3;

        J = [3 2 1];
        r1 = getDistance(guess_x(I(1)),guess_y(I(1)),true_x(J(1)),true_y(J(1)));
        r2 = getDistance(guess_x(I(2)),guess_y(I(2)),true_x(J(2)),true_y(J(2)));
        r3 = getDistance(guess_x(I(3)),guess_y(I(3)),true_x(J(3)),true_y(J(3)));
        sum6 = r1+r2+r3;

        r = min([sum1,sum2,sum3,sum4,sum5,sum6]);
    end
        