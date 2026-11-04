 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Part_Icles);
require(ReplicatedStorage.Shared.Utility.Effects);
local DarkScreenEffect = require(script.Parent.Parent.ScreenEffects.DarkScreenEffect);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 19
    -- upvalues: Knit (copy), SfxManager (copy), Debris (copy), Players (copy), VfxManager (copy), RunService (copy), workspace_CurrentCamera (copy), Lighting (copy), ReplicatedStorage (copy), Essentials (copy), LocalPlayer (copy), TweenService (copy), DarkScreenEffect (copy)
    local Controller = Knit.GetController("MovementController");
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local v4 = Character.Name .. script.Parent.Name .. script.Name;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local BALL = Character:FindFirstChild("BALL", true);

    if p2.Task ~= "Erasure" then
        if p2.Task == "Skip" then
            SfxManager:playSound({
                Sound = "BBZ Chrollo V2 Time Skip Dribble",
                Parent = HumanoidRootPart
            });
            local u5 = script.Skip.Aura:Clone();
            u5.Parent = Debris;
            u5.CFrame = HumanoidRootPart.CFrame;
            Essentials:Weld(u5, HumanoidRootPart);
            task.delay(0.08333333333333333, function() -- Line: 300
                -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
                local v6 = script.Skip.Bounce:Clone();
                v6.Parent = Debris;
                v6:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
                VfxManager.DestroyEffect(v6, 2);
                shared.vfx.emit(v6);
            end);
            task.delay(0.3 - v3, function() -- Line: 309
                -- upvalues: LocalPlayer (ref), Character (copy), DarkScreenEffect (ref), Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref), Essentials (ref)
                if LocalPlayer.Character == Character then
                    DarkScreenEffect();
                end;

                local v7 = script.Skip.BounceSlash:Clone();
                v7.Parent = Debris;
                v7:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
                VfxManager.DestroyEffect(v7, 2);
                local v8 = script.Skip.Slash:Clone();
                v8.Parent = Debris;
                v8.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1.5, 0);
                Essentials:Weld(v8, HumanoidRootPart);
                VfxManager.DestroyEffect(v8, 2);
                shared.vfx.emit(v7, v8);
            end);
            task.delay(0.55, function() -- Line: 328
                -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
                local v9 = script.Skip.Bounce:Clone();
                v9.Parent = Debris;
                v9:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
                VfxManager.DestroyEffect(v9, 2);
                shared.vfx.emit(v9);
            end);
            task.delay(1.25, function() -- Line: 337
                -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
                local v10 = script.Skip.Bounce:Clone();
                v10.Parent = Debris;
                v10:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
                VfxManager.DestroyEffect(v10, 2);
                shared.vfx.emit(v10);
            end);
            task.delay(1.6 - v3, function() -- Line: 346
                -- upvalues: LocalPlayer (ref), Character (copy), DarkScreenEffect (ref), Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref), Essentials (ref)
                if LocalPlayer.Character == Character then
                    DarkScreenEffect();
                end;

                local v11 = script.Skip.BounceSlash:Clone();
                v11.Parent = Debris;
                v11:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
                VfxManager.DestroyEffect(v11, 2);
                local v12 = script.Skip.Slash:Clone();
                v12.Parent = Debris;
                v12.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1.5, 0);
                Essentials:Weld(v12, HumanoidRootPart);
                VfxManager.DestroyEffect(v12, 2);
                shared.vfx.emit(v11, v12);
            end);
            task.delay(1.95, function() -- Line: 365
                -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
                local v13 = script.Skip.Bounce:Clone();
                v13.Parent = Debris;
                v13:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
                VfxManager.DestroyEffect(v13, 2);
                shared.vfx.emit(v13);
            end);
            task.delay(2.183333333333333, function() -- Line: 374
                -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
                local v14 = script.Skip.Bounce:Clone();
                v14.Parent = Debris;
                v14:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
                VfxManager.DestroyEffect(v14, 2);
                shared.vfx.emit(v14);
            end);
            task.delay(2.566666666666667, function() -- Line: 383
                -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
                local v15 = script.Skip.Bounce:Clone();
                v15.Parent = Debris;
                v15:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
                VfxManager.DestroyEffect(v15, 2);
                shared.vfx.emit(v15);
            end);
            task.delay(2.816666666666667, function() -- Line: 392
                -- upvalues: LocalPlayer (ref), Character (copy), DarkScreenEffect (ref), Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
                if LocalPlayer.Character == Character then
                    DarkScreenEffect();
                end;

                local v16 = script.Skip.BounceCut:Clone();
                v16.Parent = Debris;
                v16:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
                VfxManager.DestroyEffect(v16, 2);
                shared.vfx.emit(v16);
            end);
            task.delay(3.183333333333333, function() -- Line: 405
                -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
                local v17 = script.Skip.Bounce:Clone();
                v17.Parent = Debris;
                v17:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
                VfxManager.DestroyEffect(v17, 2);
                shared.vfx.emit(v17);
            end);
            task.delay(3.6, function() -- Line: 414
                -- upvalues: Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref)
                local v18 = script.Skip.Bounce:Clone();
                v18.Parent = Debris;
                v18:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
                VfxManager.DestroyEffect(v18, 2);
                shared.vfx.emit(v18);
            end);
            task.delay(4.05 - v3, function() -- Line: 423
                -- upvalues: LocalPlayer (ref), Character (copy), DarkScreenEffect (ref), Debris (ref), BALL (copy), HumanoidRootPart (copy), VfxManager (ref), Essentials (ref)
                if LocalPlayer.Character == Character then
                    DarkScreenEffect();
                end;

                local v19 = script.Skip.BounceSlash:Clone();
                v19.Parent = Debris;
                v19:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()));
                VfxManager.DestroyEffect(v19, 2);
                local v20 = script.Skip.Slash:Clone();
                v20.Parent = Debris;
                v20.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1.5, 0);
                Essentials:Weld(v20, HumanoidRootPart);
                VfxManager.DestroyEffect(v20, 2);
                shared.vfx.emit(v19, v20);
            end);
            task.delay(4.266666666666667 - v3, function() -- Line: 442
                -- upvalues: VfxManager (ref), u5 (copy)
                VfxManager.Enable(u5, false);
                VfxManager.DestroyEffect(u5, 2);
            end);
            local v21 = Debris:FindFirstChild(v4);

            if v21 then
                v21:SetAttribute("Active", nil);
            end;

            local v22 = tick();

            repeat
                task.wait(0.2);
                local v23 = Essentials:CreateClone(Character);
                VfxManager.DestroyEffect(v23, 1);
            until tick() - v22 > 4.05;
        end;

        return;
    end;

    local u24 = SfxManager:playSound({
        Sound = "BBZ Chrollo V2 Time Erasure",
        Parent = workspace
    });
    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(10 - v3, function() -- Line: 40
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local v25 = script.Erasure.Map:Clone();
    v25.Parent = Folder;
    local v26 = Players:FindFirstChild(Character.Name);

    if v26 and v26.Team == game.Teams.Away then
        v25:PivotTo(v25:GetPivot() * CFrame.Angles(0, 3.141592653589793, 0));
    end;

    SfxManager:playSound({
        Sound = "BBZ Chrollo V2 Time Skip",
        Parent = workspace
    });
    local u27 = script.Erasure.CameraVFX:Clone();
    u27.Parent = Debris;
    VfxManager.BetterEmit(u27);
    local u28 = RunService.RenderStepped:Connect(function() -- Line: 60
        -- upvalues: workspace_CurrentCamera (ref), u27 (copy)
        workspace_CurrentCamera.FieldOfView = 70;
        u27.PrimaryPart.CFrame = workspace_CurrentCamera.CFrame;
    end);
    task.delay(1, function() -- Line: 65
        -- upvalues: u28 (copy), u27 (copy)
        u28:Disconnect();
        u27:Destroy();
    end);
    local u29 = script.Erasure.FakeAtmo:Clone();
    u29.Parent = Lighting;
    local u30 = script.Erasure.FakeSky:Clone();
    u30.Parent = Lighting;
    local Ambient = Lighting.Ambient;
    local OutdoorAmbient = Lighting.OutdoorAmbient;
    Lighting.Ambient = Color3.fromRGB(246, 205, 255);
    Lighting.OutdoorAmbient = Color3.fromRGB(0, 0, 0);
    local ClockTime = Lighting.ClockTime;

    if ClockTime ~= 0 then
        Lighting.ClockTime = 0;
    end;

    local MapFolder = workspace:FindFirstChild("MapFolder");

    if MapFolder then
        MapFolder.Parent = ReplicatedStorage;
        task.delay(10 - v3, function() -- Line: 90
            -- upvalues: Folder (copy), MapFolder (copy)
            if not (Folder and Folder:GetAttribute("Active")) then
                return;
            end;

            if not workspace:FindFirstChild("MapFolder") then
                MapFolder.Parent = workspace;
            end;
        end);
    end;

    local u31 = {};
    local Courts2 = workspace:FindFirstChild("Courts2");

    if Courts2 then
        for _, descendant in Courts2:GetDescendants() do
            if descendant:IsA("BasePart") or descendant:IsA("Texture") then
                local Transparency = descendant.Transparency;
                u31[descendant] = Transparency;

                if Transparency ~= 1 then
                    descendant.Transparency = 1;
                    task.delay(10 - v3, function() -- Line: 110
                        -- upvalues: descendant (copy), Transparency (copy)
                        descendant.Transparency = Transparency;
                    end);
                end;
            end;
        end;
    end;

    local u32 = {};

    for _, v in Players:GetPlayers() do
        if v.Team ~= game.Teams.Visitor and (v.Character and (v.Character:FindFirstChild("HumanoidRootPart") and v.Character ~= Character)) then
            v.Character.Archivable = true;
            local v33 = v.Character:Clone();
            v.Character.Archivable = false;
            v33.Parent = Folder;
            local v34 = v;

            for _, descendant in v33:GetDescendants() do
                if descendant:IsA("Script") or (descendant:IsA("LocalScript") or (descendant:IsA("Highlight") or (descendant:IsA("Sound") or (descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")))))) then
                    descendant:Destroy();
                elseif descendant:IsA("BasePart") or descendant:IsA("MeshPart") then
                    local v35 = descendant:FindFirstChildOfClass("SpecialMesh");

                    if v35 then
                        v35.TextureId = "";
                    end;

                    descendant.Color = Color3.fromRGB(220, 20, 60);
                    descendant.Material = Enum.Material.ForceField;
                    descendant.Anchored = true;
                    descendant.CanCollide = false;
                    descendant.CanTouch = false;
                    descendant.CanQuery = false;
                elseif descendant:IsA("Shirt") or descendant:IsA("Pants") then
                    descendant.Color3 = Color3.fromRGB(220, 20, 60);
                elseif descendant:IsA("Humanoid") then
                    descendant.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
                end;
            end;

            Essentials:HideCharacter(v34.Character, {});
            table.insert(u32, v34.Character);
        end;
    end;

    if LocalPlayer.Character ~= Character and LocalPlayer.Team ~= game.Teams.Visitor then
        workspace:SetAttribute("TimeErasure", true);
    end;

    local u36 = {};
    table.insert(u36, RunService.Heartbeat:Connect(function() -- Line: 164
        -- upvalues: LocalPlayer (ref), Character (copy), Controller (copy)
        if LocalPlayer.Character ~= Character then
            Controller.States.Ability = true;
        end;
    end));

    local function v40() -- Line: 170
        -- upvalues: u36 (ref), u32 (copy), Essentials (ref), u24 (copy), TweenService (ref), VfxManager (ref), Folder (copy), SfxManager (ref), Debris (ref), RunService (ref), workspace_CurrentCamera (ref), u29 (copy), u30 (copy), Lighting (ref), Ambient (copy), OutdoorAmbient (copy), ClockTime (copy), MapFolder (copy), Courts2 (copy), u31 (copy), LocalPlayer (ref), Character (copy), Controller (copy)
        for _, v in pairs(u36) do
            v:Disconnect();
        end;

        for _, v in pairs(u32) do
            if v and v:IsDescendantOf(workspace) then
                Essentials:UnhideCharacter(v, {});
            end;
        end;

        if u24 then
            TweenService:Create(u24, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Volume = 0
            }):Play();
            VfxManager.DestroyEffect(u24, 0.25);
        end;

        if Folder then
            Folder:Destroy();
        end;

        SfxManager:playSound({
            Sound = "BBZ Chrollo V2 Time Skip",
            Parent = workspace
        });
        local u37 = script.Erasure.CameraVFX:Clone();
        u37.Parent = Debris;
        VfxManager.BetterEmit(u37);
        local u38 = RunService.RenderStepped:Connect(function() -- Line: 195
            -- upvalues: workspace_CurrentCamera (ref), u37 (copy)
            workspace_CurrentCamera.FieldOfView = 70;
            u37.PrimaryPart.CFrame = workspace_CurrentCamera.CFrame;
        end);
        task.delay(1, function() -- Line: 200
            -- upvalues: u38 (copy), u37 (copy)
            u38:Disconnect();
            u37:Destroy();
        end);

        if u29 then
            u29:Destroy();
        end;

        if u30 then
            u30:Destroy();
        end;

        if Lighting.Ambient == Color3.fromRGB(246, 205, 255) then
            Lighting.Ambient = Ambient;
        end;

        if Lighting.OutdoorAmbient == Color3.fromRGB(0, 0, 0) then
            Lighting.OutdoorAmbient = OutdoorAmbient;
        end;

        if ClockTime ~= 0 and not workspace:GetAttribute("NightMode") then
            Lighting.ClockTime = ClockTime;
        end;

        if MapFolder and not workspace:FindFirstChild("MapFolder") then
            MapFolder.Parent = workspace;
        end;

        if Courts2 then
            for _, descendant in Courts2:GetDescendants() do
                if descendant:IsA("BasePart") or descendant:IsA("Texture") then
                    local v39 = u31[descendant];

                    if v39 and v39 ~= 1 then
                        descendant.Transparency = v39;
                    end;
                end;
            end;
        end;

        workspace:SetAttribute("TimeErasure", nil);

        if LocalPlayer.Character ~= Character then
            Controller.States.Ability = false;
        end;

        u36 = nil;
    end;

    task.spawn(function() -- Line: 249
        -- upvalues: u36 (ref), u32 (copy), Essentials (ref), VfxManager (ref), TweenService (ref)
        while u36 do
            task.wait(0.1);

            for _, v in pairs(u32) do
                if v and v:IsDescendantOf(workspace) then
                    local v41 = Essentials:CreateClone(v);
                    VfxManager.DestroyEffect(v41, 1);

                    for _, descendant in v41:GetDescendants() do
                        if descendant:IsA("BasePart") or descendant:IsA("MeshPart") then
                            local v42 = descendant:FindFirstChildOfClass("SpecialMesh");

                            if v42 then
                                v42.TextureId = "";
                            end;

                            descendant.Color = Color3.fromRGB(220, 20, 60);
                        elseif descendant:IsA("Shirt") or descendant:IsA("Pants") then
                            descendant.Color3 = Color3.fromRGB(220, 20, 60);
                        end;
                    end;

                    if v41:FindFirstChild("PlrBall") then
                        v41.PlrBall:Destroy();
                    end;

                    local Highlight = Instance.new("Highlight");
                    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
                    Highlight.FillColor = Color3.fromRGB(220, 20, 60);
                    Highlight.FillTransparency = 0.5;
                    Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
                    Highlight.OutlineTransparency = 0;
                    Highlight.Parent = v41;
                    Highlight.Enabled = true;
                    TweenService:Create(Highlight, TweenInfo.new(0.5), {
                        FillTransparency = 1,
                        OutlineTransparency = 1
                    }):Play();
                end;
            end;
        end;
    end);
    table.insert(u36, Folder.AttributeChanged:Connect(v40));
    table.insert(u36, Folder.Destroying:Connect(v40));
end;