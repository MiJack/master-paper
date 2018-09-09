model RobotC
  Robot robot(x0 = 0, y0 = 0, v0 = 10, theta = 0, m = 100, g = 9.8, u = 0.05) annotation(Placement(visible = true, transformation(origin = {-92.646, 10}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  barrier barrier1(x0 = 10, y0 = 6, v0 = 5, theta0 = -90) annotation(Placement(visible = true, transformation(origin = {-20.895, 40.895}, extent = {{-14.105, -14.105}, {14.105, 14.105}}, rotation = 0)));
  barrier barrier2(x0 = 30, y0 = 10, v0 = 5, theta0 = -90) annotation(Placement(visible = true, transformation(origin = {-18.162, -13.162}, extent = {{-11.838, -11.838}, {11.838, 11.838}}, rotation = 0)));
  Real x, dis1, dis2, dis;
  Boolean pz(start = false);
  Real jsd[6] = {2, 4, 4, -2, -4, -4};
  //加速度的四种情况，选择的概率为 1/6 或者 2/6;
  Integer jsdIdx;
equation
  x = robot.x;
  dis1 = sqrt((robot.x - barrier1.x) * (robot.x - barrier1.x) + (robot.y - barrier1.y) * (robot.y - barrier1.y));
  dis2 = sqrt((robot.x - barrier2.x) * (robot.x - barrier2.x) + (robot.y - barrier2.y) * (robot.y - barrier2.y));
  dis = min(dis1, dis2);
  when dis < 5 then
    //reinit(robot.a, -2);
    jsdIdx = MyRandom(6);
    reinit(robot.a, jsd[jsdIdx + 1]);
  end when;
  when dis > 5 then
    reinit(robot.a, 0);
    reinit(robot.v, robot.v0);
  end when;
algorithm
  if dis < 1 then
    pz := true;
  else
    pz := false;
  end if;
  annotation(Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
end RobotC;