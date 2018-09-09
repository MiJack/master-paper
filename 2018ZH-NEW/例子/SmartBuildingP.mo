model SmartBuildingP
  model Room
    parameter Integer adjRoom(start = 0);
    parameter Real iniT(start = 1);
    parameter Real b(start = 0.25);
    parameter Real a[5];
    Real T(start = iniT);
    parameter Integer humanNum(start = 2);
    Modelica.Blocks.Interfaces.RealInput u annotation(Placement(visible = true, transformation(origin = {-151.526, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput outT annotation(Placement(visible = true, transformation(origin = {155, 7.632}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {104.377, 7.269}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Real In(start = 0);
    Modelica.Blocks.Interfaces.RealInput Tj[adjRoom] annotation(Placement(visible = true, transformation(origin = {-155, 55}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 73.98}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput h annotation(Placement(visible = true, transformation(origin = {-155, 15}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-99.022, 12.599}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  equation
    der(T) = In + h + b * (u - T);
    outT = T;
  algorithm
    In := 0;
    for i in 1:adjRoom loop
      In := In + a[i] * (Tj[i] - T);
    end for;
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Rectangle(visible = true, origin = {1.133, -1.403}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid, extent = {{-98.867, -98.597}, {98.867, 98.597}}), Rectangle(visible = true, origin = {-108.457, -35.908}, fillColor = {255, 255, 255}, extent = {{-1.543, -7.83}, {1.543, 7.83}}), Text(visible = true, origin = {8.369, 75.595}, extent = {{-66.686, -37.798}, {66.686, 37.798}}, textString = "%name")}), Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5}), graphics = {Rectangle(visible = true, origin = {0, 1.11}, fillColor = {128, 128, 128}, fillPattern = FillPattern.Solid, extent = {{-146.538, -103.89}, {146.538, 103.89}})}));
  end Room;

  model sb
    Room room2(adjRoom = 0, iniT = 11) annotation(Placement(visible = true, transformation(origin = {-82.517, 17.117}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Room room1(adjRoom = 2, iniT = 12) annotation(Placement(visible = true, transformation(origin = {-26.587, -35}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Room room3(adjRoom = 0, iniT = 12) annotation(Placement(visible = true, transformation(origin = {45, -35}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Room room5(adjRoom = 0, iniT = 12) annotation(Placement(visible = true, transformation(origin = {67.469, 7.673}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Room room4(adjRoom = 0, iniT = 12) annotation(Placement(visible = true, transformation(origin = {15, 45}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Env env(T = 9) annotation(Placement(visible = true, transformation(origin = {-5, -5}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  initial equation
    room1.a[1] = 0.4;
    room1.a[2] = 0.5;
  equation
    connect(env.y, room2.u) annotation(Line(visible = true, origin = {-40.935, 15.765}, points = {{46.211, -21.55}, {64.219, -21.55}, {64.219, 1.962}, {-0.604, 1.962}, {-0.604, 24.235}, {-60.929, 24.235}, {-60.929, -4.648}, {-51.582, -4.648}}, color = {0, 0, 127}));
    connect(env.y, room4.u) annotation(Line(visible = true, origin = {4.976, 16.716}, points = {{0.3, -22.501}, {18.308, -22.501}, {18.308, 0.217}, {-18.47, 0.217}, {-18.47, 22.284}, {0.024, 22.284}}, color = {0, 0, 127}));
    connect(env.y, room1.u) annotation(Line(visible = true, origin = {-11.304, -9.862}, points = {{16.58, 4.077}, {34.587, 4.077}, {34.587, 27.06}, {-30.236, 27.06}, {-30.236, -31.138}, {-25.283, -31.138}}, color = {0, 0, 127}));
    connect(env.y, room3.u) annotation(Line(visible = true, origin = {21.711, -23.528}, points = {{-16.435, 17.742}, {1.573, 17.742}, {1.573, -18.012}, {13.289, -17.472}}, color = {0, 0, 127}));
    connect(env.y, room5.u) annotation(Line(visible = true, origin = {27.196, -2.056}, points = {{-21.92, -3.729}, {-4.177, -3.729}, {-4.177, 3.729}, {30.273, 3.729}}, color = {0, 0, 127}));
    connect(room2.outT, room1.Tj[1]);
    connect(room5.outT, room1.Tj[2]);
    room2.h = 1;
    room1.h = 2;
    room3.h = 1;
    room4.h = 1;
    room5.h = 1;
    annotation(Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
  end sb;

  model Env
    parameter Real T;
    Modelica.Blocks.Interfaces.RealOutput y annotation(Placement(visible = true, transformation(origin = {155, 15}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {102.757, -7.853}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    y = T;
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Ellipse(visible = true, origin = {15, -10}, fillPattern = FillPattern.Solid, extent = {{-75, -77.046}, {75, 77.046}}), Text(visible = true, origin = {10, 82.5}, extent = {{-49.427, -52.5}, {49.427, 52.5}}, textString = "%name")}), Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
  end Env;

  connector Con
    parameter Real col(start = 0.5);
    input Real u;
    annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Polygon(visible = true, lineColor = {0, 0, 127}, fillColor = {0, 0, 127}, fillPattern = FillPattern.Solid, points = {{-100, 100}, {100, 0}, {-100, -100}})}), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Polygon(visible = true, lineColor = {0, 0, 127}, fillColor = {0, 0, 127}, fillPattern = FillPattern.Solid, points = {{-100, 100}, {100, 0}, {-100, -100}})}));
  end Con;

  model Heater
    parameter Real y(start = 5);
    Modelica.Blocks.Interfaces.RealOutput y1 annotation(Placement(visible = true, transformation(origin = {155, 12.72}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {103.133, 12.115}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    y1 = y;
    annotation(Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
  end Heater;

  model testArray
    Env env annotation(Placement(visible = true, transformation(origin = {-105, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Room rs[2];
  initial equation
    rs[1].iniT = 10;
    rs[2].iniT = 12;
  equation
    connect(env.y, rs[1].u);
    connect(env.y, rs[2].u);
    rs[1].h = 1;
    rs[2].h = 2;
    annotation(Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
  end testArray;
  annotation(Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
end SmartBuildingP;