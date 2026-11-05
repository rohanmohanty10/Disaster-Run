  

 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local ReplicatedModules = ReplicatedStorage:FindFirstChild("ReplicatedModules");
local PathShortcuts = require(ReplicatedModules:FindFirstChild("PathShortcuts"));
local Trove = require(PathShortcuts.KnitPath.Trove);
local SoundGroups = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules"):WaitForChild("SoundGroups"));
local LocalPlayer = Players.LocalPlayer;
local CurrentCamera = workspace.CurrentCamera;

local function formatNumber(p1) -- Line: 16
    local v2 = string.format("%d", p1);
    local v3, v4, v5 = string.match(v2, "^([^%d]*%d)(%d*)(.-)$");

    return v3 .. v4:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. v5;
end;

return function(p6) -- Line: 23
    -- upvalues: Trove (copy), SoundGroups (copy), formatNumber (copy), LocalPlayer (copy), RunService (copy), CurrentCamera (copy), TweenService (copy)
    local v7 = p6 or {};

    if not game.Players.LocalPlayer.Settings.BountyPosters.Value then
        return;
    end;

    task.wait(1);
    local v8 = v7.Model or error("No model data");
    local v9 = v7.DisplayName or v7.Model.Name;
    local v10 = v7.Bounty or 1000000;
    local v11 = v7.Offset or CFrame.new(0, 1.25, -4.75) * CFrame.Angles(0, 3.141592653589793, 0);
    local v12 = v7.Speed or 1;
    local v13 = v7.SFX or v9;
    local v14 = Trove.new();
    local u15 = v14:Clone(script.Paper);
    u15.Name = math.random(1, 1000000);
    u15.Parent = workspace.Effects;

    if v7.DefaultSFX ~= false then
        local v16 = v14:Clone(script.Sounds.SFX);
        v16.Parent = u15.Bounty;
        SoundGroups:AssignSoundTag(v16);
        v16:Play();
    end;

    local v17 = typeof(v13) == "string" and script.Sounds:FindFirstChild(v13);

    if v17 then
        SoundGroups:AssignSoundTag(v17);
        v17:Play();
    end;

    local u18 = v14:Add(u15.Bounty.SurfaceGui);
    local Template = u18:WaitForChild("Template", 2);
    local Poster = Template:WaitForChild("Poster", 2);
    local Bounty = Poster:WaitForChild("Bounty", 2);
    local DisplayName = Poster:WaitForChild("DisplayName", 2);
    Bounty.Text = formatNumber(v10);
    DisplayName.Text = v9;
    local ViewportFrame = Template:WaitForChild("ViewportFrame", 2);
    local Camera = Instance.new("Camera");
    Camera.FieldOfView = 40;
    Camera.CFrame = v11;
    Camera.Parent = ViewportFrame;
    ViewportFrame.CurrentCamera = Camera;
    local v19 = v8:Clone();
    v19:PivotTo(CFrame.identity);
    v19.Parent = Template.ViewportFrame;
    u18.Adornee = u15.Bounty;
    u18.Parent = LocalPlayer:WaitForChild("PlayerGui");
    local v20 = u15.AnimationController.Animator:LoadAnimation(script.Animation);
    v20:Play(0, nil, v12);

    repeat
        task.wait();
    until v20.Length > 0;

    v14:Connect(RunService.RenderStepped, function(p21) -- Line: 91
        -- upvalues: u15 (copy), CurrentCamera (ref)
        u15.PrimaryPart.CFrame = CurrentCamera.CFrame * CFrame.new(-0.45, -0.25, -2.25) * CFrame.Angles(0, 3.141592653589793, 0);
    end);
    local u22 = v20.Length / v12 / 10;
    task.delay(v20.Length / v12 - u22, function() -- Line: 98
        -- upvalues: u15 (copy), u18 (copy), TweenService (ref), u22 (copy)
        for _, v in { u15, u18 } do
            for _, descendant in v:GetDescendants() do
                local v23 = descendant:IsA("BasePart") and descendant.Parent.ClassName ~= "ViewportFrame" and {
                    Transparency = 1
                } or (descendant:IsA("Frame") and {
                    BackgroundTransparency = 1
                } or (descendant:IsA("ImageLabel") and {
                    ImageTransparency = 1
                } or (descendant:IsA("ViewportFrame") and {
                    BackgroundTransparency = 1,
                    ImageTransparency = 1
                } or (descendant:IsA("TextLabel") and {
                    TextTransparency = 1,
                    TextStrokeTransparency = 1
                } or {}))));
                TweenService:Create(descendant, TweenInfo.new(u22, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), v23):Play();
            end;
        end;
    end);
    v20.Stopped:Wait();
    v14:Destroy();
end;