  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local Players = game:GetService("Players");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(ReplicatedStorage.ReplicatedModules.Types);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local v1 = RaycastParams.new();
v1.FilterType = Enum.RaycastFilterType.Include;
v1.FilterDescendantsInstances = { workspace.Map };
local Petal = _G.Petal;
Petal("Util");
Petal("New");
local v2 = Petal("Extensions");
local _ = Fusion.Value;
local _ = Fusion.Observer;
local Rng = v2.Rng;
local u3 = {};
local LocalPlayer = Players.LocalPlayer;

return function(u4) -- Line: 32
    -- upvalues: u3 (copy), Trove (copy), EffectsHandler (copy), Rng (copy), ParticleHandler (copy), AssetHandler (copy), LocalPlayer (copy)
    if u3[u4] then
        return;
    end;

    if not u4 then
        return;
    end;

    local Petal2 = _G.Petal;
    Petal2("Util");
    Petal2("New");
    Petal2("Extensions");
    local u5 = Trove.new();
    local u6 = {};
    local u7 = u4:GetAttribute("Crystal_Shards");
    local u8 = u5:Construct(Instance, "Folder");
    u8.Parent = workspace.Effects;
    u8.Name = "Shards";

    local function ShardDestroyEffect(u9) -- Line: 54
        -- upvalues: EffectsHandler (ref), Rng (ref), u4 (copy), ParticleHandler (ref)
        EffectsHandler.CallEffect("Emit Particle V3", {
            Path = "Particles/DestroyShard",
            AutoSerialize = true,
            Origin = u9.CFrame,
            Scale = 1.5 + Rng(-0.15, 0.15),
            Character = u4
        });

        if not u9:FindFirstChild("Destroy_Effect") then
            return;
        end;

        ParticleHandler.EmitFromAttribute(u9:FindFirstChild("Destroy_Effect"));
        task.delay(0.5, function() -- Line: 67
            -- upvalues: u9 (ref)
            u9:Destroy();
            u9 = nil;
        end);
    end;

    local function CreateShard() -- Line: 75
        -- upvalues: AssetHandler (ref), u4 (copy), u8 (copy), ParticleHandler (ref), u6 (copy), u5 (copy)
        local v10 = AssetHandler.CloneAsset("Models/Crystal Shard", AssetHandler.GetAbilityData(u4));

        if not v10 then
            return;
        end;

        v10.CFrame = u4:GetPivot();
        v10.Parent = u8;
        v10:SetAttribute("OriginalSize", v10.Size);
        ParticleHandler.Unusualify(v10, {
            IncludeSurfaces = true,
            Character = u4
        });
        table.insert(u6, v10);
        u5:Add(v10);
    end;

    local function DestroyShard(p11) -- Line: 88
        -- upvalues: u6 (copy), ShardDestroyEffect (copy), u5 (copy)
        if u6[p11] then
            ShardDestroyEffect(u6[p11]);
            u5:Remove(u6[p11]);
            table.remove(u6, p11);
        end;
    end;

    for _ = 1, u7 do
        CreateShard();
    end;

    u5:Connect(u4:GetAttributeChangedSignal("Crystal_Shards"), function() -- Line: 100
        -- upvalues: u4 (copy), u7 (ref), u6 (copy), ShardDestroyEffect (copy), u5 (copy), CreateShard (copy)
        local v12 = u4:GetAttribute("Crystal_Shards");

        if not v12 then
            return;
        end;

        local v13 = v12 - u7;

        if v13 < 0 then
            for i = u7, v12 + 1, -1 do
                if u6[i] then
                    ShardDestroyEffect(u6[i]);
                    u5:Remove(u6[i]);
                    table.remove(u6, i);
                end;
            end;

            return;
        end;

        if v13 > 0 then
            for _ = u7 + 1, v12 do
                CreateShard();
            end;
        end;
    end);
    u3[u4] = true;
    local v14 = 0;
    local v15 = 1;

    while u4 and (u4.Parent and u4:GetAttribute("Crystal_Shards")) do
        local v16 = task.wait();

        if not u4 or (not u4.Parent or (not u4:GetAttribute("Crystal_Shards") or u4:GetAttribute("Posing"))) then
            break;
        end;

        local HumanoidRootPart = u4:FindFirstChild("HumanoidRootPart");

        if not HumanoidRootPart or LocalPlayer:DistanceFromCharacter(HumanoidRootPart.Position) >= 250 then
            break;
        end;

        local v17 = u4:GetAttribute("HideShards");
        u7 = #u6;

        for i = 1, #u6 do
            local v18 = u6[i];
            local v19 = math.rad(360 / u7 * i) + math.rad(v14 * 60);
            local v20 = v17 and 0 or 4;
            local Position = HumanoidRootPart.Position;
            local v21 = v20 * math.cos(v19);
            local v22 = math.cos(v19) * 0.7 * math.sin(v14 / 2);
            local v23 = v20 * math.sin(v19);
            local v24 = Position + Vector3.new(v21, v22, v23);
            v18.CFrame = v18.CFrame:Lerp(CFrame.new(v24, HumanoidRootPart.Position) * CFrame.Angles(0, 1.5707963267948966, 0) * CFrame.Angles(-math.rad(v14 * 85 - i * 12), 0, 0), 0.55);
            v15 = 1;
        end;

        v14 = v14 + v16 * v15;
    end;

    u3[u4] = nil;
    u8:Destroy();
    u5:Destroy();
    table.clear(u6);
end;