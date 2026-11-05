  

 

local u1 = {};
local u2 = {};
game:GetService("PhysicsService");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local CollectionService = game:GetService("CollectionService");
local Animations = require(game.ReplicatedStorage.ReplicatedModules.Animations);
local Stands = require(game.ReplicatedStorage.ReplicatedModules.Stands);
require(game.ReplicatedStorage.ReplicatedModules.Stands);
local InputFunc = game.ReplicatedStorage.Remotes.InputFunc;
local _ = game.ReplicatedStorage.Remotes.Output;
local _ = CFrame.Angles;
local _ = math.rad;
local _ = game.ReplicatedStorage["Client Assets"];

local function customWait(p3) -- Line: 28
    -- upvalues: RunService (copy)
    local v4 = 0;

    repeat
        v4 = v4 + RunService.RenderStepped:Wait();
    until (p3 or 0) <= v4;

    return v4;
end;

local function rayCast(p5, p6, p7) -- Line: 35
    local v8 = RaycastParams.new();
    local v9 = {};

    for _, descendant in pairs(workspace.Living:GetDescendants()) do
        if descendant:IsA("BasePart") and descendant.CanCollide == true then
            table.insert(v9, 1, descendant);
        end;
    end;

    v8.FilterDescendantsInstances = v9;
    v8.FilterType = Enum.RaycastFilterType.Whitelist;
    local v10 = workspace:Raycast(p5, p6, v8);

    if p7 then
        return v10;
    end;

    if v10 then
        return v10.Position, v10.Instance;
    end;

    return p5;
end;

local function raycastMap(p11, p12, p13) -- Line: 55
    local v14 = RaycastParams.new();
    local v15 = {};

    for _, descendant in ipairs(workspace.Map:GetDescendants()) do
        if descendant:IsA("BasePart") and descendant.CanCollide then
            table.insert(v15, descendant);
        end;
    end;

    v14.FilterDescendantsInstances = v15;
    v14.FilterType = Enum.RaycastFilterType.Whitelist;
    local v16 = workspace:Raycast(p11, p12, v14);

    if p13 then
        return v16;
    end;

    if v16 then
        return v16.Position, v16.Instance;
    end;

    return p11;
end;

local function defaultClientAnim(p17, p18, p19, p20, p21) -- Line: 76
    -- upvalues: Animations (copy)
    Animations.playClient(p21.StandName, p21.MoveName, nil, p21.AnimSpeed or 1);
end;

local function defaultClientAnim2(u22) -- Line: 80
    -- upvalues: CollectionService (copy), Animations (copy)
    return function(p23, p24, p25, p26, p27) -- Line: 81
        -- upvalues: CollectionService (ref), u22 (copy), Animations (ref)
        if CollectionService:HasTag(p24, u22) then
            Animations.stopClient(p27.StandName, p27.MoveName);

            return;
        end;

        Animations.playClient(p27.StandName, p27.MoveName);
    end;
end;

local u28 = {};
local u29 = {};

local function defaultCombo(u30, u31) -- Line: 93
    -- upvalues: Stands (copy), u1 (ref), u2 (copy), u28 (copy), CollectionService (copy), Animations (copy), u29 (copy), InputFunc (copy)
    return function(p32) -- Line: 94
        -- upvalues: Stands (ref), u1 (ref), u30 (copy), u2 (ref), u28 (ref), CollectionService (ref), Animations (ref), u29 (ref), InputFunc (ref), u31 (copy)
        local LocalPlayer = game.Players.LocalPlayer;
        local Character = LocalPlayer.Character;
        local v33 = Stands[LocalPlayer.Data.Ability.Value];
        local u34 = u1[v33][u30];

        if not u2[v33][LocalPlayer.Name] then
            u2[v33][LocalPlayer.Name] = {};
        end;

        local u35 = u2[v33][LocalPlayer.Name];

        if not u35[u30] then
            u35[u30] = 1;
        end;

        if u35[p32] then
            return;
        end;

        u35[p32] = true;
        local v36 = u35[u30];
        local v37 = u34.AnimSpeed or u28;
        local v38 = u34.StandOff and not CollectionService:HasTag(Character, "Summoned") and "StandOff-" or "";

        if not CollectionService:HasTag(Character, "Summoned") then
            u34 = u34.StandOff or u34;
        end;

        local v39;

        if u29[v33] then
            v39 = u29[v33][p32] or p32;
        else
            v39 = p32;
        end;

        local v40 = Animations.playClient(v33, v38 .. v39 .. "-" .. v36, nil, v37[v36]);
        LocalPlayer.Character.Values.Active.Value = "temp";
        InputFunc:InvokeServer(p32);

        if v40.Looped then
            v40:Stop();
        end;

        if v36 == u34.MaxCombo then
            u35[u30] = 1;
        else
            local v41 = u30;
            u35[v41] = u35[v41] + 1;
        end;

        coroutine.wrap(function() -- Line: 121
            -- upvalues: u35 (copy), u30 (ref), u31 (ref), u34 (copy)
            local v42 = u35[u30];
            wait((u31 or 1.5) + u34.ComboTick);

            if v42 == u35[u30] then
                u35[u30] = 1;
            end;
        end)();
        wait(u34.ComboTick);
        u35[p32] = nil;
    end;
end;

require(game.ReplicatedStorage.ClientModules.InputTracker);
u1 = {
    Gaster = {
        Summon = {
            Cooldown = 1,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true
            },
            LeaveParts = { "StandHumanoidRootPart", "KnifePart", "KnifeMain" },
            callbacks = {
                client = function(p43, p44, p45) -- Line: 140, Name: client
                end
            }
        },
        SwitchL = {
            Cooldown = 0.5,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = true,
                CheckActive = true,
                CheckTimestop = true
            },
            LeaveParts = { "StandHumanoidRootPart", "KnifePart", "KnifeMain" },
            callbacks = {
                client = function(p46, p47, p48) -- Line: 150, Name: client
                end
            }
        },
        SwitchR = {
            Cooldown = 0.5,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = true,
                CheckActive = true,
                CheckTimestop = true
            },
            LeaveParts = { "StandHumanoidRootPart", "KnifePart", "KnifeMain" },
            callbacks = {
                client = function(p49, p50, p51) -- Line: 159, Name: client
                end
            }
        },
        Fire = {
            Cooldown = 0.15,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = true,
                CheckActive = true,
                CheckTimestop = true
            },
            LeaveParts = { "StandHumanoidRootPart", "KnifePart", "KnifeMain" },
            callbacks = {
                client = function(p52, p53, p54) -- Line: 169, Name: client
                end
            }
        },
        LMB = {
            Cooldown = 0.2,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = true,
                CheckActive = true,
                CheckTimestop = true
            },
            LeaveParts = { "StandHumanoidRootPart", "KnifePart", "KnifeMain" },
            callbacks = {
                client = function(p55, p56, p57) -- Line: 178, Name: client
                end
            }
        },
        Combo = {
            Cooldown = 0.25,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = true,
                CheckActive = true,
                CheckTimestop = true
            },
            LeaveParts = { "StandHumanoidRootPart", "KnifePart", "KnifeMain" },
            callbacks = {
                client = function(p58, p59, p60) -- Line: 187, Name: client
                end
            }
        }
    },
    Chara = {
        LMB = {
            Cooldown = 0.15,
            Checks = {
                CheckStunned = true,
                Exception = "Q",
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = false,
                CheckTimestop = true
            },
            LeaveParts = { "StandHumanoidRootPart", "KnifePart", "KnifeMain" },
            callbacks = {
                client = function(p61, p62, p63) -- Line: 200, Name: client
                end
            }
        }
    }
};

for i, _ in pairs(u1) do
    if not u2[i] then
        u2[i] = {};
    end;
end;

local function loadCode(p64) -- Line: 213
    -- upvalues: u1 (ref)
    local v65 = require(p64);

    for i, v in pairs(v65) do
        u1[i] = v;
    end;
end;

for _, child in ipairs(script:GetChildren()) do
    local success, result = pcall(loadCode, child);

    if not success then
        warn(result, child);
    end;
end;

return u1;