  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("Debris");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
ReplicatedStorage:FindFirstChild("Assets"):FindFirstChild("Vfx");
local Debris = workspace:FindFirstChild("Debris");

function EnableVFX(p1: userdata, p2: boolean?)
    for _, v in next, p1:GetDescendants() do
        if v:IsA("ParticleEmitter") or (v:IsA("Beam") or v:IsA("Trail")) then
            v.Enabled = p2 or false;
        end;
    end;
end;

function Emit_All_With_Duration(p3)
    local function emit(u4) -- Line: 29
        if u4:IsA("ParticleEmitter") or (u4:IsA("Beam") or u4:IsA("Trail")) then
            local Attribute = u4:GetAttribute("EmitDuration");
            local Attribute2 = u4:GetAttribute("EmitDelay");
            local Attribute3 = u4:GetAttribute("EmitCount");

            if Attribute and Attribute ~= 0 then
                if Attribute2 and Attribute2 ~= 0 then
                    task.delay(Attribute2, function() -- Line: 37
                        -- upvalues: u4 (copy), Attribute (copy)
                        u4.Enabled = true;
                        task.delay(Attribute, function() -- Line: 40
                            -- upvalues: u4 (ref)
                            u4.Enabled = false;
                        end);
                    end);

                    return;
                end;

                u4.Enabled = true;
                task.delay(Attribute, function() -- Line: 47
                    -- upvalues: u4 (copy)
                    u4.Enabled = false;
                end);

                return;
            end;

            if Attribute3 and Attribute3 ~= 0 then
                if Attribute2 and Attribute2 ~= 0 then
                    task.delay(Attribute2, function() -- Line: 54
                        -- upvalues: u4 (copy), Attribute3 (copy)
                        u4:Emit(Attribute3);
                    end);

                    return;
                end;

                u4:Emit(Attribute3);
            end;
        end;
    end;

    if typeof(p3) == "table" then
        for _, v in p3 do
            if v:IsA("ParticleEmitter") or (v:IsA("Beam") or v:IsA("Trail")) then
                emit(v);
            else
                for _, descendant in v:GetDescendants() do
                    emit(descendant);
                end;
            end;
        end;

        return;
    end;

    if p3:IsA("ParticleEmitter") or (p3:IsA("Beam") or p3:IsA("Trail")) then
        emit(p3);

        return;
    end;

    for _, descendant in p3:GetDescendants() do
        emit(descendant);
    end;
end;

local function Destroy_Effect(u5: any, p6: number) -- Line: 86
    task.delay(p6, function() -- Line: 88
        -- upvalues: u5 (copy)
        if typeof(u5) == "table" then
            for _, v in u5 do
                if v then
                    v:Destroy();
                end;
            end;

            return;
        end;

        if u5 then
            u5:Destroy();
        end;
    end);
end;

local function tweenbeam(u7, u8, u9, u10, u11, p12) -- Line: 104
    -- upvalues: RunService (copy), TweenService (copy)
    local u13 = nil;
    local os_clock_ret = os.clock();
    local u14 = nil;
    u14 = RunService.Heartbeat:Connect(function(p15) -- Line: 108
        -- upvalues: u13 (ref), os_clock_ret (copy), u11 (copy), TweenService (ref), u9 (ref), u8 (copy), u10 (copy), u7 (copy), u14 (ref)
        u13 = (os.clock() - os_clock_ret) / u11;
        u13 = TweenService:GetValue(u13, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
        u9 = u8 + (u10 - u8) * u13;
        u7.Transparency = NumberSequence.new(u9, u9);

        if u11 <= os.clock() - os_clock_ret then
            u14:Disconnect();
        end;
    end);
    table.insert(p12, u14);
end;

local function Weld(p16, p17) -- Line: 122
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = p16;
    WeldConstraint.Part1 = p17;
    WeldConstraint.Parent = p16;

    return WeldConstraint;
end;

return function(p18) -- Line: 129
    -- upvalues: SpectatorController (copy), SoundManager (copy), Debris (copy), Knit (copy), VfxManager (copy), ReplicatedStorage (copy), Players (copy), TweenService (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p18.Char;
    local v19;

    if Char then
        v19 = script.Name .. " VFX FOLDER " .. Char.Name;
    else
        v19 = nil;
    end;

    if p18.Task == "Cutscene" then
        if not Char then
            return;
        end;

        if not Char:FindFirstChild("HumanoidRootPart") then
            return;
        end;

        SoundManager.SpawnSound("IgaguriAwakening", 0.7, workspace, 150);
        local Folder = Instance.new("Folder");
        Folder.Name = v19;
        Folder.Parent = Debris;
        Folder:SetAttribute("Active", true);
        task.spawn(function() -- Line: 151
            -- upvalues: Knit (ref), Folder (copy)
            local Controller = Knit.GetController("CameraController");

            while Folder.Parent do
                Controller.Cutscene = true;
                workspace.CurrentCamera.FieldOfView = 30;
                task.wait();
            end;
        end);
        local v20 = script.Aura:Clone();
        VfxManager.Enable(v20, true);

        for _, descendant in v20:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Parent = Char[descendant.Parent.Name];
                descendant:SetAttribute("IgaguriAwakening", true);
            end;
        end;

        task.spawn(function() -- Line: 173
            -- upvalues: ReplicatedStorage (ref), Players (ref), TweenService (ref)
            local v21 = ReplicatedStorage.Assets.UI.Popup:Clone();
            v21.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
            v21.Position = UDim2.new(0.5, 0, 0.8, 0);
            v21.Size = UDim2.new(1, 0, 0.1, 0);
            v21.BackgroundTransparency = 1;
            v21.AnchorPoint = Vector2.new(0.5, 0.5);
            v21.Font = Enum.Font.ArialBold;
            v21.MaxVisibleGraphemes = 0;
            local UIStroke = Instance.new("UIStroke");
            UIStroke.Parent = v21;
            UIStroke.Thickness = 4;
            UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
            v21.MaxVisibleGraphemes = 0;
            v21.TextTransparency = 0;
            v21.TextStrokeTransparency = 0;
            UIStroke.Transparency = 0;
            task.wait(0.3);
            v21.Text = "If the gods won\'t help him...";
            TweenService:Create(v21, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                MaxVisibleGraphemes = #v21.Text
            }):Play();
            task.wait(1.7);
            TweenService:Create(v21, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            task.wait(0.5);
            v21.MaxVisibleGraphemes = 0;
            v21.TextTransparency = 0;
            v21.TextStrokeTransparency = 0;
            UIStroke.Transparency = 0;
            v21.Text = "Then I will help him...";
            TweenService:Create(v21, TweenInfo.new(0.6, Enum.EasingStyle.Linear), {
                MaxVisibleGraphemes = #v21.Text
            }):Play();
            task.wait(1.9);
            v21.MaxVisibleGraphemes = 0;
            v21.TextTransparency = 0;
            v21.TextStrokeTransparency = 0;
            UIStroke.Transparency = 0;
            v21.Text = "And if anyone tries to stop me...";
            TweenService:Create(v21, TweenInfo.new(0.6666666666666666, Enum.EasingStyle.Linear), {
                MaxVisibleGraphemes = #v21.Text
            }):Play();
            task.wait(1.2);
            TweenService:Create(v21, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            task.wait(0.6);
            v21.MaxVisibleGraphemes = 0;
            v21.TextTransparency = 0;
            v21.TextStrokeTransparency = 0;
            UIStroke.Transparency = 0;
            v21.TextColor3 = Color3.fromRGB(255, 255, 0);
            v21.Text = "ULTIMATE FORM!";
            TweenService:Create(v21, TweenInfo.new(0.3333333333333333, Enum.EasingStyle.Linear), {
                MaxVisibleGraphemes = #v21.Text
            }):Play();
            task.wait(2);
            TweenService:Create(v21, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
        end);

        return;
    end;

    if p18.Task ~= "ScreenEffects" then
        if p18.Task == "Cleanup" then
            Knit.GetController("CameraController").Cutscene = false;
            local v22 = nil;

            if v19 then
                v22 = Debris:FindFirstChild(v19);
            else
                for _, child in workspace.Debris:GetChildren() do
                    if string.find(child.Name, "VFX FOLDER") then
                        v22 = child;
                    end;
                end;
            end;

            if Char then
                for _, descendant in Char:GetDescendants() do
                    if descendant:GetAttribute("IgaguriAwakening") then
                        descendant:Destroy();
                    end;
                end;
            end;

            if v22 then
                v22:Destroy();
            end;

            local IgaguriAwakening = workspace:FindFirstChild("IgaguriAwakening");

            if IgaguriAwakening then
                game.TweenService:Create(IgaguriAwakening, TweenInfo.new(1), {
                    Volume = 0
                }):Play();
            end;
        end;

        return;
    end;

    local workspace_AwakeningCam = workspace.AwakeningCam;
    local v23 = Debris:FindFirstChild(v19);
    VfxManager.Enable(workspace_AwakeningCam, true);
    local v24 = script.Emit:Clone();
    v24.CFrame = Char.Torso.CFrame;
    v24.Parent = v23;
    VfxManager.Emit(v24);
    local v25 = script.Sphere:Clone();
    v25.CFrame = Char.HumanoidRootPart.CFrame;
    v25.Parent = v23;
    v25.Transparency = 0;
    local u26 = 0;
    task.spawn(function() -- Line: 278
        -- upvalues: u26 (ref)
        for _, child in game.Players.LocalPlayer.PlayerGui.ImpactFramesIgaguri:GetChildren() do
            child.Position = UDim2.new(0.5, 0, 1.5, 0);
        end;

        game.Players.LocalPlayer.PlayerGui.ImpactFramesIgaguri.Enabled = true;

        for i = 1, 7 do
            task.delay(u26, function() -- Line: 284
                -- upvalues: i (copy)
                local ImpactFramesIgaguri = game.Players.LocalPlayer.PlayerGui.ImpactFramesIgaguri;

                if i > 1 then
                    ImpactFramesIgaguri[`Frame{tostring(i - 1)}`].Position = UDim2.new(0.5, 0, 2, 0);
                end;

                ImpactFramesIgaguri[`Frame{tostring(i)}`].Position = UDim2.new(0.5, 0, 0.5, 0);
            end);
            u26 = u26 + 0.06666666666666667;
            local _ = i;
        end;

        task.delay(u26, function() -- Line: 294
            for _, child in game.Players.LocalPlayer.PlayerGui.ImpactFramesIgaguri:GetChildren() do
                child.Position = UDim2.new(0.5, 0, 1.5, 0);
            end;

            game.Players.LocalPlayer.PlayerGui.ImpactFramesIgaguri.Enabled = false;
        end);
    end);
end;