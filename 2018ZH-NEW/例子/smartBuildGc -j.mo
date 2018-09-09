package smartBuildGc
  model smartBuilding
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
    Integer need[n](start = {0, 0, 0, 0, 0});
    Integer heater[3](start = {0, 0, 0});
    //加热器i给哪个房间加热
    Integer j;
    Real allUn(start = 0), derAllUn(start = 0);
    Integer sortUn[n](start = {0, 0, 0, 0, 0}), sortUn2[n](start = {0, 0, 0, 0, 0});
    Integer xzh(start = 3);
    parameter Real u(start = 6);
  equation
    for i in 1:n loop
      der(Room[i]) = derRoom[i];
    end for;
    der(allUn) = derAllUn;
  algorithm
    for i in 1:n loop
      derRoom[i] := 0;
      for j in 1:n loop
        derRoom[i] := derRoom[i] + adj[i, j] * (Room[j] - Room[i]);
      end for;
      derRoom[i] := derRoom[i] + b[i] * (u - Room[i]) + c[i] * h[i];
    end for;
    //每个房间温度导数的计算
    //+b[i] * (u - Room[i]) + c[i] * h[i];
    derAllUn := 0;
    j := 0;
    for i in 1:n loop
      when Room[i] < get[i] and h[i] < 1 then
        need[i] := 1;
      elsewhen Room[i] >= on[i] then
        need[i] := 0;
      end when;
      if Room[i] < low[i] then
        unCom[i] := (low[i] - Room[i]) * humans[i];
        derAllUn := derAllUn + unCom[i];
      elseif Room[i] >= low[i] then
        derAllUn := derAllUn - unCom[i];
        unCom[i] := 0;
      end if;
      j := if need[i] > 0 then j + 1 else j;
      if Room[i] < get[i] and h[i] == 0 and humans[i] > 0 then
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
      elseif Room[i] >= on[i] or need[i] == 0 or humans[i] == 0 then
        xzh := if h[i] == 1 then xzh + 1 else xzh;
        h[i] := 0;
        heater[rh[i]] := 0;
        rh[i] := 0;
      end if;
    end for;
    //need[i]==1
    //need[i]==0
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
    //抢夺
    if j > 0 then
      sortUn := sort(5, unCom);
      sortUn2 := sort2(5, unCom);
      for i in 1:n loop
        if need[sortUn[i]] > 0 then
          for k in 1:n - i - 1 loop
            if rh[sortUn2[k]] == 1 then
              heater[rh[sortUn2[k]]] := i;
              h[sortUn[i]] := 1;
              h[sortUn2[k]] := 0;
              rh[sortUn[i]] := rh[sortUn2[k]];
              rh[sortUn2[k]] := 0;
            end if;
          end for;
        end if;
      end for;
    else
      sortUn := {0, 0, 0, 0, 0};
    end if;
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
        if tp[i] < tp[j] then
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
    Integer need[n](start = {0, 0, 0, 0, 0});
    Integer heater[3](start = {0, 0, 0});
    //加热器i给哪个房间加热
    Integer j;
    Real allUn(start = 0), derAllUn(start = 0);
    Integer xzh(start = 3);
    parameter Real u(start = 6);
  equation
    for i in 1:n loop
      //每个房间温度所满足的ODE
      der(Room[i]) = derRoom[i];
    end for;
    der(allUn) = derAllUn;
    //不舒适度满足的ODE
  algorithm
    for i in 1:n loop
      derRoom[i] := 0;
      for j in 1:n loop
        derRoom[i] := derRoom[i] + adj[i, j] * (Room[j] - Room[i]);
      end for;
      derRoom[i] := derRoom[i] + b[i] * (u - Room[i]) + c[i] * h[i];
    end for;
    //每个房间温度导数的计算
    //+b[i] * (u - Room[i]) + c[i] * h[i];
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
        derAllUn := derAllUn - unCom[i];
        unCom[i] := 0;
      end if;
      j := if need[i] > 0 then j + 1 else j;
      if noEvent(Room[i] < get[i] and h[i] == 0 and humans[i] > 0) then
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
      elseif Room[i] >= on[i] or need[i] == 0 or humans[i] == 0 then
        xzh := if h[i] == 1 then xzh + 1 else xzh;
        h[i] := 0;
        heater[rh[i]] := 0;
        rh[i] := 0;
      end if;
    end for;
    //判断某个房间是否需要加热
    //计算不舒适度的倒数值 derAllUn
    //为第i个房间分配加热器
    //if need[i]>0 then
    //分配成功
    //房间i释放加热器
    //elseif need[i]==0 then
    //need[i]==1
    //need[i]==0
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

  function sort2
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
        if tp[i] > tp[j] then
          t := j;
        end if;
      end for;
      y[i] := t;
      tp[t] := -9e30;
    end for;
  end sort2;

  model smartBuildingNo
    parameter Integer n = 5;
    Real Room[n](start = {7, 7, 7, 7, 7});
    Real derRoom[n](start = {0, 0, 0, 0, 0});
    parameter Real adj[5, 5] = {{0.00, 0.40, 0.00, 0.00, 0.50}, {0.4, 0, 0.2, 0.2, 0}, {0, 0.2, 0, 0.5, 0}, {0.00, 0.20, 0.50, 0.00, 0.40}, {0.50, 0.00, 0.00, 0.40, 0.00}};
    parameter Real b[n](start = {0.25, 0.35, 0.10, 0.15, 0.45});
    parameter Real c[n](start = {10.0, 7.0, 10.0, 11.0, 9.0});
    parameter Real humans[n](start = {5.0, 0, 7, 8, 9.0});
    parameter Integer h[n](start = {0, 0, 0, 0, 0});
    Real allUn(start = 0), energy(start = 0);
    parameter Real derAllUn(start = 0);
    parameter Real derEnergy(start = 0);
    Real Gauss1, Gauss2, Gauss3;
    parameter Real e = 2.71828;
    Real u(start = 6);
    Real t;
  equation
    for i in 1:n loop
      //每个房间温度所满足的ODE
      der(Room[i]) = derRoom[i];
    end for;
    der(allUn) = derAllUn;
    der(energy) = derEnergy;
    //不舒适度满足的ODE
    t = YuShu(time);
    //t=time;
    Gauss1 = -(t - 24.01) / 11.58 * ((t - 24.01) / 11.58);
    Gauss2 = -(t - 14.24) / 6.194 * ((t - 14.24) / 6.194);
    Gauss3 = -(t + 1.212) / 5.069 * ((t + 1.212) / 5.069);
    u = 3.868 * pow(e, Gauss1) + 8.556 * pow(e, Gauss2) + 6.057 * pow(e, Gauss3);
  algorithm
    for i in 1:n loop
      derRoom[i] := 0;
      for j in 1:n loop
        derRoom[i] := derRoom[i] + adj[i, j] * (Room[j] - Room[i]);
      end for;
      derRoom[i] := derRoom[i] + b[i] * (u - Room[i]) + c[i] * h[i];
    end for;
    annotation(Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
    annotation(Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
  end smartBuildingNo;

  function Gaussian "Release storage"
    input Real x;
    output Real res;
  
    external "C" res = Gaussian(x) annotation(IncludeDirectory = "E://Modelica//CFunction", Include = "#include \"Random.c\"");
    annotation(Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
  end Gaussian;

  function Gaussian2
    input Real x;
    output Real sum;
    Real PI = 3.1415926535897;
    Real w, y = 0, z, b = 1;
    Integer n = 1, a = 1, m = 1;
  algorithm
    while n < 101 loop
      w := pow(x, n);
      z := a * w / (b * n);
      y := y + z;
      a := -1 * a;
      b := b * 2 * m;
      m := m + 1;
      n := n + 2;
    end while;
    //printf("%30.25f\n%d!!=%30.25f\n",z,2*m,b); //用于查看中途计算出得数据;
    sum := 0.5 + y / sqrt(2 * PI);
    annotation(Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
  end Gaussian2;

  function pow
    input Real x;
    input Real y;
    output Real res;
  algorithm
    res := exp(y * log(x));
    annotation(Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
  end pow;

  function YuShu
    input Real x;
    output Real y;
  algorithm
    if x >= 96 then
      y := x - 96;
    elseif x >= 72 then
      y := x - 72;
    elseif x >= 48 then
      y := x - 48;
    elseif x >= 24 then
      y := x - 24;
    else
      y := x;
    end if;
    annotation(Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
  end YuShu;
  annotation(Diagram(coordinateSystem(extent = {{-148.5, -105}, {148.5, 105}}, preserveAspectRatio = true, initialScale = 0.1, grid = {5, 5})));
end smartBuildGc;