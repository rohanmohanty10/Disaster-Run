  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.Popup);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);

function EmitAll(p1)
    local function emit(u2) -- Line: 12
        if u2:IsA("ParticleEmitter") or (u2:IsA("Beam") or u2:IsA("Trail")) then
            local Attribute = u2:GetAttribute("EmitDelay");
            local Attribute2 = u2:GetAttribute("EmitCount");

            if Attribute2 and Attribute2 ~= 0 then
                if Attribute and Attribute ~= 0 then
                    task.delay(Attribute, function() -- Line: 19
                        -- upvalues: u2 (copy), Attribute2 (copy)
                        u2:Emit(Attribute2);
                    end);

                    return;
                end;

                u2:Emit(Attribute2);
            end;
        end;
    end;

    if typeof(p1) == "table" then
        for _, v in p1 do
            if v:IsA("ParticleEmitter") or (v:IsA("Beam") or v:IsA("Trail")) then
                emit(v);
            else
                for _, descendant in v:GetDescendants() do
                    emit(descendant);
                end;
            end;
        end;

        return;
    end;

    if p1:IsA("ParticleEmitter") or (p1:IsA("Beam") or p1:IsA("Trail")) then
        emit(p1);

        return;
    end;

    for _, descendant in p1:GetDescendants() do
        emit(descendant);
    end;
end;

return function(p3) -- Line: 50
    -- upvalues: SoundManager (copy)
    local HumanoidRootPart = p3.Plr.Character.HumanoidRootPart;
    local game_Workspace = game.Workspace;
    local Folder = Instance.new("Folder");
    Folder.Parent = workspace.Debris;
    SoundManager.SpawnSoundId("rbxassetid://120234833406886", 3, workspace, 150);
    tick();
    local FieldOfView = game.Workspace.CurrentCamera.FieldOfView;
    local u4 = 0;
    local u7 = game:GetService("RunService").RenderStepped:Connect(function(p5) -- Line: 71
        -- upvalues: u4 (ref)
        u4 = u4 + p5 * 60;
        local script_FOV = script.FOV;
        local math_ceil_ret = math.ceil(u4);
        local v6 = script_FOV:FindFirstChild((tonumber(math_ceil_ret)));

        if not v6 then
            return;
        end;

        game.Workspace.CurrentCamera.FieldOfView = v6.Value;
    end);
    local AwakeningCam = workspace:WaitForChild("AwakeningCam");
    local v8 = script.DarknessScreen:Clone();
    v8.Parent = game_Workspace;
    local Motor6D = Instance.new("Motor6D");
    Motor6D.Part0 = AwakeningCam.CamPart;
    Motor6D.Part1 = v8;
    Motor6D.C0 = CFrame.new(0, 0, -1);
    Motor6D.Parent = v8;
    local u9 = {};
    local u10 = {};

    for _, child in pairs(script.Environment:GetChildren()) do
        local u11 = child:Clone();
        local v12 = script.HumanoidRootPart.CFrame:Inverse() * child:GetPivot();
        u11:PivotTo(HumanoidRootPart.CFrame * v12);
        u11.Parent = Folder;

        if u11.Name == "Circle" or (u11.Name == "SnowFlake" or u11.Name == "Specs2") then
            task.delay(2.8, function() -- Line: 196
                -- upvalues: u11 (copy)
                EmitAll(u11);

                for _, descendant in pairs(u11:GetDescendants()) do
                    if descendant:IsA("Beam") or descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = true;
                    end;
                end;
            end);
        end;
    end;

    task.delay(7.82, function() -- Line: 208
        -- upvalues: u7 (ref), FieldOfView (copy), Folder (copy), u9 (copy), u10 (copy)
        if u7 then
            u7:Disconnect();
        end;

        game.Workspace.CurrentCamera.FieldOfView = FieldOfView;
        Folder:Destroy();

        for _, v in pairs(u9) do
            v.Parent = game:GetService("Lighting");
        end;

        for _, v in pairs(u10) do
            v:Destroy();
        end;
    end);
end;