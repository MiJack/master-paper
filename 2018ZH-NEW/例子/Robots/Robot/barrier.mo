model barrier
  constant Real pi = 2 * Modelica.Math.asin(1.0);
  parameter Real x0, y0, v0, theta0 = -90;
  Real x, y, v, theta;
initial equation
  x = x0;
  y = y0;
  v = v0;
equation
  theta = theta0 / 180.0 * pi;
  der(x) = v * cos(theta);
  der(y) = v * sin(theta);
  when abs(y) > y0 then
    v = -v;
  end when;
  annotation(Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
end barrier;