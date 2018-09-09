model Robot
  parameter Real x0, y0, v0, theta = 0, m(displayUnit = "Kg"), g, u;
  Real x, y, v, a(start = 0), dir(start = 1);
  Real energy(start = 0, displayUnit = "J");
initial equation
  x = x0;
  y = y0;
  v = v0;
equation
  der(x) = dir * v * cos(theta);
  der(y) = dir * v * sin(theta);
  der(a) = 0;
  der(v) = a;
  if a >= 0 then
    der(energy) = u * m * g * abs(v) + m * abs(a * v);
  else
    der(energy) = (-1 * u * m * g * abs(v)) + m * abs(a * v);
  end if;
  //der(energy)=u*m*g*abs(v)*a/abs(a)+m*a*dir*v;
  //x=x0+v*cos(theta);
  //y=y0+v*sin(theta);
algorithm
  if abs(x) > 50 then
    dir := -dir;
  end if;
  //if(robot.a>0) then
  //  der(energy):=u*m*g*abs(v)+m*a*dir*v;
  //else
  //  der(energy):=-1*u*m*g*abs(v)+m*a*dir*v;
  //end if;
  annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Ellipse(visible = true, origin = {-35.454, 30.882}, fillColor = {255, 255, 255}, extent = {{-38.982, -29.118}, {38.982, 29.118}})}), Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5}), graphics = {Polygon(visible = true, origin = {-38.507, 38.234}, fillColor = {255, 255, 255}, points = {{-21.493, 21.766}, {28.507, 11.766}, {23.507, -16.619}, {-11.493, -18.234}, {-29.546, -1.406}, {3.507, -1.406}, {3.507, -0.083}, {3.507, 4.216}})}));
end Robot;