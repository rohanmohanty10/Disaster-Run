 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerStorage");
local RunService = game:GetService("RunService");
game:GetService("UserInputService");
game:GetService("TweenService");
game:GetService("Debris");
game:GetService("CollectionService");
local Lighting = game:GetService("Lighting");
game:GetService("SoundService");
game:GetService("TextService");
game:GetService("ContentProvider");
local v1 = {};
local workspace_CurrentCamera = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;
local _ = LocalPlayer.PlayerGui;
LocalPlayer:GetMouse();
local _ = Lighting.Atmosphere.Color;
local _ = Lighting.Atmosphere.Density;
local _ = Lighting.Brightness;
local _ = Lighting.ClockTime;
require(ReplicatedStorage.util.raycast);
require(ReplicatedStorage.util.animationUtil);
require(ReplicatedStorage.util.soundUtil);
local actionUtil = require(ReplicatedStorage.util.actionUtil);
require(ReplicatedStorage.util.vfxUtil);
local mainreplication = require(script.Parent.Parent.mainreplication);
require(script.Parent.Parent.TekrinnDialogue);

local function FovRenderStepped(p2, p3, p4, p5, p6, p7) -- Line: 36
    -- upvalues: workspace_CurrentCamera (copy)
    local v8 = p6 + p2 * 60;
    local math_ceil_ret = math.ceil(v8);
    local v9 = tonumber(math_ceil_ret);
    local v10 = nil;
    local v11 = nil;

    if p3:IsA("ModuleScript") then
        v11 = require(p3)[v9];
    else
        v10 = p3:FindFirstChild(v9);
    end;

    if (v10 or v11) and p4 then
        workspace_CurrentCamera.FieldOfView = v11 or v10.Value;
        workspace_CurrentCamera.CFrame = p4.CFrame;

        return v8;
    end;

    p5.Humanoid.AutoRotate = true;
    workspace_CurrentCamera.CameraSubject = p5.Humanoid;
    workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
    workspace_CurrentCamera.FieldOfView = 70;

    if not p7 and (p4 and p4.Parent) then
        p4.Parent:Destroy();
    end;

    return "disconnect";
end;

function v1.StealCamera(p12, p13, u14, p15) -- Line: 62
    -- upvalues: Players (copy), actionUtil (copy), workspace_CurrentCamera (copy), ReplicatedStorage (copy), RunService (copy), FovRenderStepped (copy)
    local Character = Players.LocalPlayer.Character;
    local u16 = 0;
    local u17 = nil;
    local v18 = p15 or CFrame.new(0, -3, 0);

    if not (actionUtil.checkGK(Character) and (Character ~= p12.Parent and not actionUtil.checksameTeam(Character, p12.Parent))) then
        Character.Humanoid.AutoRotate = false;
        workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        local u19 = ReplicatedStorage.Resources.SakuyaStealCamera:Clone();
        u19.Parent = workspace;
        u19:PivotTo(p12.CFrame * v18);
        u19.AnimationController.Animator:LoadAnimation(p13):Play();
        workspace_CurrentCamera.CameraSubject = u19.camera;
        u17 = RunService.RenderStepped:Connect(function(p20) -- Line: 82
            -- upvalues: FovRenderStepped (ref), u14 (copy), u19 (copy), Character (copy), u16 (ref), u17 (ref)
            local v21 = FovRenderStepped(p20, u14, u19:FindFirstChild("camera"), Character, u16);

            if v21 == "disconnect" then
                u17:Disconnect();

                return;
            end;

            u16 = v21;
        end);

        return u19;
    end;
end;

function v1.evilCamera(p22, p23, p24, p25, p26, p27, p28) -- Line: 94
    -- upvalues: Players (copy), actionUtil (copy), mainreplication (copy), ReplicatedStorage (copy)
    local Character = Players.LocalPlayer.Character;
    local v29 = p25 or CFrame.new(0, -2.5, 0);

    if not (actionUtil.checkGK(Character) and (Character ~= p22.Parent and not actionUtil.checksameTeam(Character, p22.Parent))) then
        return mainreplication.cutsceneCamRigWithLetterBoxForIdiots(p22, p23, p24, nil, v29, ReplicatedStorage.Resources.evilRig, "CameraPart");
    end;
end;

function v1.KimCamera(p30, p31, u32, p33) -- Line: 108
    -- upvalues: Players (copy), actionUtil (copy), workspace_CurrentCamera (copy), ReplicatedStorage (copy), RunService (copy), FovRenderStepped (copy)
    local Character = Players.LocalPlayer.Character;
    local u34 = 0;
    local u35 = nil;
    local v36 = p33 or CFrame.new(0, 0, 0);

    if not (actionUtil.checkGK(Character) and (Character ~= p30.Parent and not actionUtil.checksameTeam(Character, p30.Parent))) then
        Character.Humanoid.AutoRotate = false;
        workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        local CFrame2 = workspace_CurrentCamera.CFrame;
        local u37 = ReplicatedStorage.Resources.CameraRig:Clone();
        u37.Parent = workspace;
        u37:PivotTo(p30.CFrame * v36);
        local u38 = u37.AnimationController.Animator:LoadAnimation(p31);
        u38:Play(0);
        workspace_CurrentCamera.CameraSubject = u37.Bone;

        if u32 then
            local function resetCamera() -- Line: 132
                -- upvalues: u35 (ref), workspace_CurrentCamera (ref), CFrame2 (copy)
                u35:Disconnect();
                workspace_CurrentCamera.CFrame = CFrame2;
            end;

            u35 = RunService.RenderStepped:Connect(function(p39) -- Line: 136
                -- upvalues: u37 (copy), u35 (ref), workspace_CurrentCamera (ref), CFrame2 (copy), FovRenderStepped (ref), u32 (copy), Character (copy), u34 (ref), u38 (copy)
                if not u37:FindFirstChild("Bone") then
                    u35:Disconnect();
                    workspace_CurrentCamera.CFrame = CFrame2;

                    return;
                end;

                local v40 = FovRenderStepped(p39, u32, u37:FindFirstChild("Bone"), Character, u34);

                if not (v40 == "disconnect" and not (u37 and u37:FindFirstChild("Bone")) and u38.IsPlaying) and u32 then
                    u34 = v40;

                    return;
                end;

                u35:Disconnect();
                workspace_CurrentCamera.CFrame = CFrame2;
            end);
        else
            local u42 = RunService.Heartbeat:Connect(function(p41: number) -- Line: 149
                -- upvalues: workspace_CurrentCamera (ref), u37 (copy)
                workspace_CurrentCamera.CFrame = u37.Bone.CFrame;
            end);
            local u43 = false;
            u37.Destroying:Once(function() -- Line: 153
                -- upvalues: u43 (ref), u42 (ref), Character (copy), workspace_CurrentCamera (ref), u37 (copy), CFrame2 (copy)
                if not u43 then
                    u42:Disconnect();
                    Character.Humanoid.AutoRotate = true;
                    workspace_CurrentCamera.CameraSubject = Character.Humanoid;
                    workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
                    workspace_CurrentCamera.FieldOfView = 70;
                    u37:Destroy();
                    workspace_CurrentCamera.CFrame = CFrame2;
                end;
            end);
            u38.Stopped:Once(function() -- Line: 165
                -- upvalues: u43 (ref), u42 (ref), Character (copy), workspace_CurrentCamera (ref), u37 (copy), CFrame2 (copy)
                u43 = true;
                u42:Disconnect();
                Character.Humanoid.AutoRotate = true;
                workspace_CurrentCamera.CameraSubject = Character.Humanoid;
                workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
                workspace_CurrentCamera.FieldOfView = 70;
                u37:Destroy();
                workspace_CurrentCamera.CFrame = CFrame2;
            end);
        end;

        return u37;
    end;
end;

function v1.KuniCamera(p44, u45) -- Line: 181
    -- upvalues: Players (copy), workspace_CurrentCamera (copy), actionUtil (copy), ReplicatedStorage (copy), RunService (copy), FovRenderStepped (copy)
    local Character = Players.LocalPlayer.Character;
    local u46 = 0;
    local u47 = nil;
    Character.Humanoid.AutoRotate = false;
    workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;

    if not (actionUtil.checkGK(Character) and (Character ~= p44.Parent and not actionUtil.checksameTeam(Character, p44.Parent))) then
        local u48 = ReplicatedStorage.Resources.KunigamiCameraRig2:Clone();
        u48.Parent = p44.Parent;
        workspace_CurrentCamera.CameraSubject = u48;

        for _, child in u48:GetChildren() do
            if child:IsA("Weld") then
                child.Part0 = u48;
            end;
        end;

        u48.Name = "Cam";
        local Motor6D = Instance.new("Motor6D");
        Motor6D.Part0 = p44;
        Motor6D.Part1 = u48;
        Motor6D.Parent = u48;
        Motor6D.Name = "Cam";
        u47 = RunService.RenderStepped:Connect(function(p49) -- Line: 212
            -- upvalues: FovRenderStepped (ref), u45 (copy), u48 (copy), Character (copy), u46 (ref), Motor6D (copy), u47 (ref)
            local v50 = FovRenderStepped(p49, u45, u48, Character, u46, true);

            if v50 ~= "disconnect" then
                u46 = v50;

                return;
            end;

            Motor6D:Destroy();
            u48:Destroy();
            u47:Disconnect();
        end);

        return u48;
    end;
end;

return v1;