 
 

local workspace_InPoint2ElectricBoogaloo = workspace.InPoint2ElectricBoogaloo;
local BigBlock = workspace_InPoint2ElectricBoogaloo.Away.BigBlock;
local SmallBlock = workspace_InPoint2ElectricBoogaloo.Away.SmallBlock;
local Cylinder = workspace_InPoint2ElectricBoogaloo.Away.Cylinder;
local BigBlock2 = workspace_InPoint2ElectricBoogaloo.Home.BigBlock;
local SmallBlock2 = workspace_InPoint2ElectricBoogaloo.Home.SmallBlock;
local Cylinder2 = workspace_InPoint2ElectricBoogaloo.Home.Cylinder;

return function(p1, p2) -- Line: 13, Name: positionIsInTwoPointZone
    -- upvalues: BigBlock2 (copy), SmallBlock2 (copy), Cylinder2 (copy), BigBlock (copy), SmallBlock (copy), Cylinder (copy)
    local v3 = nil;
    local v4 = nil;
    local v5 = nil;

    if p1 == "Home" or p1 == "Ranked" then
        v3 = BigBlock2;
        v4 = SmallBlock2;
        v5 = Cylinder2;
    elseif p1 == "Away" then
        v3 = BigBlock;
        v4 = SmallBlock;
        v5 = Cylinder;
    else
        error((`{p1} (type={typeof(p1)}) is not the name of a hoop! Try "Home", "Ranked", or "Away".`));
    end;

    if typeof(p2) ~= "Vector3" then
        error((`{p2} is not a Vector3!`));
    end;

    local v6 = p2 - v5.Position;

    if v6.X ^ 2 + v6.Z ^ 2 > (0.5 * v5.Size.Z) ^ 2 then
        return false;
    end;

    local v7 = 0.5 * v4.Size.X;
    local v8 = 0.5 * v4.Size.Z;
    local v9 = p2 - v4.Position;
    local v10 = 0.5 * v3.Size.Z;
    local v11;

    if -v7 <= v9.X and (v9.X <= v7 and -v8 <= v9.Z) then
        v11 = v9.Z <= v8;
    else
        v11 = false;
    end;

    local v12;

    if -v7 <= v9.X and (v9.X <= v7 and -v10 <= v9.Z) then
        v12 = v9.Z <= v10;
    else
        v12 = false;
    end;

    return (not v12 or v11) and true or false;
end;