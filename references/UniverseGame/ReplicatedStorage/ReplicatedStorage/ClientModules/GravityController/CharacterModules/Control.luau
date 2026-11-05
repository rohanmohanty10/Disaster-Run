  

 

local u1 = {};
u1.__index = u1;
u1.ClassName = "Control";

function u1.new(p2) -- Line: 9
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    local PlayerModule = require(p2.Player.PlayerScripts:WaitForChild("PlayerModule"));
    v3.Controller = p2;
    v3.ControlModule = PlayerModule:GetControls();

    return v3;
end;

function u1.GetMoveVector(p4) -- Line: 23
    return p4.ControlModule:GetMoveVector();
end;

function u1.Destroy(p5) -- Line: 27
end;

return u1;