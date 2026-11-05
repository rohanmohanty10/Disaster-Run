  

 

local _ = math.rad;
local u1 = {
    Angles = {
        ["Meshes/LightningSpear2"] = CFrame.Angles(0, 1.5707963267948966, 0)
    }
};

function u1.Orient(p2) -- Line: 12
    -- upvalues: u1 (copy)
    if type(p2) == "userdata" and u1.Angles[p2.Name] then
        print(u1.Angles[p2.Name]);
        p2.CFrame = CFrame.new(p2.CFrame.Position) * u1.Angles[p2.Name];
    end;
end;

function u1.GetRotation(p3) -- Line: 19
    -- upvalues: u1 (copy)
    if not u1.Angles[p3.Name] then
        warn(p3.Name, "angle doesn\'t exist");
    end;

    return u1.Angles[p3.Name];
end;

return u1;