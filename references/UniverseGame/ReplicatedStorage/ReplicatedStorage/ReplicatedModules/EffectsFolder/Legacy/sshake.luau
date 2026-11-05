  

 

local u1 = 0;
local u2 = 0;

return function(p3, p4, p5) -- Line: 4
    -- upvalues: u1 (ref), u2 (ref)
    local v6 = not p5 and 1 or math.clamp((workspace.CurrentCamera.CFrame.p - p5).Magnitude, 10, (1 / 0)) / 10;

    if u1 < p4 then
        u2 = p3 / v6;
        u1 = p4;
    end;
end;