  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("Debris");
game:GetService("RunService");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);

local function EmitAll(p1) -- Line: 11
    for _, descendant in pairs(p1:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            task.spawn(function() -- Line: 14
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

local function EmitBeam(p2, u3) -- Line: 29
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
            task.delay(u3, function() -- Line: 42
                -- upvalues: TweenService (ref), descendant (copy), u3 (copy)
                TweenService:Create(descendant, TweenInfo.new(u3 / 2), {
                    Width0 = 0,
                    Width1 = 0
                }):Play();
            end);
        end;
    end;
end;

local u4 = { "Right Leg", "Right Arm", "Left Leg", "Left Arm" };

return function(p5) -- Line: 53
    -- upvalues: SoundManager (copy), EmitAll (copy), EmitBeam (copy), u4 (copy)
    local Char = p5.Char;
    local Folder = Instance.new("Folder");
    Folder.Parent = workspace.Debris;
    local u6 = {};
    tick();
    local _ = game.Workspace.CurrentCamera.FieldOfView;
    local u7 = 0;
    local u8 = nil;
    u8 = game:GetService("RunService").RenderStepped:Connect(function(p9) -- Line: 66
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
    local NagiCam = workspace:FindFirstChild("NagiCam");
    SoundManager.SpawnSound("OtoyaSteal2", 0.8, workspace, 150);
    local v11 = script.ScreenEffectsMain:Clone();
    v11.Parent = Folder;
    local Motor6D = Instance.new("Motor6D");
    Motor6D.Parent = v11;
    Motor6D.Part0 = NagiCam.CamPart;
    Motor6D.Part1 = v11;
    Motor6D.C0 = CFrame.new(0, 0, -1.123);
    Motor6D.C1 = CFrame.Angles(0, 0, 0.6981317007977318);
    local v12 = script.OtayaEye.Eyes:Clone();
    table.insert(u6, v12);
    v12.Parent = Char.Head;
    EmitAll(v12);
    EmitBeam(v12, 1.6);
    task.delay(2.2, function() -- Line: 99
        -- upvalues: u4 (ref), Char (copy), EmitAll (ref), u6 (copy), Folder (copy), EmitBeam (ref)
        for _, v in pairs(u4) do
            local v13 = v;

            for _, child in pairs(script.Aura:GetChildren()) do
                local v14 = child:Clone();
                v14.Parent = Char[v13];
                EmitAll(v14);
                table.insert(u6, v14);
            end;
        end;

        local v15 = script.WindBlaze:Clone();
        v15.CFrame = Char.Torso.CFrame;
        v15.Parent = Folder;
        EmitAll(v15);
        EmitBeam(v15, 1.6);
        table.insert(u6, v15);
    end);
    task.delay(3.6, function() -- Line: 117
        -- upvalues: Folder (copy), u6 (copy)
        Folder:Destroy();

        for _, v in pairs(u6) do
            v:Destroy();
        end;
    end);
end;