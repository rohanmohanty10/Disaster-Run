 
 

game:GetService("RunService");
game:GetService("TweenService");
game:GetService("ReplicatedStorage");
game:GetService("Players");
local u1 = require("@game/ReplicatedStorage/Packages/Janitor");
local u2 = require("@game/ReplicatedStorage/Shared/Utility/SfxManager");

return function(p3: any, p4: table) -- Line: 11
    -- upvalues: u1 (copy), u2 (copy)
    local TimeSent = p4.TimeSent;
    local v5 = workspace:GetServerTimeNow() - TimeSent;
    local math_max_ret = math.max(2 - v5, 0);

    if math_max_ret <= 0.1 then
        return;
    end;

    local HumanoidRootPart = p4.Character.HumanoidRootPart;
    local u6 = u1.new();
    u6:Add(task.delay(math_max_ret, function() -- Line: 25
        -- upvalues: u6 (copy)
        u6:Destroy();
    end));
    u2:playSound({
        Sound = "BBZ Ninja Ninja Run",
        Parent = HumanoidRootPart
    }).TimePosition = v5;

    for _, child in script.vfx:GetChildren() do
        local u7 = child:Clone();
        u6:Add(function() -- Line: 34
            -- upvalues: u7 (copy)
            u7.Enabled = false;
            task.delay(2, u7.Destroy, u7);
        end);
        u7.Parent = HumanoidRootPart;
        u7.Enabled = true;
    end;
end;