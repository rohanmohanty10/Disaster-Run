  

 

local Maid = require(script.Parent.Utility.Maid);
local Signal = require(script.Parent.Utility.Signal);
local u1 = {
    [Enum.HumanoidStateType.Running] = true
};
local _ = {
    [Enum.HumanoidStateType.Jumping] = true,
    [Enum.HumanoidStateType.Freefall] = true
};
local u2 = {
    onFreefall = "onFreeFall"
};
local u3 = {};
u3.__index = u3;
u3.ClassName = "StateTracker";

function u3.new(p4) -- Line: 27
    -- upvalues: u3 (copy), Maid (copy), Signal (copy)
    local v5 = setmetatable({}, u3);
    v5._maid = Maid.new();
    v5.Controller = p4;
    v5.State = Enum.HumanoidStateType.Running;
    v5.Speed = 0;
    v5.Jumped = false;
    v5.JumpTick = os.clock();
    v5.Animation = require(p4.Character:WaitForChild("Animate"):WaitForChild("Controller"));
    v5.Changed = Signal.new();
    init(v5);

    return v5;
end;

function init(u6)
    -- upvalues: u2 (copy)
    u6._maid:Mark(u6.Changed);
    u6._maid:Mark(u6.Changed:Connect(function(p7, p8) -- Line: 51
        -- upvalues: u6 (copy), u2 (ref)
        local v9 = "on" .. p7.Name;
        u6.Animation[u2[v9] or v9](p8);
    end));
end;

function u3.Update(p10, p11, p12, p13) -- Line: 60
    -- upvalues: u1 (copy)
    local Velocity = p10.Controller.HRP.Velocity;
    local v14 = Velocity:Dot(p11);
    local State = p10.State;
    local Speed = p10.Speed;
    local Magnitude = Velocity.Magnitude;
    local v15;

    if p12 then
        if p10.Jumped and os.clock() - p10.JumpTick > 0.1 then
            p10.Jumped = false;
        end;

        Magnitude = (Velocity - v14 * p11).Magnitude;
        v15 = Enum.HumanoidStateType.Running;
    elseif v14 > 0 then
        if p10.Jumped then
            v15 = Enum.HumanoidStateType.Jumping;
        else
            v15 = Enum.HumanoidStateType.Freefall;
        end;
    else
        if p10.Jumped then
            p10.Jumped = false;
        end;

        v15 = Enum.HumanoidStateType.Freefall;
    end;

    local v16 = p13 and Magnitude and Magnitude or 0;

    if State ~= v15 or u1[v15] and math.abs(v16 - Speed) > 0.1 then
        p10.State = v15;
        p10.Speed = v16;
        p10.Changed:Fire(v15, v16);
    end;
end;

function u3.RequestJump(p17) -- Line: 100
    p17.Jumped = true;
    p17.JumpTick = os.clock();
end;

function u3.Destroy(p18) -- Line: 105
    p18._maid:Sweep();
end;

return u3;