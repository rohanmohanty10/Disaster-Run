  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local ServerScriptService = game:GetService("ServerScriptService");
local Trove = require(ReplicatedStorage.Packages.Trove);
require(ReplicatedStorage.Shared.BLRTypes);
local u1 = require("./standardEmote");

return function(u2: table) -- Line: 32, Name: groupEmote
    -- upvalues: u1 (copy), Trove (copy), RunService (copy), Players (copy), ReplicatedStorage (copy), ServerScriptService (copy)
    return u1({
        animationId = u2.slots[1].animationId,
        looped = u2.looped,
        maxWalkDistance = u2.maxWalkDistance,
        meta = u2.meta,

        effect = function(p3, u4, p5) -- Line: 38, Name: effect
            -- upvalues: Trove (ref), RunService (ref), Players (ref), ReplicatedStorage (ref), ServerScriptService (ref), u2 (copy)
            local v6 = Trove.new();

            if p5 ~= "Game" or not RunService:IsServer() then
                return v6;
            end;

            local PlayerFromCharacter = Players:GetPlayerFromCharacter(p3);
            local HumanoidRootPart = p3:FindFirstChild("HumanoidRootPart");

            if not (PlayerFromCharacter and HumanoidRootPart) then
                return v6;
            end;

            local Knit = require(ReplicatedStorage.Packages.Knit);
            local Essentials = require(ReplicatedStorage.Shared.Essentials);
            local Service = Knit.GetService("EmoteService");
            local Service2 = Knit.GetService("AntiCheatService");
            local DuoPromptVisibility = ServerScriptService.KnitServer.Services.EmoteService.EmoteFunctions:FindFirstChild("DuoPromptVisibility");
            local u7 = {};
            local u8 = nil;
            local u9 = false;

            local function freeSlot() -- Line: 60
                -- upvalues: u2 (ref), u7 (copy)
                for i = 2, #u2.slots do
                    if not u7[i] then
                        return i;
                    end;

                    local _ = i;
                end;

                return nil;
            end;

            local u10 = nil;

            local function refreshPrompt() -- Line: 71
                -- upvalues: u9 (ref), u2 (ref), u7 (copy), u8 (ref), ReplicatedStorage (ref), DuoPromptVisibility (copy), u10 (ref), HumanoidRootPart (copy)
                if u9 then
                    return;
                end;

                local v11 = nil;

                for i = 2, #u2.slots do
                    if not u7[i] then
                        v11 = i;
                        break;
                    end;

                    local _ = i;
                end;

                local v12 = v11 ~= nil;

                if not v12 or u8 then
                    if not v12 and u8 then
                        u8:Destroy();
                        u8 = nil;
                    end;

                    return;
                end;

                local GameValues = ReplicatedStorage:FindFirstChild("GameValues");

                if GameValues then
                    GameValues = GameValues:FindFirstChild("Scored");
                end;

                local ProximityPrompt = Instance.new("ProximityPrompt");
                ProximityPrompt.MaxActivationDistance = GameValues and GameValues.Value and 400 or 20;
                ProximityPrompt.ActionText = "Emote Together";
                ProximityPrompt.ObjectText = u2.displayName;
                ProximityPrompt.RequiresLineOfSight = false;
                ProximityPrompt.KeyboardKeyCode = Enum.KeyCode.H;
                ProximityPrompt.GamepadKeyCode = Enum.KeyCode.DPadDown;

                if DuoPromptVisibility then
                    DuoPromptVisibility:Clone().Parent = ProximityPrompt;
                end;

                ProximityPrompt.Triggered:Connect(u10);
                ProximityPrompt.Parent = HumanoidRootPart;
                u8 = ProximityPrompt;
            end;

            local function release(p13: number) -- Line: 98
                -- upvalues: u7 (copy), refreshPrompt (copy)
                local v14 = u7[p13];

                if not v14 then
                    return;
                end;

                u7[p13] = nil;
                v14.trove:Destroy();
                refreshPrompt();
            end;

            u10 = function(u15: userdata) -- Line: 108
                -- upvalues: u9 (ref), PlayerFromCharacter (copy), u7 (copy), u2 (ref), Service (copy), Trove (ref), Service2 (copy), HumanoidRootPart (copy), u4 (copy), Essentials (copy), refreshPrompt (copy), Players (ref)
                if u9 or (u15 == PlayerFromCharacter or u15.Team ~= PlayerFromCharacter.Team) then
                    return;
                end;

                for _, v in u7 do
                    if v.player == u15 then
                        return;
                    end;
                end;

                local u16 = nil;

                for i = 2, #u2.slots do
                    if not u7[i] then
                        u16 = i;
                        break;
                    end;

                    local _ = i;
                end;

                if not u16 then
                    return;
                end;

                local Character = u15.Character;
                local u17;

                if Character then
                    u17 = Character:FindFirstChild("HumanoidRootPart");
                else
                    u17 = Character;
                end;

                local v18;

                if Character then
                    v18 = Character:FindFirstChildOfClass("Humanoid");
                else
                    v18 = Character;
                end;

                local v19;

                if v18 then
                    v19 = v18:FindFirstChildOfClass("Animator");
                else
                    v19 = v18;
                end;

                if not (Character and (u17 and (v18 and (v19 and v18.Health > 0)))) then
                    return;
                end;

                Service:ForceStopEmoting(u15);
                local v20 = u2.slots[u16];
                local v21 = Trove.new();
                u7[u16] = {
                    player = u15,
                    trove = v21
                };
                Service2:Teleport(u15, HumanoidRootPart.CFrame * v20.offset);
                u17.Massless = true;
                local Weld = Instance.new("Weld");
                Weld.Name = "EmoteWeld";
                Weld.Part0 = HumanoidRootPart;
                Weld.Part1 = u17;
                Weld.C0 = v20.offset;
                Weld.Parent = u17;
                local Animation = Instance.new("Animation");
                Animation.AnimationId = v20.animationId;
                local u22 = v19:LoadAnimation(Animation);
                u22.Priority = Enum.AnimationPriority.Action4;
                u22.Looped = u2.looped ~= false;
                u22:Play();

                local function syncTrack() -- Line: 149
                    -- upvalues: u22 (copy), u4 (ref)
                    if u22.Length <= 0 or u4.Length <= 0 then
                        return false;
                    end;

                    u22.TimePosition = u4.TimePosition % u22.Length;

                    return true;
                end;

                local v23;

                if u22.Length <= 0 or u4.Length <= 0 then
                    v23 = false;
                else
                    u22.TimePosition = u4.TimePosition % u22.Length;
                    v23 = true;
                end;

                if not v23 then
                    v21:Add(task.spawn(function() -- Line: 157
                        -- upvalues: u22 (copy), u4 (ref)
                        local v24 = os.clock() + 3;

                        while u22.Length <= 0 and os.clock() < v24 do
                            task.wait();
                        end;

                        task.wait();

                        if u22.Length > 0 then
                            if u4.Length <= 0 then
                                return;
                            end;

                            u22.TimePosition = u4.TimePosition % u22.Length;
                        end;
                    end));
                end;

                u15:SetAttribute("TeamEmoting", true);
                PlayerFromCharacter:SetAttribute("TeamEmoting", true);
                v21:Add(function() -- Line: 170
                    -- upvalues: u22 (copy), Animation (copy), Weld (copy), u15 (copy), u17 (copy), Character (copy), Essentials (ref)
                    u22:Stop();
                    u22:Destroy();
                    Animation:Destroy();

                    if Weld.Parent then
                        Weld:Destroy();
                    end;

                    u15:SetAttribute("TeamEmoting", false);

                    if u17.Parent then
                        u17.Massless = false;
                        task.delay(0.1, function() -- Line: 180
                            -- upvalues: Character (ref), Essentials (ref)
                            if Character.Parent then
                                Essentials:FixAlignment(Character);
                            end;
                        end);
                    end;
                end);
                v21:Connect(v18.Died, function() -- Line: 187
                    -- upvalues: u16 (copy), u7 (ref), refreshPrompt (ref)
                    local v25 = u16;
                    local v26 = u7[v25];

                    if not v26 then
                        return;
                    end;

                    u7[v25] = nil;
                    v26.trove:Destroy();
                    refreshPrompt();
                end);
                v21:Connect(Character.AncestryChanged, function() -- Line: 190
                    -- upvalues: Character (copy), u16 (copy), u7 (ref), refreshPrompt (ref)
                    if not Character:IsDescendantOf(workspace) then
                        local v27 = u16;
                        local v28 = u7[v27];

                        if not v28 then
                            return;
                        end;

                        u7[v27] = nil;
                        v28.trove:Destroy();
                        refreshPrompt();
                    end;
                end);
                v21:Connect(Players.PlayerRemoving, function(p29) -- Line: 195
                    -- upvalues: u15 (copy), u16 (copy), u7 (ref), refreshPrompt (ref)
                    if p29 == u15 then
                        local v30 = u16;
                        local v31 = u7[v30];

                        if not v31 then
                            return;
                        end;

                        u7[v30] = nil;
                        v31.trove:Destroy();
                        refreshPrompt();
                    end;
                end);
                refreshPrompt();
            end;

            refreshPrompt();
            v6:Add(function() -- Line: 206
                -- upvalues: u9 (ref), u7 (copy), refreshPrompt (copy), u8 (ref), PlayerFromCharacter (copy)
                u9 = true;

                for i in u7 do
                    local v32 = u7[i];

                    if v32 then
                        u7[i] = nil;
                        v32.trove:Destroy();
                        refreshPrompt();
                    end;
                end;

                if u8 then
                    u8:Destroy();
                    u8 = nil;
                end;

                PlayerFromCharacter:SetAttribute("TeamEmoting", false);
            end);

            return v6;
        end
    });
end;