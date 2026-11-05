  

 

local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local u1 = Random.new();
local u2 = RaycastParams.new();
u2.FilterType = Enum.RaycastFilterType.Include;
u2.FilterDescendantsInstances = { workspace.Map };
local u3 = {};

return function(p4, u5, p6) -- Line: 26
    -- upvalues: u3 (copy), LocalPlayer (copy), ParticleHandler (copy), u2 (copy), TweenService (copy), AssetHandler (copy), EffectsHandler (copy), Trove (copy), u1 (copy), RunService (copy)
    local Character = p6.Character;
    local SkinName = p6.SkinName;
    local v7 = {
        AbilityName = "Ope",
        SkinName = SkinName
    };

    if not (Character and (Character:IsDescendantOf(game) and u5)) then
        return;
    end;

    if p4 ~= "Redirect" then
        if p4 == "Generate" then
            local Room = p6.Room;
            local Rocks = p6.Rocks;

            if not (Room and (Rocks and Room:IsDescendantOf(game))) then
                return;
            end;

            local v8 = Trove.new();
            v8:AttachToInstance(Room);
            v8:Add(function() -- Line: 165
                -- upvalues: u3 (ref), u5 (copy)
                if u3[u5] then
                    u3[u5] = nil;
                end;
            end);
            local v9 = v8:Construct(Instance, "Model");
            v9.Name = "Takt Rocks";
            v9.Parent = workspace.Effects;
            local v10 = ParticleHandler.GetUnusualHSVData({
                Character = p6.Character
            });
            local v11 = {};

            for _, v in Rocks do
                local v12 = v8:Clone(AssetHandler.GetAsset("Particles/Takt/Rock", v7));
                v12.CFrame = CFrame.new(v.Origin) * CFrame.Angles(math.rad(v.Direction.Z), 0, (math.rad(v.Direction.X)));
                v12.Position = v.RayPoint;
                v12.Color = v.RayResult.Color;
                v12.Material = v.RayResult.Material;
                ParticleHandler.Unusualify(v12, {
                    HSVData = v10
                });

                if v10 and v10.Chroma then
                    ParticleHandler.Chromaify(v12, {
                        Character = Character
                    });
                end;

                local v13 = v.RayResult:FindFirstChildOfClass("Texture") or v.RayResult:FindFirstChildOfClass("Decal");

                if v13 then
                    for _, v2 in { "Front", "Back", "Bottom", "Left", "Right", "Top" } do
                        local v14 = v13:Clone();
                        v14.Face = v2;
                        v14.Parent = v12;
                    end;
                end;

                v12.Parent = v9;
                AssetHandler.ScaleAsset(v12, {
                    Scale = v.Scale
                });
                local AlignPosition = v12.AlignPosition;
                AlignPosition.MaxVelocity = AlignPosition.MaxVelocity * v.Scale;
                local v15 = {
                    Sine = 0,
                    Model = v12,
                    Direction = v.Direction,
                    Origin = v.Origin,
                    Scale = v.Scale,
                    Amp = u1:NextNumber(5, 5.5) * v.Scale
                };
                table.insert(v11, v15);
                local v16 = v8:Clone(AssetHandler.GetAsset("Particles/Takt/Spawn", v7));
                v16.CFrame = CFrame.new(v.RayPoint, v.RayPoint + v.Normal) * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(0, -0.7 * v.Scale, 0);
                ParticleHandler.Unusualify(v16, {
                    HSVData = v10
                });
                v16.Parent = workspace.Effects;
                task.delay(3, v16.Destroy, v16);
                AssetHandler.ScaleAsset(v16, {
                    Scale = v.Scale
                });

                for _, descendant in v16:GetDescendants() do
                    if descendant:IsA("ParticleEmitter") then
                        if descendant:GetAttribute("RayColored") then
                            descendant.Color = ColorSequence.new(v.RayResult.Color);
                        end;

                        descendant:Emit(descendant:GetAttribute("EmitCount") or descendant.Rate);
                    end;
                end;

                v16.Sound:Play();
            end;

            u3[u5] = {
                Active = true,
                Trove = v8,
                RockInfo = v11,
                Container = v9
            };
            local u17 = false;
            v8:Connect(RunService.RenderStepped, function(p18) -- Line: 253
                -- upvalues: u3 (ref), u5 (copy), u17 (ref), TweenService (ref), Character (copy)
                for _, v in u3[u5].RockInfo do
                    local Model = v.Model;

                    if Model:IsDescendantOf(game) then
                        local Direction = v.Direction;
                        Model.CFrame = Model.CFrame * CFrame.Angles(math.rad(Direction.Z * p18), 0, (math.rad(Direction.X * p18)));

                        if (not v.Tween or v.Tween.PlaybackState == Enum.PlaybackState.Completed) and (u3[u5].Active and not u17) then
                            if v.Amp > 0.5 then
                                v.Amp = v.Amp - v.Scale * p18;
                            end;

                            v.Sine = v.Sine + 4.71238898038469 * p18;

                            if v.Sine >= 6.283185307179586 then
                                v.Sine = v.Sine - 6.283185307179586;
                            end;

                            local AlignPosition = Model.AlignPosition;
                            local v19 = TweenInfo.new(p18);
                            local v20 = {};
                            local Origin = v.Origin;
                            local v21 = v.Amp * math.sin(v.Sine);
                            v20.Position = Origin + Vector3.new(0, v21, 0);
                            TweenService:Create(AlignPosition, v19, v20):Play();
                        end;
                    end;
                end;

                if not (u17 or Character:IsDescendantOf(game) and Character:GetAttribute("Room")) then
                    u17 = true;

                    for _, v in u3[u5].RockInfo do
                        if v.Model:IsDescendantOf(game) then
                            v.Model.AlignPosition.Enabled = false;
                            v.Model.AngularVelocity.Enabled = false;
                        end;
                    end;
                end;
            end);
        end;

        return;
    end;

    local v22 = os.clock();

    repeat
        task.wait();
    until os.clock() - v22 > 5 or u3[u5] ~= nil;

    if not u3[u5] then
        return;
    end;

    local Goal = p6.Goal;
    local Speed = p6.Speed;
    local Character2 = LocalPlayer.Character;
    local u23 = 1 - (Character2.HumanoidRootPart.Position - Goal).Magnitude / p6.Size;
    local u24 = math.max(0.65, u23) * 1.25;
    local v25 = u3[u5];
    v25.Active = false;
    task.delay(3, v25.Trove.Destroy, v25.Trove);
    local Attachment = Instance.new("Attachment");
    Attachment.Parent = workspace.Terrain;
    Attachment.WorldPosition = Goal;
    local v26 = ParticleHandler.GetUnusualHSVData({
        Character = p6.Character
    });
    task.delay(Speed, Attachment.Destroy, Attachment);
    local v27 = Speed;

    for _, v in v25.RockInfo do
        if v.Model and v.Model:IsDescendantOf(game) then
            local v28 = workspace:Raycast(v.Origin, Goal - v.Origin, u2);
            local v29;

            if v28 then
                v29 = v28.Position or Goal;
            else
                v29 = Goal;
            end;

            local v30 = (v29 - v.Origin).Magnitude / Speed;

            if v27 < v30 then
                v27 = v30;
            end;

            v.Model.AlignPosition.Enabled = false;
            v.Model.Anchored = true;
            TweenService:Create(v.Model, TweenInfo.new(v30, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                Position = v29
            }):Play();
            task.delay(v30 * 0.95, function() -- Line: 97
                -- upvalues: AssetHandler (ref), v (copy), Character2 (copy), u23 (copy), EffectsHandler (ref), u24 (copy)
                AssetHandler.ScaleAsset(v.Model, {
                    Scale = 0,
                    TweenInfo = TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
                });

                if Character2 and (u23 <= 1 and u23 > 0) then
                    EffectsHandler.CallEffect("Camera Shake", {
                        v.Scale * 4 * u24,
                        v.Scale * 8 * u24,
                        0,
                        u24 * 0.1,
                        Vector3.new(0.2, 0.2, 0.2),
                        Vector3.new(1, 1, 1)
                    });
                end;
            end);
            local v31 = AssetHandler.GetAsset("Particles/Takt/RedirectBeams", v7):Clone();
            ParticleHandler.Unusualify(v31, {
                HSVData = v26
            });
            v31.Parent = v.Model;
            AssetHandler.ScaleAsset(v31, {
                Scale = v.Scale * 0.5
            });

            for _, child in v31:GetChildren() do
                child.Attachment0 = v.Model.Attachment;
                child.Attachment1 = Attachment;
                EffectsHandler.CallEffect("Boat Tween", child, {
                    EasingStyle = "ExitExpressive",
                    EasingDirection = "Out",
                    StepType = "RenderStepped",
                    Time = v30 / 2,
                    Goal = {
                        Brightness = 11,
                        Transparency = NumberSequence.new(1)
                    }
                });
            end;

            EffectsHandler.CallEffect("HighlightObject", v25.Container, {
                Lifetime = 0.4,
                Tween = true,
                OutlineColor = ParticleHandler.TryHSVShift(Color3.fromRGB(13, 137, 214), v26),
                FillColor = ParticleHandler.TryHSVShift(Color3.fromRGB(15, 163, 255), v26)
            });
            EffectsHandler.CallEffect("Enable Trails", "Universal", { v.Model }, true);
            EffectsHandler.CallEffect("Emit Particle V3", {
                Path = "Particles/Takt/Redirect",
                AbilityName = "Ope",
                PlaySounds = true,
                Character = Character,
                Origin = CFrame.new(v.Model.Position, v29),
                SkinName = SkinName,
                Scale = v.Scale
            });
        end;
    end;
end;