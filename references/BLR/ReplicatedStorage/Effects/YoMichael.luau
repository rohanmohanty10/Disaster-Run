  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local script_Fov = require(script.Fov);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local u1 = { "Head", "Left Arm", "Right Arm", "Torso", "Left Leg", "Right Leg" };

return function(p2) -- Line: 23
    -- upvalues: SpectatorController (copy), SoundManager (copy), RunService (copy), script_Fov (copy), Essentials (copy), ReplicatedStorage (copy), TweenService (copy), u1 (copy), VfxManager (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    if game.Players.LocalPlayer.Character.Values.Goalie.Value and (p2.Char ~= game.Players.LocalPlayer.Character and p2.enemy ~= game.Players.LocalPlayer.Character) then
        return;
    end;

    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    SoundManager.SpawnSound("YoMichael", 0.6, workspace, 130, false);
    local u3 = 0;
    local u4 = nil;
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u4 = RunService.RenderStepped:Connect(function(p5) -- Line: 37
        -- upvalues: u3 (ref), script_Fov (ref), u4 (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        u3 = u3 + p5 * 60;
        local v6 = script_Fov[math.ceil(u3)];

        if v6 ~= nil then
            if math.ceil(u3) >= #script_Fov then
                u4:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v6, p5 * 10);
        end;
    end);

    if Char == game.Players.LocalPlayer.Character then
        local AnimationController = require(ReplicatedStorage.Controllers.AnimationController);
        AnimationController:StopAnims();
        AnimationController.Ball.YoMichaelBall.Priority = Enum.AnimationPriority.Action4;
        AnimationController.Ball.YoMichaelBall:Play();
        AnimationController.Abilities.YoMichaelPlr.Priority = Enum.AnimationPriority.Action4;
        AnimationController.Abilities.YoMichaelPlr:Play();
    end;

    task.delay(1.7, function() -- Line: 63
        -- upvalues: u4 (ref)
        u4:Disconnect();
    end);
    local u7 = script["RUN "]:Clone();
    u7.Parent = workspace.Debris;
    u7.CFrame = HumanoidRootPart.CFrame * CFrame.new(1.607, 1.116, -2.305) * CFrame.Angles(0, -0.7852236304722489, 0);
    local Atmosphere = Instance.new("Atmosphere");
    Atmosphere.Parent = game.Lighting;
    Atmosphere.Color = Color3.fromRGB(0, 0, 0);
    Atmosphere.Decay = Color3.fromRGB(50, 2, 111);
    Atmosphere.Glare = 5;
    Atmosphere.Haze = 4;
    Atmosphere.Density = 0;
    Atmosphere.Offset = 0;
    task.delay(0.3, function() -- Line: 80
        -- upvalues: TweenService (ref), Atmosphere (copy)
        TweenService:Create(Atmosphere, TweenInfo.new(0.4), {
            Density = 0.7,
            Offset = 0.9
        }):Play();
    end);
    task.delay(1.7, function() -- Line: 84
        -- upvalues: Atmosphere (copy), u7 (copy)
        Atmosphere:Destroy();
        u7:Destroy();
    end);
    local u8 = script.Beams.Attachment:Clone();
    u8.Parent = HumanoidRootPart;

    for _, descendant in u8:GetDescendants() do
        if descendant:IsA("Beam") then
            local Width0 = descendant.Width0;
            descendant.Enabled = false;
            descendant.Width0 = 0;
            task.delay(0.45, function() -- Line: 97
                -- upvalues: descendant (copy), TweenService (ref), Width0 (copy)
                descendant.Enabled = true;
                TweenService:Create(descendant, TweenInfo.new(0.2), {
                    Width0 = Width0
                }):Play();
            end);
        end;
    end;

    task.delay(1.7, function() -- Line: 103
        -- upvalues: u8 (copy)
        u8:Destroy();
    end);
    local u9 = {};

    for _, child in script.Lorenzo:GetChildren() do
        if table.find(u1, child.Name) then
            local v10 = child;

            for _, child2 in child:GetChildren() do
                local v11 = child2:Clone();
                v11.Parent = Char:FindFirstChild(v10.Name);
                table.insert(u9, v11);

                if v11.Name == "Part" then
                    local Part = v11.Part;
                    Part.Part0 = Char:FindFirstChild("Head");
                    Part.Part1 = v11;
                end;

                if v11:IsA("ParticleEmitter") then
                    v11.Enabled = true;
                elseif v11.Name == "particle" then
                    VfxManager.Emit(v11);
                else
                    VfxManager.Enable(v11, true);
                end;
            end;
        end;
    end;

    task.delay(1.7, function() -- Line: 133
        -- upvalues: u9 (ref), VfxManager (ref)
        for _, v in u9 do
            if v:IsA("ParticleEmitter") then
                v.Enabled = false;
            elseif v.Name ~= "particle" then
                VfxManager.Enable(v, false);
            end;

            task.delay(1, function() -- Line: 140
                -- upvalues: v (copy)
                v:Destroy();
            end);
        end;

        task.wait(1);
        table.clear(u9);
        u9 = nil;
    end);
end;