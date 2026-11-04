 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local Trove = require(ReplicatedStorage.Shared.Utility.Trove);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, u2) -- Line: 18
    -- upvalues: Players (copy), Debris (copy), Essentials (copy), SfxManager (copy), VfxManager (copy), TweenService (copy), Trove (copy), LocalPlayer (copy), Lighting (copy), RunService (copy)
    local TimeSent = u2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local _ = u1.BallController;
    local _ = u1.CameraController;
    local Character = u2.Character;
    local Other = u2.Other;
    local Team = Players:FindFirstChild(Character.Name).Team;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local BALL = Character:FindFirstChild("BALL", true);

    if u2.Task ~= "Tri-Slash" then
        if u2.Task == "Blade Dash" then
            local Torso = Character:FindFirstChild("Torso");

            if not Torso then
                return;
            end;

            SfxManager:playSound({
                Sound = "BBZ Eclipse Blade Dash",
                Parent = HumanoidRootPart
            });
            local Model = Instance.new("Model");
            Model.Parent = Debris;

            for _, child in pairs(script.AuraBodyPartsToWeld:GetChildren()) do
                local v4 = Character:FindFirstChild(child.Name);

                if v4 then
                    local v5 = child:Clone();
                    v5.CFrame = v4.CFrame;
                    v5.Parent = Model;
                    Essentials:Weld(v5, v4);
                end;
            end;

            local u6 = script.Torso:Clone();
            u6.Parent = Debris;
            local u7 = nil;
            u7 = RunService.RenderStepped:Connect(function() -- Line: 246
                -- upvalues: Torso (copy), u6 (copy), Debris (ref), u7 (ref), HumanoidRootPart (copy)
                if Torso and (u6 and u6:IsDescendantOf(Debris)) then
                    u6.CFrame = CFrame.new(Torso.Position) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());

                    return;
                end;

                u7:Disconnect();
            end);
            task.spawn(function() -- Line: 255
                -- upvalues: VfxManager (ref), Model (copy), u6 (copy), Essentials (ref), Character (copy)
                VfxManager.Enable(Model, true);
                VfxManager.Enable(u6, true);
                local v8 = tick();

                repeat
                    task.wait(0.1);
                    local v9 = Essentials:CreateClone(Character);
                    VfxManager.DestroyEffect(v9, 1);
                until tick() - v8 > 0.5;
            end);
            task.delay(u2.Time * 10 / 60 - v3, function() -- Line: 266
                -- upvalues: Other (copy), SfxManager (ref), Debris (ref), VfxManager (ref)
                if Other and Other:FindFirstChild("HumanoidRootPart") then
                    SfxManager:playSound({
                        Sound = "BBZ Eclipse Blade Dash Enemy",
                        Parent = Other.HumanoidRootPart
                    });
                    local v10 = script.Mark:Clone();
                    v10.Parent = Debris;
                    v10.CFrame = Other.HumanoidRootPart.CFrame;
                    VfxManager.Emit(v10);
                    VfxManager.DestroyEffect(v10, 2);
                end;
            end);
            task.delay(0.5 - v3, function() -- Line: 279
                -- upvalues: VfxManager (ref), Model (copy), u6 (copy)
                VfxManager.Enable(Model, false);
                VfxManager.Enable(u6, false);
                VfxManager.DestroyEffect(Model, 2);
                VfxManager.DestroyEffect(u6, 2);
            end);
        end;

        return;
    end;

    local u11 = script.Ball:Clone();
    u11.Parent = Debris;
    u11.CFrame = BALL.CFrame;
    Essentials:Weld(u11, BALL);
    local u12 = script.Triangle:Clone();
    u12.Parent = Debris;
    u12.CFrame = u2.CFrame * CFrame.new(0, -2.5, -32.47595264191645);
    task.delay(0.9666666666666667 - v3, function() -- Line: 43
        -- upvalues: SfxManager (ref), HumanoidRootPart (copy), Debris (ref), u2 (copy), VfxManager (ref), u12 (copy), TweenService (ref)
        SfxManager:playSound({
            Sound = "BBZ Eclipse Tri-Slash",
            Parent = HumanoidRootPart
        });
        local v13 = script.A:Clone();
        v13.Parent = Debris;
        v13.CFrame = CFrame.new(u2.Positions[1], u2.Positions[2]);
        VfxManager.Emit(v13);
        VfxManager.DestroyEffect(v13, 6);
        VfxManager.Enable(u12.A, true);

        for _, descendant in pairs(u12.A:GetDescendants()) do
            if descendant:IsA("Beam") then
                local Width0 = descendant.Width0;
                local Width1 = descendant.Width1;
                descendant.Width0 = 0;
                descendant.Width1 = 0;
                TweenService:Create(descendant, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    Width0 = Width0,
                    Width1 = Width1
                }):Play();
            end;
        end;
    end);
    task.delay(1.6666666666666667 - v3, function() -- Line: 66
        -- upvalues: Debris (ref), u2 (copy), VfxManager (ref), u12 (copy), TweenService (ref)
        local v14 = script.B:Clone();
        v14.Parent = Debris;
        v14.CFrame = CFrame.new(u2.Positions[2], u2.Positions[3]);
        VfxManager.Emit(v14);
        VfxManager.DestroyEffect(v14, 6);
        VfxManager.Enable(u12.B, true);

        for _, descendant in pairs(u12.B:GetDescendants()) do
            if descendant:IsA("Beam") then
                local Width0 = descendant.Width0;
                local Width1 = descendant.Width1;
                descendant.Width0 = 0;
                descendant.Width1 = 0;
                TweenService:Create(descendant, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    Width0 = Width0,
                    Width1 = Width1
                }):Play();
            end;
        end;
    end);
    task.delay(2.3666666666666667 - v3, function() -- Line: 87
        -- upvalues: Debris (ref), u2 (copy), VfxManager (ref), u12 (copy), TweenService (ref)
        local v15 = script.C:Clone();
        v15.Parent = Debris;
        v15.CFrame = CFrame.new(u2.Positions[3], u2.Positions[1]);
        VfxManager.Emit(v15);
        VfxManager.DestroyEffect(v15, 6);
        local v16 = script.TriangleEmit:Clone();
        v16.Parent = Debris;
        v16.CFrame = u2.CFrame;
        VfxManager.Emit(v16);
        VfxManager.DestroyEffect(v16, 6);
        VfxManager.Enable(u12, true);

        for _, descendant in pairs(u12.C:GetDescendants()) do
            if descendant:IsA("Beam") then
                local Width0 = descendant.Width0;
                local Width1 = descendant.Width1;
                descendant.Width0 = 0;
                descendant.Width1 = 0;
                TweenService:Create(descendant, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    Width0 = Width0,
                    Width1 = Width1
                }):Play();
            end;
        end;
    end);
    task.delay(2.75 - v3, function() -- Line: 114
        -- upvalues: VfxManager (ref), u11 (copy)
        VfxManager.Enable(u11, false);
        VfxManager.DestroyEffect(u11, 2);
    end);
    local u17 = nil;
    local u18 = Trove.new();

    local function Remove() -- Line: 122
        -- upvalues: LocalPlayer (ref), u18 (copy)
        LocalPlayer:SetAttribute("Tri-SlashSpeedBoost", nil);
        u18:Clean();
    end;

    local function Apply() -- Line: 127
        -- upvalues: LocalPlayer (ref), Team (copy), Lighting (ref), u18 (copy)
        LocalPlayer:SetAttribute("Tri-SlashSpeedBoost", LocalPlayer.Team == Team and 4 or -8);
        local ColorCorrection = Lighting.ColorCorrection;
        local v19 = u18:Add(Instance.new("ColorCorrectionEffect", Lighting));
        v19.Name = "CC";
        v19.Saturation = -ColorCorrection.Saturation - 1;
        v19.TintColor = Color3.fromRGB(255, 0, 0);
        local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
        local v20 = u18:Add(script.Vignette:Clone());
        v20.Parent = PlayerGui;
        v20.Enabled = true;
        local Vignette = v20.Vignette;
        local Vignette1 = v20.Vignette1;
        Vignette.ImageTransparency = 0;
        Vignette1.ImageTransparency = 0;
        Vignette.ImageColor3 = Color3.fromRGB(0, 0, 0);
        Vignette1.ImageColor3 = Color3.fromRGB(0, 0, 0);
    end;

    task.delay(2.3666666666666667 - v3, function() -- Line: 151
        -- upvalues: LocalPlayer (ref), u17 (ref), RunService (ref), u2 (copy), u1 (copy), Essentials (ref), Team (copy), Apply (copy), u18 (copy)
        local u21 = nil;
        local FieldOfView = workspace.CurrentCamera.FieldOfView;
        local u22 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart");

        if not u22 then
            return;
        end;

        u17 = RunService.Heartbeat:Connect(function(p23) -- Line: 157
            -- upvalues: u2 (ref), u22 (copy), u1 (ref), FieldOfView (ref), Essentials (ref), LocalPlayer (ref), Team (ref), u21 (ref), Apply (ref), u18 (ref)
            if CFrame.new(u2.Positions[1], u2.Positions[2]):ToObjectSpace(u22.CFrame).X > 0 and (CFrame.new(u2.Positions[2], u2.Positions[3]):ToObjectSpace(u22.CFrame).X > 0 and CFrame.new(u2.Positions[3], u2.Positions[1]):ToObjectSpace(u22.CFrame).X > 0) then
                u1.CameraController.FOVActive = false;
                FieldOfView = Essentials:Lerp(FieldOfView, LocalPlayer.Team == Team and 90 or 45, p23 * 5);
                workspace.CurrentCamera.FieldOfView = FieldOfView;

                if not u21 then
                    u21 = true;
                    Apply();
                end;
            else
                u1.CameraController.FOVActive = true;
                FieldOfView = workspace.CurrentCamera.FieldOfView;

                if u21 then
                    u21 = nil;
                    LocalPlayer:SetAttribute("Tri-SlashSpeedBoost", nil);
                    u18:Clean();
                end;
            end;
        end);
    end);
    task.delay(15 - v3, function() -- Line: 181
        -- upvalues: u1 (copy), u17 (ref), LocalPlayer (ref), u18 (copy), u12 (copy), TweenService (ref), VfxManager (ref)
        u1.CameraController.FOVActive = true;

        if u17 then
            u17:Disconnect();
            LocalPlayer:SetAttribute("Tri-SlashSpeedBoost", nil);
            u18:Clean();
        end;

        local u24 = {};
        local u25 = {};

        for _, descendant in pairs(u12:GetDescendants()) do
            if descendant:IsA("Beam") then
                table.insert(u24, descendant);
                u25[descendant] = {};
                local v26 = descendant;

                for i, v in ipairs(descendant.Transparency.Keypoints) do
                    u25[v26][i] = {
                        Start = v.Value,
                        Needed = 1 - v.Value
                    };
                end;
            end;
        end;

        local NumberValue = Instance.new("NumberValue");
        NumberValue.Changed:Connect(function() -- Line: 207
            -- upvalues: u24 (copy), u25 (copy), NumberValue (copy)
            for _, v in u24 do
                local v27 = v;
                local v28 = {};

                for i, v2 in ipairs(v.Transparency.Keypoints) do
                    table.insert(v28, NumberSequenceKeypoint.new(v2.Time, u25[v27][i].Start + u25[v27][i].Needed * NumberValue.Value));
                end;

                v27.Transparency = NumberSequence.new(v28);
            end;
        end);
        TweenService:Create(NumberValue, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Value = 1
        }):Play();
        VfxManager.DestroyEffect(NumberValue, 2);
        VfxManager.DestroyEffect(u12, 2);
    end);
end;