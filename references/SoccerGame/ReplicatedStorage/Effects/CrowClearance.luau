  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("Debris");
local RunService = game:GetService("RunService");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local script_Fov = require(script.Fov);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

function EmitAll(p1)
    for _, v in next, p1 do
        if v.ClassName == "ParticleEmitter" then
            if v:GetAttribute("EmitDelay") then
                task.delay(v:GetAttribute("EmitDelay"), function() -- Line: 18
                    -- upvalues: v (copy)
                    v:Emit(v:GetAttribute("EmitCount"));
                end);
            else
                v:Emit(v:GetAttribute("EmitCount"));
            end;
        end;
    end;
end;

function EnableVFX(p2: userdata, p3: boolean?)
    for _, v in next, p2:GetDescendants() do
        if v.ClassName == "ParticleEmitter" then
            v.Enabled = p3 or false;
        end;
    end;
end;

function Weld(p4: userdata, p5: userdata)
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = p4;
    WeldConstraint.Part1 = p5;
    WeldConstraint.Parent = p4;
end;

function DestroyEffect(u6: userdata, p7: number)
    task.delay(p7, function() -- Line: 43
        -- upvalues: u6 (copy)
        u6:Destroy();
    end);
end;

local function BeamTweens(p8) -- Line: 48
    -- upvalues: TweenService (copy)
    for _, descendant in ipairs(p8:GetDescendants()) do
        if descendant:IsA("Beam") then
            local Width0 = descendant.Width0;
            local Width1 = descendant.Width1;
            descendant.Width0 = 0;
            descendant.Width1 = 0;
            descendant.Enabled = true;
            TweenService:Create(descendant, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
                Width0 = Width0,
                Width1 = Width1
            }):Play();
        end;
    end;
end;

local l_workspace = workspace;
local script_Assets = script.Assets;
local u9 = {};

return function(p10) -- Line: 65
    -- upvalues: SpectatorController (copy), u9 (copy), TweenService (copy), script_Assets (copy), l_workspace (copy), RunService (copy), script_Fov (copy), Essentials (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p10.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local u11 = Char:FindFirstChild("Right Leg");
    local Head = Char:FindFirstChild("Head");
    u9[Char] = {};
    local _ = workspace.CurrentCamera.FieldOfView;
    local workspace_CurrentCamera = workspace.CurrentCamera;
    workspace_CurrentCamera.FieldOfView = 30;
    TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.48), {
        FieldOfView = 40
    }):Play();
    task.delay(0.5, function() -- Line: 83
        -- upvalues: TweenService (ref), workspace_CurrentCamera (copy)
        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.91), {
            FieldOfView = 30
        }):Play();
    end);
    task.delay(1.42, function() -- Line: 86
        -- upvalues: TweenService (ref), workspace_CurrentCamera (copy)
        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.38), {
            FieldOfView = 47
        }):Play();
    end);
    task.spawn(function() -- Line: 93
        -- upvalues: Char (copy), script_Assets (ref), l_workspace (ref), HumanoidRootPart (copy), u11 (copy), Head (copy), u9 (ref)
        local BALL = Char:FindFirstChild("BALL", true);

        if not BALL then
            return;
        end;

        local v12 = script_Assets.BallFX:Clone();
        v12.CFrame = BALL.CFrame;
        v12.Parent = l_workspace;
        EnableVFX(v12, true);
        Weld(v12, BALL);
        DestroyEffect(v12, 1.795);
        task.wait(0.38);
        local v13 = script_Assets.RootAuraVFX:Clone();
        v13.CFrame = HumanoidRootPart.CFrame;
        v13.Parent = l_workspace;
        EnableVFX(v13, true);
        Weld(v13, HumanoidRootPart);
        DestroyEffect(v13, 3);
        local v14 = script_Assets.KickEmit:Clone();
        v14.CFrame = u11.CFrame;
        v14.Parent = l_workspace;
        EmitAll(v14:GetDescendants());
        DestroyEffect(v14, 1.45);
        local v15 = script_Assets.EnablingFeather:Clone();
        v15:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, 0, -1.35));
        v15.Parent = l_workspace;
        EnableVFX(v15, true);
        DestroyEffect(v15, 4);
        local v16 = script_Assets.EyeVFX:Clone();
        v16.CFrame = Head.CFrame;
        v16.Parent = l_workspace;
        EnableVFX(v16, true);
        Weld(v16, Char:FindFirstChild("Head"));
        DestroyEffect(v16, 1.5);

        for _, child in Char:GetChildren() do
            if child.Name ~= "HumanoidRootPart" and child:IsA("BasePart") then
                local v17 = child;

                for _, child2 in script_Assets.AuraFX:Clone():GetChildren() do
                    child2.Parent = v17;
                    table.insert(u9[Char], child2);
                end;
            end;
        end;

        task.wait(0.43);
        local v18 = script_Assets.LandingCharVFX:Clone();
        v18.CFrame = HumanoidRootPart.CFrame;
        v18.Parent = l_workspace;
        EmitAll(v18:GetDescendants());
        DestroyEffect(v18, 3);
        local v19 = script_Assets.BallEmitLandVFX:Clone();
        v19.Position = BALL.Position;
        v19.Parent = l_workspace;
        EmitAll(v19:GetDescendants());
        DestroyEffect(v19, 3);
        task.wait(0.4);
        EnableVFX(v12, false);
        EnableVFX(v13, false);

        for _, v in ipairs(u9[Char]) do
            if v.ClassName == "ParticleEmitter" then
                v.Enabled = false;
                DestroyEffect(v, 2);
            end;
        end;

        u9[Char] = nil;
    end);
    local u20 = 0;
    local u21 = nil;
    local workspace_CurrentCamera2 = workspace.CurrentCamera;
    local FieldOfView = workspace_CurrentCamera2.FieldOfView;
    u21 = RunService.RenderStepped:Connect(function(p22) -- Line: 175
        -- upvalues: u20 (ref), script_Fov (ref), u21 (ref), workspace_CurrentCamera2 (copy), FieldOfView (ref), Essentials (ref)
        u20 = u20 + p22 * 60;
        local v23 = script_Fov[math.ceil(u20)];

        if v23 ~= nil then
            if math.ceil(u20) >= #script_Fov then
                u21:Disconnect();

                return;
            end;

            workspace_CurrentCamera2.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v23, p22 * 10);
        end;
    end);
    task.delay(2, function() -- Line: 189
        -- upvalues: u21 (ref)
        u21:Disconnect();
    end);
end;