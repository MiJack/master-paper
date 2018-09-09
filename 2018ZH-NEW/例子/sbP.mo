package sbP
  model smartBuildingNo
    parameter Integer n = 5;
    Real Room[n](start = {7, 7, 7, 7, 7});
    Real derRoom[n](start = {0, 0, 0, 0, 0});
    parameter Real adj[5, 5] = {{0.00, 0.40, 0.00, 0.00, 0.50}, {0.4, 0, 0.2, 0.2, 0}, {0, 0.2, 0, 0.5, 0}, {0.00, 0.20, 0.50, 0.00, 0.40}, {0.50, 0.00, 0.00, 0.40, 0.00}};
    parameter Real b[n](start = {0.25, 0.35, 0.10, 0.15, 0.45});
    parameter Real c[n](start = {10.0, 7.0, 10.0, 11.0, 9.0});
    parameter Real humans[n](start = {5.0, 0, 7, 8, 9.0});
    parameter Integer h[n](start = {0, 0, 0, 0, 0});
    Real allUn(start = 0);
    parameter Real derAllUn(start = 0);
    Real u(start = 6);
  equation
    for i in 1:n loop
//每个房间温度所满足的ODE
      der(Room[i]) = derRoom[i];
    end for;
    der(allUn) = derAllUn;
//不舒适度满足的ODE
    u = Gaussian(time);
//u=6;
  algorithm
    for i in 1:n loop
      derRoom[i] := 0;
      for j in 1:n loop
        derRoom[i] := derRoom[i] + adj[i, j] * (Room[j] - Room[i]);
      end for;
      derRoom[i] := derRoom[i] + b[i] * (u - Room[i]) + c[i] * h[i];
    end for;
    annotation(
      Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
    annotation(
      Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
  end smartBuildingNo;

  function Gaussian
   input Real x;
    output Real res;
  
    external "C" res = Gaussian(x) annotation(IncludeDirectory = "E://Modelica//CFunction//", Include = "#include \"Random.c\"");
    annotation(Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
  end Gaussian;



end sbP;
