  

 

local RunService = game:GetService("RunService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local GenericModule = require(PathShortcuts.GenericModule);
local u1 = {};
local u2 = nil;

local function StateStepped(p3) -- Line: 13
    -- upvalues: u1 (copy)
    for i, v in u1 do
        if i:IsDescendantOf(workspace) then
            local PrimaryPart = i.PrimaryPart;

            if PrimaryPart and PrimaryPart.Parent then
                local v4 = i:GetAttribute("Flashtime") and 0.4 or 1;
                v.Phase = v.Phase + p3 * (40 * v4);
                local v5 = math.sin(v.Phase);
                local RightVector = PrimaryPart.CFrame.RightVector;
                local v6 = i:GetAttribute("Vanished") == true;

                if v6 ~= v.LastVanished then
                    v.LastVanished = v6;

                    for _, v2 in v.Afterimages do
                        for _, v3 in v2.CharacterParts do
                            if v3 and v3.Parent then
                                v3.Transparency = v6 and 1 or (v2.OriginalTransparency[v3] or 1);
                            end;
                        end;

                        for _, v3 in v2.CharacterTextures do
                            if v3 and v3.Parent then
                                v3.Transparency = v6 and 1 or (v2.OriginalTransparency[v3] or 1);
                            end;
                        end;
                    end;
                end;

                for _, v2 in v.Afterimages do
                    local v7 = RightVector * (v5 * 0.75 * v2.TheMethod);

                    for i2, v3 in v2.CharacterParts do
                        if v3 and v3.Parent then
                            local v8 = v.CharacterParts[i2];

                            if v8 and v8.Parent then
                                v3.CFrame = v8.CFrame + v7;
                            else
                                v3.Transparency = 1;
                            end;
                        end;
                    end;
                end;
            end;
        else
            v:Destroy();
        end;
    end;
end;

local u9 = { "Fire", "Sparkles", "Smoke", "ParticleEmitter", "Sound", "Trail", "Beam", "Attachment", "WeldConstraint", "BillboardGui" };

local function CleanInstance(p10, p11) -- Line: 71
    -- upvalues: u9 (copy), CleanInstance (ref)
    if p11:IsA("LuaSourceContainer") or (p11:IsA("JointInstance") or (p11:IsA("Constraint") or table.find(u9, p11.ClassName))) then
        p11:Destroy();

        return true;
    end;

    if p11:IsA("Decal") and not table.find(p10.CharacterTextures, p11) then
        table.insert(p10.CharacterTextures, p11);

        return;
    end;

    for _, child in p11:GetChildren() do
        CleanInstance(p10, child);
    end;
end;

local u13 = {
    __index = {
        Destroy = function(p12) -- Line: 85, Name: Destroy
            -- upvalues: u1 (copy)
            for _, v in p12.Afterimages do
                if v.Model and v.Model.Parent then
                    v.Model:Destroy();
                end;
            end;

            u1[p12.Model] = nil;
        end
    }
};

return function(p14, p15, p16) -- Line: 96
    -- upvalues: u1 (copy), u13 (copy), GenericModule (copy), u2 (ref), RunService (copy), StateStepped (copy)
    if not p15 then
        local v17 = u1[p14];

        if v17 then
            v17:Destroy();
        end;

        if not u2 or next(u1) ~= nil then
            return;
        end;

        u2:Disconnect();
        u2 = nil;

        return;
    end;

    if u1[p14] then
        return;
    end;

    local v18 = setmetatable({
        Phase = 0,
        LastVanished = nil,
        Model = p14,
        CharacterParts = {},
        CharacterOthers = {},
        Afterimages = {}
    }, u13);

    for _, descendant in p14:GetDescendants() do
        if descendant:IsA("BasePart") and not descendant:GetAttribute("AfterimageIgnore") then
            table.insert(v18.CharacterParts, descendant);
        end;
    end;

    for _, child in p14:GetChildren() do
        if child:IsA("Clothing") or (child:IsA("ShirtTemplate") or (child:IsA("CharacterMesh") or child:IsA("BodyColors"))) then
            table.insert(v18.CharacterOthers, child);
        end;
    end;

    local v19 = p14:GetAttribute("Vanished") == true;

    for i = 1, 2 do
        local v20 = {
            Model = nil,
            Humanoid = nil,
            TheMethod = i == 1 and -1 or 1,
            CharacterParts = {},
            CharacterTextures = {},
            CharacterOthers = {},
            OriginalTransparency = {}
        };
        local Model = Instance.new("Model");
        local Humanoid = Instance.new("Humanoid");
        Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
        Humanoid.EvaluateStateMachine = false;
        Humanoid.Parent = Model;

        if i == 1 then
            for _, v in v18.CharacterParts do
                if v and v.Parent then
                    local v21 = Instance.fromExisting(v);

                    for _, child in v:GetChildren() do
                        if child:IsA("DataModelMesh") or child:IsA("SurfaceAppearance") then
                            Instance.fromExisting(child).Parent = v21;
                        elseif child:IsA("Texture") then
                            local v22 = Instance.fromExisting(child);
                            v22.Parent = v21;
                            table.insert(v20.CharacterTextures, v22);
                        end;
                    end;

                    v21.CollisionGroup = "Ghosted";
                    v21.Anchored = true;
                    v21.CanCollide = false;
                    v21.CanTouch = false;
                    v21.CanQuery = false;
                    v21.Massless = true;
                    v21.CastShadow = false;
                    v21.Archivable = true;
                    local v23 = GenericModule.Lerp(v.Transparency, 1, p16 or 0.5);
                    v20.OriginalTransparency[v21] = v23;
                    v21.Transparency = v19 and 1 or v23;
                    table.insert(v20.CharacterParts, v21);
                    v21.Parent = Model;
                end;
            end;
        else
            for _, v in v18.Afterimages[1].CharacterParts do
                if v and v.Parent then
                    local v24 = v:Clone();
                    v24.Parent = Model;
                    local v25 = v18.Afterimages[1].OriginalTransparency[v] or v.Transparency;
                    v20.OriginalTransparency[v24] = v25;
                    v24.Transparency = v19 and 1 or v25;
                    table.insert(v20.CharacterParts, v24);
                end;
            end;
        end;

        for _, v in v20.CharacterTextures do
            local v26 = GenericModule.Lerp(v.Transparency, 1, p16 or 0.5);
            v20.OriginalTransparency[v] = v26;
            v.Transparency = v19 and 1 or v26;
        end;

        for _, v in v18.CharacterOthers do
            if v and v.Parent then
                Instance.fromExisting(v).Parent = Model;
            end;
        end;

        v20.Model = Model;
        v20.Humanoid = Humanoid;
        Model.Parent = workspace.Effects;
        table.insert(v18.Afterimages, v20);
    end;

    v18.LastVanished = v19;

    if not u2 then
        u2 = RunService.RenderStepped:Connect(StateStepped);
    end;

    u1[p14] = v18;
end;