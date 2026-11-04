  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
game:GetService("Debris");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);

local function EmitAll(p1) -- Line: 12
    for _, descendant in pairs(p1:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            task.spawn(function() -- Line: 15
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

local function EmitBeam(p2, u3) -- Line: 30
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
            task.delay(u3, function() -- Line: 44
                -- upvalues: TweenService (ref), descendant (copy), u3 (copy)
                TweenService:Create(descendant, TweenInfo.new(u3 / 2), {
                    Width0 = 0,
                    Width1 = 0
                }):Play();
            end);
        end;
    end;
end;

return function(p4) -- Line: 55
    -- upvalues: Players (copy), SoundManager (copy), ReplicatedStorage (copy), RunService (copy), VfxManager (copy)
    local Char = p4.Char;
    local Folder = Instance.new("Folder");
    Folder.Parent = workspace.Debris;
    local u5 = {};
    tick();

    if not Players.LocalPlayer.Character.Values.Goalie.Value then
        local u6 = 0;
        local u7 = nil;
        u7 = game:GetService("RunService").RenderStepped:Connect(function(p8) -- Line: 68
            -- upvalues: u6 (ref), u7 (ref)
            u6 = u6 + p8 * 60;
            local script_FOV = script.FOV;
            local math_ceil_ret = math.ceil(u6);
            local v9 = script_FOV:FindFirstChild((tonumber(math_ceil_ret)));

            if v9 then
                game.Workspace.CurrentCamera.FieldOfView = v9.Value;

                return;
            end;

            u7:Disconnect();
        end);
    end;

    task.delay(10, function() -- Line: 80
        local u10 = 0;
        task.spawn(function() -- Line: 82
            -- upvalues: u10 (ref)
            for _, child in game.Players.LocalPlayer.PlayerGui.ImpactFramesViper:GetChildren() do
                child.Position = UDim2.new(0.5, 0, 1.5, 0);
            end;

            game.Players.LocalPlayer.PlayerGui.ImpactFramesViper.Enabled = true;

            for i = 1, 5 do
                task.delay(u10, function() -- Line: 88
                    -- upvalues: i (copy)
                    local ImpactFramesViper = game.Players.LocalPlayer.PlayerGui.ImpactFramesViper;

                    if i > 1 then
                        ImpactFramesViper[`Frame{tostring(i - 1)}`].Position = UDim2.new(0.5, 0, 2, 0);
                    end;

                    ImpactFramesViper[`Frame{tostring(i)}`].Position = UDim2.new(0.5, 0, 0.5, 0);
                end);
                u10 = u10 + 0.05;
                local _ = i;
            end;

            task.delay(u10, function() -- Line: 98
                for _, child in game.Players.LocalPlayer.PlayerGui.ImpactFramesViper:GetChildren() do
                    child.Position = UDim2.new(0.5, 0, 1.5, 0);
                end;

                game.Players.LocalPlayer.PlayerGui.ImpactFramesViper.Enabled = false;
            end);
        end);
    end);
    SoundManager.SpawnSound("AikuViper", 0.7, workspace, 150);
    workspace:FindFirstChild("NagiCam");
    local u11 = script["Aiku Strike Snake"]:Clone();
    u11.RootPart.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0) * CFrame.Angles(0, 3.141592653589793, 0);
    u11.Parent = Folder;
    u11.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.ReplicatedAnims.Abilities.ViperRig):Play();
    local u12 = script.GreenAura:Clone();
    u12.Parent = Folder;
    local u13 = script.Face:Clone();
    u13.Parent = Folder;
    local u14 = RunService.Heartbeat:Connect(function() -- Line: 126
        -- upvalues: u13 (copy), Char (copy), u11 (copy), u12 (copy)
        u13.CFrame = Char.Head.CFrame;
        u11.RootPart.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0) * CFrame.Angles(0, 3.141592653589793, 0);
        u12.CFrame = Char.Torso.CFrame;
    end);

    for _, child in pairs(script.Assets:GetChildren()) do
        local u15 = child:Clone();
        local v16 = script.HumanoidRootPart.CFrame:Inverse() * child:GetPivot();
        u15:PivotTo(Char.HumanoidRootPart.CFrame * v16);
        u15.Parent = Folder;

        if u15.Name == "Bounce" then
            task.delay(0.433, function() -- Line: 139
                -- upvalues: VfxManager (ref), u15 (copy)
                VfxManager.Emit(u15);
            end);
        elseif u15.Name == "Circle" then
            task.delay(6.8, function() -- Line: 144
                -- upvalues: VfxManager (ref), u15 (copy)
                VfxManager.Emit(u15);

                for _, descendant in pairs(u15:GetDescendants()) do
                    if descendant:IsA("Beam") then
                        task.defer(function() -- Line: 149
                            -- upvalues: descendant (copy)
                            if descendant:GetAttribute("EmitDuration") and descendant:GetAttribute("EmitDuration") > 0 and true or false then
                                descendant.Enabled = true;
                                task.delay(descendant:GetAttribute("EmitDuration"), function() -- Line: 158
                                    -- upvalues: descendant (ref)
                                    descendant.Enabled = false;
                                end);
                            end;
                        end);
                    end;
                end;
            end);
        elseif u15.Name == "SpeedLines" then
            task.delay(9.75, function() -- Line: 168
                -- upvalues: VfxManager (ref), u15 (copy)
                VfxManager.Emit(u15);
            end);
        elseif u15.Name == "FinalHit" then
            task.delay(10.2, function() -- Line: 174
                -- upvalues: VfxManager (ref), u15 (copy)
                VfxManager.Emit(u15);
            end);
        elseif u15.Name == "Shockwaving" then
            task.delay(9.72, function() -- Line: 180
                -- upvalues: VfxManager (ref), u15 (copy)
                VfxManager.Emit(u15);
            end);
        end;
    end;

    task.delay(11.7, function() -- Line: 186
        -- upvalues: u14 (ref), Folder (copy), u5 (copy)
        u14:Disconnect();
        Folder:Destroy();

        for _, v in pairs(u5) do
            v:Destroy();
        end;
    end);
end;