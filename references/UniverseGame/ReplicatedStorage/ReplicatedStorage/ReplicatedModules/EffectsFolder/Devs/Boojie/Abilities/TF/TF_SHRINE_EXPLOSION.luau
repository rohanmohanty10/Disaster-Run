  

 

if game:GetService("RunService"):IsServer() then
    return function() -- Line: 2
    end;
end;

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local Promise = require(Knit.Util.Promise);
require(Knit.Util.TableUtil);
local GenericModule = require(PathShortcuts.GenericModule);
local BoatTween = require(game.ReplicatedStorage.ClientLibrary.BoatTween);
local Fusion = require(game.ReplicatedStorage.ClientLibrary.Fusion);
local Value = Fusion.Value;
local _ = Fusion.Observer;
local Computed = Fusion.Computed;
local _ = Fusion.ForKeys;
local _ = Fusion.ForValues;
local _ = Fusion.ForPairs;
local _ = Fusion.New;
local Hydrate = Fusion.Hydrate;
local _ = Fusion.Children;
local _ = Fusion.OnEvent;
local _ = Fusion.OnChange;
local _ = Fusion.Out;
local _ = Fusion.Ref;
local _ = Fusion.Cleanup;
local Tween = Fusion.Tween;
local Spring = Fusion.Spring;
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
local EffectsHandler = require(ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = EffectsHandler.GetEffect("Emit Particle V3");
local FlipbookTable = require(script.FlipbookTable);

local function SetVisible(p2, p3) -- Line: 33
    -- upvalues: SetVisible (copy)
    if not (p2:IsA("ParticleEmitter") or (p2:IsA("Beam") or p2:IsA("Trail"))) then
        for _, child in pairs(p2:GetChildren()) do
            SetVisible(child, p3);
        end;

        return;
    end;

    local v4 = p2:GetAttribute("OriginalEnabled");

    if not v4 then
        p2:SetAttribute("OriginalEnabled", p2.Enabled);
        v4 = p2.Enabled;
    end;

    p2.Enabled = v4 and p3 and p3 or false;
end;

local function FlipbookMesh(u5, u6) -- Line: 48
    local u7 = #u6;
    local u8 = 0;
    local u9 = 0;
    task.spawn(function() -- Line: 55
        -- upvalues: u5 (copy), u9 (ref), u8 (ref), u7 (copy), u6 (copy)
        while u5 and u5:IsDescendantOf(workspace) do
            u9 = u9 + task.wait();

            if u9 >= 0.125 then
                u9 = u9 - 0.125;
                u8 = u8 + 1;

                if u7 < u8 then
                    break;
                end;

                u5.TextureId = u6[u8];
            end;
        end;
    end);
end;

return function(p10) -- Line: 71
    -- upvalues: FlipbookTable (copy), AssetHandler (copy), Trove (copy), BoatTween (copy), Promise (copy), SetVisible (copy), ParticleHandler (copy), u1 (copy), Value (copy), Hydrate (copy), Tween (copy), Computed (copy), GenericModule (copy), Spring (copy)
    local u11 = p10 or {};
    local u12 = u11.Origin or CFrame.identity;
    local v13 = u11.Directory or "Particles/Open/ExplosionPillar";
    local u14 = u11.FlipbookTable or FlipbookTable;
    local u15 = (typeof(v13) ~= "string" or not AssetHandler.GetAsset(v13, u11)) and "Particles/Open/ExplosionPillar" or v13;
    local u16 = Trove.new();

    local function TweenObject(p17, p18) -- Line: 81
        -- upvalues: u16 (copy), BoatTween (ref)
        u16:Add(BoatTween:Create(p17, p18)):Play();
    end;

    Promise.try(function() -- Line: 86
        -- upvalues: AssetHandler (ref), u11 (copy), u16 (copy), u12 (copy), SetVisible (ref), ParticleHandler (ref), u1 (ref), Value (ref), Hydrate (ref), Tween (ref), Computed (ref), GenericModule (ref), Spring (ref), BoatTween (ref), u15 (ref), u14 (copy)
        local u19 = AssetHandler.CloneAsset("Particles/Open/ExplosionCharge", u11);

        if u19 then
            u16:Add(u19);
            u19:PivotTo(u12);
            SetVisible(u19, false);

            if u11.HSVData then
                ParticleHandler.Unusualify(u19, {
                    IncludeParts = true,
                    HSVData = u11.HSVData
                });
            end;

            u1({
                Enabled = false,
                Clone = false,
                Destroy = false,
                Parent = false,
                Particle = u19,
                AbilityName = u11.AbilityName,
                SkinName = u11.SkinName,
                Player = u11.Player,
                Character = u11.Character
            });
            u19.Parent = workspace.Effects;
            u19.Orb.Transparency = 1;
            local u20 = {
                Transparency = Value(1),
                Scale = Value(0.01)
            };
            local v21 = Value(TweenInfo.new(0.5, Enum.EasingStyle.Sine));
            local Brightness = u19.Orb.FXBottom.PointLight.Brightness;
            local Range = u19.Orb.FXBottom.PointLight.Range;
            Hydrate(u19.Orb.FXBottom.PointLight)({
                Brightness = Tween(Computed(function() -- Line: 126
                    -- upvalues: GenericModule (ref), Brightness (copy), u20 (copy)
                    return GenericModule.Lerp(Brightness, 0, u20.Transparency:get());
                end), v21),
                Range = Spring(Computed(function() -- Line: 129
                    -- upvalues: Range (copy), u20 (copy)
                    return Range * u20.Scale:get();
                end), 1)
            });
            local u22 = {};

            for _, descendant in pairs(u19:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant:SetAttribute("OriginalTransparency", descendant.Transparency);
                    descendant.Transparency = NumberSequence.new(1);
                    table.insert(u22, descendant);
                end;
            end;

            u19:ScaleTo(u20.Scale:get());
            u19.Parent = workspace.Effects;
            u16:Add(BoatTween:Create(u19.Orb, {
                Time = 0.25,
                EasingStyle = "Linear",
                StepType = "Heartbeat",
                Goal = {
                    Transparency = 0.25
                }
            })):Play();

            for _, v in pairs(u22) do
                u16:Add(BoatTween:Create(v, {
                    Time = 0.25,
                    EasingStyle = "Linear",
                    StepType = "Heartbeat",
                    Goal = {
                        Transparency = v:GetAttribute("OriginalTransparency")
                    }
                })):Play();
            end;

            SetVisible(u19, true);
            local u23 = Spring(u20.Scale, 6, 7.5);
            u16:Connect(game:GetService("RunService").RenderStepped, function(p24) -- Line: 169
                -- upvalues: u23 (copy), u19 (copy), u12 (ref)
                local _currentValue = u23._currentValue;
                local v25 = u19:GetScale() - _currentValue;

                if math.abs(v25) > 0.005 then
                    u19:ScaleTo(_currentValue);
                    u19:PivotTo(u12);
                end;
            end);
            u20.Scale:set(10);
            task.delay(5, function() -- Line: 179
                -- upvalues: u19 (copy), u16 (ref), BoatTween (ref), u22 (copy)
                u16:Add(BoatTween:Create(u19.Orb, {
                    Time = 1,
                    EasingStyle = "Circ",
                    EasingDirection = "Out",
                    StepType = "Heartbeat",
                    Goal = {
                        Transparency = 1
                    }
                })):Play();

                for _, v in pairs(u22) do
                    u16:Add(BoatTween:Create(v, {
                        Time = 1,
                        EasingStyle = "Circ",
                        EasingDirection = "Out",
                        StepType = "Heartbeat",
                        Goal = {
                            Transparency = NumberSequence.new(1)
                        }
                    })):Play();
                end;

                for _, descendant in pairs(u19:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        u16:Add(BoatTween:Create(descendant, {
                            Time = 1,
                            EasingStyle = "Circ",
                            EasingDirection = "Out",
                            StepType = "Heartbeat",
                            Goal = {
                                Transparency = NumberSequence.new(1)
                            }
                        })):Play();
                    end;
                end;
            end);
        end;

        local u26 = {
            Width = Value(0.01),
            Height = Value(1),
            Speed = Value(10),
            Dampening = Value(12),
            Orientation = Value(0),
            Transparency = Value(0)
        };
        local v27 = {};
        local u28 = u16:Clone(AssetHandler.GetAsset(u15, u11));
        u28:PivotTo(u12);

        if u11.HSVData then
            ParticleHandler.Unusualify(u28, {
                IncludeParts = true,
                HSVData = u11.HSVData
            });
        end;

        SetVisible(u28, false);
        u1({
            Enabled = false,
            Clone = false,
            Destroy = false,
            Parent = false,
            Particle = u28,
            AbilityName = u11.AbilityName,
            SkinName = u11.SkinName,
            Player = u11.Player,
            Character = u11.Character
        });

        for _, descendant in pairs(u28:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant:SetAttribute("OriginalTransparency", descendant.Transparency);
                descendant.Transparency = NumberSequence.new(1);
                table.insert(v27, descendant);
            end;
        end;

        for _, child in pairs(u28.Beam:GetChildren()) do
            if child:IsA("MeshPart") and child.Name:match("Layer") then
                local Size = child.Size;
                local _ = child.Transparency;
                Hydrate(child)({
                    Size = Spring(Computed(function() -- Line: 265
                        -- upvalues: u26 (copy), Size (copy)
                        local v29 = u26.Height:get();
                        local v30 = u26.Width:get();

                        return Vector3.new(Size.X * v29, Size.Y * v30, Size.Z * v30);
                    end), u26.Speed, u26.Dampening)
                });
            end;
        end;

        for _, child in pairs(u28:GetChildren()) do
            if child:IsA("BasePart") and child.Name:match("WindMesh") then
                local Scale = child.Mesh.Scale;
                Hydrate(child.Mesh)({
                    Scale = Spring(Computed(function() -- Line: 278
                        -- upvalues: u26 (copy), Scale (copy)
                        local v31 = u26.Height:get() * 1.25;
                        local v32 = u26.Width:get() * 2;

                        return Vector3.new(Scale.X * v32, Scale.Y * v31, Scale.Z * v32);
                    end), u26.Speed, u26.Dampening)
                });
            end;
        end;

        for _, descendant in pairs(u28.Beam:GetDescendants()) do
            if descendant:IsA("Beam") then
                local Width0 = descendant.Width0;
                local Width1 = descendant.Width1;
                local _ = descendant.Transparency;
                Hydrate(descendant)({
                    Width0 = Spring(Computed(function() -- Line: 293
                        -- upvalues: u26 (copy), Width0 (copy)
                        return Width0 * u26.Width:get();
                    end), u26.Speed, u26.Dampening),
                    Width1 = Spring(Computed(function() -- Line: 297
                        -- upvalues: u26 (copy), Width1 (copy)
                        return Width1 * u26.Width:get();
                    end), u26.Speed, u26.Dampening)
                });
            end;
        end;

        for _, v in pairs(v27) do
            u16:Add(BoatTween:Create(v, {
                Time = 0.5,
                EasingStyle = "Linear",
                StepType = "Heartbeat",
                Goal = {
                    Transparency = v:GetAttribute("OriginalTransparency")
                }
            })):Play();
        end;

        u28.Parent = workspace.Effects;
        u26.Width:set(1.25);
        u26.Transparency:set(1);
        SetVisible(u28, true);

        for i, child in pairs(u28:GetChildren()) do
            if child.Name:match("WindMesh") then
                local _ = child.CFrame;
                child.CFrame = child.CFrame * CFrame.Angles(0, math.rad(90 * i), 0);
                local Mesh = child.Mesh;
                local u33 = u14;
                local u34 = #u33;
                local u35 = 0;
                local u36 = 0;
                task.spawn(function() -- Line: 55
                    -- upvalues: Mesh (copy), u36 (ref), u35 (ref), u34 (copy), u33 (copy)
                    while Mesh and Mesh:IsDescendantOf(workspace) do
                        u36 = u36 + task.wait();

                        if u36 >= 0.125 then
                            u36 = u36 - 0.125;
                            u35 = u35 + 1;

                            if u34 < u35 then
                                break;
                            end;

                            Mesh.TextureId = u33[u35];
                        end;
                    end;
                end);
            end;
        end;

        task.delay(5, function() -- Line: 330
            -- upvalues: u28 (copy), u16 (ref), BoatTween (ref)
            for _, descendant in pairs(u28:GetDescendants()) do
                if descendant:IsA("BasePart") then
                    u16:Add(BoatTween:Create(descendant, {
                        Time = 1,
                        EasingStyle = "Circ",
                        EasingDirection = "Out",
                        StepType = "Heartbeat",
                        Goal = {
                            Transparency = 1
                        }
                    })):Play();
                elseif descendant:IsA("Beam") or descendant:IsA("ParticleEmitter") then
                    u16:Add(BoatTween:Create(descendant, {
                        Time = 1,
                        EasingStyle = "Circ",
                        EasingDirection = "Out",
                        StepType = "Heartbeat",
                        Goal = {
                            Transparency = NumberSequence.new(1)
                        }
                    })):Play();
                end;
            end;
        end);
        u26.Orientation:set(360);
        task.wait(7);
    end):finallyCall(u16.Destroy, u16):catch(warn);
end;