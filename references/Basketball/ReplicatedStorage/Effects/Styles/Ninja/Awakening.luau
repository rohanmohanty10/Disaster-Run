 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local u1 = require("@game/ReplicatedStorage/Packages/Janitor");
local u2 = require("@game/ReplicatedStorage/Shared/Utility/Sequencer");
local u3 = require("@game/ReplicatedStorage/Shared/Utility/ForgeVFX");
local u4 = require("@game/ReplicatedStorage/Shared/Utility/SfxManager");
local u5 = require("@self/CutsceneData");
local workspace_CurrentCamera = workspace.CurrentCamera;

local function TrySetProperties(p6, p7, p8, p9) -- Line: 15
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

return function(p11: any, u12: table) -- Line: 38
    -- upvalues: u1 (copy), u4 (copy), ReplicatedStorage (copy), Lighting (copy), workspace_CurrentCamera (copy), TrySetProperties (copy), u5 (copy), u2 (copy), u3 (copy), RunService (copy)
    local u13 = workspace:GetServerTimeNow() - u12.TimeSent;
    local math_max_ret = math.max(2.6166666666666667 - u13, 0);

    if math_max_ret <= 0.1 then
        return;
    end;

    local u14 = u1.new();
    u14:Add(task.delay(math_max_ret, function() -- Line: 48
        -- upvalues: u14 (copy)
        u14:Destroy();
    end));
    u4:playSound({
        Sound = "BBZ Ninja Awakening",
        Parent = workspace
    }).TimePosition = u13;
    local CamRig = workspace:FindFirstChild("CamRig");
    local Character = u12.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local u15 = u14:Add(script.KURAMA:Clone());
    u15:PivotTo(CFrame.new(0, 10000, 0));
    u15.Parent = workspace.Debris;
    local u16 = u15.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations.Ninja.AwakeningKurama);
    u16:Play();
    u16.TimePosition = u13;
    u14:Add(task.spawn(function() -- Line: 69
        -- upvalues: u15 (copy), u16 (copy), u13 (copy), HumanoidRootPart (copy)
        local os_clock_ret = os.clock();
        local v17 = true;

        while true do
            if u15 == nil or u15.Parent == nil then
                v17 = false;
                break;
            end;

            if u16.Length > 0 then
                break;
            end;

            task.wait();
        end;

        if v17 == false then
            return;
        end;

        u16.TimePosition = os.clock() - os_clock_ret + u13;
        u15:PivotTo(HumanoidRootPart.CFrame * CFrame.new(1.55431107e-15, -3, -2.98023224e-8, -1, 3.33067304e-16, 0, -3.33067304e-16, 1, 0, 0, 0, -1));
    end));
    local u18 = {};

    for _, child in Lighting:GetChildren() do
        if not (child:IsA("Atmosphere") or child:IsA("Sky")) then
            child.Parent = nil;
            u14:Add(function() -- Line: 93
                -- upvalues: child (copy), Lighting (ref)
                if child == nil then
                    return;
                end;

                pcall(function() -- Line: 97
                    -- upvalues: child (ref), Lighting (ref)
                    child.Parent = Lighting;
                end);
            end);
        end;
    end;

    for _, child in script.Lighting:GetChildren() do
        local v19 = u14:Add(child:Clone());
        v19.Parent = workspace_CurrentCamera;

        if v19.Name == "Blur" or v19.Name == "Sae Cele" then
            table.insert(u18, v19);
        end;
    end;

    local v20 = u14:Add(script.Highlight:Clone());
    v20.Name = "HighlightPlayer";
    v20.Parent = Character;
    table.insert(u18, workspace_CurrentCamera);
    table.insert(u18, u15.Highlight);
    local v21 = (workspace:GetServerTimeNow() - u12.TimeSent) * 60;
    local math_floor_ret = math.floor(v21);

    for _, v in u18 do
        TrySetProperties(math_floor_ret, v, u5.Data[v.Name].Properties, true);
    end;

    u14:Add(u2({
        [0] = function() -- Line: 126
            -- upvalues: CamRig (copy), u3 (ref)
            for _, v in CamRig.CamPart:QueryDescendants("ParticleEmitter,Beam") do
                if not (v:IsDescendantOf(CamRig.CamPart["11"]) or v:IsDescendantOf(CamRig.CamPart.WindScene)) then
                    v.Enabled = true;
                end;
            end;

            u3.emit(CamRig.CamPart["11"]);
        end,

        [48] = function() -- Line: 135
            -- upvalues: u3 (ref), CamRig (copy)
            u3.emit(CamRig.CamPart.WindScene);
        end
    }, {
        FPS = 60,
        PassedTime = u13
    }));
    u14:Add(RunService.Heartbeat:Connect(function(p22: number) -- Line: 143
        -- upvalues: u12 (copy), u18 (copy), u5 (ref)
        local v23 = (workspace:GetServerTimeNow() - u12.TimeSent) * 60;
        local math_floor_ret2 = math.floor(v23);

        for _, v in u18 do
            local v24 = v;

            for i, v2 in u5.Data[v.Name].Properties do
                local Frames = v2.Frames;

                if Frames[math_floor_ret2] ~= nil then
                    v24[i] = Frames[math_floor_ret2];
                end;
            end;
        end;
    end));
end;