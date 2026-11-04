 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
game:GetService("SoundService");
game:GetService("TweenService");
game:GetService("Lighting");
local RunService = game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.util.Util);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
require(ReplicatedStorage.util.UwUEffects);
require(ReplicatedStorage.forum.trove);
require(ReplicatedStorage.client.replication.TekrinnDialogue);
require(ReplicatedStorage.client.replication.BezierCurve);
require(ReplicatedStorage.util.soundUtil);
require(ReplicatedStorage.util.actionUtil);
require(ReplicatedStorage.util.animationUtil);
require(ReplicatedStorage.util.MoonPropertyAnimator);
local Util = require(ReplicatedStorage.util.Util);
require(ReplicatedStorage.VfxHandler);
require(ReplicatedStorage.wiki.styles);
require(ReplicatedStorage.util.KatUtil);
require(ReplicatedStorage.util.MoonPropertyAnimator);
local _ = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;
local Random_new_ret = Random.new();
local u1 = {};

local function Lerp(p2, p3, p4) -- Line: 35
    return p2 + p4 * (p3 - p2);
end;

local u5 = { "ParticleEmitter", "Sound", "Trail", "Beam", "HumanoidRootPart", "Ball", "Flashstep", "Dash", "SpotlightPart" };
RunService.PostSimulation:Connect(function(p6) -- Line: 51
    -- upvalues: u1 (copy), Random_new_ret (copy)
    for i, v in u1 do
        if i:IsDescendantOf(workspace) then
            local v7 = v;

            for _, v2 in v.Afterimages do
                local v8 = v2;

                for i2, v3 in v2.CharacterParts do
                    local CFrame = v7.CharacterParts[i2].CFrame;
                    local v9 = Random_new_ret:NextNumber(0, 0.4) * v8.Multiplier;
                    local v10 = Random_new_ret:NextNumber(-0.1, 0.1);
                    local v11 = Random_new_ret:NextNumber(0, 0.4) * -v8.Multiplier;
                    v3.CFrame = CFrame + Vector3.new(v9, v10, v11);
                end;
            end;
        else
            v:Destroy();
        end;
    end;
end);

local function CleanInstance(p12: any, p13: userdata) -- Line: 70
    -- upvalues: u5 (copy), CleanInstance (copy)
    if table.find(u5, p13.ClassName) or table.find(u5, p13.Name) then
        p13:Destroy();

        return true;
    end;

    if p13:IsA("Decal") and not table.find(p12.CharacterTextures, p13) then
        table.insert(p12.CharacterTextures, p13);

        return;
    end;

    for _, child in p13:GetChildren() do
        CleanInstance(p12, child);
    end;
end;

local u15 = {
    __index = {
        Destroy = function(p14) -- Line: 88, Name: Destroy
            -- upvalues: u1 (copy)
            for _, v in p14.Afterimages do
                v.Model:Destroy();
            end;

            u1[p14.Model] = nil;
        end
    }
};

return function(p16) -- Line: 97
    -- upvalues: u1 (copy), u15 (copy), u5 (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy)
    if not p16.Enabled then
        local v17 = u1[p16.Character];

        if not v17 then
            return;
        end;

        v17:Destroy();

        return;
    end;

    if u1[p16.Character] then
        return;
    end;

    local v18 = setmetatable({
        Model = p16.Character,
        CharacterParts = {},
        CharacterOthers = {},
        Afterimages = {}
    }, u15);
    local v19 = p16.Exclude or {};

    for _, descendant in p16.Character:GetDescendants() do
        if descendant:IsA("BasePart") and not (table.find(u5, descendant.ClassName) or table.find(u5, descendant.Name)) then
            local v20 = descendant;
            local v21 = false;

            for _, v in next, v19 do
                if v20:IsDescendantOf(v) then
                    v21 = true;
                    break;
                end;
            end;

            if v21 == false then
                table.insert(v18.CharacterParts, v20);
            end;
        end;
    end;

    for _, child in p16.Character:GetChildren() do
        if child:IsA("Clothing") or (child:IsA("ShirtTemplate") or (child:IsA("CharacterMesh") or child:IsA("BodyColors"))) then
            local v22 = child;

            for _, v in next, v19 do
                v22:IsDescendantOf(v);
            end;

            table.insert(v18.CharacterOthers, v22);
        end;
    end;

    for i = 1, 2 do
        local v23 = {
            Model = nil,
            Humanoid = nil,
            Multiplier = i == 1 and -1 or 1,
            CharacterParts = {},
            CharacterTextures = {},
            CharacterOthers = {}
        };
        local Model = Instance.new("Model");
        local Humanoid = Instance.new("Humanoid");
        Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
        Humanoid.EvaluateStateMachine = false;
        Humanoid.Parent = Model;
        local v24;

        if i == 1 then
            v24 = i;

            for _, v in v18.CharacterParts do
                local Instance_fromExisting_ret = Instance.fromExisting(v);

                if Instance_fromExisting_ret.Name == "HumanoidRootPart" then
                    return;
                end;

                for _, child in v:GetChildren() do
                    if child:IsA("DataModelMesh") or child:IsA("SurfaceAppearance") then
                        Instance.fromExisting(child).Parent = Instance_fromExisting_ret;
                    elseif child:IsA("Texture") then
                        local Instance_fromExisting_ret2 = Instance.fromExisting(child);
                        Instance_fromExisting_ret2.Parent = Instance_fromExisting_ret;
                        table.insert(v23.CharacterTextures, Instance_fromExisting_ret2);
                    end;
                end;

                Instance_fromExisting_ret.CollisionGroup = "none";
                Instance_fromExisting_ret.Anchored = true;
                Instance_fromExisting_ret.CanCollide = false;
                Instance_fromExisting_ret.CanTouch = false;
                Instance_fromExisting_ret.CanQuery = false;
                Instance_fromExisting_ret.Massless = true;
                Instance_fromExisting_ret.CastShadow = false;
                Instance_fromExisting_ret.Archivable = true;
                local Transparency = v.Transparency;
                Instance_fromExisting_ret.Transparency = Transparency + 0.7 * (0.8 - Transparency);
                table.insert(v23.CharacterParts, Instance_fromExisting_ret);
                Instance_fromExisting_ret.Parent = Model;
            end;
        else
            v24 = i;

            for _, v in v18.Afterimages[1].CharacterParts do
                local v25 = v:Clone();
                v25.Parent = Model;
                table.insert(v23.CharacterParts, v25);
            end;
        end;

        for _, v in v23.CharacterTextures do
            local Transparency = v.Transparency;
            v.Transparency = Transparency + 0.7 * (0.8 - Transparency);
        end;

        for _, v in v18.CharacterOthers do
            Instance.fromExisting(v).Parent = Model;
        end;

        v23.Model = Model;
        v23.Humanoid = Humanoid;
        Model.Parent = workspace.Effects;

        if Util.canshiftcolor(LocalPlayer, p16.Character) then
            vfxUtil.LeanTowardsColor(Model, p16.Character:GetAttribute("CustomColor") or Color3.fromRGB(102, 213, 90), p16.Character:GetAttribute("CustomAlpha") or 0.985);
        end;

        table.insert(v18.Afterimages, v23);
    end;

    u1[p16.Character] = v18;
end;