 
 

game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ContentProvider");
game:GetService("Debris");
local Lighting = game:GetService("Lighting");
local Players = game:GetService("Players");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
game:GetService("ServerStorage");
local SoundService = game:GetService("SoundService");
game:GetService("TextService");
game:GetService("TweenService");
game:GetService("UserInputService");
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);
local u1 = {};
local _ = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;
local _ = LocalPlayer.PlayerGui;
LocalPlayer:GetMouse();
local _ = Lighting.Atmosphere.Color;
local _ = Lighting.Atmosphere.Density;
local _ = Lighting.Brightness;
local _ = Lighting.ClockTime;
require(ReplicatedStorage2.util.raycast);
require(ReplicatedStorage2.util.animationUtil);
local soundUtil = require(ReplicatedStorage2.util.soundUtil);
require(ReplicatedStorage2.util.actionUtil);
local EasingFunctions = require(ReplicatedStorage2.util.EasingFunctions);
local TekrinnDialogue = require(script.Parent.Parent.TekrinnDialogue);

function u1.dashToDestination(p2, p3, ...) -- Line: 35
    -- upvalues: u1 (copy)
    local v4 = p3 * Vector3.new(1, 0, 1) + Vector3.new(0, 1, 0) * p2.HumanoidRootPart.Position.Y;
    p2:SetAttribute("disableRotate", true);
    u1.moveToDestination(p2, v4, unpack({
        ...,
        [5] = true
    }));
    p2:SetAttribute("disableRotate", false);
end;

function u1.moveToDestination(p5, p6, p7, p8, p9, p10) -- Line: 48
    -- upvalues: ReplicatedStorage2 (copy), EasingFunctions (copy)
    local HumanoidRootPart = p5.HumanoidRootPart;
    local ServerTimeNow = workspace:GetServerTimeNow();
    local math_max_ret = math.max(p7 - ServerTimeNow, 0);
    local u11 = ReplicatedStorage2.Resources.milkytillys.milkydash:Clone();
    u11.Parent = p5;
    u11.Weld.Part0 = HumanoidRootPart;
    local u12 = ReplicatedStorage2.Resources.armdrip:Clone();
    u12.Parent = p5;
    u12.Weld.Part0 = p5["Left Arm"];
    local u13 = ReplicatedStorage2.Resources.armdrip:Clone();
    u13.Parent = p5;
    u13.Weld.Part0 = p5["Right Arm"];
    task.delay(math_max_ret, function() -- Line: 66
        -- upvalues: u12 (copy), u13 (copy)
        for _, descendant in ipairs(u12:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u13:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        task.delay(2, u12.Destroy, u12);
        task.delay(2, u13.Destroy, u13);
    end);
    task.delay(math_max_ret, function() -- Line: 83
        -- upvalues: u11 (copy)
        for _, descendant in ipairs(u11:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        task.delay(2, u11.Destroy, u11);
    end);
    local CFrame2 = HumanoidRootPart.CFrame;
    local v14 = p8 and EasingFunctions[p8] or EasingFunctions.Linear;
    local Rotation = CFrame.lookAt(HumanoidRootPart.Position, p6).Rotation;

    while task.wait() do
        local v15 = workspace:GetServerTimeNow() - ServerTimeNow;
        local v16 = v14((math.clamp(v15 / math_max_ret, 0, 1)));
        local v17 = p9 and CFrame2.Rotation:Lerp(Rotation, v16) or HumanoidRootPart.CFrame.Rotation;
        HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(100, 100, 100);
        HumanoidRootPart.CFrame = v17 + CFrame2.Position:Lerp(p6, v16);

        if math_max_ret <= v15 then
            break;
        end;
    end;

    if p10 then
        HumanoidRootPart.AssemblyLinearVelocity = (HumanoidRootPart.CFrame.Position - CFrame2.Position) * Vector3.new(1, 0, 1) * math_max_ret;

        return;
    end;

    HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
end;

function u1.delayedToMove(p18, p19, p20, ...) -- Line: 117
    -- upvalues: u1 (copy)
    task.wait(p20 - workspace:GetServerTimeNow());
    u1.moveToDestination(p18, p19, ...);
end;

function u1.delayedToDash(p21, p22, p23, ...) -- Line: 122
    -- upvalues: u1 (copy)
    task.wait(p23 - workspace:GetServerTimeNow());
    u1.dashToDestination(p21, p22, ...);
end;

function u1.milkyOvertimeAwaken(u24, u25) -- Line: 128
    -- upvalues: mainreplication (copy), soundUtil (copy), ReplicatedStorage2 (copy), SoundService (copy), TekrinnDialogue (copy), RunService (copy)
    local v26 = u24.HumanoidRootPart or u24.PrimaryPart;
    local _ = u24.Torso;
    mainreplication.sceneEnabled(true);
    soundUtil:play(ReplicatedStorage2.Resources.Through, SoundService);
    mainreplication.cutscene(v26, CFrame.new(Vector3.new(0, 0, 0)), 4.5, ReplicatedStorage2.Resources.isagi.FOV);
    task.delay(0.05, function() -- Line: 140
        -- upvalues: TekrinnDialogue (ref), u24 (copy), u25 (copy)
        TekrinnDialogue.Speak(u24, {
            {
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Text = `Throughout {u25 and "depths and back" or "heaven and earth"}...`,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(44, 44, 44)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 3);
    end);
    task.delay(1.9, function() -- Line: 166
        -- upvalues: TekrinnDialogue (ref), u24 (copy)
        TekrinnDialogue.Speak(u24, {
            {
                Text = "I am the above one!",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 45)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 5
                }
            }
        }, 2.5);
    end);
    local u27 = ReplicatedStorage2.Resources.isagi.A:Clone();
    u27.CFrame = v26.CFrame;
    u27.Parent = u24;
    local v30 = RunService.PreRender:Connect(function(p28) -- Line: 196
        -- upvalues: u27 (copy)
        local v29 = u27;
        v29.CFrame = v29.CFrame * CFrame.Angles(0, 0.005, 0);
    end);
    mainreplication.bright(1, 1.5);
    local v31 = ReplicatedStorage2.Resources.isagi.RoomReal:Clone();
    v31.CFrame = v26.CFrame;
    v31.Parent = u24;
    task.wait(1.91);
    v31:Destroy();
    local v32 = ReplicatedStorage2.Resources.isagi.RoomReal2:Clone();
    v32.CFrame = v26.CFrame;
    v32.Parent = u24;
    local v33 = ReplicatedStorage2.Resources.isagi.legwater:Clone();
    v33.Parent = u24;
    v33.CFrame = CFrame.new(u24["Left Leg"].Position);
    local v34 = ReplicatedStorage2.Resources.isagi.legwater:Clone();
    v34.Parent = u24;
    v34.CFrame = CFrame.new(u24["Right Leg"].Position);
    task.wait(2.5);
    v32:Destroy();
    v30:Disconnect();
    u27:Destroy();
    v33:Destroy();
    v34:Destroy();
    mainreplication.ultFlash(-1, 1);
    mainreplication.fov(false, 40);
    mainreplication.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    mainreplication.sceneEnabled(false);
end;

return u1;