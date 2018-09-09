function MyRandom "Release storage"
  input Integer fw;
  output Integer res;

  external "C" res = Random(fw) annotation(IncludeDirectory = "E://Modelica//CFunction", Include = "#include \"Random.c\"");
end MyRandom;