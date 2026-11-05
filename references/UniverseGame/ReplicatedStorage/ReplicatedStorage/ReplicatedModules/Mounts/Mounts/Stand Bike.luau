  

 

local u1 = game:GetService("ReplicatedStorage")["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
Knit.OnStart():await();
local u2 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
local u3 = Knit.GetService("EffectService");
game:GetService("CollectionService");
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local StatsHandler = require(PathShortcuts.ReplicatedModules.StatsHandler);

return {
    Inherit = "Bike",
    Animator = "MotorcycleAnimator",
    ItemId = "MOUNT_9",

    OnSetup = function(u4) -- Line: 23, Name: OnSetup
        -- upvalues: StatsHandler (copy), u1 (copy), ParticleHandler (copy), u2 (copy), u3 (copy)
        local Model = u4.Model;
        local Player = u4.Player;
        Model.PrimaryPart.Equip:Play();
        Model.PrimaryPart.IdleLoop:Play();
        local Value = Player.Data.Ability.Value;
        local v5 = Player.Data.Ability:GetAttribute("AbilityName");
        local v6 = Player.Data.Skin:GetAttribute("SkinName");
        local v7 = u4.Character:GetAttribute("MeterColor");
        local u8 = 0;

        if Player and Player.Data.Skin:GetAttribute("UnusualHueId") then
            u8 = u8 + Player.Data.Skin:GetAttribute("UnusualHueId") * 5;
        end;

        local u9 = StatsHandler.GetStats(v5, v6).Stats.Summon or {};
        local u10 = u9.AuraColor or u9.AuraColour;
        local Universal = u1.CustomAuras.Universal;

        local function AddAura(p11) -- Line: 47
            -- upvalues: u10 (copy), Universal (copy), u9 (copy)
            if not u10 then
                return;
            end;

            if not p11:FindFirstChild("BikeAura") then
                for _, child in Universal:GetChildren() do
                    local v12 = child:Clone();

                    for i, v in u9.Properties or {} do
                        v12[i] = v;
                    end;

                    v12.Color = u10;
                    v12.Enabled = true;
                    v12.Name = "BikeAura";
                    v12.Parent = p11;
                end;
            end;
        end;

        local function ColorShift(p13) -- Line: 66
            -- upvalues: ParticleHandler (ref), u8 (ref)
            for _, descendant in p13:GetDescendants() do
                pcall(function() -- Line: 68
                    -- upvalues: descendant (copy), ParticleHandler (ref), u8 (ref)
                    descendant.Color = ParticleHandler.HSVShift(descendant.Color, {
                        HueShift = u8
                    });
                end);

                if descendant:IsA("Decal") then
                    descendant.Color3 = ParticleHandler.HSVShift(descendant.Color3, {
                        HueShift = u8
                    });
                elseif descendant:IsA("DataModelMesh") then
                    local v14 = Color3.new(descendant.VertexColor.X, descendant.VertexColor.Y, descendant.VertexColor.Z);
                    local v15 = ParticleHandler.HSVShift(v14, {
                        HueShift = u8
                    });
                    descendant.VertexColor = Vector3.new(v15.R, v15.G, v15.B);
                end;
            end;
        end;

        if v7 then
            for _, child in Model:GetChildren() do
                if child:GetAttribute("Colorable") then
                    child.Color = v7;
                    AddAura(child);
                end;
            end;
        end;

        ColorShift(Model);
        Model.BikeHead.Transparency = 1;

        for _, v in { "SummonEffects", "SummonSound", "Summon-SFX", "Summon-Voiceline" } do
            u2.PlaySound(u4.Character, v);
        end;

        u4.Character.Humanoid.HipHeight = -1;
        u4.Trove:Add(function() -- Line: 107
            -- upvalues: u4 (copy)
            u4.Character.Humanoid.HipHeight = 0;
        end);
        local v16 = game:GetService("ServerStorage").StandModels:FindFirstChild(Value);

        if not v16 then
            return;
        end;

        local v17 = v16:FindFirstChild((v6 == nil or not v6) and "Model" or v6);

        if not (v17 and v17:FindFirstChild("Stand Head")) then
            return;
        end;

        local v18 = u4.Trove:Clone(v17);
        local v19 = v18["Stand Head"];
        local v20 = {};

        for _, descendant in v18:GetDescendants() do
            if (descendant:IsA("JointInstance") or (descendant:IsA("ManualWeld") or descendant:IsA("WeldConstraint"))) and (descendant.Part0 == v19 or descendant.Part1 == v19) and ((descendant.Part0 == nil or descendant.Part0.Name ~= "Stand Torso") and (descendant.Part1 == nil or descendant.Part1.Name ~= "Stand Torso")) then
                if descendant.Part0 ~= nil then
                    v20[descendant.Part0] = descendant;
                end;

                if descendant.Part1 ~= nil then
                    v20[descendant.Part1] = descendant;
                end;
            end;
        end;

        local SummonParticle = u4.Character:FindFirstChild("SummonParticle", true);

        if SummonParticle then
            u3.FireAllClients("Q_EMIT_AT", SummonParticle, u4.Character.HumanoidRootPart, nil, 4.5);
        end;

        v19.Anchored = true;
        AddAura(v19);
        local v21 = math.random(1, 1000000);
        local v22 = u4.Trove:Construct(Instance, "Model");
        v22.PrimaryPart = v19;
        v22.Name = v21;
        v22.Parent = workspace.Effects;

        for i, v in v20 do
            v.Parent = i;
            i.Parent = v22;
        end;

        if u8 > 0 then
            ParticleHandler.HSVShiftParticles(v22, {
                HueShift = u8
            });
        end;

        local v23 = u9.IgnoreParts or (u9.LeaveParts or {});
        local v24 = u9.CustomTransparency or {};
        ColorShift(v22);

        for _, descendant in v22:GetDescendants() do
            if not table.find(v23, descendant.Name) and (descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture"))) then
                local v25 = 0;

                if v24[descendant.Name] then
                    v25 = v24[descendant.Name].SummonTransparency or v25;
                end;

                descendant.Transparency = v25;
            end;
        end;

        v18:Destroy();
        v22:PivotTo(Model.BikeHead.CFrame);
        u3.FireAllClients("Transform StandBike Head", u4.Character, v21);
    end
};