  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("HttpService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

local function EmitAll(p1) -- Line: 17
    for _, descendant in pairs(p1:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            task.spawn(function() -- Line: 20
                -- upvalues: descendant (copy)
                if descendant:GetAttribute("EmitCount") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;

                if descendant:GetAttribute("EmitDuration") then
                    descendant.Enabled = true;
                    task.wait(descendant:GetAttribute("EmitDuration"));
                    descendant.Enabled = false;
                end;
            end);
        end;
    end;
end;

local function EmitBeam(p2, u3) -- Line: 35
    -- upvalues: TweenService (copy)
    for _, descendant in pairs(p2:GetDescendants()) do
        if descendant:IsA("Beam") then
            local Width0 = descendant.Width0;
            local Width1 = descendant.Width1;
            descendant.Width0 = 0;
            descendant.Width1 = 0;
            descendant.Enabled = true;
            TweenService:Create(descendant, TweenInfo.new(0.25), {
                Width0 = Width0,
                Width1 = Width1
            }):Play();
            task.delay(u3, function() -- Line: 49
                -- upvalues: TweenService (ref), descendant (copy), u3 (copy)
                TweenService:Create(descendant, TweenInfo.new(u3 / 2), {
                    Width0 = 0,
                    Width1 = 0
                }):Play();
            end);
        end;
    end;
end;

return function(p4) -- Line: 58
    -- upvalues: SpectatorController (copy), ReplicatedStorage (copy), TweenService (copy), Debris (copy), RunService (copy), VfxManager (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char1 = p4.Char1;
    local Char2 = p4.Char2;
    local Folder = Instance.new("Folder");
    Folder.Parent = workspace.Debris;
    local u5 = {};
    tick();
    task.delay(0, function() -- Line: 73
        -- upvalues: ReplicatedStorage (ref), TweenService (ref)
        local v6 = ReplicatedStorage.Assets.UI.Popup:Clone();
        v6.Parent = game.Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        v6.Position = UDim2.new(0.5, 0, 0.8, 0);
        v6.Size = UDim2.new(1, 0, 0.1, 0);
        v6.BackgroundTransparency = 1;
        v6.AnchorPoint = Vector2.new(0.5, 0.5);
        v6.Font = Enum.Font.ArialBold;
        v6.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = v6;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        v6.MaxVisibleGraphemes = 0;
        v6.TextTransparency = 0;
        v6.TextStrokeTransparency = 0;
        UIStroke.Transparency = 0;
        v6.TextColor3 = Color3.new(1, 0.772549, 0.243137);
        v6.Text = "Give me the ball!";
        TweenService:Create(v6, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            MaxVisibleGraphemes = #v6.Text
        }):Play();
        task.wait(0.5);
        v6.MaxVisibleGraphemes = 0;
        v6.TextTransparency = 0;
        v6.TextStrokeTransparency = 0;
        UIStroke.Transparency = 0;
        v6.TextColor3 = Color3.new(0.235294, 1, 0.45098);
        v6.Text = "Being Relentless...";
        TweenService:Create(v6, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            MaxVisibleGraphemes = #v6.Text
        }):Play();
        task.wait(1);
        v6.MaxVisibleGraphemes = 0;
        v6.TextTransparency = 0;
        v6.TextStrokeTransparency = 0;
        UIStroke.Transparency = 0;
        task.wait(2);
        v6.TextColor3 = Color3.new(1, 0.772549, 0.243137);
        v6.Text = "Isn\'t my ego type!";
        TweenService:Create(v6, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            MaxVisibleGraphemes = #v6.Text
        }):Play();
        task.wait(1.5);
        v6.MaxVisibleGraphemes = 0;
        v6.TextTransparency = 0;
        v6.TextStrokeTransparency = 0;
        UIStroke.Transparency = 0;
        v6.TextColor3 = Color3.new(0.235294, 1, 0.45098);
        v6.Text = " I am a...";
        TweenService:Create(v6, TweenInfo.new(0.7, Enum.EasingStyle.Linear), {
            MaxVisibleGraphemes = #v6.Text
        }):Play();
        task.wait(1);
        v6.MaxVisibleGraphemes = 0;
        v6.TextTransparency = 0;
        v6.TextStrokeTransparency = 0;
        UIStroke.Transparency = 0;
        v6.TextColor3 = Color3.new(0.235294, 1, 0.45098);
        v6.Text = "STRIKER!";
        TweenService:Create(v6, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            MaxVisibleGraphemes = #v6.Text
        }):Play();
        task.wait(1.3);
        v6.MaxVisibleGraphemes = 0;
        v6.TextTransparency = 0;
        v6.TextStrokeTransparency = 0;
        UIStroke.Transparency = 0;
        v6.TextColor3 = Color3.new(0.235294, 1, 0.45098);
        v6.Text = "DIRECT...";
        TweenService:Create(v6, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            MaxVisibleGraphemes = #v6.Text
        }):Play();
        task.wait(3);
        v6.MaxVisibleGraphemes = 0;
        v6.TextTransparency = 0;
        v6.TextStrokeTransparency = 0;
        UIStroke.Transparency = 0;
        v6.TextColor3 = Color3.new(1, 0, 0.0156863);
        v6.Text = "SHOT!!!";
        TweenService:Create(v6, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            MaxVisibleGraphemes = #v6.Text
        }):Play();
        task.wait(1);
        v6.MaxVisibleGraphemes = 0;
        v6.TextTransparency = 0;
        v6.TextStrokeTransparency = 0;
        UIStroke.Transparency = 0;
        v6.TextColor3 = Color3.new(0.235294, 1, 0.45098);
    end);
    local _ = game.Workspace.CurrentCamera.FieldOfView;
    local u7 = 0;
    local u8 = nil;
    u8 = game:GetService("RunService").RenderStepped:Connect(function(p9) -- Line: 188
        -- upvalues: u7 (ref), u8 (ref)
        u7 = u7 + p9 * 60;
        local script_FOV = script.FOV;
        local math_ceil_ret = math.ceil(u7);
        local v10 = script_FOV:FindFirstChild((tonumber(math_ceil_ret)));

        if v10 then
            game.Workspace.CurrentCamera.FieldOfView = v10.Value;

            return;
        end;

        u8:Disconnect();
    end);
    local NagiCam = workspace:WaitForChild("NagiCam", 4);
    local u11 = script.VFX:Clone();
    u11.Parent = Folder;
    u11:PivotTo(Char2.HumanoidRootPart.CFrame);
    local SpeedLines = u11.SpeedLines;
    local v12 = SpeedLines["Camera Lines"];
    local v13 = SpeedLines["Camera Lines2"];
    local Motor6D = Instance.new("Motor6D");
    Motor6D.Part0 = NagiCam.CamPart;
    Motor6D.Part1 = v12;
    Motor6D.C0 = CFrame.new(0.045, -0.325, -1.268) * CFrame.Angles(0.070179689222692, -3.1381892615484044, -1.5705519806996175);
    Motor6D.C1 = CFrame.new(-0.383, -0.756, 0) * CFrame.Angles(0, 0, -0.6981317007977318);
    Motor6D.Parent = NagiCam.CamPart;
    local Motor6D2 = Instance.new("Motor6D");
    Motor6D2.Part0 = NagiCam.CamPart;
    Motor6D2.Part1 = v13;
    Motor6D2.C0 = CFrame.new(0.098, 0.56, -1.331) * CFrame.Angles(0.070179689222692, -3.1381892615484044, -1.5705519806996175);
    Motor6D2.C1 = CFrame.new(0.367, -0.437, -0) * CFrame.Angles(0, 0, -0.8726646259971648);
    Motor6D2.Parent = NagiCam.CamPart;
    local Circles = u11.Circles;
    local Motor6D3 = Instance.new("Motor6D");
    Motor6D3.Part0 = NagiCam.CamPart;
    Motor6D3.Part1 = Circles;
    Motor6D3.C0 = CFrame.new(-0.004, -0.01, -0.313) * CFrame.Angles(0.03298672286269283, 0.0043982297150257105, -0.00047123889803846896);
    Motor6D3.C1 = CFrame.new(0, 0, -0.104);
    Motor6D3.Parent = NagiCam.CamPart;
    local IncomingBall = u11.IncomingBall;
    local Motor6D4 = Instance.new("Motor6D");
    Motor6D4.Part0 = NagiCam.CamPart;
    Motor6D4.Part1 = IncomingBall;
    Motor6D4.C0 = CFrame.new(-0.007, 0.018, -1.162) * CFrame.Angles(0.03298672286269283, 0.0043982297150257105, -0.00047123889803846896);
    Motor6D4.C1 = CFrame.new(0, 0, 0.56);
    Motor6D4.Parent = NagiCam.CamPart;
    local OtherAura = u11.OtherAura;
    local Motor6D5 = Instance.new("Motor6D");
    Motor6D5.Part0 = Char2.Torso;
    Motor6D5.Part1 = OtherAura;
    Motor6D5.Parent = Char2.Torso;
    Debris:AddItem(Motor6D5, 12);
    local GlowAura = u11.GlowAura;
    local Motor6D6 = Instance.new("Motor6D");
    Motor6D6.Part0 = Char1.Torso;
    Motor6D6.Part1 = GlowAura;
    Motor6D6.Parent = Char2.Torso;
    Debris:AddItem(Motor6D6, 12);
    local u14 = RunService.Heartbeat:Connect(function() -- Line: 261
        -- upvalues: OtherAura (copy), Char2 (copy), GlowAura (copy), Char1 (copy)
        OtherAura.CFrame = Char2.Torso.CFrame;
        GlowAura.CFrame = Char1.Torso.CFrame;
    end);
    task.delay(3.44, function() -- Line: 266
        -- upvalues: u11 (copy), VfxManager (ref), Circles (copy)
        VfxManager.Emit(u11.Shot);
        task.wait(0.02);
        VfxManager.Emit(Circles);
        task.wait(0.02);
        VfxManager.Emit(u11.Pressure2);
    end);
    task.delay(6.35, function() -- Line: 280
        -- upvalues: VfxManager (ref), IncomingBall (copy), u11 (copy)
        VfxManager.Emit(IncomingBall);
        task.wait(0.02);
        VfxManager.Emit(u11.Pressure);
    end);
    task.delay(7.57, function() -- Line: 288
        -- upvalues: VfxManager (ref), SpeedLines (copy)
        VfxManager.Emit(SpeedLines);
    end);
    task.delay(10.21, function() -- Line: 292
        -- upvalues: u11 (copy), VfxManager (ref)
        VfxManager.Emit(u11.Pressure);
    end);
    task.delay(12, function() -- Line: 297
        -- upvalues: u5 (copy), Debris (ref), Motor6D5 (copy), Motor6D6 (copy), Folder (copy), u14 (ref)
        print("Erm what the sigma");

        for _, v in pairs(u5) do
            Debris:AddItem(v, 0);
        end;

        Motor6D5:Destroy();
        Motor6D6:Destroy();
        Debris:AddItem(Folder, 0);
        u14:Disconnect();
    end);
end;