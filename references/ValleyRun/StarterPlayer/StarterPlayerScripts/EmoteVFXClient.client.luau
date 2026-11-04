 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Emotes = ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Emotes");
local EmoteVFX = require(Emotes:WaitForChild("EmoteVFX"));
local EmitModule = ReplicatedStorage:WaitForChild("EmitModule", 30);
local success, result = pcall(require, EmitModule);

if not (EmitModule and success) then
    warn("EmoteVFXClient: emote effects are off (ReplicatedStorage.EmitModule: " .. tostring(EmitModule and result and result or "missing") .. ")");

    return;
end;

local u1 = nil;
local u2 = {};
local u3 = {};
local u4 = (-1 / 0);

local function fire(p5, p6) -- Line: 26
    -- upvalues: u1 (ref), result (copy), u4 (ref)
    if u1 == nil then
        local success2, result2 = pcall(result.init);
        u1 = success2;

        if not success2 then
            warn("EmoteVFXClient: emote effects are off (EmitModule.init: " .. tostring(result2) .. ")");
        end;
    end;

    if not u1 then
        return;
    end;

    local success2, result2 = pcall(result.emit, p6 or 1, p5);

    if not success2 and os.clock() - u4 > 30 then
        u4 = os.clock();
        warn("EmoteVFXClient: an effect failed to fire: " .. tostring(result2));
    end;
end;

local function refresh(p7) -- Line: 45
    -- upvalues: u2 (copy), EmoteVFX (copy)
    local Attribute = p7:GetAttribute("EmoteId");
    local v8 = u2[p7];

    if v8 and v8.id == Attribute then
        return;
    end;

    if v8 then
        EmoteVFX.unmount(v8);
        u2[p7] = nil;
    end;

    if type(Attribute) == "string" and EmoteVFX.has(Attribute) then
        u2[p7] = EmoteVFX.mount(p7, Attribute);
    end;
end;

local function unwatch(p9) -- Line: 60
    -- upvalues: u3 (copy), u2 (copy), EmoteVFX (copy)
    local v10 = u3[p9];

    if v10 then
        v10:Disconnect();
        u3[p9] = nil;
    end;

    local v11 = u2[p9];

    if v11 then
        EmoteVFX.unmount(v11);
        u2[p9] = nil;
    end;
end;

local function watch(u12) -- Line: 73
    -- upvalues: u3 (copy), refresh (copy)
    if u3[u12] then
        return;
    end;

    u3[u12] = u12:GetAttributeChangedSignal("EmoteId"):Connect(function() -- Line: 77
        -- upvalues: refresh (ref), u12 (copy)
        refresh(u12);
    end);
    refresh(u12);
end;

local function joined(p13) -- Line: 83
    -- upvalues: u3 (copy), refresh (copy), watch (copy), unwatch (copy)
    if p13.Character then
        local Character = p13.Character;

        if not u3[Character] then
            u3[Character] = Character:GetAttributeChangedSignal("EmoteId"):Connect(function() -- Line: 77
                -- upvalues: refresh (ref), Character (copy)
                refresh(Character);
            end);
            refresh(Character);
        end;
    end;

    p13.CharacterAdded:Connect(watch);
    p13.CharacterRemoving:Connect(unwatch);
end;

local function skip() -- Line: 43
end;

for _, v in Players:GetPlayers() do
    if v.Character then
        local Character = v.Character;

        if not u3[Character] then
            u3[Character] = Character:GetAttributeChangedSignal("EmoteId"):Connect(function() -- Line: 77
                -- upvalues: refresh (copy), Character (copy)
                refresh(Character);
            end);
            refresh(Character);
        end;
    end;

    v.CharacterAdded:Connect(watch);
    v.CharacterRemoving:Connect(unwatch);
end;

Players.PlayerAdded:Connect(joined);
Players.PlayerRemoving:Connect(function(p14) -- Line: 94
    -- upvalues: u3 (copy), u2 (copy), EmoteVFX (copy)
    if p14.Character then
        local Character = p14.Character;
        local v15 = u3[Character];

        if v15 then
            v15:Disconnect();
            u3[Character] = nil;
        end;

        local v16 = u2[Character];

        if v16 then
            EmoteVFX.unmount(v16);
            u2[Character] = nil;
        end;
    end;
end);
local CollectionService = game:GetService("CollectionService");

for _, v in CollectionService:GetTagged("EmoteVFXRig") do
    if not u3[v] then
        u3[v] = v:GetAttributeChangedSignal("EmoteId"):Connect(function() -- Line: 77
            -- upvalues: refresh (copy), v (copy)
            refresh(v);
        end);
        refresh(v);
    end;
end;

CollectionService:GetInstanceAddedSignal("EmoteVFXRig"):Connect(watch);
CollectionService:GetInstanceRemovedSignal("EmoteVFXRig"):Connect(unwatch);
RunService.Heartbeat:Connect(function() -- Line: 106
    -- upvalues: u2 (copy), u3 (copy), EmoteVFX (copy), fire (copy), skip (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;

    for i, v in u2 do
        if i.Parent then
            local HumanoidRootPart = i:FindFirstChild("HumanoidRootPart");
            local v17;

            if workspace_CurrentCamera == nil or HumanoidRootPart == nil then
                v17 = false;
            else
                v17 = (HumanoidRootPart.Position - workspace_CurrentCamera.CFrame.Position).Magnitude <= 250;
            end;

            local v18;

            if v17 then
                v18 = fire;
            else
                v18 = skip;
            end;

            EmoteVFX.update(v, v18);
        else
            local v19 = u3[i];

            if v19 then
                v19:Disconnect();
                u3[i] = nil;
            end;

            local v20 = u2[i];

            if v20 then
                EmoteVFX.unmount(v20);
                u2[i] = nil;
            end;
        end;
    end;
end);