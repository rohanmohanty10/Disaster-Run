  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("HttpService");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local u1 = { "Right Leg", "Right Arm", "Left Leg", "Left Arm" };

local function EmitAll(p2) -- Line: 17
    for _, descendant in pairs(p2:GetDescendants()) do
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

local function EmitBeam(p3, u4) -- Line: 35
    -- upvalues: TweenService (copy)
    for _, descendant in pairs(p3:GetDescendants()) do
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
            task.delay(u4, function() -- Line: 49
                -- upvalues: TweenService (ref), descendant (copy), u4 (copy)
                TweenService:Create(descendant, TweenInfo.new(u4 / 2), {
                    Width0 = 0,
                    Width1 = 0
                }):Play();
            end);
        end;
    end;
end;

return function(p5) -- Line: 58
    -- upvalues: SpectatorController (copy), SoundManager (copy), ReplicatedStorage (copy), EmitAll (copy), Players (copy), TweenService (copy), u1 (copy), Essentials (copy), EmitBeam (copy), RunService (copy), Debris (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char1 = p5.Char1;
    local Char2 = p5.Char2;
    local Folder = Instance.new("Folder");
    Folder.Parent = workspace.Debris;
    local u6 = {};
    tick();
    local _ = game.Workspace.CurrentCamera.FieldOfView;
    local u7 = 0;
    local u8 = nil;
    u8 = game:GetService("RunService").RenderStepped:Connect(function(p9) -- Line: 74
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
    SoundManager.SpawnSound("OtoyaBachiraCR", 0.8, workspace, 150);
    local NagiCam = workspace:WaitForChild("NagiCam", 4);
    local v11 = script.ScreenEffectsMain:Clone();
    v11.Parent = Folder;
    local u12 = script.OtoyaScreen:Clone();
    u12.Parent = Folder;
    local Motor6D = Instance.new("Motor6D");
    Motor6D.Parent = v11;
    Motor6D.Part0 = NagiCam.CamPart;
    Motor6D.Part1 = v11;
    Motor6D.C0 = CFrame.new(0, 0, -1.123);
    local Motor6D2 = Instance.new("Motor6D");
    Motor6D2.Parent = u12;
    Motor6D2.Part0 = NagiCam.CamPart;
    Motor6D2.Part1 = u12;
    Motor6D2.C0 = CFrame.new(0.126, -0.003, -1.1) * CFrame.fromOrientation(-0.00006981317007977319, 0.039322268047432246, 0.00027925268031909274);
    local v13 = script.Monster:Clone();
    v13.RootPart.CFrame = Char1.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0) * CFrame.fromOrientation(0, 3.141592653589793, 0);
    v13.Parent = Folder;
    v13.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.ReplicatedAnims.OtoyaXBachiraMonster):Play();
    EmitAll(v11);
    local v14 = script.VignetteGuiOtoya:Clone();
    v14.Overlay.ImageTransparency = 1;
    table.insert(u6, v14);
    v14.Parent = Players.LocalPlayer.PlayerGui;
    TweenService:Create(v14.Overlay, TweenInfo.new(0.1), {
        ImageTransparency = 0
    }):Play();

    for i, v in pairs({ Char1, Char2 }) do
        local v15 = i == 1 and script.BachiraAura or script.OtoyaAura;
        local v16 = i;
        local v17 = v;

        for _, v2 in pairs(u1) do
            local v18 = v2;

            for _, child in pairs(v15:GetChildren()) do
                local v19 = child:Clone();
                v19.Parent = v17[v18];
                table.insert(u6, v19);
            end;
        end;

        local v20 = v16 == 1 and script.BachiraGlowAura:Clone() or script.OtoyaAura:Clone();
        v20.Parent = Folder;
        v20.CFrame = v17.Torso.CFrame;
        table.insert(u6, v20);
        Essentials:Weld(v20, v17.Torso);
        EmitAll(v20);
        local u21 = v16 == 1 and script.BachiraFace:Clone() or script.OtoyaFace:Clone();
        u21.Parent = Folder;
        u21.CFrame = v17.Head.CFrame;
        table.insert(u6, u21);
        Essentials:Weld(u21, v17.Torso);
        task.delay(2.8, function() -- Line: 147
            -- upvalues: EmitAll (ref), u21 (copy), EmitBeam (ref)
            EmitAll(u21);
            EmitBeam(u21, 3);
        end);
    end;

    task.delay(0, function() -- Line: 155
        -- upvalues: ReplicatedStorage (ref), TweenService (ref)
        local v22 = ReplicatedStorage.Assets.UI.Popup:Clone();
        v22.Parent = game.Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        v22.Position = UDim2.new(0.5, 0, 0.8, 0);
        v22.Size = UDim2.new(1, 0, 0.1, 0);
        v22.BackgroundTransparency = 1;
        v22.AnchorPoint = Vector2.new(0.5, 0.5);
        v22.Font = Enum.Font.ArialBold;
        v22.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = v22;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        v22.MaxVisibleGraphemes = 0;
        v22.TextTransparency = 0;
        v22.TextStrokeTransparency = 0;
        UIStroke.Transparency = 0;
        v22.TextColor3 = Color3.new(1, 0.772549, 0.243137);
        v22.Text = "I\'ll leave the rest to you!";
        TweenService:Create(v22, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            MaxVisibleGraphemes = #v22.Text
        }):Play();
        task.wait(1.5);
        v22.MaxVisibleGraphemes = 0;
        v22.TextTransparency = 0;
        v22.TextStrokeTransparency = 0;
        UIStroke.Transparency = 0;
        task.wait(0.5);
        v22.TextColor3 = Color3.new(0.235294, 1, 0.45098);
        v22.Text = "Sup!";
        TweenService:Create(v22, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            MaxVisibleGraphemes = #v22.Text
        }):Play();
        task.wait(1);
        v22.MaxVisibleGraphemes = 0;
        v22.TextTransparency = 0;
        v22.TextStrokeTransparency = 0;
        UIStroke.Transparency = 0;
        task.wait(0.7);
        v22.TextColor3 = Color3.new(1, 0.772549, 0.243137);
        v22.Text = "BOOM!!!";
        TweenService:Create(v22, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            MaxVisibleGraphemes = #v22.Text
        }):Play();
        task.wait(1.5);
        v22.MaxVisibleGraphemes = 0;
        v22.TextTransparency = 0;
        v22.TextStrokeTransparency = 0;
        UIStroke.Transparency = 0;
        v22.TextColor3 = Color3.new(0.235294, 1, 0.45098);
        v22.Text = "Your speed...";
        TweenService:Create(v22, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            MaxVisibleGraphemes = #v22.Text
        }):Play();
        task.wait(2);
        v22.MaxVisibleGraphemes = 0;
        v22.TextTransparency = 0;
        v22.TextStrokeTransparency = 0;
        UIStroke.Transparency = 0;
        task.wait(1);
        v22.TextColor3 = Color3.new(0.235294, 1, 0.45098);
        v22.Text = "GETS ME EXCITED!";
        TweenService:Create(v22, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            MaxVisibleGraphemes = #v22.Text
        }):Play();
        task.wait(1);
        v22.MaxVisibleGraphemes = 0;
        v22.TextTransparency = 0;
        v22.TextStrokeTransparency = 0;
        UIStroke.Transparency = 0;
    end);
    task.delay(5.5, function() -- Line: 244
        -- upvalues: EmitAll (ref), u12 (copy)
        EmitAll(u12);
    end);
    task.delay(6.5, function() -- Line: 248
        -- upvalues: Folder (copy), Char2 (copy), u6 (copy), EmitBeam (ref)
        local v23 = script.WindBlaze:Clone();
        v23.Parent = Folder;
        v23.CFrame = Char2.HumanoidRootPart.CFrame * CFrame.new(4.303, 4.686, -61.914) * CFrame.fromOrientation(0.1007753110101526, -0.9800896414574157, 1.1056835344309277);
        table.insert(u6, v23);
        EmitBeam(v23, 1.5);
    end);
    task.delay(10.1, function() -- Line: 257
        -- upvalues: Char1 (copy), Folder (copy), u6 (copy), EmitAll (ref)
        local v24 = script.Blitz:Clone();
        v24.CFrame = Char1.HumanoidRootPart.CFrame * CFrame.new(6.484, 6.285, -63.78) * CFrame.fromOrientation(0, -1.5707963267948966, 0);
        v24.Parent = Folder;
        table.insert(u6, v24);
        EmitAll(v24);
    end);
    task.delay(3.7, function() -- Line: 265
        -- upvalues: Char1 (copy), Folder (copy), u6 (copy), EmitAll (ref)
        local v25 = script.Kick:Clone();
        v25.CFrame = Char1.HumanoidRootPart.CFrame * CFrame.new(0.341, -0.2, -8.544);
        v25.Parent = Folder;
        table.insert(u6, v25);
        EmitAll(v25);
    end);
    task.delay(6.3, function() -- Line: 273
        -- upvalues: Char1 (copy), Folder (copy), u6 (copy), EmitAll (ref)
        local v26 = script.SpeedLines:Clone();
        v26.CFrame = Char1.HumanoidRootPart.CFrame * CFrame.new(3.902, 4, -63.78) * CFrame.fromOrientation(0, -1.5707963267948966, 1.5707963267948966);
        v26.Parent = Folder;
        table.insert(u6, v26);
        EmitAll(v26);
    end);
    local u27 = RunService.Heartbeat:Connect(function() -- Line: 282
        -- upvalues: Char2 (copy), Char1 (copy)
        Char2:PivotTo(Char1:GetPivot());
    end);
    task.delay(10, function() -- Line: 286
        -- upvalues: u27 (ref)
        u27:Disconnect();
    end);
    task.delay(12, function() -- Line: 290
        -- upvalues: Debris (ref), Folder (copy), u6 (copy)
        print("Erm what the sigma");
        Debris:AddItem(Folder, 0);

        for _, v in pairs(u6) do
            Debris:AddItem(v, 0);
        end;
    end);
end;