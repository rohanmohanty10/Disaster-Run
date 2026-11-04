 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local TatlisV2ScreenEffect = require(script.Parent.Parent.ScreenEffects.TatlisV2ScreenEffect);
local DarkScreenEffect = require(script.Parent.Parent.ScreenEffects.DarkScreenEffect);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, u2) -- Line: 19
    -- upvalues: LocalPlayer (copy), DarkScreenEffect (copy), Debris (copy), Essentials (copy), VfxManager (copy), SfxManager (copy), TweenService (copy), Lighting (copy), workspace_CurrentCamera (copy), RunService (copy), TatlisV2ScreenEffect (copy), ReplicatedStorage (copy)
    local TimeSent = u2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = u2.Character;
    local Other = u2.Other;
    local Humanoid = Character:FindFirstChild("Humanoid");
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local BALL = Character:FindFirstChild("BALL", true);

    local function GetGoal() -- Line: 30
        -- upvalues: LocalPlayer (ref), Character (copy), u2 (copy), HumanoidRootPart (copy), Other (copy)
        local v4;

        if LocalPlayer.Character == Character then
            if u2.HasBall then
                local Position = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;
                v4 = Vector3.new(Position.X, HumanoidRootPart.Position.Y, Position.Z);
            else
                local v5 = Other or u2.Others[1];

                if not v5 then
                    return;
                end;

                local HumanoidRootPart2 = v5:FindFirstChild("HumanoidRootPart");

                if not HumanoidRootPart2 then
                    return;
                end;

                v4 = HumanoidRootPart2.Position;
            end;
        else
            v4 = HumanoidRootPart.Position;
        end;

        if (v4 - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude ~= 0 then
            return v4;
        end;
    end;

    if u2.Task ~= "Stare Down" then
        if u2.Task == "Stare Down End" then
            SfxManager:playSound({
                Sound = u2.HasBall and "BBZ Tatlis V2 Stare Down End With Ball" or "BBZ Tatlis V2 Stare Down End Without Ball",
                Parent = HumanoidRootPart
            });

            if not u2.HasBall then
                local v6 = script.Dash:Clone();
                v6.Parent = Debris;
                v6:PivotTo(HumanoidRootPart.CFrame);
                VfxManager.DestroyEffect(v6, 2);
                shared.vfx.emit(v6);
            end;

            local v7 = Debris:FindFirstChild(Character.Name .. script.Name);

            if v7 then
                v7:SetAttribute("Ended", true);
                v7:SetAttribute("Active", nil);

                if v7:FindFirstChild("Torso") and v7.Torso:FindFirstChild("Sound") then
                    TweenService:Create(v7.Torso.Sound, TweenInfo.new(1), {
                        Volume = 0
                    }):Play();
                end;

                task.wait(1);
                VfxManager.Enable(v7, false);
                VfxManager.DestroyEffect(v7, 2);

                return;
            end;
        elseif u2.Task == "Start" then
            local v8 = script.Impact:Clone();
            v8.Parent = Debris;
            v8.CFrame = u2.CFrame;
            VfxManager.DestroyEffect(v8, 2);
            SfxManager:playSound({
                Sound = "BBZ Tatlis V2 Soul Walk Start",
                Parent = v8
            });
            shared.vfx.emit(v8);
            Character.Archivable = true;
            local u9 = Character:Clone();
            Character.Archivable = false;
            u9.Name = Character.Name .. script.Name;
            u9.Parent = Debris;
            VfxManager.DestroyEffect(u9, 10);

            for _, child in pairs(script.AuraBodyPartsToWeld:GetChildren()) do
                local v10 = u9:FindFirstChild(child.Name);

                if v10 then
                    for _, child2 in child:GetChildren() do
                        local v11 = child2:Clone();
                        v11.Parent = v10;
                        VfxManager.Enable(v11, true);
                    end;
                end;
            end;

            local HumanoidRootPart2 = u9.HumanoidRootPart;
            HumanoidRootPart2.Anchored = true;
            HumanoidRootPart2.CFrame = u2.CFrame;
            u9.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;

            for _, v in ipairs(Humanoid.Animator:GetPlayingAnimationTracks()) do
                u9.Humanoid:LoadAnimation(v.Animation):Play(0);
                v:Stop(0.5);
            end;

            local v12 = u9.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations.TatlisV2.SoulWalk);
            v12.Priority = Enum.AnimationPriority.Action3;
            v12:Play();
            local v13 = u9.PlrBall.Anims.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations.TatlisV2.SoulWalkBall);
            v13.Priority = Enum.AnimationPriority.Action3;
            v13:Play();

            for _, descendant in pairs(u9:GetDescendants()) do
                if descendant:IsA("Script") or (descendant:IsA("LocalScript") or (descendant:IsA("Highlight") or (descendant:IsA("Sound") or (descendant:IsA("SurfaceGui") or (descendant:IsA("Decal") or (descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")))))))) then
                    descendant:Destroy();
                end;
            end;

            local Highlight = Instance.new("Highlight", u9);
            Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
            Highlight.FillColor = Color3.fromRGB(0, 0, 0);
            Highlight.OutlineColor = Color3.fromRGB(0, 0, 0);
            Highlight.OutlineTransparency = 0;
            Highlight.FillTransparency = 1;
            task.delay(5 - v3, function() -- Line: 311
                -- upvalues: u9 (copy), Debris (ref), Character (copy), VfxManager (ref), SfxManager (ref), Essentials (ref)
                if not (u9 and u9:IsDescendantOf(workspace)) then
                    return;
                end;

                local v14 = Debris:FindFirstChild(Character.name .. script.Name);

                if v14 then
                    if v14:FindFirstChild("HumanoidRootPart") then
                        local v15 = script.Impact:Clone();
                        v15.Parent = Debris;
                        v15.CFrame = v14.HumanoidRootPart.CFrame;
                        VfxManager.DestroyEffect(v15, 2);
                        shared.vfx.emit(v15);
                        SfxManager:playSound({
                            Sound = "BBZ Tatlis V2 Soul Walk End",
                            Parent = v15
                        });
                    end;

                    v14:Destroy();
                end;

                Essentials:UnhideCharacter(Character, {});
            end);
            Essentials:HideCharacter(Character, {});

            if LocalPlayer.Character == Character or LocalPlayer.Character == Other then
                DarkScreenEffect();
            end;

            local v16 = tick();

            repeat
                task.wait(0.5);
                local v17 = Essentials:CreateClone(Character, 1);

                for _, descendant in pairs(v17:GetDescendants()) do
                    if descendant:IsA("BasePart") or (descendant:IsA("Decal") or (descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or (descendant:IsA("SurfaceAppearance") or (descendant:IsA("Shirt") or descendant:IsA("Pants")))))) then
                        if descendant:IsA("BasePart") then
                            if descendant.Name == "PlrBall" or descendant.Name == "RootPart" then
                                descendant.Transparency = 1;
                            else
                                if descendant:IsA("MeshPart") then
                                    descendant.TextureID = "";
                                end;

                                local v18 = descendant:FindFirstChildOfClass("SpecialMesh");

                                if v18 then
                                    v18.TextureId = "";
                                end;

                                descendant.Color = Color3.fromRGB(0, 0, 0);
                                descendant.Material = Enum.Material.Neon;

                                if descendant.LocalTransparencyModifier < 0.7 then
                                    descendant.LocalTransparencyModifier = 0.7;
                                end;
                            end;
                        elseif descendant:IsA("SurfaceAppearance") then
                            descendant.Color = Color3.fromRGB(0, 0, 0);
                        elseif descendant:IsA("Shirt") or descendant:IsA("Pants") then
                            descendant.Color3 = Color3.fromRGB(0, 0, 0);
                        else
                            descendant.LocalTransparencyModifier = 1;
                        end;
                    elseif descendant:IsA("SurfaceGui") then
                        descendant.Enabled = false;
                    end;
                end;

                VfxManager.DestroyEffect(v17, 1);
                SfxManager:playSound({
                    Sound = `BBZ Tatlis V2 Soul Walk Poof {math.random(1, 2)}`,
                    Parent = v17
                });
            until tick() - v16 > 4.75 - v3 or not (u9 and u9:IsDescendantOf(workspace));
        elseif u2.Task == "End" then
            local v19 = Debris:FindFirstChild(Character.name .. script.Name);

            if v19 then
                if v19:FindFirstChild("HumanoidRootPart") then
                    local v20 = script.Impact:Clone();
                    v20.Parent = Debris;
                    v20.CFrame = v19.HumanoidRootPart.CFrame;
                    VfxManager.DestroyEffect(v20, 2);
                    shared.vfx.emit(v20);
                    SfxManager:playSound({
                        Sound = "BBZ Tatlis V2 Soul Walk End",
                        Parent = v20
                    });
                end;

                v19:Destroy();
            end;

            Essentials:UnhideCharacter(Character, {});

            if LocalPlayer.Character == Character or LocalPlayer.Character == Other then
                DarkScreenEffect();

                return;
            end;
        elseif u2.Task == "Snatch" then
            SfxManager:playSound({
                Sound = "BBZ Tatlis V2 Soul Catch",
                Parent = HumanoidRootPart
            });

            if LocalPlayer.Character == Character or LocalPlayer.Character == Other then
                local NumberValue = Instance.new("NumberValue");
                local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
                ColorCorrectionEffect.Name = "CCAddon";
                ColorCorrectionEffect.Parent = Lighting;
                ColorCorrectionEffect.Enabled = true;
                local u23 = RunService.RenderStepped:Connect(function() -- Line: 415
                    -- upvalues: Lighting (ref), ColorCorrectionEffect (copy), NumberValue (copy)
                    local v21 = 0;
                    local v22 = 0;

                    for _, child in Lighting:GetChildren() do
                        if child:IsA("ColorCorrectionEffect") and child ~= ColorCorrectionEffect then
                            v21 = v21 + child.Brightness;
                            v22 = v22 + child.Saturation;
                        end;
                    end;

                    ColorCorrectionEffect.Brightness = (v21 + 0.15) * NumberValue.Value;
                    ColorCorrectionEffect.Saturation = (v22 + 1) * NumberValue.Value;
                end);
                TweenService:Create(NumberValue, TweenInfo.new(1.8), {
                    Value = -1
                }):Play();
                local u24 = nil;
                task.delay(0.18333333333333332 - v3, function() -- Line: 434
                    -- upvalues: DarkScreenEffect (ref), u24 (ref), Debris (ref), HumanoidRootPart (copy)
                    DarkScreenEffect();
                    u24 = script.Domain:Clone();
                    u24.Parent = Debris;
                    u24:PivotTo(CFrame.new(HumanoidRootPart.Position.X, 1.025, HumanoidRootPart.Position.Z));
                    shared.vfx.emit(u24);
                end);
                task.delay(1.8 - v3, function() -- Line: 444
                    -- upvalues: u23 (copy), RunService (ref), NumberValue (copy), ColorCorrectionEffect (copy), TatlisV2ScreenEffect (ref), u24 (ref)
                    u23:Disconnect();
                    RunService:UnbindFromRenderStep("Stare");
                    NumberValue:Destroy();
                    ColorCorrectionEffect:Destroy();
                    TatlisV2ScreenEffect();

                    if u24 then
                        u24:Destroy();
                    end;
                end);
                RunService:UnbindFromRenderStep("Stare");
                RunService:BindToRenderStep("Stare", Enum.RenderPriority.Character.Value, function(p25) -- Line: 458
                    -- upvalues: GetGoal (copy), LocalPlayer (ref), workspace_CurrentCamera (ref)
                    local v26 = GetGoal();

                    if not v26 then
                        return;
                    end;

                    local v27 = (LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 4, (math.sqrt((LocalPlayer.Character.HumanoidRootPart.Position - workspace_CurrentCamera.CFrame.Position).Magnitude ^ 2 - 16)))).Position - LocalPlayer.Character.HumanoidRootPart.Position;
                    workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame:Lerp(CFrame.new(LocalPlayer.Character.HumanoidRootPart.Position + v27, (Vector3.new(v26.X, workspace_CurrentCamera.CFrame.Position.Y, v26.Z))), p25 * 5);
                end);
            end;

            local v28 = script.FlashStep:Clone();
            v28.Parent = Debris;
            v28.CFrame = HumanoidRootPart.CFrame;
            Essentials:Weld(v28, HumanoidRootPart);
            VfxManager.DestroyEffect(v28, 2);
            shared.vfx.emit(v28);
        end;

        return;
    end;

    DarkScreenEffect();
    local Model = Instance.new("Model");
    Model.Name = Character.Name .. script.Name;
    Model.Parent = Debris;
    Model:SetAttribute("Active", true);

    for _, child in pairs(script.AuraBodyPartsToWeld:GetChildren()) do
        local v29 = Character:FindFirstChild(child.Name);

        if v29 then
            local v30 = child:Clone();
            v30.CFrame = v29.CFrame;
            v30.Parent = Model;
            Essentials:Weld(v30, v29);
        end;
    end;

    VfxManager.Enable(Model, true);
    local u31 = SfxManager:playSound({
        Sound = u2.HasBall and "BBZ Tatlis V2 Stare Down With Ball" or "BBZ Tatlis V2 Stare Down Without Ball",
        Parent = Model:FindFirstChild("Torso")
    });
    task.delay((u2.HasBall and 2.6333333333333333 or 3.6) - v3, function() -- Line: 76
        -- upvalues: Model (copy), u31 (copy), TweenService (ref), VfxManager (ref)
        Model:SetAttribute("Active", nil);

        if u31 then
            TweenService:Create(u31, TweenInfo.new(1), {
                Volume = 0
            }):Play();
        end;

        task.wait(1);
        VfxManager.Enable(Model, false);
        VfxManager.DestroyEffect(Model, 2);
    end);

    if u2.HasBall then
        task.delay(0.21666666666666667, function() -- Line: 90
            -- upvalues: Model (copy), Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
            if not (Model and Model:GetAttribute("Active")) then
                return;
            end;

            local v32 = script.Bounce:Clone();
            v32.Parent = Debris;
            v32:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
            VfxManager.DestroyEffect(v32, 2);
            shared.vfx.emit(v32);
        end);
        task.delay(0.95, function() -- Line: 101
            -- upvalues: Model (copy), Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
            if not (Model and Model:GetAttribute("Active")) then
                return;
            end;

            local v33 = script.Bounce:Clone();
            v33.Parent = Debris;
            v33:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
            VfxManager.DestroyEffect(v33, 2);
            shared.vfx.emit(v33);
        end);
        task.delay(1.5, function() -- Line: 112
            -- upvalues: Model (copy), Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
            if not (Model and Model:GetAttribute("Active")) then
                return;
            end;

            local v34 = script.Bounce:Clone();
            v34.Parent = Debris;
            v34:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
            VfxManager.DestroyEffect(v34, 2);
            shared.vfx.emit(v34);
        end);
        task.delay(1.9166666666666667, function() -- Line: 123
            -- upvalues: Model (copy), Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
            if not (Model and Model:GetAttribute("Active")) then
                return;
            end;

            local v35 = script.Bounce:Clone();
            v35.Parent = Debris;
            v35:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
            VfxManager.DestroyEffect(v35, 2);
            shared.vfx.emit(v35);
        end);
        task.delay(2.35, function() -- Line: 134
            -- upvalues: Model (copy), Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
            if not (Model and Model:GetAttribute("Active")) then
                return;
            end;

            local v36 = script.Bounce:Clone();
            v36.Parent = Debris;
            v36:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
            VfxManager.DestroyEffect(v36, 2);
            shared.vfx.emit(v36);
        end);
    end;

    local NumberValue = Instance.new("NumberValue");
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Name = "CCAddon";
    ColorCorrectionEffect.Parent = Lighting;
    ColorCorrectionEffect.Enabled = true;
    TweenService:Create(NumberValue, TweenInfo.new(1), {
        Value = -1
    }):Play();
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u37 = script.Vignette:Clone();
    u37.Parent = PlayerGui;
    u37.Enabled = true;
    local Vignette = u37.Vignette;
    local u38 = 1;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    local u39 = nil;
    u39 = RunService.RenderStepped:Connect(function(p40) -- Line: 165
        -- upvalues: Model (copy), u39 (ref), RunService (ref), NumberValue (copy), ColorCorrectionEffect (copy), TatlisV2ScreenEffect (ref), TweenService (ref), VfxManager (ref), Vignette (copy), u37 (copy), Lighting (ref), FieldOfView (ref), Essentials (ref), workspace_CurrentCamera (ref), u38 (ref), GetGoal (copy), LocalPlayer (ref)
        if not (Model and Model:GetAttribute("Active")) then
            u39:Disconnect();
            RunService:UnbindFromRenderStep("Stare");

            if Model:GetAttribute("Ended") then
                NumberValue:Destroy();
                ColorCorrectionEffect:Destroy();
                TatlisV2ScreenEffect();
            else
                NumberValue:Destroy();
                TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Brightness = 0,
                    Saturation = 0
                }):Play();
                VfxManager.DestroyEffect(ColorCorrectionEffect, 0.5);
            end;

            TweenService:Create(Vignette, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                ImageTransparency = 1
            }):Play();
            VfxManager.DestroyEffect(u37, 0.5);

            return;
        end;

        local v41 = 0;
        local v42 = 0;

        for _, child in Lighting:GetChildren() do
            if child:IsA("ColorCorrectionEffect") and child ~= ColorCorrectionEffect then
                v41 = v41 + child.Brightness;
                v42 = v42 + child.Saturation;
            end;
        end;

        ColorCorrectionEffect.Brightness = (v41 + 0.15) * NumberValue.Value;
        ColorCorrectionEffect.Saturation = (v42 + 1) * NumberValue.Value;
        FieldOfView = Essentials:Lerp(FieldOfView, 30, p40);
        workspace_CurrentCamera.FieldOfView = FieldOfView;
        u38 = Essentials:Lerp(u38, 0, p40);
        Vignette.ImageTransparency = u38;
        local v43 = GetGoal();

        if not v43 then
            return;
        end;

        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(LocalPlayer.Character.HumanoidRootPart.Position, v43);
    end);

    if LocalPlayer.Character == Character or table.find(u2.Others, LocalPlayer.Character) then
        RunService:UnbindFromRenderStep("Stare");
        RunService:BindToRenderStep("Stare", Enum.RenderPriority.Character.Value, function() -- Line: 213
            -- upvalues: GetGoal (copy), LocalPlayer (ref), workspace_CurrentCamera (ref)
            local v44 = GetGoal();

            if not v44 then
                return;
            end;

            local v45 = (LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 4, (math.sqrt((LocalPlayer.Character.HumanoidRootPart.Position - workspace_CurrentCamera.CFrame.Position).Magnitude ^ 2 - 16)))).Position - LocalPlayer.Character.HumanoidRootPart.Position;
            workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame:Lerp(CFrame.new(LocalPlayer.Character.HumanoidRootPart.Position + v45, (Vector3.new(v44.X, workspace_CurrentCamera.CFrame.Position.Y, v44.Z))), 1);
        end);
    end;
end;