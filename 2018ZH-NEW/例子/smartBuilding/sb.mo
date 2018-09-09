model sb
  parameter Real e = 5;
  //Real h[2](start = {12, 12});
  //Real a[2, 2] = {{0.1, 0.1}, {0.1, 0.3}};
  //Integer heater = 0;
  Room room annotation(Placement(visible = true, transformation(origin = {-1.14, 15}, extent = {{-18.86, -18.86}, {18.86, 18.86}}, rotation = 0)));
  Env env(T = 10) annotation(Placement(visible = true, transformation(origin = {-110, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  t t1 annotation(Placement(visible = true, transformation(origin = {80, 15}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(room.outT, t1.u) annotation(Line(visible = true, origin = {55.561, 16}, points = {{-37.015, 0.37}, {11.338, 0.37}, {11.338, -0.37}, {14.338, -0.37}}, color = {0, 0, 127}));
  connect(env.y, room.Tj) annotation(Line(visible = true, origin = {-41.533, 23.154}, points = {{-58.029, -1.725}, {18.343, -1.725}, {18.343, 1.725}, {21.343, 1.725}}, color = {0, 0, 127}));
  connect(env.y, room.h) annotation(Line(visible = true, origin = {-41.121, 19.402}, points = {{-58.442, 2.026}, {18.121, 2.026}, {18.121, -2.026}, {22.2, -2.026}}, color = {0, 0, 127}));
  connect(env.y, room.u) annotation(Line(visible = true, origin = {-49.019, 14.878}, points = {{-50.544, 6.55}, {10.858, 6.55}, {10.858, -6.55}, {28.828, -6.55}}, color = {0, 0, 127}));
  annotation(Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
end sb;