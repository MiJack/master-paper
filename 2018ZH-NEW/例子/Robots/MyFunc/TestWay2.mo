package TestWay2
  model TestWay2
    output Real res;
  equation
    res = time;
    //algorithm
    //  res := time;
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
  end TestWay2;

  model two
    input Real res;
    Real test;
  equation
    res = 1;
    //der(test) = res;
  end two;
end TestWay2;