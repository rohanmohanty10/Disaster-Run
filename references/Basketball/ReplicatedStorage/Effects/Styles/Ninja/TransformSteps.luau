 
 

require("@game/ReplicatedStorage/Shared/Utility/ForgeVFX");
local u1 = require("@game/ReplicatedStorage/Shared/Utility/SfxManager");
local RunService = game:GetService("RunService");
local u2 = require("@game/ReplicatedStorage/Packages/Janitor");

return function(p3: any, p4: table) -- Line: 8
    -- upvalues: u2 (copy), RunService (copy), u1 (copy)
    local Character = p4.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;

    if Character == nil or HumanoidRootPart == nil then
        return;
    end;

    local KuramaTransformation = Character:FindFirstChild("KuramaTransformation");

    if KuramaTransformation == nil then
        return;
    end;

    local _ = workspace:GetServerTimeNow() - p4.TimeSent;
    local v5 = u2.new();
    v5:LinkToInstance(KuramaTransformation);
    local u6 = tick();
    v5:Add(RunService.Heartbeat:Connect(function() -- Line: 30
        -- upvalues: HumanoidRootPart (copy), KuramaTransformation (copy), u6 (ref), u1 (ref)
        if HumanoidRootPart == nil or KuramaTransformation == nil then
            return;
        end;

        if tick() - u6 <= 0.6166666666666667 then
            return;
        end;

        if HumanoidRootPart.AssemblyLinearVelocity.Magnitude < 5 then
            return;
        end;

        u6 = tick();
        u1:playSound({
            Sound = "BBZ Ninja Nine Tails Steps",
            Parent = HumanoidRootPart
        });
        task.delay(0.4, function() -- Line: 47
            -- upvalues: HumanoidRootPart (ref), u1 (ref)
            if HumanoidRootPart.AssemblyLinearVelocity.Magnitude < 5 then
                return;
            end;

            u1:playSound({
                Sound = "BBZ Ninja Nine Tails Steps",
                Parent = HumanoidRootPart
            });
        end);
    end));
end;