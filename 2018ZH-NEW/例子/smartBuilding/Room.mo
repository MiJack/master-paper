model Room
  parameter Real iniT(start = 10);
  Real T(start = iniT);
  parameter Integer humanNum(start = 2);
  Modelica.Blocks.Interfaces.RealInput Tj annotation(Placement(visible = true, transformation(origin = {-150, 55}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 73.98}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u annotation(Placement(visible = true, transformation(origin = {-150, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput outT annotation(Placement(visible = true, transformation(origin = {155, 7.632}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {104.377, 7.269}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput h annotation(Placement(visible = true, transformation(origin = {-150, 12.212}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-100, 10}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  der(T) = 1;
  annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {10, 10}), graphics = {Rectangle(visible = true, origin = {1.133, 1.403}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid, extent = {{-98.867, -98.597}, {98.867, 98.597}}), Rectangle(visible = true, origin = {-108.457, -35.908}, fillColor = {255, 255, 255}, extent = {{-1.543, -7.83}, {1.543, 7.83}})}), Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5}), graphics = {Rectangle(visible = true, origin = {0, 1.11}, fillColor = {128, 128, 128}, fillPattern = FillPattern.Solid, extent = {{-146.538, -103.89}, {146.538, 103.89}})}));
end Room;