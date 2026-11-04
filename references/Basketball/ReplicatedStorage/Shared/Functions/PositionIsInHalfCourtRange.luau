 
 

return function(p1, p2) -- Line: 1, Name: positionIsInHalfCourtRange
    local v3 = nil;

    if p1 == "Home" or p1 == "Ranked" then
        v3 = workspace.Hoops.Home.Hoop.Position;
    elseif p1 == "Away" then
        v3 = workspace.Hoops.Away.Hoop.Position;
    else
        error((`{p1} (type={typeof(p1)}) is not the name of a hoop! Try "Home", "Ranked", or "Away".`));
    end;

    if typeof(p2) ~= "Vector3" then
        error((`{p2} is not a Vector3!`));
    end;

    return math.abs(p2.X - v3.X) > 126;
end;