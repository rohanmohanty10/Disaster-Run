  

game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local Parent = script.Parent.Parent.Parent;
local UtilityModules = Parent.UtilityModules;
local CoreRemotes = Parent.CoreRemotes;
local Trove = require(UtilityModules.Trove);
require(UtilityModules.FastSignal);
require(UtilityModules.t);
local GlobalConfig = require(Parent.Components.GlobalConfig);
local SharedComponent = require(Parent.Components.SharedComponent);
local u1 = {};
u1.__index = u1;

function u1.GetDebugClone(p2: table, p3: any, p4: boolean?) -- Line: 64
    local v5 = "_DebugClone:" .. p3;

    if p2[v5] then
        return p2[v5], false;
    end;

    if p4 then
        return p2:CreateDebugClone(p3), true;
    end;
end;

function u1.DestroyDebugClone(p6, p7) -- Line: 72
    local v8 = "_DebugClone:" .. p7;

    if p6[v8] then
        p6.Trove:Remove(p6[v8]);
        p6[v8]:Destroy();
    end;

    p6[v8] = nil;
end;

local function findMatchingPart(p9, p10, p11, p12) -- Line: 81
    local v13 = p12 or {};

    for _, descendant in p9:GetDescendants() do
        if descendant.Name == p10 and (descendant.Parent and (descendant.Parent.Name == p11 or v13[p11])) then
            return descendant;
        end;
    end;

    return nil;
end;

function u1.UpdateDebugClonePose(p14, p15) -- Line: 93
    -- upvalues: GlobalConfig (copy), findMatchingPart (copy)
    local DebugClone = p14:GetDebugClone(p15, false);

    if not DebugClone then
        return;
    end;

    for _, descendant in DebugClone:GetDescendants() do
        if descendant:IsA("BasePart") and (GlobalConfig.BodyPartNames[descendant.Name] or GlobalConfig.AuxNames[descendant.Name]) then
            local v16 = p14.Character:FindFirstChild(descendant.Name) or findMatchingPart(p14.Character, descendant.Name, descendant.Parent.Name);

            if v16 then
                descendant.CFrame = v16.CFrame;
            end;
        end;
    end;
end;

function u1.CreateDebugClone(p17: table, p18: any, p19: table, p20: userdata) -- Line: 107
    -- upvalues: GlobalConfig (copy)
    p17.Character.Archivable = true;

    for _, descendant in p17.Character:GetDescendants() do
        descendant.Archivable = true;
    end;

    local u21 = p17.Character:Clone();

    local function ProcessDecendant(p22) -- Line: 116
        -- upvalues: GlobalConfig (ref)
        local v23 = false;

        for i in GlobalConfig.WhitelistedClasses do
            if p22:IsA(i) then
                v23 = true;
                break;
            end;
        end;

        if not (GlobalConfig.BodyPartNames[p22.Name] or (GlobalConfig.AuxNames[p22.Name] or v23)) then
            p22:Destroy();

            return;
        end;

        if not p22:IsA("BasePart") then
            if p22:IsA("Decal") then
                p22.Transparency = math.max(p22.Transparency, 0.8);
            end;

            return;
        end;

        p22.Transparency = math.max(p22.Transparency, 0.99);
        p22.CanCollide = false;
        p22.CanTouch = false;
        p22.CanQuery = false;
        p22.Anchored = true;
    end;

    for _, descendant in pairs(u21:GetDescendants()) do
        ProcessDecendant(descendant);
    end;

    p17:UpdateDebugClonePose(p18);
    local v24 = u21:FindFirstChildOfClass("Humanoid");

    if v24 then
        v24:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, true);
    end;

    u21.Name = p17.Character.Name .. "_DebugClone_" .. tick();

    if p19 == nil then
        for _, descendant in u21:GetDescendants() do
            if (GlobalConfig.BodyPartNames[descendant.Name] or descendant.Name == "Handle") and descendant:IsA("BasePart") then
                descendant.Transparency = 0.75;
            end;
        end;
    else
        local Highlight = Instance.new("Highlight");
        Highlight.FillColor = Color3.fromRGB(0, 255, 8);
        Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
        Highlight.FillTransparency = 0.5;
        Highlight.OutlineTransparency = 1;
        Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
        Highlight.Adornee = u21;
        Highlight.Parent = u21;

        for i, v in p19 do
            Highlight[i] = v;
        end;
    end;

    if p20 then
        p20:Once(function() -- Line: 182
            -- upvalues: u21 (copy)
            u21:Destroy();
        end);
    end;

    p17["_DebugClone:" .. p18] = u21;

    return u21;
end;

function u1.IsServerWaitingOnRelocationAcknowledgement(p25) -- Line: 192
    -- upvalues: GlobalConfig (copy)
    if GlobalConfig.WaitForSyncs then
        return not p25.LastServerRelocation.HasClientAcknowledged and p25.LastServerRelocation.CFrame ~= nil and true or false;
    end;

    return false;
end;

function u1.DistributeCFrameToClients(p26: table, p27: boolean) -- Line: 202
    -- upvalues: GlobalConfig (copy), SharedComponent (copy)
    if p26:IsServerWaitingOnRelocationAcknowledgement() then
        return;
    end;

    if p26.LastClientSnapshot.CFrame == nil then
        return;
    end;

    if not GlobalConfig.GloballyEnabled then
        p26.LastClientSnapshot.CFrame = p26.HumanoidRootPart.CFrame;

        return;
    end;

    local v28 = { SharedComponent.Serialize(p26.LastClientSnapshot.CFrame) };

    for i, v in p26.DataRecipients do
        if i ~= p26.Player then
            local v29 = os.clock() - v.TimeOfLastCFrameDistribution;
            local v30 = GlobalConfig.Optimizations.DynamicPlayerUniqueTickRates.Enabled and GlobalConfig.Optimizations.DynamicPlayerUniqueTickRates.GetCFrameTickRate(p26.Player, i) or GlobalConfig.ServerRootCFrameDistributionSpeed;
            local v31 = not (GlobalConfig.Optimizations.IgnoreRedundantRootCFrameUpdates.EnabledForServerToClient and SharedComponent.IsVelocityOrCFrameRedundant(p26.LastClientSnapshot.CFrame, v.LastDistributedCFrame));

            if v30 <= v29 and v31 or p27 then
                v.TimeOfLastCFrameDistribution = os.clock();
                v.LastDistributedCFrame = p26.LastClientSnapshot.CFrame;
                p26.PrivateRemotes.CacheRootCFrame:FireClient(i, table.unpack(v28));
            end;
        end;
    end;
end;

function u1.DistributeVelocityToClients(p32: table, p33: boolean) -- Line: 225
    -- upvalues: GlobalConfig (copy), SharedComponent (copy)
    if p32.LastClientSnapshot.Velocity == nil then
        return;
    end;

    if not GlobalConfig.GloballyEnabled then
        p32.LastClientSnapshot.Velocity = p32.HumanoidRootPart.Velocity;

        return;
    end;

    local v34 = { SharedComponent.Serialize(p32.LastClientSnapshot.Velocity) };

    for i, v in p32.DataRecipients do
        if i ~= p32.Player then
            local v35 = os.clock() - v.TimeOfLastVelocityDistribution;
            local v36 = GlobalConfig.Optimizations.DynamicPlayerUniqueTickRates.Enabled and GlobalConfig.Optimizations.DynamicPlayerUniqueTickRates.GetVelocityTickRate(p32.Player, i) or GlobalConfig.ServerRootVelocityDistributionSpeed;
            local v37 = not (GlobalConfig.Optimizations.IgnoreRedundantVelocityUpdates.EnabledForServerToClient and SharedComponent.IsVelocityOrCFrameRedundant(p32.LastClientSnapshot.Velocity, v.LastDistributedVelocity));

            if v36 <= v35 and v37 or p33 then
                v.TimeOfLastVelocityDistribution = os.clock();
                v.LastDistributedVelocity = p32.LastClientSnapshot.Velocity;
                p32.PrivateRemotes.CacheRootVelocity:FireClient(i, table.unpack(v34));
            end;
        end;
    end;
end;

function u1.SyncServerCFrame(p38) -- Line: 250
    -- upvalues: GlobalConfig (copy)
    if p38:IsServerWaitingOnRelocationAcknowledgement() then
        return;
    end;

    if p38.LastClientSnapshot.CFrame == nil then
        return;
    end;

    if not GlobalConfig.GloballyEnabled then
        return;
    end;

    if GlobalConfig.Optimizations.IgnoreRedundantServerSyncs and p38.HumanoidRootPart.CFrame == p38.LastClientSnapshot.CFrame then
        return;
    end;

    p38.HumanoidRootPart.CFrame = p38.LastClientSnapshot.CFrame;

    if GlobalConfig.Optimizations.RectificationMode == "RemoteEvent" then
        p38.PrivateRemotes.RectifyServerChanges:FireClient(p38.Player);
    end;
end;

function u1.Destroy(p39) -- Line: 265
    if p39._Destroyed then
        warn("Attempt to destroy an already destroyed object CharacterClass", debug.traceback());

        return;
    end;

    p39._Destroyed = true;
    p39.Trove:Destroy();
    setmetatable(p39, nil);
end;

function u1.BuildPrivateRemotesFolder(p40) -- Line: 275
    local Folder = Instance.new("Folder");
    Folder.Name = "PrivateRemotes";
    Folder.Parent = p40.Character;
    p40.PrivateRemotesFolder = Folder;

    return Folder;
end;

function u1.GetPrivateRemotesFolder(p41: table, p42: boolean) -- Line: 285
    if p41.PrivateRemotesFolder then
        return p41.PrivateRemotesFolder;
    end;

    local PrivateRemotes = p41.Character:FindFirstChild("PrivateRemotes");

    if PrivateRemotes == nil and p42 then
        PrivateRemotes = p41:BuildPrivateRemotesFolder();
    end;

    return PrivateRemotes;
end;

function u1.AddPrivateRemote(p43: table, p44: string, p45: string, p46: boolean) -- Line: 294
    local PrivateRemotesFolder = p43:GetPrivateRemotesFolder(true);
    local v47 = p45 == "Reliable" and Instance.new("RemoteEvent") or Instance.new("UnreliableRemoteEvent");
    v47.Name = p44;

    if not p46 then
        v47.Parent = PrivateRemotesFolder;
    end;

    return v47;
end;

function u1.GetVelocity(p48) -- Line: 307
    -- upvalues: GlobalConfig (copy)
    if GlobalConfig.GloballyEnabled then
        return p48.LastClientSnapshot.Velocity;
    end;

    return p48.HumanoidRootPart.AssemblyLinearVelocity;
end;

function u1.new(u49) -- Line: 315
    -- upvalues: u1 (copy), Players (copy), Trove (copy), RunService (copy), GlobalConfig (copy), CoreRemotes (copy), SharedComponent (copy)
    local u50 = setmetatable({}, u1);
    u50.Player = Players:GetPlayerFromCharacter(u49);
    u50.Character = u49;
    u50.Humanoid = u49:WaitForChild("Humanoid");
    u50.HumanoidRootPart = u49:WaitForChild("HumanoidRootPart");
    u50.PrivateRemotes = {
        RectifyServerChanges = u50:AddPrivateRemote("RectifyServerChanges", "Reliable"),
        ServerHasSetCFrame = u50:AddPrivateRemote("ServerHasSetCFrame", "Reliable"),
        CacheRootCFrame = u50:AddPrivateRemote("CacheRootCFrame", "Unreliable"),
        CacheRootVelocity = u50:AddPrivateRemote("CacheRootVelocity", "Unreliable"),
        ReadyForUpdates = u50:AddPrivateRemote("ReadyForUpdates", "Reliable", true)
    };
    u50.DataRecipients = {};
    u50.Trove = Trove.new();
    u50.LastClientSnapshot = {
        CFrame = nil,
        Velocity = nil
    };
    u50.LastServerRelocation = {
        CFrame = nil,
        HasClientAcknowledged = true,
        Id = 0
    };
    u50.NoReplicationContainer = Instance.new("Camera");
    u50.NoReplicationContainer.Name = "NoReplicationContainer" .. u50.Player.UserId;
    u50.NoReplicationContainer.Parent = workspace;
    u50.Trove:Add(u50.NoReplicationContainer);
    u50.Trove:Add(RunService.Heartbeat:Connect(function(p51) -- Line: 355
        -- upvalues: u50 (copy), u49 (copy), GlobalConfig (ref)
        u50:DistributeCFrameToClients();
        u50:DistributeVelocityToClients();
        local PlayerOwnedPart = u49:FindFirstChild("PlayerOwnedPart");

        if not (GlobalConfig.Visualization.VisualizeNativeCharacterOnTheServer and PlayerOwnedPart) then
            u50:DestroyDebugClone("NativeVisualizer");

            return;
        end;

        local DebugClone, v52 = u50:GetDebugClone("NativeVisualizer", true);

        if v52 then
            DebugClone.Parent = u50.NoReplicationContainer;

            return;
        end;

        DebugClone:PivotTo(u49:GetPivot());
        u50:UpdateDebugClonePose("NativeVisualizer");
        DebugClone:PivotTo(PlayerOwnedPart.CFrame);
    end));
    u50.Trove:Add(task.defer(function() -- Line: 373
        -- upvalues: u50 (copy), GlobalConfig (ref)
        while true do
            u50:SyncServerCFrame();
            task.wait(GlobalConfig.ServerCFrameSyncRate);
        end;
    end));
    u50.Trove:Add(u50.PrivateRemotes.ReadyForUpdates.OnServerEvent:Connect(function(p53) -- Line: 380
        -- upvalues: u50 (copy)
        u50.DataRecipients[p53] = {
            TimeOfLastCFrameDistribution = 0,
            TimeOfLastVelocityDistribution = 0,
            LastDistributedCFrame = nil,
            LastDistributedVelocity = nil
        };
    end));
    u50.PrivateRemotes.ReadyForUpdates.Parent = u50:GetPrivateRemotesFolder(false);
    u50.Trove:Add(Players.PlayerRemoving:Connect(function(p54) -- Line: 391
        -- upvalues: u50 (copy)
        u50.DataRecipients[p54] = nil;
    end));
    u50.Trove:Add(CoreRemotes.ClientToServer.AcknowledgeServerCFrameSet.OnServerEvent:Connect(function(p55, p56) -- Line: 394
        -- upvalues: u50 (copy)
        if p55 ~= u50.Player or tonumber(p56) ~= u50.LastServerRelocation.Id then
            return;
        end;

        u50.LastServerRelocation.HasClientAcknowledged = true;
    end));
    u50.Trove:Add(u50.HumanoidRootPart:GetPropertyChangedSignal("CFrame"):Connect(function() -- Line: 399
        -- upvalues: u50 (copy), SharedComponent (ref)
        local CFrame = u50.HumanoidRootPart.CFrame;

        if CFrame == u50.LastClientSnapshot.CFrame then
            return;
        end;

        u50.LastClientSnapshot.CFrame = CFrame;
        u50.LastServerRelocation.CFrame = CFrame;
        local LastServerRelocation = u50.LastServerRelocation;
        LastServerRelocation.Id = LastServerRelocation.Id + 1;
        u50.LastServerRelocation.HasClientAcknowledged = false;
        local v57 = { SharedComponent.Serialize(CFrame) };
        u50.PrivateRemotes.ServerHasSetCFrame:FireClient(u50.Player, tostring(u50.LastServerRelocation.Id), table.unpack(v57));

        for i, _ in u50.DataRecipients do
            if i ~= u50.Player then
                u50.PrivateRemotes.ServerHasSetCFrame:FireClient(i, table.unpack(v57));
            end;
        end;
    end));
    u50.Trove:Add(CoreRemotes.ClientToServer.CacheRootCFrame.OnServerEvent:Connect(function(p58, ...) -- Line: 427
        -- upvalues: u49 (copy), u50 (copy), SharedComponent (ref)
        if p58.Character ~= u49 then
            return;
        end;

        if not u50:IsServerWaitingOnRelocationAcknowledgement() then
            local v59 = SharedComponent.Deserialize({ ... });
            u50.LastClientSnapshot.CFrame = v59;
        end;
    end));
    u50.Trove:Add(CoreRemotes.ClientToServer.CacheRootVelocity.OnServerEvent:Connect(function(p60, ...) -- Line: 436
        -- upvalues: u49 (copy), SharedComponent (ref), u50 (copy)
        if p60.Character ~= u49 then
            return;
        end;

        local v61 = SharedComponent.Deserialize({ ... });
        u50.LastClientSnapshot.Velocity = v61;
    end));

    return u50;
end;

return u1;