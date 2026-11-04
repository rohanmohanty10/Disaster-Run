 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = Players.LocalPlayer;
local u1 = {
    [4166416054] = true,
    [619213444] = true,
    [9248296813] = true,
    [10444140562] = true,
    [393718809] = true,
    [1549164509] = true,
    [568225745] = true
};

if ({
    [2447122302] = true,
    [4166416054] = true,
    [619213444] = true,
    [9248296813] = true,
    [10444140562] = true,
    [393718809] = true,
    [1549164509] = true,
    [568225745] = true
})[LocalPlayer.UserId] then
    return;
end;

local packets = require(ReplicatedStorage:WaitForChild("packets"));
local u2 = {
    [Enum.KeyCode.W] = "forward",
    [Enum.KeyCode.Up] = "forward",
    [Enum.KeyCode.S] = "back",
    [Enum.KeyCode.Down] = "back"
};
local u3 = {};
local u4 = false;
RunService.PostSimulation:Connect(function() -- Line: 45
    -- upvalues: u3 (ref)
    local v5 = tick();

    while #u3 > 0 and v5 - u3[1].time > 1.5 do
        table.remove(u3, 1);
    end;
end);

local function nearTarget() -- Line: 53
    -- upvalues: LocalPlayer (copy), Players (copy), u1 (copy)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return nil;
    end;

    for _, v in Players:GetPlayers() do
        if v ~= LocalPlayer and u1[v.UserId] then
            local Character2 = v.Character;

            if Character2 then
                Character2 = Character2:FindFirstChild("HumanoidRootPart");
            end;

            if Character2 and (Character.Position - Character2.Position).Magnitude <= 7 then
                return v;
            end;
        end;
    end;

    return nil;
end;

local function isFrozen(p6: userdata) -- Line: 79
    -- upvalues: LocalPlayer (copy)
    if workspace:GetAttribute("activeMvp") or workspace:GetAttribute("Timestopped") then
        return true;
    end;

    local Character = LocalPlayer.Character;
    local Character2 = p6.Character;

    if Character and Character:GetAttribute("frozen") or Character2 and Character2:GetAttribute("frozen") then
        return true;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v7;

    if workspace_CurrentCamera == nil then
        v7 = false;
    else
        v7 = workspace_CurrentCamera.CameraType == Enum.CameraType.Scriptable;
    end;

    return v7;
end;

local function registerTap(p8: string) -- Line: 94
    -- upvalues: u4 (ref), nearTarget (copy), isFrozen (copy), u3 (ref), packets (copy)
    if u4 then
        return;
    end;

    local v9 = nearTarget();

    if not v9 then
        return;
    end;

    if isFrozen(v9) then
        u3 = {};

        return;
    end;

    local v10 = {
        key = p8,
        time = tick()
    };
    table.insert(u3, v10);

    if #u3 < 5 then
        return;
    end;

    local v11 = true;

    for i = 2, #u3 do
        if u3[i].key == u3[i - 1].key then
            v11 = false;
            break;
        end;

        local _ = i;
    end;

    if v11 and u3[#u3].time - u3[1].time <= 1.5 then
        u4 = true;
        u3 = {};
        packets.bytenet_noWeirdo.send(v9.UserId);
        task.delay(3, function() -- Line: 129
            -- upvalues: u4 (ref)
            u4 = false;
        end);
    end;
end;

UserInputService.InputBegan:Connect(function(p12, p13) -- Line: 135
    -- upvalues: u2 (copy), registerTap (copy)
    if p13 then
        return;
    end;

    local v14 = u2[p12.KeyCode];

    if v14 then
        registerTap(v14);
    end;
end);
local u15 = nil;
task.spawn(function() -- Line: 149
    -- upvalues: LocalPlayer (copy), u15 (ref)
    local PlayerModule = LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule", 30);

    if not PlayerModule then
        return;
    end;

    local success, result = pcall(function() -- Line: 154
        -- upvalues: PlayerModule (copy)
        return require(PlayerModule):GetControls();
    end);

    if success then
        u15 = result;
    end;
end);

local function usingStick() -- Line: 162
    -- upvalues: UserInputService (copy)
    local LastInputType = UserInputService:GetLastInputType();

    return LastInputType == Enum.UserInputType.Touch and true or LastInputType.Name:sub(1, 7) == "Gamepad";
end;

local u16 = nil;
RunService.PreSimulation:Connect(function() -- Line: 169
    -- upvalues: u15 (ref), UserInputService (copy), u16 (ref), registerTap (copy)
    if u15 then
        local LastInputType = UserInputService:GetLastInputType();

        if LastInputType == Enum.UserInputType.Touch and true or LastInputType.Name:sub(1, 7) == "Gamepad" then
            local MoveVector = u15:GetMoveVector();
            local v17 = MoveVector.Z <= -0.6 and "forward" or (MoveVector.Z >= 0.6 and "back" or nil);

            if v17 ~= u16 then
                u16 = v17;

                if v17 then
                    registerTap(v17);
                end;
            end;

            return;
        end;
    end;

    u16 = nil;
end);