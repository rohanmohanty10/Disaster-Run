  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
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
    -- upvalues: SpectatorController (copy), u9 (copy), SoundManager (copy), TweenService (copy), script_Assets (copy), l_workspace (copy), BeamTweens (copy), RunService (copy), script_Fov (copy), Essentials (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Character = p10.Plr.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    u9[Character] = {};
    SoundManager.SpawnSound("KarasuMode", 1, workspace, 100);
    local _ = workspace.CurrentCamera.FieldOfView;
    local workspace_CurrentCamera = workspace.CurrentCamera;
    workspace_CurrentCamera.FieldOfView = 40;
    TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1.5), {
        FieldOfView = 30
    }):Play();
    task.delay(1.5, function() -- Line: 83
        -- upvalues: TweenService (ref), workspace_CurrentCamera (copy)
        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.2), {
            FieldOfView = 50
        }):Play();
        task.wait(0.2);
        workspace_CurrentCamera.FieldOfView = 40;
    end);
    task.delay(1.75, function() -- Line: 89
        -- upvalues: TweenService (ref), workspace_CurrentCamera (copy)
        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.21), {
            FieldOfView = 60
        }):Play();
        task.wait(0.21);
        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1.1), {
            FieldOfView = 70
        }):Play();
    end);
    task.spawn(function() -- Line: 98
        -- upvalues: script_Assets (ref), HumanoidRootPart (copy), l_workspace (ref), BeamTweens (ref), TweenService (ref), Character (copy), u9 (ref)
        local v11 = script_Assets.StartupVFX:Clone();
        v11.CFrame = HumanoidRootPart.CFrame;
        v11.Parent = l_workspace;
        EmitAll(v11:GetDescendants());
        DestroyEffect(v11, 7.35);
        local v12 = script_Assets.Enabling:Clone();
        v12:PivotTo(HumanoidRootPart.CFrame);
        v12.Parent = l_workspace;
        EnableVFX(v12, true);
        DestroyEffect(v12, 5);
        BeamTweens(v12);
        task.wait(1.715);

        for _, descendant in v12:GetDescendants() do
            if descendant:IsA("Beam") then
                TweenService:Create(descendant, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                    Width0 = 0,
                    Width1 = 0
                }):Play();
            end;
        end;

        EnableVFX(v12, false);
        EnableVFX(l_workspace:FindFirstChild(Character.Name), true);
        DestroyEffect(v11, 6);

        for _, child in Character:GetChildren() do
            if child.Name ~= "HumanoidRootPart" and child:IsA("BasePart") then
                local v13 = child;

                for _, child2 in script_Assets.AuraFX:Clone():GetChildren() do
                    child2.Parent = v13;
                    table.insert(u9[Character], child2);
                end;
            end;
        end;

        local v14 = script_Assets.EnablingFeather:Clone();
        v14:PivotTo(HumanoidRootPart.CFrame);
        v14.Parent = l_workspace;
        EnableVFX(v14, true);
        DestroyEffect(v14, 5);
        local v15 = script_Assets.FinalEmit:Clone();
        v15.Position = HumanoidRootPart.Position - Vector3.new(0, 2, 0.3);
        v15.Parent = l_workspace;
        EmitAll(v15:GetDescendants());
        DestroyEffect(v15, 6);
        local v16 = script_Assets.EyeVFX:Clone();
        v16.CFrame = Character:FindFirstChild("Head").CFrame;
        v16.Parent = l_workspace;
        EnableVFX(v16, true);
        Weld(v16, Character:FindFirstChild("Head"));
        DestroyEffect(v16, 1.5);
        BeamTweens(v16);
        BeamTweens(l_workspace:FindFirstChild(Character.Name));
        task.wait(1.15);
        EnableVFX(l_workspace:FindFirstChild(Character.Name), false);
        EnableVFX(v16, false);
        EnableVFX(v14, false);
        TweenService:Create(v11.Light.PointLight, TweenInfo.new(0.4, Enum.EasingStyle.Sine), {
            Brightness = 0,
            Range = 12
        }):Play();

        for _, v in ipairs(u9[Character]) do
            if v.ClassName == "ParticleEmitter" then
                v.Enabled = false;
                DestroyEffect(v, 2);
            elseif v.ClassName == "Beam" then
                TweenService:Create(v, TweenInfo.new(0.4, Enum.EasingStyle.Linear), {
                    Width0 = 0,
                    Width1 = 0
                }):Play();
            end;
        end;

        u9[Character] = nil;
    end);
    local u17 = 0;
    local u18 = nil;
    local workspace_CurrentCamera2 = workspace.CurrentCamera;
    local FieldOfView = workspace_CurrentCamera2.FieldOfView;
    u18 = RunService.RenderStepped:Connect(function(p19) -- Line: 179
        -- upvalues: u17 (ref), script_Fov (ref), u18 (ref), workspace_CurrentCamera2 (copy), FieldOfView (ref), Essentials (ref)
        u17 = u17 + p19 * 60;
        local v20 = script_Fov[math.ceil(u17)];

        if v20 ~= nil then
            if math.ceil(u17) >= #script_Fov then
                u18:Disconnect();

                return;
            end;

            workspace_CurrentCamera2.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v20, p19 * 10);
        end;
    end);
    task.delay(3.2, function() -- Line: 193
        -- upvalues: u18 (ref)
        u18:Disconnect();
    end);
end;