  

 

local RunService = game:GetService("RunService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local GenericModule = require(PathShortcuts.GenericModule);
local u1 = {};
local u2 = nil;

local function StateStepped(p3) -- Line: 9
    -- upvalues: u1 (copy)
    for i, v in u1 do
        if i:IsDescendantOf(workspace) then
            v.Time = v.Time + p3 * 3.5;

            for _, v2 in v.Afterimages do
                for i2, v3 in v2.CharacterParts do
                    local CFrame = v.CharacterParts[i2].CFrame;
                    local v4 = math.noise(v2.NoiseX1, v2.NoiseY1, v.Time);
                    local v5 = math.noise(v2.NoiseX2, v2.NoiseY2, v.Time);
                    v3.CFrame = CFrame + Vector3.new(v4, v5, math.noise(v2.NoiseX3, v2.NoiseY3, v.Time)) * 1.65;
                end;
            end;
        else
            v:Destroy();
        end;
    end;
end;

local u6 = { "Fire", "Sparkles", "Smoke", "ParticleEmitter", "Sound", "Trail", "Beam", "Attachment", "WeldConstraint", "BillboardGui" };

local function CleanInstance(p7, p8) -- Line: 31
    -- upvalues: u6 (copy), CleanInstance (ref)
    if p8:IsA("LuaSourceContainer") or (p8:IsA("JointInstance") or (p8:IsA("Constraint") or table.find(u6, p8.ClassName))) then
        p8:Destroy();

        return true;
    end;

    if p8:IsA("Decal") and not table.find(p7.CharacterTextures, p8) then
        table.insert(p7.CharacterTextures, p8);

        return;
    end;

    for _, child in p8:GetChildren() do
        CleanInstance(p7, child);
    end;
end;

local u10 = {
    __index = {
        Destroy = function(p9) -- Line: 45, Name: Destroy
            -- upvalues: u1 (copy)
            for _, v in p9.Afterimages do
                v.Model:Destroy();
            end;

            u1[p9.Model] = nil;
        end
    }
};

return function(p11, p12) -- Line: 52
    -- upvalues: u1 (copy), u10 (copy), GenericModule (copy), u2 (ref), RunService (copy), StateStepped (copy)
    if not p12 then
        local v13 = u1[p11];

        if v13 then
            v13:Destroy();
        end;

        if not u2 or next(u1) ~= nil then
            return;
        end;

        u2:Disconnect();
        u2 = nil;

        return;
    end;

    if u1[p11] then
        return;
    end;

    local v14 = setmetatable({
        Time = 0,
        Model = p11,
        CharacterParts = {},
        CharacterOthers = {},
        Afterimages = {}
    }, u10);

    for _, descendant in p11:GetDescendants() do
        if descendant:IsA("BasePart") and not descendant:GetAttribute("AfterimageIgnore") then
            table.insert(v14.CharacterParts, descendant);
        end;
    end;

    for _, child in p11:GetChildren() do
        if child:IsA("Clothing") or (child:IsA("ShirtTemplate") or (child:IsA("CharacterMesh") or child:IsA("BodyColors"))) then
            table.insert(v14.CharacterOthers, child);
        end;
    end;

    for i = 1, 3 do
        local v15 = {
            Model = nil,
            Humanoid = nil,
            NoiseX1 = math.random() * 10000,
            NoiseY1 = math.random() * 10000,
            NoiseX2 = math.random() * 10000,
            NoiseY2 = math.random() * 10000,
            NoiseX3 = math.random() * 10000,
            NoiseY3 = math.random() * 10000,
            CharacterParts = {},
            CharacterTextures = {},
            CharacterOthers = {}
        };
        local Model = Instance.new("Model");
        local Humanoid = Instance.new("Humanoid");
        Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
        Humanoid:ChangeState(Enum.HumanoidStateType.Physics);
        Humanoid.EvaluateStateMachine = false;
        Humanoid.Parent = Model;

        if i == 1 then
            for _, v in v14.CharacterParts do
                local v16 = Instance.fromExisting(v);

                for _, child in v:GetChildren() do
                    if child:IsA("DataModelMesh") or child:IsA("SurfaceAppearance") then
                        Instance.fromExisting(child).Parent = v16;
                    elseif child:IsA("Texture") then
                        local v17 = Instance.fromExisting(child);
                        v17.Parent = v16;
                        table.insert(v15.CharacterTextures, v17);
                    end;
                end;

                v16.CollisionGroup = "Ghosted";
                v16.Anchored = true;
                v16.CanCollide = false;
                v16.CanTouch = false;
                v16.CanQuery = false;
                v16.Massless = true;
                v16.CastShadow = false;
                v16.Archivable = true;
                v16.Transparency = GenericModule.Lerp(v.Transparency, 1, 0.7);
                table.insert(v15.CharacterParts, v16);
                v16.Parent = Model;
            end;
        else
            for _, v in v14.Afterimages[1].CharacterParts do
                local v18 = v:Clone();
                v18.Parent = Model;
                table.insert(v15.CharacterParts, v18);
            end;
        end;

        for _, v in v15.CharacterTextures do
            v.Transparency = GenericModule.Lerp(v.Transparency, 1, 0.7);
        end;

        for _, v in v14.CharacterOthers do
            Instance.fromExisting(v).Parent = Model;
        end;

        v15.Model = Model;
        v15.Humanoid = Humanoid;
        Model.Parent = workspace.Effects;
        table.insert(v14.Afterimages, v15);
    end;

    if not u2 then
        u2 = RunService.RenderStepped:Connect(StateStepped);
    end;

    u1[p11] = v14;
end;