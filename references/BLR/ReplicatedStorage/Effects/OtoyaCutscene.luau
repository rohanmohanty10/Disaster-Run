  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("Debris");
game:GetService("RunService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local _ = workspace;
local u1 = { "Right Leg", "Right Arm", "Left Leg", "Left Arm" };

local function EmitBeam(p2, u3) -- Line: 18
    -- upvalues: TweenService (copy)
    for _, descendant in pairs(p2:GetDescendants()) do
        if descendant:IsA("Beam") then
            print(descendant);
            local Width0 = descendant.Width0;
            local Width1 = descendant.Width1;
            descendant.Width0 = 0;
            descendant.Width1 = 0;
            descendant.Enabled = true;
            TweenService:Create(descendant, TweenInfo.new(0.25), {
                Width0 = Width0,
                Width1 = Width1
            }):Play();
            task.delay(u3, function() -- Line: 32
                -- upvalues: TweenService (ref), descendant (copy), u3 (copy)
                TweenService:Create(descendant, TweenInfo.new(u3 / 2), {
                    Width0 = 0,
                    Width1 = 0
                }):Play();
            end);
        end;
    end;
end;

return function(p4) -- Line: 41
    -- upvalues: SpectatorController (copy), SoundManager (copy), Players (copy), TweenService (copy), u1 (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Character = p4.Plr.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    Character:FindFirstChild("HumanoidRootPart");
    local Folder = Instance.new("Folder");
    Folder.Parent = workspace.Debris;
    local FieldOfView = game.Workspace.CurrentCamera.FieldOfView;
    local u5 = 0;
    local u8 = game:GetService("RunService").RenderStepped:Connect(function(p6) -- Line: 55
        -- upvalues: u5 (ref)
        u5 = u5 + p6 * 60;
        local script_FOV = script.FOV;
        local math_ceil_ret = math.ceil(u5);
        local v7 = script_FOV:FindFirstChild((tonumber(math_ceil_ret)));

        if not v7 then
            return;
        end;

        game.Workspace.CurrentCamera.FieldOfView = v7.Value;
    end);
    local u9 = {};
    SoundManager.SpawnSound("OtoyaAwkSound", 1, workspace, 400);
    local v10 = workspace:FindFirstChild("NagiCam") or workspace:FindFirstChild("AwakeningCam");
    local v11 = script.ScreenEffectsMain:Clone();
    v11.Parent = Folder;
    local Motor6D = Instance.new("Motor6D");
    Motor6D.Parent = v11;
    Motor6D.Part0 = v10.CamPart;
    Motor6D.Part1 = v11;
    Motor6D.C0 = CFrame.new(0, 0, -1.329);
    local v12 = script.VignetteGuiOtoya:Clone();
    v12.Overlay.ImageTransparency = 1;
    table.insert(u9, v12);
    v12.Parent = Players.LocalPlayer.PlayerGui;
    TweenService:Create(v12.Overlay, TweenInfo.new(0.1), {
        ImageTransparency = 0
    }):Play();
    local v13 = script.Flash.Attachment:Clone();
    table.insert(u9, v13);
    v13.Parent = Character.Torso;
    local u14 = {};

    for _, descendant in pairs(v13:GetDescendants()) do
        if descendant:IsA("Beam") or descendant:IsA("ParticleEmitter") then
            descendant.Enabled = true;
        end;
    end;

    for _, child in pairs(script.Environment:GetChildren()) do
        local v15 = child:Clone();
        local v16 = script.HumanoidRootPart.CFrame:Inverse() * child:GetPivot();
        v15:PivotTo(HumanoidRootPart.CFrame * v16);
        v15.Parent = Folder;

        for _, descendant in pairs(v15:GetDescendants()) do
            if descendant:IsA("Beam") or descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end;

    for _, child in pairs(game:GetService("Lighting"):GetChildren()) do
        local v17 = child:Clone();
        table.insert(u14, v17);
        child:Destroy();
    end;

    for _, child in pairs(script.Lighting:GetChildren()) do
        local v18 = child:Clone();
        table.insert(u9, v18);
        v18.Parent = game:GetService("Lighting");
    end;

    for _, child in pairs(script.Face:GetChildren()) do
        local v19 = child:Clone();
        table.insert(u9, v19);
        v19.Parent = Character.Head;

        for _, descendant in pairs(v19:GetDescendants()) do
            if descendant:IsA("Beam") or descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end;

    for _, v in pairs(u1) do
        local v20 = v;

        for _, child in pairs(script.Aura:GetChildren()) do
            local v21 = child:Clone();
            v21.Parent = Character[v20];
            table.insert(u9, v21);
        end;
    end;

    for _, child in pairs(script.Torso:GetChildren()) do
        local v22 = child:Clone();
        v22.Parent = Character.Torso;
        table.insert(u9, v22);
    end;

    task.delay(4.6, function() -- Line: 151
        -- upvalues: u8 (ref), FieldOfView (copy), Folder (copy), u14 (copy), u9 (copy)
        if u8 then
            u8:Disconnect();
        end;

        game.Workspace.CurrentCamera.FieldOfView = FieldOfView;
        Folder:Destroy();

        for _, v in pairs(u14) do
            v.Parent = game:GetService("Lighting");
        end;

        for _, v in pairs(u9) do
            v:Destroy();
        end;
    end);
end;