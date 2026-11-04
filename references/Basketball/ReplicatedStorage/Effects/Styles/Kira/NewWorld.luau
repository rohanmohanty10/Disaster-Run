 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local KiraScreenEffect = require(script.Parent.Parent.ScreenEffects.KiraScreenEffect);
local DarkScreenEffect = require(script.Parent.Parent.ScreenEffects.DarkScreenEffect);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");
local u1 = { "bro", "broski", "brochaco", "brotato chip", "lil bro", "son", "sonion" };

return function(p2, p3) -- Line: 29
    -- upvalues: Players (copy), Debris (copy), VfxManager (copy), Lighting (copy), ReplicatedStorage (copy), DarkScreenEffect (copy), Essentials (copy), LocalPlayer (copy), Effects (copy), RunService (copy), TweenService (copy), SfxManager (copy), KiraScreenEffect (copy), u1 (copy)
    local TimeSent = p3.TimeSent;
    local v4 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p3.Character;
    local v5 = Players:FindFirstChild(Character.Name);

    if p3.Task == "Map" then
        if not v5 or v5.Team == game.Teams.Visitor then
            return;
        end;

        local v6 = script.Map:Clone();
        v6.Parent = Debris;
        v6:PivotTo(CFrame.new(0, 4, -297.5));
        VfxManager.DestroyEffect(v6, 15 - v4);
        local v7 = script.FakeSky:Clone();
        v7.Parent = Lighting;
        VfxManager.DestroyEffect(v7, 15 - v4);
        local ClockTime = Lighting.ClockTime;

        if ClockTime ~= 0 then
            Lighting.ClockTime = 0;
        end;

        local MapFolder = workspace:FindFirstChild("MapFolder");

        if MapFolder then
            MapFolder.Parent = ReplicatedStorage;
            task.delay(15 - v4, function() -- Line: 56
                -- upvalues: MapFolder (copy)
                if not workspace:FindFirstChild("MapFolder") then
                    MapFolder.Parent = workspace;
                end;
            end);
        end;

        local v8 = {};
        local Courts2 = workspace:FindFirstChild("Courts2");

        if Courts2 then
            for _, descendant in Courts2:GetDescendants() do
                if descendant:IsA("BasePart") or descendant:IsA("Texture") then
                    local Transparency = descendant.Transparency;
                    v8[descendant] = Transparency;

                    if Transparency ~= 1 then
                        descendant.Transparency = 1;
                        task.delay(15 - v4, function() -- Line: 74
                            -- upvalues: descendant (copy), Transparency (copy)
                            descendant.Transparency = Transparency;
                        end);
                    end;
                end;
            end;
        end;

        DarkScreenEffect();
        task.delay(15 - v4, function() -- Line: 83
            -- upvalues: ClockTime (copy), Lighting (ref), DarkScreenEffect (ref)
            if ClockTime ~= 0 then
                Lighting.ClockTime = ClockTime;
            end;

            DarkScreenEffect();
        end);

        for _, v in game.Teams[Essentials:ActualTeam(v5.Team.Name)]:GetPlayers() do
            if v.Character and (v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Torso")) then
                local v9 = script.Heart:Clone();
                v9.Parent = Debris;
                v9.CFrame = v.Character.Torso.CFrame;
                Essentials:Weld(v9, v.Character.Torso);
                VfxManager.DestroyEffect(v9, 15 - v4);
            end;
        end;

        if v5.Team ~= LocalPlayer.Team then
            Effects:Popup("PACE YOURSELF OR SUFFER.", 3, Color3.fromRGB(133, 0, 0));
            local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
            script.Vignette:Clone();
            local u10 = script.Vignette:Clone();
            u10.Parent = PlayerGui;
            u10.Enabled = true;
            VfxManager.DestroyEffect(u10, 15.25 - v4);
            u10.Vignette2.ImageColor3 = Color3.fromRGB(133, 0, 0);
            local Position = LocalPlayer.Character.HumanoidRootPart.Position;
            local u11 = nil;
            u11 = RunService.Heartbeat:Connect(function(p12) -- Line: 116
                -- upvalues: LocalPlayer (ref), u11 (ref), Position (ref), TweenService (ref), u10 (ref)
                if not (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) then
                    u11:Disconnect();

                    return;
                end;

                local Position2 = LocalPlayer.Character.HumanoidRootPart.Position;
                local Magnitude = (Position2 - Position).Magnitude;
                TweenService:Create(u10.Vignette2, TweenInfo.new(0.25), {
                    ImageTransparency = 1 - Magnitude / p12 / 25
                }):Play();
                Position = Position2;
            end);
            local u13 = SfxManager:playSound({
                Sound = "BBZ Kira Pulse",
                Parent = workspace
            });
            VfxManager.DestroyEffect(u13, 15.25 - v4);
            task.delay(15 - v4, function() -- Line: 133
                -- upvalues: u11 (ref), TweenService (ref), u10 (ref), u13 (copy)
                u11:Disconnect();
                TweenService:Create(u10.Vignette2, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    ImageTransparency = 1
                }):Play();
                TweenService:Create(u13, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Volume = 0
                }):Play();
            end);
        end;

        local v14 = tick();

        repeat
            task.wait(0.1);
            local v15 = Essentials:CreateClone(Character);
            VfxManager.DestroyEffect(v15, 1);
        until tick() - v14 > 15 - v4;
    elseif p3.Task == "Stun" then
        KiraScreenEffect();
        Effects:Popup(`Slow down {u1[math.random(1, #u1)]}!`, 1, Color3.fromRGB(133, 0, 0));
    end;
end;