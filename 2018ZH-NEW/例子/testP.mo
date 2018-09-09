package testP
  model T1
    Real t1(start = 0);
    Modelica.Blocks.Interfaces.RealInput u annotation(Placement(visible = true, transformation(origin = {-150, 5}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-101.01, 4.762}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  equation
    der(t1) = u;
    annotation(Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
  end T1;

  model Tout
    Real t2;
    Modelica.Blocks.Interfaces.RealOutput y annotation(Placement(visible = true, transformation(origin = {150, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {101.01, 19.048}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    der(t2) = 1;
    y = t2;
    annotation(Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
  end Tout;

  model all
    T1 t1 annotation(Placement(visible = true, transformation(origin = {-27.985, 35}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Tout tout annotation(Placement(visible = true, transformation(origin = {-110, 32.055}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(tout.y, t1.u) annotation(Line(visible = true, origin = {-55.039, 34.718}, points = {{-44.86, -0.758}, {13.953, -0.758}, {13.953, 0.758}, {16.953, 0.758}}, color = {0, 0, 127}));
    annotation(Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
  end all;
  annotation(Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
end testP;