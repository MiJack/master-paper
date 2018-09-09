model testSBIni
  parameter Integer n = 5;
  Real Room[n](start = {7, 7, 7, 7, 7});
  Real derRoom[n](start = {0, 0, 0, 0, 0});
  parameter Real off[n](start = {21, 21, 21, 21, 21});
  parameter Real on[n](start = {19, 19, 19, 19, 19});
  parameter Real get[n](start = {16, 17, 18, 17, 16});
  parameter Real low[n](start = {15, 16, 16, 16, 15});
  /*parameter Real dif[n](start = {1, 1, 1, 1, 1});
                                          parameter Real imp[n](start = {1, 30, 2, 3, 4});*/
  parameter Real power[n](start = {5, 5, 5, 5, 5});
  parameter Real adj[5, 5] = {{0.00, 0.40, 0.00, 0.00, 0.50}, {0.4, 0, 0.2, 0.2, 0}, {0, 0.2, 0, 0.5, 0}, {0.00, 0.20, 0.50, 0.00, 0.40}, {0.50, 0.00, 0.00, 0.40, 0.00}};
  parameter Real b[n](start = {0.25, 0.35, 0.10, 0.15, 0.45});
  parameter Real c[n](start = {10.0, 7.0, 10.0, 11.0, 9.0});
  parameter Real humans[n](start = {5.0, 0, 7, 8, 9.0});
  Real unCom[n](start = {0, 0, 0, 0, 0});
  Integer h[n](start = {0, 0, 0, 0, 0});
  //某房间是否有加热器
  Integer rh[n](start = {0, 0, 0, 0, 0});
  //房间i占用哪个加热器
  //Integer need[n](start = {0, 0, 0, 0, 0});
  Integer heater[3](start = {0, 0, 0});
  //加热器i给哪个房间加热
  Real allUn(start = 0), derAllUn(start = 0);
  parameter Real u(start = 6);
equation
  for i in 1:n loop//每个房间温度所满足的ODE
    der(Room[i]) = derRoom[i];
  end for;
  der(allUn) = derAllUn;//不舒适度满足的ODE
algorithm
  for i in 1:n loop   //每个房间温度导数的计算 //+b[i] * (u - Room[i]) + c[i] * h[i];
    derRoom[i] := 0;
    for j in 1:n loop
      derRoom[i] := derRoom[i] + adj[i, j] * (Room[j] - Room[i]);
    end for;
    derRoom[i] := derRoom[i] + b[i] * (u - Room[i]) + c[i] * h[i];
  end for;
  derAllUn := 0;
  for i in 1:n loop
    if Room[i] < low[i] then
      unCom[i] := (low[i] - Room[i]) * humans[i];
      derAllUn := derAllUn + unCom[i];
    elseif Room[i] > low[i] then
      derAllUn := derAllUn - unCom[i];
      unCom[i] := 0;
    end if;
    if noEvent(Room[i] < get[i] and h[i] == 0 and humans[i] > 0) then
      for ii in 1:3 loop
        if heater[ii] < 1 then
          heater[ii] := i;
          h[i] := 1;
          rh[i] := ii;
          break;
        end if;
      end for;
    elseif Room[i] >= on[i]  or humans[i] == 0 then
      h[i] := 0;
      heater[rh[i]] := 0;
      rh[i] := 0;
    end if;
  end for;
end testSBIni;
