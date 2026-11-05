  

 

local _ = game.ReplicatedStorage["Client Assets"];
game:GetService("TweenService");
game:GetService("Debris");
local _ = CFrame.Angles;
local _ = math.rad;
local _ = math.random;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);

local function raycastMap(p1, p2, p3) -- Line: 12
    local v4 = RaycastParams.new();
    local v5 = {};

    for _, descendant in ipairs(workspace.Map:GetDescendants()) do
        if descendant:IsA("BasePart") and descendant.CanCollide then
            table.insert(v5, descendant);
        end;
    end;

    v4.FilterDescendantsInstances = v5;
    v4.FilterType = Enum.RaycastFilterType.Include;
    local v6 = workspace:Raycast(p1, p2, v4);

    if p3 then
        return v6;
    end;

    if v6 then
        return v6.Position, v6.Instance;
    end;

    return p1;
end;

return function(p7, p8, p9, p10) -- Line: 34
    -- upvalues: AssetHandler (copy), ParticleHandler (copy)
    local _ = task.wait;
    local HumanoidRootPart = p7:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local v11 = p10 and {
        HueShift = p10
    } or nil;
    local v12 = AssetHandler.CloneAsset("BreakThroughTrail", {
        AbilityName = "Dawn",
        SkinName = p9
    });
    local v13 = ParticleHandler.GetSkinInfo(p9);
    local v14 = type(v13) == "table" and ((v13.Aura or {}).HSVShift or (v13.Metadata or {}).HSVShift);

    if v14 then
        ParticleHandler.HSVShiftParticles(v12, v14);
    end;

    if v11 then
        ParticleHandler.HSVShiftParticles(v12, v11);
    end;

    local u15 = Random.new();

    for _ = 1, 5 do
        local u16 = v12:Clone();
        local u17 = u15:NextNumber(3, 10);
        local u18 = u15:NextNumber(-1.5, 2.5);
        u16.CFrame = HumanoidRootPart.CFrame;
        u16.Parent = workspace.Effects;
        task.delay(p8, function() -- Line: 66
            -- upvalues: u16 (copy)
            for _, descendant in ipairs(u16:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;

            task.delay(3, u16.Destroy, u16);
        end);
        task.spawn(function() -- Line: 74
            -- upvalues: u15 (copy), u16 (copy), HumanoidRootPart (copy), u17 (copy), u18 (copy)
            local v19 = u15:NextInteger(1, 2) == 1 and 1 or -1;
            local v20 = u15:NextNumber(180, 360);
            local v21 = 0;

            while u16.Parent do
                v21 = v21 + task.wait() * v20 * v19;
                local CFrame2 = HumanoidRootPart.CFrame;
                local new = CFrame.new;
                local v22 = math.rad(v21);
                local v23 = math.cos(v22) * u17;
                local v24 = math.rad(v21);
                u16.CFrame = CFrame2 * new(v23, u18, math.sin(v24) * u17);
            end;
        end);
    end;

    v12:Destroy();
end;