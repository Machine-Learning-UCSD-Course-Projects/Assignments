function val = smDer(V, x, i)
    smVal = sm(V, x, i)
    val = smVal(1 - smVal);
end