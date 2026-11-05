  

 

local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local GenericModule = require(PathShortcuts.GenericModule);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = nil;
local u2 = nil;
Knit.OnStart():andThen(function() -- Line: 12
    -- upvalues: u1 (ref), PathShortcuts (copy), u2 (ref)
    u1 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware);
    u2 = u1.GetMiddleware("CombatService");
end);
local LocalPlayer = Players.LocalPlayer;
local u3 = { "Anything", "Chaos Chaos", "Meta", "Laughter", "Neo Chaos" };
local u4 = {};
local u5 = nil;

local function IsExtraEnabled(p6) -- Line: 61
    -- upvalues: Players (copy), LocalPlayer (copy)
    local v7 = Players:GetPlayerFromCharacter(p6);

    if not (v7 and (v7.Settings and v7.Settings.PoseExtrasVisibility)) then
        return true;
    end;

    local Value = v7.Settings.PoseExtrasVisibility.Value;

    if Value >= 3 then
        return false;
    end;

    return Value < 2 and true or p6 == LocalPlayer.Character;
end;

local function StateStepped(p8) -- Line: 78
    -- upvalues: u4 (copy), u3 (copy), u2 (ref), GenericModule (copy)
    for i, v in u4 do
        if i:IsDescendantOf(workspace) then
            local v9 = os.clock();

            if v9 - v.LastSoundTime >= 5 then
                v.LastSoundTime = v9;

                if math.random() <= 0.3333333333333333 then
                    local v10 = {};

                    for _, v2 in u3 do
                        if v2 ~= v.LastPlayedSound then
                            table.insert(v10, v2);
                        end;
                    end;

                    if #v10 > 0 then
                        local v11 = v10[math.random(1, #v10)];
                        u2.PlaySound(i, v11);
                        v.LastPlayedSound = v11;
                    elseif #u3 > 1 then
                        v.LastPlayedSound = nil;
                        local v12 = u3[math.random(1, #u3)];
                        u2.PlaySound(i, v12);
                        v.LastPlayedSound = v12;
                    end;
                end;
            end;

            local v13 = #v.Afterimages;

            if v.RampData then
                local v14 = (os.clock() - v.StartTime) / v.RampData.RampDuration;
                local v15 = math.clamp(v14, 0, 1) * #v.Afterimages;
                local v16 = math.floor(v15);
                v13 = math.max(1, v16);
            end;

            for i2, v2 in v.Afterimages do
                if v13 < i2 then
                    for _, v3 in v2.CharacterParts do
                        v3.Transparency = 1;
                    end;

                    for _, v3 in v2.CharacterTextures do
                        v3.Transparency = 1;
                    end;
                else
                    local v17 = v2.OrbitRadius * 1;

                    for i3, v3 in v2.CharacterParts do
                        local v18 = os.clock() * v2.FrequencyX;
                        local v19 = os.clock() * v2.FrequencyZ;
                        local v20 = os.clock() * 0.25;
                        local v21 = math.sin(v18 + v2.AngleOffset) * v2.OrbitRadius;
                        local v22 = math.cos(v19 + v2.AngleOffset) * v2.OrbitRadius;
                        local v23 = math.sin(v20) * 0.15;
                        local v24 = Vector3.new(v21 * 1, v23 * 1, v22 * 1);
                        v3.CFrame = v.CharacterParts[i3].CFrame + v24;
                        local v25 = math.min(v24.Magnitude / v17, 1);
                        local v26 = math.max(0.5, v.CharacterParts[i3].Transparency);
                        v3.Transparency = GenericModule.Lerp(v26, 1, v25 * 0.99);
                    end;

                    for i3, v3 in v2.CharacterTextures do
                        if v2.CharacterParts[i3] then
                            local v27 = math.min((v2.CharacterParts[i3].CFrame.Position - v.CharacterParts[i3].CFrame.Position).Magnitude / v17, 1);
                            v3.Transparency = GenericModule.Lerp(0, 1, v27 * 0.99);
                        end;
                    end;
                end;
            end;
        else
            v:Destroy();
        end;
    end;
end;

local u28 = { "Fire", "Sparkles", "Smoke", "ParticleEmitter", "Sound", "Trail", "Beam", "Attachment", "WeldConstraint", "BillboardGui" };

local function CleanInstance(p29, p30) -- Line: 170
    -- upvalues: u28 (copy), CleanInstance (ref)
    if p30:IsA("LuaSourceContainer") or (p30:IsA("JointInstance") or (p30:IsA("Constraint") or table.find(u28, p30.ClassName))) then
        p30:Destroy();

        return true;
    end;

    if p30:IsA("Decal") and not table.find(p29.CharacterTextures, p30) then
        table.insert(p29.CharacterTextures, p30);

        return;
    end;

    for _, child in p30:GetChildren() do
        CleanInstance(p29, child);
    end;
end;

local u32 = {
    __index = {
        Destroy = function(p31) -- Line: 184, Name: Destroy
            -- upvalues: u4 (copy)
            for _, v in p31.Afterimages do
                v.Model:Destroy();
            end;

            u4[p31.Model] = nil;
        end
    }
};

return function(p33, p34, p35, p36) -- Line: 191
    -- upvalues: u4 (copy), Players (copy), LocalPlayer (copy), u32 (copy), GenericModule (copy), u5 (ref), RunService (copy), StateStepped (copy)
    if not p34 then
        local v37 = u4[p33];

        if v37 then
            v37:Destroy();
        end;

        if not u5 or next(u4) ~= nil then
            return;
        end;

        u5:Disconnect();
        u5 = nil;

        return;
    end;

    if u4[p33] then
        return;
    end;

    local v38 = Players:GetPlayerFromCharacter(p33);
    local v39;

    if v38 and (v38.Settings and v38.Settings.PoseExtrasVisibility) then
        local Value = v38.Settings.PoseExtrasVisibility.Value;

        if Value >= 3 then
            v39 = false;
        else
            v39 = Value < 2 and true or p33 == LocalPlayer.Character;
        end;
    else
        v39 = true;
    end;

    if not v39 then
        return;
    end;

    local v40 = {
        LastPlayedSound = nil,
        Model = p33,
        CharacterParts = {},
        CharacterOthers = {},
        Afterimages = {},
        LastSoundTime = os.clock(),
        StartTime = os.clock(),
        RampData = p36
    };
    local v41 = setmetatable(v40, u32);

    for _, descendant in p33:GetDescendants() do
        if descendant:IsA("BasePart") and not descendant:GetAttribute("AfterimageIgnore") then
            table.insert(v41.CharacterParts, descendant);
        end;
    end;

    for _, child in p33:GetChildren() do
        if child:IsA("Clothing") or (child:IsA("ShirtTemplate") or (child:IsA("CharacterMesh") or child:IsA("BodyColors"))) then
            table.insert(v41.CharacterOthers, child);
        end;
    end;

    local v42 = Players:GetPlayerFromCharacter(p33);
    local v43 = 6;

    if v42 and v42:FindFirstChild("PersonalUnlocker") then
        v43 = v43 * 3;
    end;

    for i = 1, v43 do
        local v44 = {
            Model = nil,
            Humanoid = nil,
            AngleOffset = (i - 1) * (6.283185307179586 / v43),
            OrbitRadius = 1 + (i - 1) * 1.5,
            FrequencyX = 4 + i * 0.5,
            FrequencyZ = 4 + i * 0.4,
            CharacterParts = {},
            CharacterTextures = {},
            CharacterOthers = {}
        };
        local Model = Instance.new("Model");
        local Humanoid = Instance.new("Humanoid");
        Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
        Humanoid.EvaluateStateMachine = false;
        Humanoid.Parent = Model;

        if i == 1 then
            for _, v in v41.CharacterParts do
                local v45 = Instance.fromExisting(v);

                for _, child in v:GetChildren() do
                    if child:IsA("DataModelMesh") or child:IsA("SurfaceAppearance") then
                        Instance.fromExisting(child).Parent = v45;
                    elseif child:IsA("Texture") then
                        local v46 = Instance.fromExisting(child);
                        v46.Parent = v45;
                        table.insert(v44.CharacterTextures, v46);
                    end;
                end;

                v45.CollisionGroup = "Ghosted";
                v45.Anchored = true;
                v45.CanCollide = false;
                v45.CanTouch = false;
                v45.CanQuery = false;
                v45.Massless = true;
                v45.CastShadow = false;
                v45.Archivable = true;
                v45.Transparency = GenericModule.Lerp(v.Transparency, 1, (p35 or 0.5) + (0.1 + (i - 1) * 0.1));
                table.insert(v44.CharacterParts, v45);
                v45.Parent = Model;
            end;
        else
            for _, v in v41.Afterimages[1].CharacterParts do
                local v47 = v:Clone();
                v47.Transparency = GenericModule.Lerp(v47.Transparency, 1, 0.1 + (i - 1) * 0.1);
                v47.Parent = Model;
                table.insert(v44.CharacterParts, v47);
            end;
        end;

        for _, v in v44.CharacterTextures do
            v.Transparency = GenericModule.Lerp(v.Transparency, 1, (p35 or 0.5) + (0.1 + (i - 1) * 0.1));
        end;

        for _, v in v41.CharacterOthers do
            Instance.fromExisting(v).Parent = Model;
        end;

        v44.Model = Model;
        v44.Humanoid = Humanoid;
        Model.Parent = workspace.Effects;
        table.insert(v41.Afterimages, v44);
    end;

    if not u5 then
        u5 = RunService.RenderStepped:Connect(StateStepped);
    end;

    u4[p33] = v41;
end;