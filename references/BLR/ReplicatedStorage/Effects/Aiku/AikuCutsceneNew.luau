  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
game:GetService("Debris");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
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

local function EmitBeam(p2) -- Line: 30
    -- upvalues: TweenService (copy)
    for _, descendant in pairs(p2:GetDescendants()) do
        if descendant:IsA("Beam") then
            local Width0 = descendant.Width0;
            local Width1 = descendant.Width1;
            descendant.Width0 = 0;
            descendant.Width1 = 0;
            descendant.Enabled = true;
            local Attribute = descendant:GetAttribute("EmitDuration");
            TweenService:Create(descendant, TweenInfo.new(0.25), {
                Width0 = Width0,
                Width1 = Width1
            }):Play();
            task.delay(Attribute, function() -- Line: 44
                -- upvalues: TweenService (ref), descendant (copy), Attribute (copy)
                TweenService:Create(descendant, TweenInfo.new(Attribute / 2), {
                    Width0 = 0,
                    Width1 = 0
                }):Play();
            end);
        end;
    end;
end;

function EMITP(p3)
    local function Emit(u4: userdata) -- Line: 54
        if u4:IsA("Beam") or u4:IsA("Trail") then
            local Attribute = u4:GetAttribute("EmitDelay");
            local Attribute2 = u4:GetAttribute("EmitDuration");
            task.delay(tonumber(Attribute) or 0, function() -- Line: 57
                -- upvalues: Attribute2 (copy), u4 (copy)
                if tonumber(Attribute2) and Attribute2 ~= 0 then
                    u4.Enabled = true;

                    if not u4:GetAttribute("pr3") then
                        u4:SetAttribute("pr3", 0);
                    end;

                    local v5 = (u4:GetAttribute("pr3") + 1) % 1000;
                    u4:SetAttribute("pr3", v5);
                    task.wait(Attribute2);

                    if v5 == u4:GetAttribute("pr3") then
                        u4.Enabled = false;
                    end;
                end;
            end);

            return;
        end;

        local Attribute = u4:GetAttribute("EmitCount");
        local Attribute2 = u4:GetAttribute("EmitDelay");
        local Attribute3 = u4:GetAttribute("EmitDuration");
        task.delay(tonumber(Attribute2) or 0, function() -- Line: 73
            -- upvalues: u4 (copy), Attribute (copy), Attribute3 (copy)
            u4:Emit(Attribute or 0);

            if tonumber(Attribute3) and Attribute3 ~= 0 then
                u4.Enabled = true;

                if not u4:GetAttribute("pr3") then
                    u4:SetAttribute("pr3", 0);
                end;

                local v6 = (u4:GetAttribute("pr3") + 1) % 1000;
                u4:SetAttribute("pr3", v6);
                task.wait(Attribute3);

                if v6 == u4:GetAttribute("pr3") then
                    u4.Enabled = false;
                end;
            end;
        end);
    end;

    for _, descendant in p3:GetDescendants() do
        if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
            Emit(descendant);
        end;
    end;
end;

return function(p7) -- Line: 101
    -- upvalues: Players (copy), SoundManager (copy), RunService (copy)
    local Char = p7.Char;
    Players:GetPlayerFromCharacter(Char);
    local _ = p7.Enemy;
    Instance.new("Folder").Parent = workspace.Debris;
    tick();
    local _ = game.Workspace.CurrentCamera.FieldOfView;
    local u8 = 0;
    local u9 = nil;
    u9 = game:GetService("RunService").RenderStepped:Connect(function(p10) -- Line: 116
        -- upvalues: u8 (ref), u9 (ref)
        u8 = u8 + p10 * 60;
        local script_FOV = script.FOV;
        local math_ceil_ret = math.ceil(u8);
        local v11 = script_FOV:FindFirstChild((tonumber(math_ceil_ret)));

        if v11 then
            game.Workspace.CurrentCamera.FieldOfView = v11.Value;

            return;
        end;

        u9:Disconnect();
    end);
    SoundManager.SpawnSound("AikuAwk3", 0.7, workspace, 150);
    local AwakeningCam = workspace:FindFirstChild("AwakeningCam");
    local u12 = script.VFX:Clone();
    u12:PivotTo(Char.HumanoidRootPart.CFrame);
    u12.Parent = workspace.Debris;
    local GlowAura = u12.GlowAura;
    local Face = u12.Face;
    local u13 = RunService.Heartbeat:Connect(function() -- Line: 140
        -- upvalues: GlowAura (copy), Char (copy), Face (copy)
        GlowAura.CFrame = Char.Torso.CFrame;
        Face.CFrame = Char.Head.CFrame;
    end);
    local Motor6D = Instance.new("Motor6D");
    Motor6D.C0 = CFrame.new(0, 0, -1);
    Motor6D.Part0 = AwakeningCam.CamPart;
    Motor6D.part1 = u12.LinesScreen;
    Motor6D.Parent = AwakeningCam.CamPart;
    local Motor6D2 = Instance.new("Motor6D");
    Motor6D2.C0 = CFrame.new(0, 0, -1);
    Motor6D2.Part0 = AwakeningCam.CamPart;
    Motor6D2.part1 = u12.Shockwaving;
    Motor6D2.Parent = AwakeningCam.CamPart;
    task.delay(11.16, function() -- Line: 157
        -- upvalues: u13 (ref), u12 (copy)
        u13:Disconnect();
        u12:Destroy();
    end);
    task.delay(2.14, function() -- Line: 162
        -- upvalues: Face (copy)
        EMITP(Face);
    end);
    task.delay(5.13, function() -- Line: 167
        -- upvalues: u12 (copy)
        EMITP(u12.SpeedLines);
    end);
    task.delay(7.32, function() -- Line: 171
        -- upvalues: u12 (copy)
        EMITP(u12.Screams);
        task.wait(0.14);
        EMITP(u12.Shockwaving);
    end);
end;