  

 

local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);
local GenericModule = require(PathShortcuts.GenericModule);
local u1 = {
    Easing = Enum.EasingStyle.Linear,
    Direction = Enum.EasingDirection.Out
};
local u3 = {
    Destroy = function(p2) -- Line: 14, Name: Destroy
        p2.Container:Destroy();
    end
};
u3.__index = u3;

return function(p4) -- Line: 22
    -- upvalues: u1 (copy), u3 (copy), GenericModule (copy), EffectsHandler (copy), TweenService (copy), RunService (copy)
    local Character = p4.Character;
    local Time = p4.Time;
    local v5 = p4.Transparency or 0;
    local v6 = p4.Amount or 2;
    local v7 = p4.Distance or 5;
    local v8 = p4.YDistance or 0;
    local v9 = p4.ZDistance or 0;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local u10 = TweenInfo.new(Time / 2, u1.Easing, u1.Direction);
    local Model = Instance.new("Model");
    Model.Parent = workspace.Effects;
    local u11 = setmetatable({
        Time = 0,
        Model = Character,
        Container = Model,
        CharacterParts = {},
        CharacterOthers = {},
        Afterimages = {}
    }, u3);
    local u12 = nil;

    for _, descendant in Character:GetDescendants() do
        if descendant:IsA("BasePart") and not descendant:GetAttribute("AfterimageIgnore") then
            table.insert(u11.CharacterParts, descendant);
        elseif descendant.Parent == Character and (descendant:IsA("Clothing") or (descendant:IsA("ShirtTemplate") or (descendant:IsA("CharacterMesh") or descendant:IsA("BodyColors")))) then
            table.insert(u11.CharacterOthers, descendant);
        end;
    end;

    if p4.HighlightData then
        u12 = Instance.new("Highlight");
        u12.Enabled = false;
        u12.Parent = Model;
        u12.FillTransparency = v5;
        u12.OutlineTransparency = v5;
        u12.DepthMode = Enum.HighlightDepthMode.Occluded;

        for i, v in p4.HighlightData do
            u12[i] = v;
        end;

        u12.Adornee = Model;
        u12.Enabled = true;
    end;

    for i = 1, v6 do
        local v13 = {
            Model = nil,
            Humanoid = nil,
            CharacterParts = {},
            CharacterTextures = {},
            CharacterOthers = {},
            Vector = i % 2 == 1 and Vector3.new(-1, v8, v9) or Vector3.new(1, v8, v9),
            Distance = v7 * math.round(i / 2)
        };
        local Model2 = Instance.new("Model");
        local Humanoid = Instance.new("Humanoid");
        Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
        Humanoid.EvaluateStateMachine = false;
        Humanoid.Parent = Model2;

        if i == 1 then
            for _, v in u11.CharacterParts do
                local v14 = Instance.fromExisting(v);

                for _, child in v:GetChildren() do
                    if child:IsA("DataModelMesh") or child:IsA("SurfaceAppearance") then
                        Instance.fromExisting(child).Parent = v14;
                    elseif child:IsA("Texture") or child:IsA("Decal") then
                        local v15 = Instance.fromExisting(child);
                        v15.Transparency = GenericModule.Lerp(v15.Transparency, 1, v5);
                        v15.Parent = v14;
                        table.insert(v13.CharacterTextures, v15);
                    end;
                end;

                v14.CollisionGroup = "Ghosted";
                v14.Anchored = true;
                v14.CanCollide = false;
                v14.CanTouch = false;
                v14.CanQuery = false;
                v14.Massless = true;
                v14.CastShadow = false;
                v14.Archivable = true;
                v14.Transparency = GenericModule.Lerp(v14.Transparency, 1, v5);
                table.insert(v13.CharacterParts, v14);
                v14.Parent = Model2;
            end;
        else
            for _, v in u11.Afterimages[1].CharacterParts do
                local v16 = v:Clone();
                v16.Parent = Model2;
                table.insert(v13.CharacterParts, v16);
            end;
        end;

        for _, v in u11.CharacterOthers do
            Instance.fromExisting(v).Parent = Model2;
        end;

        v13.Model = Model2;
        v13.Humanoid = Humanoid;
        Model2.Parent = Model;
        table.insert(u11.Afterimages, v13);
    end;

    task.spawn(function() -- Line: 144
        -- upvalues: EffectsHandler (ref), Time (copy), u11 (copy), TweenService (ref), u10 (copy), u12 (ref)
        EffectsHandler.Wait(Time / 2);

        for _, v in u11.Afterimages do
            for _, v2 in v.CharacterParts do
                TweenService:Create(v2, u10, {
                    Transparency = 1
                }):Play();
            end;

            for _, v2 in v.CharacterTextures do
                TweenService:Create(v2, u10, {
                    Transparency = 1
                }):Play();
            end;
        end;

        if u12 then
            TweenService:Create(u12, u10, {
                FillTransparency = 1,
                OutlineTransparency = 1
            }):Play();
        end;
    end);
    local u17 = nil;
    u17 = RunService.RenderStepped:Connect(function(p18) -- Line: 167
        -- upvalues: u11 (copy), TweenService (ref), Time (copy), u1 (ref), HumanoidRootPart (copy), u17 (ref)
        local v19 = u11;
        v19.Time = v19.Time + p18;

        for _, v in u11.Afterimages do
            for i, v2 in v.CharacterParts do
                local v20 = TweenService:GetValue(u11.Time / Time, u1.Easing, u1.Direction);

                if v20 < 1 then
                    v2.CFrame = v2.CFrame:Lerp(u11.CharacterParts[i].CFrame + HumanoidRootPart.CFrame:VectorToWorldSpace(v.Vector) * v.Distance, v20);
                elseif u17 then
                    u17:Disconnect();
                    u17 = nil;
                end;
            end;
        end;
    end);
    task.spawn(function() -- Line: 196
        -- upvalues: EffectsHandler (ref), Time (copy), Model (copy)
        EffectsHandler.Wait(Time);
        Model:Destroy();
    end);
end;