  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(ReplicatedStorage.ReplicatedModules.Types);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
require(game.ReplicatedStorage.ClientLibrary.BoatTween);
local v1 = RaycastParams.new();
v1.FilterType = Enum.RaycastFilterType.Include;
v1.FilterDescendantsInstances = { workspace.Map };
local _ = Fusion.Value;
local _ = Fusion.Observer;
local _ = Fusion.New;
local u2 = Random.new();

local function Rng(p3, p4) -- Line: 31
    -- upvalues: u2 (copy)
    return u2:NextNumber(p3, p4);
end;

local LocalPlayer = Players.LocalPlayer;
local u5 = {};

local function GenerateBonePath(p6) -- Line: 38
    local u7 = { p6 };

    local function Scan(p8) -- Line: 41
        -- upvalues: u7 (copy), Scan (copy)
        for _, child in p8:GetChildren() do
            if child:IsA("Bone") and child.Name:find("ArmBone") then
                table.insert(u7, child);
                Scan(child);

                return;
            end;
        end;
    end;

    Scan(p6);

    return u7;
end;

local function PulseTransparency(p9) -- Line: 56
    return (p9 - 0.45) ^ 2 * 6;
end;

return function(u10, p11) -- Line: 61
    -- upvalues: u5 (copy), LocalPlayer (copy), AssetHandler (copy), Trove (copy), ParticleHandler (copy), RunService (copy)
    if u5[u10] then
        if LocalPlayer:DistanceFromCharacter(u10:GetPivot().Position) >= 200 then
            print("Distance high, destroying");
            u5[u10]:Destroy();
            u5[u10] = nil;
        end;

        return;
    end;

    if not (u10 and u10.Parent) then
        return;
    end;

    if LocalPlayer:DistanceFromCharacter(u10:GetPivot().Position) >= 200 then
        return;
    end;

    local v12 = AssetHandler.GetAbilityData(u10);
    u10:FindFirstChild("HumanoidRootPart");
    local AbilityModel = p11.AbilityModel;

    if not (AbilityModel and AbilityModel.PrimaryPart) then
        return;
    end;

    local u13 = AssetHandler.GetAsset("Models/ArmTriangle", v12);
    local v14 = AbilityModel.PrimaryPart:FindFirstChild("DeltaArmBone.L", true);
    local u15 = { v14 };

    local function u17(p16) -- Line: 41
        -- upvalues: u15 (copy), u17 (copy)
        for _, child in p16:GetChildren() do
            if child:IsA("Bone") and child.Name:find("ArmBone") then
                table.insert(u15, child);
                u17(child);

                return;
            end;
        end;
    end;

    u17(v14);
    local v18 = AbilityModel.PrimaryPart:FindFirstChild("DeltaArmBone.R", true);
    local u19 = { v18 };

    local function u21(p20) -- Line: 41
        -- upvalues: u19 (copy), u21 (copy)
        for _, child in p20:GetChildren() do
            if child:IsA("Bone") and child.Name:find("ArmBone") then
                table.insert(u19, child);
                u21(child);

                return;
            end;
        end;
    end;

    u21(v18);
    local v22 = Trove.new();
    v22:AttachToInstance(u10);
    local u23 = {};
    local u24 = 1.65;
    local u25 = 0;

    local function GeneratePulse(p26, p27) -- Line: 100
        -- upvalues: u13 (copy), ParticleHandler (ref), u10 (copy), u23 (copy)
        if not p26 or #p26 < 2 then
            warn("Not enough segments");

            return;
        end;

        local v28 = Instance.fromExisting(u13);
        v28.Size = v28.Size * 1.45;
        ParticleHandler.Unusualify(v28, {
            IncludeParts = true,
            Character = u10
        });
        v28.Parent = workspace.Effects;
        local v29 = #p26;
        local _ = 2 / v29;
        table.insert(u23, {
            v28,
            p26,
            v29,
            0,
            p27 or 1
        });
    end;

    local function UpdateCores() -- Line: 123
        -- upvalues: u10 (copy), u24 (ref)
        local v30 = (u10:GetAttribute("Cores") or 0) / 5;
        u24 = math.lerp(1.65, 0.5, v30);
    end;

    v22:Connect(RunService.Heartbeat, function(p31) -- Line: 128, Name: Update
        -- upvalues: u25 (ref), u24 (ref), GeneratePulse (copy), u15 (copy), u19 (copy), u23 (copy)
        if u24 <= u25 then
            GeneratePulse(u15, 1);
            GeneratePulse(u19, -1);
            u25 = 0;
        end;

        for i, v in u23 do
            local v32 = v[1];
            local v33 = v[2];
            local v34 = v[3];
            local v35 = v[4];
            local v36 = v[5];
            local v37 = v35 / 2;
            local v38 = v37 * v34;
            local v39 = math.floor(v38) + 1;
            local v40 = v33[v39];
            local v41 = v33[v39 + 1];

            if v34 < v39 + 1 then
                table.remove(u23, i);
                table.clear(v);
                v32:Destroy();
            else
                v32.Transparency = (v37 - 0.45) ^ 2 * 6;
                v32.CFrame = v40.WorldCFrame:Lerp(v41.WorldCFrame, v38 - (v39 - 1)) * CFrame.Angles(0, 5.811946409141117 * v35 * v36, 0) * CFrame.new(0, 0, v32.Size.Z * 0.16666666);
                v[4] = v[4] + p31;

                if v[4] >= 2 then
                    table.remove(u23, i);
                    table.clear(v);
                    v32:Destroy();
                end;
            end;
        end;

        u25 = u25 + p31;
    end);
    v22:Connect(u10:GetAttributeChangedSignal("Cores"), UpdateCores);
    v22:Add(function() -- Line: 172
        -- upvalues: u23 (copy)
        for _, v in u23 do
            if v[1] then
                v[1]:Destroy();
            end;
        end;
    end);
    local v42 = (u10:GetAttribute("Cores") or 0) / 5;
    u24 = math.lerp(1.65, 0.5, v42);
    u5[u10] = v22;
end;