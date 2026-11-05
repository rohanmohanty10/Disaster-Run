  

 

local Util = require(script.Parent.Parent:WaitForChild("Util"));
local Signal = require(game.ReplicatedStorage.ReplicatedModules.KnitPackage.Signal);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 7
    -- upvalues: u1 (copy), Signal (copy)
    local v3 = setmetatable({}, u1);
    v3.Model = p2;
    v3.Loose = false;
    v3.Cracked = false;
    v3.CrackedSignal = Signal.new();

    return v3;
end;

function u1.SetCracked(p4, p5) -- Line: 18
    -- upvalues: Util (copy)
    Util.Assert(typeof(p5) == "boolean", "Provided argument is not datatype boolean");
    p4.Cracked = p5;

    if p5 then
        p4.CrackedSignal:Fire();
    end;
end;

function u1.SetLoose(p6, p7) -- Line: 26
    -- upvalues: Util (copy)
    Util.Assert(typeof(p7) == "boolean", "Provided argument is not datatype boolean");
    p6.Loose = p7;
end;

function u1.IsCracked(p8) -- Line: 31
    return p8.Cracked;
end;

function u1.IsLoose(p9) -- Line: 35
    return p9.Loose;
end;

function u1.GetBottom(p10) -- Line: 39
    return p10.Model:FindFirstChild("BottomPin");
end;

function u1.GetTop(p11) -- Line: 43
    return p11.Model:FindFirstChild("TopPin");
end;

function u1.GetModel(p12) -- Line: 47
    return p12.Model;
end;

return u1;