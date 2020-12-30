

a=1;
b=0;
c=0;

p1 = [a,b,c];

d=1;
e=1;
f=0;

p2 = [d,e,f];

g=0;
h=0;
j=1;

p3 = [g,h,j]

target = 1/2-0.01
k = 1/2 - target;
l = sqrt(5)/2-target;
m = sqrt(5)/2-target;

syms x;
syms y;
syms z;
syms r;

eqns = [r >= 0,
        r^2 == x^2 + y^2 + z^2,
        (r+l)^2 == (x-d)^2 + (y-e)^2 + (z-f)^2,
        (r+k)^2 == (x-a)^2 + (y-b)^2 + (z-c)^2,
        (r+m)^2 == (x-g)^2 + (y-h)^2 + (z-j)^2];
    
vars = [r, x, y, z];

[solvr, solvx, solvy, solvz] = solve(eqns, vars);



% for graph stuff
[x1,y1,z1] = sphere(50);
x1 = x1*k + p1(1);
y1 = y1*k + p1(2);
z1 = z1*k + p1(3);
figure
lightGrey = 0.8*[1 1 1]; % It looks better if the lines are lighter
surface(x1,y1,z1,'FaceColor', 'none','EdgeColor',"magenta")
hold on

[x2,y2,z2] = sphere(30);
x2 = x2*l + p2(1);
y2 = y2*l + p2(2);
z2 = z2*l + p2(3);
lightGrey = 0.8*[1 1 1]; % It looks better if the lines are lighter
surface(x2,y2,z2,'FaceColor', 'none','EdgeColor',"yellow")
hold on

[x2,y2,z2] = sphere(30);
x2 = x2*m + p3(1);
y2 = y2*m + p3(2);
z2 = z2*m + p3(3);
lightGrey = 0.8*[1 1 1]; % It looks better if the lines are lighter
surface(x2,y2,z2,'FaceColor', 'none','EdgeColor',"green")


axis vis3d










