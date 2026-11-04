 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local PolicyService = game:GetService("PolicyService");
local FFlags = require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags"));

if not (FFlags.CrateRollOverhead or (FFlags.PumpkinRollOverhead or FFlags.SpinWheelKnifeOverhead)) then
    return;
end;

local LocalPlayer = Players.LocalPlayer;
local Crates = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("Crates");
local CrateRollConfig = require(Crates:WaitForChild("CrateRollConfig"));
local OverheadRoll = require(Crates:WaitForChild("OverheadRoll"));
local CrateRollEvent = Crates:WaitForChild("CrateRollEvent", 30);

if not CrateRollEvent then
    return;
end;

local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local u1 = false;
task.spawn(function() -- Line: 33
    -- upvalues: PolicyService (copy), LocalPlayer (copy), u1 (ref)
    for i = 1, 4 do
        local success, result = pcall(PolicyService.GetPolicyInfoForPlayerAsync, PolicyService, LocalPlayer);

        if success and type(result) == "table" then
            u1 = result.ArePaidRandomItemsRestricted == false;

            return;
        end;

        task.wait(i * 5);
        local _ = i;
    end;
end);

local function inLobby(p2) -- Line: 45
    local v3;

    if p2:GetAttribute("InMatch") == true or ((p2:GetAttribute("GameRole") or "Lobby") ~= "Lobby" or (p2:GetAttribute("EventIntroPlaying") == true or p2:GetAttribute("AdminTransferring") == true)) then
        v3 = false;
    else
        v3 = p2:GetAttribute("ServerBrowserTransferring") ~= true;
    end;

    return v3;
end;

local function headOf(p4) -- Line: 53
    local Character = p4.Character;
    local v5;

    if Character then
        v5 = Character:FindFirstChild("Head");
    else
        v5 = Character;
    end;

    if Character then
        Character = Character:FindFirstChildOfClass("Humanoid");
    end;

    if v5 and (v5:IsA("BasePart") and (Character and Character.Health > 0)) then
        return v5;
    end;

    return nil;
end;

local u6 = {};

local function drop(p7) -- Line: 64
    -- upvalues: u6 (copy)
    local v8 = u6[p7];

    if v8 then
        u6[p7] = nil;
        local success, result = pcall(v8.destroy, v8);

        if not success then
            warn("[CrateRolls]", result);
        end;
    end;
end;

local function clear() -- Line: 74
    -- upvalues: u6 (copy)
    for i in u6 do
        local v9 = u6[i];

        if v9 then
            u6[i] = nil;
            local success, result = pcall(v9.destroy, v9);

            if not success then
                warn("[CrateRolls]", result);
            end;
        end;
    end;
end;

local function distanceTo(p10) -- Line: 81
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v11 = not workspace_CurrentCamera and (1 / 0) or (workspace_CurrentCamera.CFrame.Position - p10.Position).Magnitude;

    return v11 ~= v11 and (1 / 0) or v11;
end;

CrateRollEvent.OnClientEvent:Connect(function(p12, p13) -- Line: 87
    -- upvalues: FFlags (copy), u1 (ref), inLobby (copy), LocalPlayer (copy), Players (copy), CrateRollConfig (copy), u6 (copy), OverheadRoll (copy), PlayerGui (copy)
    if p12 ~= "Show" or (type(p13) ~= "table" or (type(p13.user) ~= "number" or type(p13.at) ~= "number")) then
        return;
    end;

    local v14;

    if p13.kind == "Pumpkin" then
        v14 = FFlags.PumpkinRollOverhead;
    elseif p13.kind == "Wheel" then
        v14 = FFlags.SpinWheelKnifeOverhead;
    else
        v14 = FFlags.CrateRollOverhead;
    end;

    if not v14 then
        return;
    end;

    local v15 = workspace:GetServerTimeNow() - p13.at;

    if v15 <= -3 or v15 >= 8 then
        return;
    end;

    if not (u1 and inLobby(LocalPlayer)) then
        return;
    end;

    local PlayerByUserId = Players:GetPlayerByUserId(p13.user);

    if not (PlayerByUserId and inLobby(PlayerByUserId)) then
        return;
    end;

    if PlayerByUserId == LocalPlayer ~= (p13.preview == true) then
        return;
    end;

    local Character = PlayerByUserId.Character;
    local v16;

    if Character then
        v16 = Character:FindFirstChild("Head");
    else
        v16 = Character;
    end;

    if Character then
        Character = Character:FindFirstChildOfClass("Humanoid");
    end;

    if not (v16 and (v16:IsA("BasePart") and (Character and Character.Health > 0))) then
        v16 = nil;
    end;

    if not v16 then
        return;
    end;

    local v17;

    if PlayerByUserId == LocalPlayer then
        v17 = 0;
    else
        local workspace_CurrentCamera = workspace.CurrentCamera;
        local v18 = not workspace_CurrentCamera and (1 / 0) or (workspace_CurrentCamera.CFrame.Position - v16.Position).Magnitude;
        v17 = v18 ~= v18 and (1 / 0) or v18;
    end;

    if v17 > CrateRollConfig.SendRadius then
        return;
    end;

    local user = p13.user;
    local v19 = u6[user];

    if v19 then
        u6[user] = nil;
        local success, result = pcall(v19.destroy, v19);

        if not success then
            warn("[CrateRolls]", result);
        end;
    end;

    local v20 = 0;
    local v21 = -1;
    local v22 = nil;

    for i, v in u6 do
        v20 = v20 + 1;
        local workspace_CurrentCamera = workspace.CurrentCamera;
        local v23 = not workspace_CurrentCamera and (1 / 0) or (workspace_CurrentCamera.CFrame.Position - v.head.Position).Magnitude;
        local v24 = v23 ~= v23 and (1 / 0) or v23;

        if v21 < v24 then
            v22 = i;
            v21 = v24;
        end;
    end;

    if CrateRollConfig.MaxShows <= v20 then
        if v21 <= v17 then
            return;
        end;

        local v25 = u6[v22];

        if v25 then
            u6[v22] = nil;
            local success, result = pcall(v25.destroy, v25);

            if not success then
                warn("[CrateRolls]", result);
            end;
        end;
    end;

    local v26 = OverheadRoll.new(p13, v16, PlayerByUserId, PlayerGui);

    if v26 then
        u6[p13.user] = v26;
    end;
end);
RunService.RenderStepped:Connect(function() -- Line: 146
    -- upvalues: u6 (copy), u1 (ref), inLobby (copy), LocalPlayer (copy), Players (copy)
    if next(u6) == nil then
        return;
    end;

    if not (u1 and inLobby(LocalPlayer)) then
        for i in u6 do
            local v27 = u6[i];

            if v27 then
                u6[i] = nil;
                local success, result = pcall(v27.destroy, v27);

                if not success then
                    warn("[CrateRolls]", result);
                end;
            end;
        end;

        return;
    end;

    local ServerTimeNow = workspace:GetServerTimeNow();

    for i, v in u6 do
        local opener = v.opener;
        local v28;

        if opener.Parent == Players then
            v28 = v.head:IsDescendantOf(workspace) and inLobby(opener);

            if v28 then
                local Character = opener.Character;
                local v29;

                if Character then
                    v29 = Character:FindFirstChild("Head");
                else
                    v29 = Character;
                end;

                if Character then
                    Character = Character:FindFirstChildOfClass("Humanoid");
                end;

                if not (v29 and (v29:IsA("BasePart") and (Character and Character.Health > 0))) then
                    v29 = nil;
                end;

                v28 = v29 == v.head;
            end;
        else
            v28 = false;
        end;

        if v28 then
            local workspace_CurrentCamera = workspace.CurrentCamera;
            local v30 = not workspace_CurrentCamera and (1 / 0) or (workspace_CurrentCamera.CFrame.Position - v.head.Position).Magnitude;
            local success, result = pcall(v.step, v, ServerTimeNow, v30 ~= v30 and (1 / 0) or v30);
            v28 = success and result;

            if not success then
                warn("[CrateRolls]", result);
            end;
        end;

        if not v28 then
            local v31 = u6[i];

            if v31 then
                u6[i] = nil;
                local success, result = pcall(v31.destroy, v31);

                if not success then
                    warn("[CrateRolls]", result);
                end;
            end;
        end;
    end;
end);
Players.PlayerRemoving:Connect(function(p32) -- Line: 174
    -- upvalues: u6 (copy)
    local UserId = p32.UserId;
    local v33 = u6[UserId];

    if v33 then
        u6[UserId] = nil;
        local success, result = pcall(v33.destroy, v33);

        if not success then
            warn("[CrateRolls]", result);
        end;
    end;
end);