  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local script_Fov = require(script.Fov);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 14
    -- upvalues: SpectatorController (copy), SoundManager (copy), RunService (copy), script_Fov (copy), Essentials (copy), VfxManager (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    print(game.Players.LocalPlayer.Character.Values.Goalie.Value and p1.Char ~= game.Players.LocalPlayer.Character);

    if game.Players.LocalPlayer.Character.Values.Goalie.Value and (game.Players.LocalPlayer.Character.Values.IsInPenalty.Value and p1.Char ~= game.Players.LocalPlayer.Character) then
        return;
    end;

    SoundManager.SpawnSound("JokerKuni", 0.75, workspace, 150);
    local u2 = 0;
    local u3 = nil;
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u3 = RunService.RenderStepped:Connect(function(p4) -- Line: 25
        -- upvalues: u2 (ref), script_Fov (ref), u3 (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        u2 = u2 + p4 * 60;
        local v5 = script_Fov[math.ceil(u2)];

        if v5 ~= nil then
            if math.ceil(u2) >= #script_Fov then
                u3:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v5, p4 * 10);
        end;
    end);
    task.delay(4.5, function() -- Line: 39
        -- upvalues: u3 (ref)
        u3:Disconnect();
    end);
    local Char = p1.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local script_Attachments = script.Attachments;
    local u6 = {};

    for _, child in script_Attachments:GetChildren() do
        child:Clone().Parent = HumanoidRootPart;
    end;

    local Highlight = Instance.new("Highlight");
    Highlight.Parent = Char;
    Highlight.Enabled = false;
    Highlight.OutlineTransparency = 0;
    Highlight.FillTransparency = 0;
    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.fromRGB(0, 0, 0);
    local u7 = nil;

    for _, child in script:GetChildren() do
        if script_Attachments:FindFirstChild(child.Name) then
            local v8 = child:Clone();
            v8.Parent = workspace.Debris;
            v8.CFrame = HumanoidRootPart:FindFirstChild(v8.Name).WorldCFrame;
            u6[v8.Name] = v8;
        end;
    end;

    for _, child in script.Beams:GetChildren() do
        local v9 = Char:FindFirstChild(child.Name);

        if v9 then
            local v10 = child.Beams:Clone();
            v10.Parent = v9;
            u6[v10] = v10;
        end;
    end;

    task.delay(0.83, function() -- Line: 86
        -- upvalues: u6 (copy), VfxManager (ref)
        for _, v in u6 do
            if v.Name:find("Beams") then
                VfxManager.Enable(v, true);
            end;
        end;
    end);
    task.delay(2.25, function() -- Line: 94
        -- upvalues: u6 (copy), VfxManager (ref)
        for _, v in u6 do
            if v.Name:find("Beams") then
                VfxManager.Enable(v, false);
            end;
        end;
    end);
    task.spawn(function() -- Line: 102
        -- upvalues: Char (copy), u6 (copy)
        local BALL = Char:FindFirstChild("BALL", true);

        for _, child in script.BALLEffects:GetChildren() do
            local v11 = child:Clone();
            v11.Parent = BALL;
            u6[v11] = v11;
        end;
    end);
    local u12 = script.TorsoEffect.TorsoEffectAttachment:Clone();
    u12.Parent = Char:FindFirstChild("Torso");
    u6[u12] = u12;
    task.delay(0.68, function() -- Line: 116
        -- upvalues: u6 (copy), VfxManager (ref)
        local Step = u6.Step;

        if not Step then
            return;
        end;

        VfxManager.Emit(Step);
    end);
    task.delay(0.9, function() -- Line: 123
        -- upvalues: VfxManager (ref), u12 (copy)
        VfxManager.Enable(u12, true);
    end);
    task.delay(2.5, function() -- Line: 127
        -- upvalues: VfxManager (ref), u12 (copy)
        VfxManager.Enable(u12, false);
    end);
    local AttachmentBALL = u6.AttachmentBALL;
    task.delay(2.05, function() -- Line: 132
        -- upvalues: AttachmentBALL (copy), VfxManager (ref)
        if AttachmentBALL then
            VfxManager.Emit(AttachmentBALL);
        end;
    end);
    task.delay(2.1, function() -- Line: 138
        -- upvalues: u6 (copy), VfxManager (ref)
        local weirdGlowParts = u6.weirdGlowParts;

        if not weirdGlowParts then
            return;
        end;

        VfxManager.Enable(weirdGlowParts, true);
    end);
    task.delay(2.6, function() -- Line: 145
        -- upvalues: u6 (copy), VfxManager (ref)
        local weirdGlowParts = u6.weirdGlowParts;

        if not weirdGlowParts then
            return;
        end;

        VfxManager.Enable(weirdGlowParts, false);
    end);
    task.delay(2.91, function() -- Line: 152
        -- upvalues: u6 (copy), VfxManager (ref)
        local KICK = u6.KICK;

        if not KICK then
            return;
        end;

        VfxManager.Emit(KICK);
    end);
    task.delay(2.2, function() -- Line: 161
        -- upvalues: Highlight (copy)
        Highlight.Enabled = true;
        task.wait(0.05);
        Highlight.Enabled = false;
    end);
    task.delay(2.33, function() -- Line: 167
        -- upvalues: Highlight (copy)
        Highlight.Enabled = true;
        task.wait(0.07);
        Highlight.Enabled = false;
    end);
    task.delay(2.43, function() -- Line: 173
        -- upvalues: Highlight (copy)
        Highlight.FillColor = Color3.fromRGB(255, 255, 255);
        Highlight.Enabled = true;
        task.wait(0.1);
        Highlight:Destroy();
    end);
    local NagiCam = workspace:FindFirstChild("NagiCam");

    if NagiCam then
        local camera = NagiCam:FindFirstChild("camera");
        u7 = script.camera.Beams:Clone();
        u7.Parent = camera;
    end;

    task.delay(2.86, function() -- Line: 190
        -- upvalues: VfxManager (ref), u7 (ref), NagiCam (copy), u6 (copy)
        VfxManager.Enable(u7, true);

        for _, child in script.camera:GetChildren() do
            if child:IsA("ParticleEmitter") then
                local v13 = child:Clone();
                v13.Parent = NagiCam.camera;
                u6[v13] = v13;
            end;
        end;
    end);
    task.delay(4, function() -- Line: 202
        -- upvalues: u7 (ref), u6 (copy), HumanoidRootPart (copy)
        if u7 then
            u7:Destroy();
        end;

        for _, v in u6 do
            local v14 = HumanoidRootPart:FindFirstChild(v.Name);

            if v14 then
                v14:Destroy();
            end;

            v:Destroy();
        end;

        table.clear(u6);
    end);
end;