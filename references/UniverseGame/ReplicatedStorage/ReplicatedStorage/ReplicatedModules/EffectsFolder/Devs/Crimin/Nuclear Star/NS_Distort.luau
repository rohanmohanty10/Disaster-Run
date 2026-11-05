  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
game.ReplicatedStorage:WaitForChild("Client Assets");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
local u1 = {};

return function(p2) -- Line: 11
    -- upvalues: u1 (copy), RunService (copy)
    local Character = p2.Character;

    if not Character then
        return;
    end;

    if u1[Character] then
        u1[Character].Percent = 1;

        return;
    end;

    local v3 = Character:FindFirstChildOfClass("Humanoid");
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local RootJoint = HumanoidRootPart:FindFirstChild("RootJoint");

    if not (v3 and RootJoint) then
        return;
    end;

    local u4 = v3:FindFirstChildOfClass("Animator");

    if not u4 then
        return;
    end;

    local u5 = p2.Rate or 2;
    local u6 = {
        Percent = p2.StartPercentage or 1,
        RootOffset = RootJoint.C0
    };
    local u7 = nil;
    u7 = RunService.PreSimulation:Connect(function(p8) -- Line: 32
        -- upvalues: u6 (copy), u5 (copy), u1 (ref), Character (copy), u7 (ref), u4 (copy), RootJoint (copy)
        local v9 = u6;
        v9.Percent = v9.Percent - p8 * u5;

        if u6.Percent > 0 then
            local v10 = #u4:GetPlayingAnimationTracks() > 0 and RootJoint.Transform or CFrame.identity;
            RootJoint.Transform = u6.RootOffset * CFrame.new((math.random() - 0.5) * u6.Percent, 0, (math.random() - 0.5) * u6.Percent):ToWorldSpace(u6.RootOffset) * v10;

            return;
        end;

        u1[Character] = nil;
        u7:Disconnect();
        u7 = nil;
    end);
end;