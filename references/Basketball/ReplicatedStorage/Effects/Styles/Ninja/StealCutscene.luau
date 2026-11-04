 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local u1 = require("@game/ReplicatedStorage/Packages/Janitor");
local u2 = require("@game/ReplicatedStorage/Shared/Utility/Sequencer");
local u3 = require("@game/ReplicatedStorage/Shared/Utility/ForgeVFX");
local u4 = require("@game/ReplicatedStorage/Shared/Utility/SfxManager");
local u5 = require("@self/CutsceneData");
local workspace_CurrentCamera = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;

local function TrySetProperties(p6, p7, p8, p9) -- Line: 19
    for i, v in p8 do
        local Frames = v.Frames;

        if p9 then
            if Frames[p6] == nil then
                local v10 = i;

                for i2 = p6, 0, -1 do
                    if Frames[i2] ~= nil then
                        p7[v10] = Frames[i2];
                        break;
                    end;

                    local _ = i2;
                end;
            else
                p7[i] = Frames[p6];
            end;
        elseif Frames[p6] ~= nil then
            p7[i] = Frames[p6];
        end;
    end;
end;

return function(p11: any, u12: table) -- Line: 42
    -- upvalues: u4 (copy), LocalPlayer (copy), u1 (copy), workspace_CurrentCamera (copy), Lighting (copy), ReplicatedStorage (copy), TrySetProperties (copy), u5 (copy), u2 (copy), u3 (copy), RunService (copy)
    local TimeSent = u12.TimeSent;
    local v13 = workspace:GetServerTimeNow() - u12.TimeSent;
    local math_max_ret = math.max(14.166666666666666 - v13, 0);

    if math_max_ret <= 0.1 then
        return;
    end;

    u4:playSound({
        Sound = "BBZ Ninja Steal Cutscene",
        Parent = workspace
    }).TimePosition = v13;
    local u14 = u12.Character or LocalPlayer.Character;
    local v15 = u12.Target or u14;
    local CamRig = workspace:FindFirstChild("CamRig");
    u14.Archivable = true;
    v15.Archivable = true;
    local HumanoidRootPart = u14.HumanoidRootPart;
    local u16 = u1.new();
    u16:Add(task.delay(math_max_ret, function() -- Line: 65
        -- upvalues: u16 (copy)
        u16:Destroy();
    end));
    local v17 = u16:Add(script.FX:Clone());
    v17.Parent = LocalPlayer.PlayerGui;
    local u18 = { workspace_CurrentCamera, v17["Screen Cover"] };
    local u19 = {
        v17.Vignette,
        v17.Vignette.LL,
        v17.Vignette.UR,
        v17.Vignette.LL.LR
    };

    for _, child in Lighting:GetChildren() do
        if not (child:IsA("Atmosphere") or child:IsA("Sky")) then
            child.Parent = nil;
            u16:Add(function() -- Line: 81
                -- upvalues: child (copy), Lighting (ref)
                if child == nil then
                    return;
                end;

                child.Parent = Lighting;
            end);
        end;
    end;

    for _, child in script.Lighting:GetChildren() do
        local v20 = u16:Add(child:Clone());
        v20.Parent = workspace_CurrentCamera;

        if v20.Name == "Blur" or (v20.Name == "Sae Cele" or v20.Name == "GREEN") then
            table.insert(u18, v20);
        end;
    end;

    local u21 = {};

    for i = 1, 9 do
        local u22 = i == 9 and u16:Add(v15:Clone()) or u16:Add(u14:Clone());
        u21[i] = u22;
        u22.PlrBall:Destroy();
        u22.Humanoid.RequiresNeck = false;
        u22.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
        u22.PrimaryPart = u22.HumanoidRootPart;
        u22.PrimaryPart.Anchored = true;
        local v23 = i;

        for _, v in u22:QueryDescendants("Script,LocalScript") do
            v:Destroy();
        end;

        if u22:FindFirstChild("Torso") and (u22:FindFirstChild("FrontJersey") and u22:FindFirstChild("BackJersey")) then
            u22.FrontJersey.Adornee = u22.Torso;
            u22.BackJersey.Adornee = u22.Torso;
        end;

        u22.Parent = workspace.Debris;
        local v24 = v23 == 9 and "StealCutsceneEnemy" or `StealCutsceneClone{v23}`;
        local u25 = u16:Add(u22.Humanoid.Animator:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations.Ninja[v24]));
        u25:Play();
        u16:Add(task.spawn(function() -- Line: 125
            -- upvalues: u22 (copy), u25 (copy), HumanoidRootPart (copy), TimeSent (copy)
            u22:PivotTo(CFrame.new(0, 10000, 0));

            repeat
                task.wait();
            until u25.Length > 0 or (u22 == nil or u22.Parent == nil);

            if u22 == nil or u22.Parent == nil then
                return;
            end;

            u22:PivotTo(HumanoidRootPart.CFrame);
            u25.TimePosition = workspace:GetServerTimeNow() - TimeSent;
        end));
    end;

    local v26 = u16:Add(script.Highlight:Clone());
    v26.Parent = u21[9];
    table.insert(u18, v26);
    local v27 = (workspace:GetServerTimeNow() - u12.TimeSent) * 60;
    local math_floor_ret = math.floor(v27);

    for _, v in u18 do
        TrySetProperties(math_floor_ret, v, u5.Data[v.Name].Properties, true);
    end;

    for _, v in u19 do
        TrySetProperties(math_floor_ret, v, u5.Data.Vignette.Properties, true);
    end;

    local u28 = u16:Add(script.VFX:Clone());
    u28:PivotTo(HumanoidRootPart.CFrame);
    local u29 = {};

    for _, child in script.TargetAura:GetChildren() do
        local v30 = u16:Add(child:Clone());
        u29[v30.Name] = child;
        v30.CFrame = u21[9][v30.Name].CFrame;
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = u21[9][v30.Name];
        WeldConstraint.Part1 = v30;
        WeldConstraint.Parent = v30;
        v30.Parent = workspace.Debris;
    end;

    u16:Add(u2({
        [0] = function() -- Line: 169
            -- upvalues: CamRig (copy)
            for _, v in CamRig.Camera:QueryDescendants("[$EnableAtStart = true]") do
                v.Enabled = true;
            end;
        end,

        [57] = function() -- Line: 174
            -- upvalues: u3 (ref), u28 (copy)
            u3.emit(u28["SIGN "]);
        end,

        [92] = function() -- Line: 177
            -- upvalues: u21 (copy), u3 (ref)
            for i, v in u21 do
                if i ~= 9 then
                    local v31 = script.A2:Clone();
                    task.delay(3, v31.Destroy, v31);
                    v31.Parent = v.Torso;
                    u3.emit(v31);
                end;
            end;
        end,

        [95] = function() -- Line: 189
            -- upvalues: u21 (copy), u3 (ref)
            local v32 = u21[1];
            local v33 = script.A2:Clone();
            task.delay(3, v33.Destroy, v33);
            v33.Parent = v32.Torso;
            u3.emit(v33);
        end,

        [156] = function() -- Line: 197
            -- upvalues: u3 (ref), CamRig (copy)
            u3.emit(CamRig.Camera.eyes, CamRig.Camera["11"]);
        end,

        [256] = function() -- Line: 200
            -- upvalues: u3 (ref), u29 (copy)
            u3.emit(u29["Right Leg"], u29["Left Leg"]);
        end,

        [308] = function() -- Line: 203
            -- upvalues: u3 (ref), u28 (copy), u29 (copy)
            u3.emit(u28.ScreenEffect, u29.Torso);
        end,

        [310] = function() -- Line: 206
            -- upvalues: u3 (ref), u28 (copy)
            u3.emit(u28.g);
        end,

        [316] = function() -- Line: 209
            -- upvalues: u3 (ref), u28 (copy)
            u3.emit(u28.DashPart);
        end,

        [354] = function() -- Line: 212
            -- upvalues: u14 (copy), u3 (ref)
            local v34 = script.RightArm:Clone();
            task.delay(3, v34.Destroy, v34);
            v34.Parent = u14["Right Arm"];
            u3.emit(v34);
        end,

        [364] = function() -- Line: 219
            -- upvalues: u3 (ref), u28 (copy)
            u3.emit(u28.sa);
        end,

        [366] = function() -- Line: 222
            -- upvalues: u16 (copy), u14 (copy), u3 (ref)
            for _, child in script.BallVFX:GetChildren() do
                u16:Add(child:Clone()).Parent = u14.PlrBall.BallAnims.BALL;
            end;

            u3.emit(u14.PlrBall.BallAnims.BALL);
        end,

        [368] = function() -- Line: 229
            -- upvalues: u14 (copy), u3 (ref)
            local v35 = script.A2:Clone();
            task.delay(3, v35.Destroy, v35);
            v35.Parent = u14.Torso;
            u3.emit(v35);
        end,

        [472] = function() -- Line: 237
            -- upvalues: u21 (copy), u3 (ref)
            for i, v in u21 do
                if i ~= 9 then
                    local v36 = script.A2:Clone();
                    task.delay(3, v36.Destroy, v36);
                    v36.Parent = v.Torso;
                    u3.emit(v36);
                end;
            end;
        end,

        [481] = function() -- Line: 249
            -- upvalues: u3 (ref), u28 (copy)
            u3.emit(u28.tp1);
        end,

        [578] = function() -- Line: 252
            -- upvalues: u3 (ref), u28 (copy)
            u3.emit(u28.Push);
        end,

        [644] = function() -- Line: 255
            -- upvalues: u3 (ref), u28 (copy)
            u3.emit(u28.FallFX);
        end,

        [680] = function() -- Line: 258
            -- upvalues: u3 (ref), u28 (copy)
            u3.emit(u28.Impact);
        end,

        [780] = function() -- Line: 261
            -- upvalues: u14 (copy), u3 (ref)
            local v37 = script.Glint:Clone();
            task.delay(3, v37.Destroy, v37);
            v37.Parent = u14.Head;
            u3.emit(v37);
        end
    }, {
        FPS = 60,
        PassedTime = v13
    }));
    u16:Add(RunService.Heartbeat:Connect(function(p38: number) -- Line: 273
        -- upvalues: u12 (copy), u18 (copy), u5 (ref), u19 (copy), math_floor_ret (copy)
        local v39 = (workspace:GetServerTimeNow() - u12.TimeSent) * 60;
        local math_floor_ret2 = math.floor(v39);

        for _, v in u18 do
            local v40 = v;

            for i, v2 in u5.Data[v.Name].Properties do
                local Frames = v2.Frames;

                if Frames[math_floor_ret2] ~= nil then
                    v40[i] = Frames[math_floor_ret2];
                end;
            end;
        end;

        for _, v in u19 do
            local v41 = math_floor_ret;
            local v42 = v;

            for i, v2 in u5.Data.Vignette.Properties do
                local Frames = v2.Frames;

                if Frames[v41] ~= nil then
                    v42[i] = Frames[v41];
                end;
            end;
        end;
    end));
end;