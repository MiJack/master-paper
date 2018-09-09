model BouncingBall
  parameter Real g = -9.8;
  Real h(start = 4);
  Real v(start = 0);
  String eventIndicator_1(start = "ini\ini");
  //slaveIdentifier,eventName
equation
  der(v) = g;
  der(h) = v;
  when h <= 0 then
    reinit(v, v * (-0.8));
    eventIndicator_1 = "ini\ini";
  elsewhen h > 0 then
    eventIndicator_1 = "BouncingBall\BallLanding";
  end when;
  /*algorithm
    if h<0 then 
      eventIndicator_1 := "BouncingBall\BallLanding";
    elseif h>0 then
      eventIndicator_1 := "ini\ini";
    end if;
  */
  annotation(Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
end BouncingBall;