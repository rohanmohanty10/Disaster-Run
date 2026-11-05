  

 

local LocalPlayer = game.Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
game:GetService("CollectionService");
local _ = game.ReplicatedStorage.Remotes.Output;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
require(PathShortcuts.KnitPath.Promise);

local function toggleWater(p1) -- Line: 15
    -- upvalues: ReplicatedStorage (copy)
    if p1 then
        ReplicatedStorage["Client Assets"]["Big Glass Block"]:Clone().Parent = workspace.CurrentCamera;

        return;
    end;

    for _, child in pairs(workspace.CurrentCamera:GetChildren()) do
        if child.Name == "Big Glass Block" then
            child:Destroy();
        end;
    end;
end;

local u2 = {};

return function(p3, p4, u5, p6, p7, p8) -- Line: 30
    -- upvalues: u2 (copy), Trove (copy), Debris (copy), TweenService (copy), LocalPlayer (copy), RunService (copy), PlayerGui (copy)
    if p3 and u2.DEData then
        u2.DEData.Cleanup();

        return;
    end;

    local v9 = Trove.new();
    local Value = p4.Settings.CosmeticalChanges.Value;
    local v10 = {};
    local v11 = {
        OriginalUser = u5,
        CC = game.Workspace.CurrentCamera,
        ClearParts = {},
        Trove = v9,
        ogBrightness = game.Lighting.Brightness,
        ogAmbient = game.Lighting.Ambient,
        lightingObjects = game.Lighting:GetChildren(),
        OGC0 = u5.HumanoidRootPart.RootJoint.C0
    };
    local v12;

    if Value then
        v12 = u5.Head.BlindfoldWeld.C0 or nil;
    else
        v12 = nil;
    end;

    v11.OGBC0 = v12;
    v11.RandomColors = {
        Color3.fromRGB(255, 0, 127),
        Color3.fromRGB(170, 0, 0),
        Color3.fromRGB(255, 0, 0),
        Color3.fromRGB(170, 0, 255)
    };
    v11.opos = u5.HumanoidRootPart.CFrame;
    v11.Tweens = {};
    v10.Variables = v11;
    local u13 = v10;
    local Variables = u13.Variables;

    function u13.Cleanup() -- Line: 64
        -- upvalues: Variables (copy), u13 (ref), Value (copy), u5 (copy), Debris (ref), TweenService (ref)
        Variables.Trove:Destroy();

        if Variables.Clouds then
            Variables.Clouds.Parent = workspace.Terrain;
        end;

        if u13.cancel then
            workspace.GameMusic.DomainExpansion:Stop();
        end;

        for _, v in pairs(Variables.lightingObjects) do
            pcall(function() -- Line: 73
                -- upvalues: v (copy)
                v.Parent = game.Lighting;
            end);
        end;

        game.Lighting.Brightness = Variables.ogBrightness;
        game.Lighting.Ambient = Variables.ogAmbient;
        pcall(function() -- Line: 79
            -- upvalues: Value (ref), u5 (ref), Variables (ref)
            if Value then
                for _, child in ipairs(u5:GetChildren()) do
                    if string.find(child.Name, "NormalGojoHair") then
                        child.Transparency = 0;

                        for _, child2 in ipairs(child:GetChildren()) do
                            child2.Transparency = 0;
                        end;
                    elseif string.find(child.Name, "GojoHair") then
                        child.Transparency = 1;

                        for _, child2 in ipairs(child:GetChildren()) do
                            child2.Transparency = 1;
                        end;
                    end;
                end;

                u5.Head.BlindfoldWeld.C0 = Variables.OGBC0;
                u5.Blindfold.Transparency = 0;
            end;
        end);

        for _, child in pairs(workspace.CurrentCamera:GetChildren()) do
            if child.Name == "Big Glass Block" then
                child:Destroy();
            end;
        end;

        game.StarterGui:SetCore("ResetButtonCallback", true);

        if Variables.cc then
            Variables.cc.TintColor = Color3.new(1, 1, 1);
            Debris:AddItem(Variables.cc, 0.6);
            TweenService:Create(Variables.cc, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Brightness = 0
            }):Play();
        end;

        if Variables.ClearParts and next(Variables.ClearParts) then
            for i, v in pairs(Variables.ClearParts) do
                if i ~= nil then
                    if type(v) == "boolean" then
                        i.Enabled = v;
                    else
                        i.Transparency = v;
                    end;
                end;
            end;
        end;
    end;

    for _, v in pairs(p7) do
        local Parent = v.Parent;
        v.Parent = nil;
        task.delay(5, function() -- Line: 121
            -- upvalues: v (copy), Parent (copy)
            v.Parent = Parent;
        end);
    end;

    if p8 then
        if Value then
            local BlindfoldWeld = u5.Head.BlindfoldWeld;
            BlindfoldWeld.C0 = BlindfoldWeld.C0 * CFrame.new(0, -0.55, 0);

            for _, child in ipairs(u5:GetChildren()) do
                if string.find(child.Name, "NormalGojoHair") then
                    child.Transparency = 1;

                    for _, child2 in ipairs(child:GetChildren()) do
                        child2.Transparency = 1;
                    end;
                elseif string.find(child.Name, "GojoHair") then
                    child.Transparency = 0;

                    for _, child2 in ipairs(child:GetChildren()) do
                        child2.Transparency = 0;
                    end;
                end;
            end;
        end;
    else
        if u5 == game.Players.LocalPlayer.Character then
            require(game.ReplicatedStorage.ReplicatedModules.Animations).playClient("Gojo", "DEActivate");
        end;

        wait(0.2);

        if Value then
            TweenService:Create(u5.Head.BlindfoldWeld, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                C0 = u5.Head.BlindfoldWeld.C0 * CFrame.new(0, -0.55, 0)
            }):Play();
            task.delay(0.15, function() -- Line: 133
                -- upvalues: u5 (copy), TweenService (ref)
                for _, child in ipairs(u5:GetChildren()) do
                    if string.find(child.Name, "NormalGojoHair") then
                        child.Transparency = 1;

                        for _, child2 in ipairs(child:GetChildren()) do
                            TweenService:Create(child2, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                Transparency = 1
                            }):Play();
                        end;
                    elseif string.find(child.Name, "GojoHair") then
                        child.Transparency = 0;

                        for _, child2 in ipairs(child:GetChildren()) do
                            TweenService:Create(child2, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                Transparency = 0
                            }):Play();
                        end;
                    end;
                end;
            end);
        end;

        wait(0.55);
    end;

    Variables.Clouds = workspace.Terrain:FindFirstChildWhichIsA("Clouds") or nil;

    if Variables.Clouds then
        Variables.Clouds.Parent = nil;
    end;

    local v14 = game.ReplicatedStorage["Client Assets"].Galaxy:Clone();
    v14.Parent = game.Lighting;
    v9:Add(v14);
    local u15 = false;
    local u16 = false;
    v9:Connect(LocalPlayer.Character:GetPropertyChangedSignal("Parent"), function() -- Line: 179
        -- upvalues: u15 (ref), u16 (ref), u13 (ref)
        u15 = true;
        u16 = true;
        u13.Cleanup();
    end);

    local function _(p17) -- Line: 185
        -- upvalues: RunService (ref), u15 (ref)
        local v18 = 0;

        repeat
            v18 = v18 + RunService.Heartbeat:Wait();
        until (p17 or 0) <= v18 or u15 == true;

        return v18;
    end;

    local v19 = u5.HumanoidRootPart.Interrupt:Clone();
    v19.Parent = workspace;
    v19.PlayOnRemove = true;
    v19:Destroy();

    if Value then
        local _ = u5.Head.BlindfoldWeld.C0;
        u5.Blindfold.Transparency = 1;
    end;

    Random.new();
    local u20 = {
        Color3.fromRGB(255, 0, 127),
        Color3.fromRGB(170, 0, 0),
        Color3.fromRGB(255, 0, 0),
        Color3.fromRGB(170, 0, 255)
    };
    local u21 = {};

    for _, v in pairs(p6) do
        pcall(function() -- Line: 209
            -- upvalues: v (copy), u21 (copy)
            for _, descendant in pairs(v:GetDescendants()) do
                if descendant:IsA("BasePart") or descendant:IsA("Decal") then
                    table.insert(u21, descendant);
                end;
            end;
        end);
    end;

    local ScreenGui = Instance.new("ScreenGui", PlayerGui);
    ScreenGui.Name = "WhiteScreen";
    ScreenGui.IgnoreGuiInset = true;
    local Frame = Instance.new("Frame", ScreenGui);
    Frame.BackgroundColor3 = Color3.new(1, 1, 1);
    Frame.Size = UDim2.new(1, 0, 1, 0);
    Frame.BackgroundTransparency = 1;
    Frame.ZIndex = 10000;
    ScreenGui.Enabled = true;
    ScreenGui.Frame.BackgroundTransparency = 0;
    TweenService:Create(ScreenGui.Frame, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    }):Play();
    v9:Add(Frame);
    v9:Add(ScreenGui);
    game.Lighting.Brightness = 0;
    game.Lighting.Ambient = Color3.fromRGB(136, 0, 255);

    for _, v in pairs(Variables.lightingObjects) do
        pcall(function() -- Line: 256
            -- upvalues: v (copy)
            v.Parent = nil;
        end);
    end;

    game.Lighting.Brightness = 0;
    u2.DEData = u13;
    delay(0.1, function() -- Line: 267
        -- upvalues: u20 (copy), LocalPlayer (ref), TweenService (ref)
        for _ = 1, 15 do
            for _ = 1, 15 do
                local v22 = u20[math.random(#u20)];
                local v23 = game.ReplicatedStorage["Client Assets"].Gojo.DomainPart:Clone();
                v23.Parent = game.Workspace.Effects;
                v23.Trail.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v22), ColorSequenceKeypoint.new(1, v22) });
                v23.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(math.random(-20, 20), math.random(-20, 20), 100);
                TweenService:Create(v23, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    CFrame = v23.CFrame * CFrame.new(0, 0, -200)
                }):Play();
                task.delay(0.6, v23.Destroy, v23);
            end;
        end;

        task.wait(0.05);
    end);
    local Folder = Instance.new("Folder", workspace.Effects);
    Folder.Name = "Gojo Stuff";
    v9:Add(Folder);
end;