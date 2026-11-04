 

 

local CollectionService = game:GetService("CollectionService");
local RunService = game:GetService("RunService");
local WeaponEffects = require(game.ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Weapons"):WaitForChild("WeaponEffects"));
local CloneEchoMotion = require(game.ReplicatedStorage.ChickenOrHero.Weapons.CloneEchoMotion);
local UserGameSettings = UserSettings():GetService("UserGameSettings");
local u1 = {};

local function refresh(p2) -- Line: 8
    -- upvalues: WeaponEffects (copy), UserGameSettings (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        workspace_CurrentCamera = workspace_CurrentCamera.CFrame.Position;
    end;

    WeaponEffects.update(p2, workspace_CurrentCamera, WeaponEffects.detail(UserGameSettings.SavedQualityLevel));
end;

local function watchBlade(u3, p4) -- Line: 12
    -- upvalues: WeaponEffects (copy), UserGameSettings (copy)
    local VFXWeld = u3:FindFirstChild("VFXWeld");
    local v5 = VFXWeld and VFXWeld:IsA("Weld") and VFXWeld.Part0;

    if not v5 or v5 == p4.blade then
        return;
    end;

    for _, v in p4.connections do
        v:Disconnect();
    end;

    table.clear(p4.connections);
    p4.blade = v5;
    local connections = p4.connections;
    local PropertyChangedSignal = v5:GetPropertyChangedSignal("Transparency");
    table.insert(connections, PropertyChangedSignal:Connect(function() -- Line: 18
        -- upvalues: u3 (copy), WeaponEffects (ref), UserGameSettings (ref)
        local workspace_CurrentCamera = workspace.CurrentCamera;

        if workspace_CurrentCamera then
            workspace_CurrentCamera = workspace_CurrentCamera.CFrame.Position;
        end;

        WeaponEffects.update(u3, workspace_CurrentCamera, WeaponEffects.detail(UserGameSettings.SavedQualityLevel));
    end));
    local connections2 = p4.connections;
    local PropertyChangedSignal2 = v5:GetPropertyChangedSignal("LocalTransparencyModifier");
    table.insert(connections2, PropertyChangedSignal2:Connect(function() -- Line: 19
        -- upvalues: u3 (copy), WeaponEffects (ref), UserGameSettings (ref)
        local workspace_CurrentCamera = workspace.CurrentCamera;

        if workspace_CurrentCamera then
            workspace_CurrentCamera = workspace_CurrentCamera.CFrame.Position;
        end;

        WeaponEffects.update(u3, workspace_CurrentCamera, WeaponEffects.detail(UserGameSettings.SavedQualityLevel));
    end));
end;

local function add(p6) -- Line: 21
    -- upvalues: u1 (copy), CloneEchoMotion (copy), watchBlade (copy), WeaponEffects (copy), UserGameSettings (copy)
    if not p6:IsA("BasePart") or u1[p6] then
        return;
    end;

    local v7 = {
        connections = {},
        motion = CloneEchoMotion.build(p6)
    };
    u1[p6] = v7;
    watchBlade(p6, v7);
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        workspace_CurrentCamera = workspace_CurrentCamera.CFrame.Position;
    end;

    WeaponEffects.update(p6, workspace_CurrentCamera, WeaponEffects.detail(UserGameSettings.SavedQualityLevel));
end;

local u8 = CollectionService:GetInstanceAddedSignal(WeaponEffects.Tag):Connect(add);
local u11 = CollectionService:GetInstanceRemovedSignal(WeaponEffects.Tag):Connect(function(p9) -- Line: 26, Name: remove
    -- upvalues: u1 (copy)
    local v10 = u1[p9];

    if not v10 then
        return;
    end;

    for _, v in v10.connections do
        v:Disconnect();
    end;

    u1[p9] = nil;
end);

for _, v in CollectionService:GetTagged(WeaponEffects.Tag) do
    add(v);
end;

local u12 = 0;
local u13 = 0;
local u17 = RunService.Heartbeat:Connect(function(p14) -- Line: 35
    -- upvalues: u12 (ref), u13 (ref), u1 (copy), watchBlade (copy), WeaponEffects (copy), UserGameSettings (copy), CloneEchoMotion (copy)
    u12 = u12 + p14;
    u13 = u13 + p14;

    if u12 >= 0.2 then
        u12 = 0;

        for i, v in u1 do
            if i.Parent then
                watchBlade(i, v);
                local workspace_CurrentCamera = workspace.CurrentCamera;

                if workspace_CurrentCamera then
                    workspace_CurrentCamera = workspace_CurrentCamera.CFrame.Position;
                end;

                WeaponEffects.update(i, workspace_CurrentCamera, WeaponEffects.detail(UserGameSettings.SavedQualityLevel));

                if not v.motion then
                    v.motion = CloneEchoMotion.build(i);
                end;
            else
                local v15 = u1[i];

                if v15 then
                    for _, v2 in v15.connections do
                        v2:Disconnect();
                    end;

                    u1[i] = nil;
                end;
            end;
        end;
    end;

    local v16 = WeaponEffects.detail(UserGameSettings.SavedQualityLevel);

    if u13 < (v16 < 1 and 0.06666666666666667 or 0.03333333333333333) then
        return;
    end;

    u13 = 0;
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local os_clock_ret = os.clock();

    for _, v in u1 do
        if v.motion then
            CloneEchoMotion.step(v.motion, os_clock_ret, workspace_CurrentCamera, v16);
        end;
    end;
end);
script.Destroying:Connect(function() -- Line: 55
    -- upvalues: u8 (copy), u11 (copy), u17 (copy), u1 (copy)
    u8:Disconnect();
    u11:Disconnect();
    u17:Disconnect();

    for i in u1 do
        local v18 = u1[i];

        if v18 then
            for _, v in v18.connections do
                v:Disconnect();
            end;

            u1[i] = nil;
        end;
    end;
end);