  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local GenericModule = require(PathShortcuts.GenericModule);
local ClientAssets = PathShortcuts.ClientAssets;
local Trove = require(Knit.Util.Trove);

return function(p1, p2) -- Line: 9
    -- upvalues: Trove (copy), ClientAssets (copy), GenericModule (copy)
    local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local TSWalk = HumanoidRootPart:FindFirstChild("TSWalk");

    if not p2 then
        if TSWalk then
            TSWalk:Destroy();
        end;

        return;
    end;

    if TSWalk then
        return;
    end;

    local v3 = Trove.new();
    local u4 = ClientAssets.Combat.TSWalk.TSWalk:Clone();
    u4.Parent = HumanoidRootPart;
    v3:AttachToInstance(u4);
    v3:Connect(game:GetService("RunService").Heartbeat, function(p5) -- Line: 39
        -- upvalues: HumanoidRootPart (copy), u4 (ref), GenericModule (ref)
        local v6 = math.clamp((HumanoidRootPart.Velocity * Vector3.new(1, 0, 1)).Magnitude / 32, 0, 1);
        u4.ParticleTimestop.Rate = GenericModule.Lerp(0, 6, v6);
    end);
end;