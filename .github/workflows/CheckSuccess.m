function [success] = CheckSuccess(success, angle1, angle2, S, thetas)
min1 = inf;
min2 = inf;
for i = 1:length(thetas)
   distance1(i) = abs(thetas(i)-angle1);
   distance2(i) = abs(thetas(i)-angle2);
   
   if distance1(i) < min1
       min_indx1 = i;
       min1 = distance1(i);
   end
   
   if distance2(i) < min2
       min_indx2 = i;
       min2 = distance2(i);
   end
end

if(min_indx1 == S(1,1) || min_indx2 == S(1,1)...
   && min_indx1 == S(2,1) || min_indx2 == S(2,1))

    success = success + 1;
end
end
