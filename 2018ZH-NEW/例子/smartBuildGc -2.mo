package smartBuildGc
  model smartBuilding
    parameter Integer n = 5;
    Real Room[n](start = {7, 7, 7, 7, 7});
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
    parameter Real humans[n](start = {5.0, 6, 7, 8, 9.0});
    Real unCom[n](start = {0, 0, 0, 0, 0});
    Integer h[n](start = {0, 0, 0, 0, 0});
    //某房间是否有加热器
    Integer rh[n](start = {0, 0, 0, 0, 0});
    //房间i占用哪个加热器
    Integer need[n](start = {0, 0, 0, 0, 0});
    Integer heater[3](start = {0, 0, 0});
    //加热器i给哪个房间加热
    Integer j;
    Real allUn(start = 0), derAllUn(start = 0);
    Integer sortUn[n](start = {0, 0, 0, 0, 0});
    //Boolean
  equation
    for i in 1:n loop
      der(Room[i]) = b[i] * (7 - Room[i]) + c[i] * h[i];
      //unCom[i]= if Room[i]>=get[i] then 0 else (get[i]-Room[i])*humans[i];
    end for;
    der(allUn) = derAllUn;
  algorithm
    j := 0;
    derAllUn := 0;
    for i in 1:n loop
      when Room[i] < get[i] and h[i] < 1 then
        need[i] := 1;
      elsewhen Room[i] > on[i] then
        need[i] := 0;
      end when;
      if Room[i] < low[i] then
        unCom[i] := (low[i] - Room[i]) * humans[i];
        derAllUn := derAllUn + unCom[i];
      elseif Room[i] > low[i] then
        unCom[i] := 0;
      end if;
      j := if need[i] > 0 then j + 1 else j;
      if need[i] > 0 then
        for ii in 1:3 loop
          if heater[ii] < 1 then
            heater[ii] := i;
            h[i] := 1;
            rh[i] := ii;
            j := j - 1;
            break;
          end if;
        end for;
      else
        h[i] := 0;
        heater[rh[i]] := 0;
        rh[i] := 0;
      end if;
    end for;
    /*
                when Room[i] < low[i] then
                  unCom[i] := (get[i] - Room[i]) * humans[i];
                  allUn := allUn + unCom[i];
                elsewhen Room[i] > low[i] then
                  unCom[i] := 0;
                end when;
            */
    //释放加热器
    /*
                  for ii in 1:3 loop
                    heater[ii] := if heater[ii] == i then 0 else heater[ii];
                  end for;
                  */
    if j > 0 then
      sortUn := sort(5, unCom);
      for i in 1:n loop
        if need[sortUn[i]] == 1 then
          for k in n:i + 1 loop
            if rh[sortUn[k]] == 1 then
              heater[rh[sortUn[k]]] := i;
              h[sortUn[i]] := 1;
              h[sortUn[k]] := 0;
              rh[sortUn[i]] := rh[sortUn[k]];
              rh[sortUn[k]] := 0;
            end if;
          end for;
        end if;
      end for;
    else
      sortUn := {0, 0, 0, 0, 0};
    end if;
    //抢夺
    annotation(Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
  end smartBuilding;

  function sort
    input Integer n;
    input Real x[n];
    output Integer y[n];
    Integer t;
    Real tp[n];
  algorithm
    tp := x;
    for i in 1:n loop
      t := i;
      for j in 1:n loop
        if tp[t] < tp[j] then
          t := j;
        end if;
      end for;
      y[i] := t;
      tp[t] := -9e30;
    end for;
  end sort;

  model smartBuildingIni
    parameter Integer n = 5;
    Real Room[n](start = {7, 7, 7, 7, 7});
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
    parameter Real humans[n](start = {5.0, 6, 7, 8, 9.0});
    Real unCom[n](start = {0, 0, 0, 0, 0});
    Integer h[n](start = {0, 0, 0, 0, 0});
    //某房间是否有加热器
    Integer rh[n](start = {0, 0, 0, 0, 0});
    //房间i占用哪个加热器
    Integer need[n](start = {0, 0, 0, 0, 0});
    Integer heater[3](start = {0, 0, 0});
    //加热器i给哪个房间加热
    Integer j;
    Real allUn(start = 0), derAllUn(start = 0);
    Integer xzh(start = 3);
  equation
    for i in 1:n loop
      der(Room[i]) = b[i] * (6 - Room[i]) + c[i] * h[i];
      //unCom[i]= if Room[i]>=get[i] then 0 else (get[i]-Room[i])*humans[i];
    end for;
    der(allUn) = derAllUn;
  algorithm
    derAllUn := 0;
    j := 0;
    for i in 1:n loop
      when Room[i] < get[i] and h[i] < 1 then
        need[i] := 1;
      elsewhen Room[i] > on[i] then
        need[i] := 0;
      end when;
      if Room[i] < low[i] then
        unCom[i] := (low[i] - Room[i]) * humans[i];
        derAllUn := derAllUn + unCom[i];
      elseif Room[i] > low[i] then
        unCom[i] := 0;
      end if;
      j := if need[i] > 0 then j + 1 else j;
      if need[i] > 0 and h[i] == 0 then
        for ii in 1:3 loop
          if heater[ii] < 1 then
            heater[ii] := i;
            h[i] := 1;
            rh[i] := ii;
            j := j - 1;
            xzh := xzh - 1;
            break;
          end if;
        end for;
      else
        h[i] := 0;
        heater[rh[i]] := 0;
        rh[i] := 0;
        xzh := xzh + 1;
      end if;
    end for;
    /*
                  when Room[i] < low[i] then
                    unCom[i] := (get[i] - Room[i]) * humans[i];
                    allUn := allUn + unCom[i];
                  elsewhen Room[i] > low[i] then
                    unCom[i] := 0;
                  end when;
              */
    //need[i]:=0;
    //释放加热器
    /*
                      for ii in 1:3 loop
                        heater[ii] := if heater[ii] == i then 0 else heater[ii];
                      end for;
                      */
    annotation(Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
  end smartBuildingIni;
  annotation(Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
end smartBuildGc;