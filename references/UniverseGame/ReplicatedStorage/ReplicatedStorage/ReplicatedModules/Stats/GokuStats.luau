  

 

local u1 = {};
local v2 = {
    CheckStunned = true,
    CheckDisabled = true,
    CheckActive = true,
    CheckTimestop = true
};
local v3 = { "rbxassetid://7290321324", "rbxassetid://7290325561", "rbxassetid://7290327465" };
local u4 = {
    Goku = {
        Forms = { "Base", "SSJ", "SSJ2", "SSJ3", "SSJ4", "SSJG", "SSJB", "SSJBK", "UI", "MUI" }
    }
};
game:GetService("PhysicsService");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Animations = require(game.ReplicatedStorage.ReplicatedModules.Animations);
local Stands = require(game.ReplicatedStorage.ReplicatedModules.Stands);
require(game.ReplicatedStorage["Client Assets"].Goku["Goku Modules"].FormValues);
local CollectionService = game:GetService("CollectionService");
local InputFunc = game.ReplicatedStorage.Remotes.InputFunc;
local _ = CFrame.Angles;
local _ = math.rad;
require(game.ReplicatedStorage.ClientModules.InputTracker);
local u5 = {};
local u6 = {};

local function defaultCombo(u7, u8) -- Line: 30
    -- upvalues: Stands (copy), u1 (ref), u4 (copy), u5 (copy), CollectionService (copy), Animations (copy), u6 (copy), InputFunc (copy)
    return function(p9) -- Line: 31
        -- upvalues: Stands (ref), u1 (ref), u7 (copy), u4 (ref), u5 (ref), CollectionService (ref), Animations (ref), u6 (ref), InputFunc (ref), u8 (copy)
        local LocalPlayer = game.Players.LocalPlayer;
        local Character = LocalPlayer.Character;
        local v10 = Stands[LocalPlayer.Data.Ability.Value];
        local v11 = u1[v10][u7];

        if not u4[v10][LocalPlayer.Name] then
            u4[v10][LocalPlayer.Name] = {};
        end;

        local u12 = u4[v10][LocalPlayer.Name];

        if not u12[u7] then
            u12[u7] = 1;
        end;

        if u12[p9] then
            return;
        end;

        u12[p9] = true;
        local v13 = u12[u7];
        local v14 = v11.AnimSpeed or u5;
        local v15 = v11.StandOff and not CollectionService:HasTag(Character, "Summoned") and "StandOff-" or "";
        local u16 = v11.Standoff or v11;
        local v17;

        if u6[v10] then
            v17 = u6[v10][p9] or p9;
        else
            v17 = p9;
        end;

        local v18 = Animations.playClient(v10, v15 .. v17 .. "-" .. v13, nil, v14[v13]);
        LocalPlayer.Character.Values.Active.Value = "temp";
        InputFunc:InvokeServer(p9);

        if v18.Looped then
            v18:Stop();
        end;

        if v13 == u16.MaxCombo then
            u12[u7] = 1;
        else
            local v19 = u7;
            u12[v19] = u12[v19] + 1;
        end;

        coroutine.wrap(function() -- Line: 58
            -- upvalues: u12 (copy), u7 (ref), u8 (ref), u16 (copy)
            local v20 = u12[u7];
            wait((u8 or 1.5) + u16.ComboTick);

            if v20 == u12[u7] then
                u12[u7] = 1;
            end;
        end)();
        wait(u16.ComboTick);
        u12[p9] = nil;
    end;
end;

local function raycastMap(p21, p22, p23) -- Line: 68
    local v24 = RaycastParams.new();
    v24.FilterDescendantsInstances = { workspace.Map };
    v24.FilterType = Enum.RaycastFilterType.Whitelist;
    local v25 = workspace:Raycast(p21, p22, v24);

    if p23 then
        return v25;
    end;

    if v25 then
        return v25.Position;
    end;
end;

local function _(p26) -- Line: 80
    -- upvalues: RunService (copy)
    local v27 = 0;

    repeat
        v27 = v27 + RunService.RenderStepped:Wait();
    until (p26 or 0) <= v27;

    return v27;
end;

local v28 = {};
local v37 = {
    Transform = {
        Checks = v2
    },
    Detransform = {
        Checks = v2
    },
    Pose = {
        DoNotDeactivate = true,
        Cooldown = 2,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = false,
            CheckTimestop = true,

            ExtraCheck = function(p29) -- Line: 97, Name: ExtraCheck
                return p29.Character.Values.Active.Value == "" and true or p29.Character.Values.Active.Value == "P";
            end
        },
        callbacks = {
            client = function(p30, p31, p32) -- Line: 100, Name: client
                -- upvalues: CollectionService (copy), Animations (copy), RunService (copy)
                if CollectionService:HasTag(p31, "Posing") then
                    Animations.stopClient("Goku", "PoseIdle");
                    local BinaryStringValue = Instance.new("BinaryStringValue");
                    BinaryStringValue.Name = "P";
                    BinaryStringValue.Parent = p30.Cooldowns;

                    while true do
                        local v33 = 0;

                        repeat
                            v33 = v33 + RunService.RenderStepped:Wait();
                        until (0.025 or 0) <= v33;

                        local v34 = 0;

                        for _, child in pairs(p30.Cooldowns:GetChildren()) do
                            if child.Name == "P" then
                                v34 = v34 + 1;
                            end;
                        end;

                        if v34 >= 2 then
                            BinaryStringValue:Destroy();

                            return;
                        end;
                    end;
                else
                    Animations.playClient("Goku", "PoseTransition").Stopped:Wait();
                    Animations.playClient("Goku", "PoseIdle");
                    local BinaryStringValue = Instance.new("BinaryStringValue");
                    BinaryStringValue.Name = "P";
                    BinaryStringValue.Parent = p30.Cooldowns;

                    while true do
                        local v35 = 0;

                        repeat
                            v35 = v35 + RunService.RenderStepped:Wait();
                        until (0.025 or 0) <= v35;

                        local v36 = 0;

                        for _, child in pairs(p30.Cooldowns:GetChildren()) do
                            if child.Name == "P" then
                                v36 = v36 + 1;
                            end;
                        end;

                        if v36 >= 2 then
                            BinaryStringValue:Destroy();

                            return;
                        end;
                    end;
                end;
            end
        }
    }
};
local v38 = {
    Damage = 7.25,
    Stun = 0.4,
    MaxCombo = 4,
    ComboTick = 0.3,
    Cooldown = 0.1,
    Checks = v2,
    Knockback = { 5, 0.05 },
    Hitbox = {
        Type = "Magnitude",
        RelativePart = "HumanoidRootPart",
        Size = 4,
        Offset = CFrame.new(0, 0, -4)
    },
    HitAnimation = v3,
    Sound = { { "rbxassetid://7213363915", 2, 0, false } },
    Remotes = { { "FX", "Kur Heavy 2" } },
    HitData = {
        Color = Color3.new(1, 1, 1)
    }
};
local u39 = "LMB Combo";
local u40 = 0.75;

function v38.CustomInvoke(p41) -- Line: 31
    -- upvalues: Stands (copy), u1 (ref), u39 (copy), u4 (copy), u5 (copy), CollectionService (copy), Animations (copy), u6 (copy), InputFunc (copy), u40 (copy)
    local LocalPlayer = game.Players.LocalPlayer;
    local Character = LocalPlayer.Character;
    local v42 = Stands[LocalPlayer.Data.Ability.Value];
    local v43 = u1[v42][u39];

    if not u4[v42][LocalPlayer.Name] then
        u4[v42][LocalPlayer.Name] = {};
    end;

    local u44 = u4[v42][LocalPlayer.Name];

    if not u44[u39] then
        u44[u39] = 1;
    end;

    if u44[p41] then
        return;
    end;

    u44[p41] = true;
    local v45 = u44[u39];
    local v46 = v43.AnimSpeed or u5;
    local v47 = v43.StandOff and not CollectionService:HasTag(Character, "Summoned") and "StandOff-" or "";
    local u48 = v43.Standoff or v43;
    local v49;

    if u6[v42] then
        v49 = u6[v42][p41] or p41;
    else
        v49 = p41;
    end;

    local v50 = Animations.playClient(v42, v47 .. v49 .. "-" .. v45, nil, v46[v45]);
    LocalPlayer.Character.Values.Active.Value = "temp";
    InputFunc:InvokeServer(p41);

    if v50.Looped then
        v50:Stop();
    end;

    if v45 == u48.MaxCombo then
        u44[u39] = 1;
    else
        local v51 = u39;
        u44[v51] = u44[v51] + 1;
    end;

    coroutine.wrap(function() -- Line: 58
        -- upvalues: u44 (copy), u39 (ref), u40 (ref), u48 (copy)
        local v52 = u44[u39];
        wait((u40 or 1.5) + u48.ComboTick);

        if v52 == u44[u39] then
            u44[u39] = 1;
        end;
    end)();
    wait(u48.ComboTick);
    u44[p41] = nil;
end;

v37["LMB Combo"] = v38;
v37.Kamehameha = {
    Damage = 2,
    Tick = 0.1,
    Stun = 0.85,
    StunSpeed = 0,
    Cooldown = 9,
    Checks = v2,
    Knockback = { 5, 0.05 },
    Sound = { { "rbxassetid://7213363915", 3, 0, false } },
    Remotes = { { "FX", "HitEffect" } },
    HitData = {
        Color = Color3.fromRGB(85, 255, 255)
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(5.5, 5.5, 5.5),
        MaxRange = 35,
        Offset = CFrame.new()
    }
};
v37.Barrage = {
    Damage = 1,
    Stun = 0.4,
    Tick = 0.1,
    Time = 1.4,
    Cooldown = 8,
    Checks = v2,
    Knockback = { 5, 0.05 },
    Hitbox = {
        Type = "Magnitude",
        RelativePart = "HumanoidRootPart",
        Size = 4.7,
        Offset = CFrame.new(0, 0, -4.7)
    },
    HitAnimation = v3,
    Sound = { { "rbxassetid://7213363915 ", 2, 0, false } },
    Remotes = { { "FX", "Kur Heavy 2" } },
    HitData = {
        Color = Color3.new(0.490196, 0.737255, 1)
    }
};
v37.Feint = {
    Damage = 14,
    Stun = 0.85,
    Cooldown = 11,
    Checks = v2,
    Knockback = { 10, 0.25 },
    Hitbox = {
        Type = "Magnitude",
        RelativePart = "HumanoidRootPart",
        Size = 6,
        Offset = CFrame.new(0, 0, -5)
    },
    HitAnimation = v3,
    Sound = { { "rbxassetid://7213364499", 2, 0, false } },
    Remotes = { { "FX", "HeavyEffect" } },
    HitData = {
        Color = Color3.new(1, 1, 1)
    },
    callbacks = {
        client = function(p53, p54, p55) -- Line: 242, Name: client
            -- upvalues: Animations (copy)
            Animations.playClient("Goku", "Feint");
        end
    }
};
v37["Meteor Strike"] = {
    Damage = 9,
    Stun = 0.65,
    Cooldown = 17,
    Checks = v2,
    Hitbox = {
        Type = "Magnitude",
        RelativePart = "HumanoidRootPart",
        Size = 6,
        Offset = CFrame.new(0, 0, -5)
    },
    HitAnimation = v3,
    Sound = { { "rbxassetid://7213364499", 3.5, 0, false } },
    Remotes = { { "FX", "HitEffect" } },
    HitData = {
        Color = Color3.new(0.333333, 0, 0)
    },
    callbacks = {
        client = function(p56, p57, p58) -- Line: 269, Name: client
            -- upvalues: Animations (copy)
            Animations.playClient("Goku", "Kick-3");
        end
    }
};
v37.Genkidama = {
    Damage = 85,
    Stun = 1.5,
    Cooldown = 45,
    Checks = v2,
    Knockback = { 100, 0.25 },
    Hitbox = {
        Type = "Magnitude",
        RelativePart = "HumanoidRootPart",
        Size = 60,
        Offset = CFrame.new()
    },
    HitAnimation = v3,
    Sound = { { "rbxassetid://7048656678", 1, 0, false } },
    Remotes = { { "FX", "HeavyEffect" } },
    HitData = {
        Color = Color3.fromRGB(85, 255, 255)
    },

    CustomInvoke = function(p59) -- Line: 296, Name: CustomInvoke
        -- upvalues: Animations (copy), RunService (copy), InputFunc (copy)
        local LocalPlayer = game.Players.LocalPlayer;
        local Character = LocalPlayer.Character;
        local Humanoid = Character.Humanoid;
        local HumanoidRootPart = Character.HumanoidRootPart;

        if LocalPlayer.UserId ~= 110231579 and Character.Values.Form.Value ~= "Base" then
            return;
        end;

        local u60 = Animations.playClient("Goku", "Genkidama", nil, 1.2);
        Humanoid.AutoRotate = false;
        HumanoidRootPart.Anchored = true;
        coroutine.wrap(function() -- Line: 305
            -- upvalues: RunService (ref), u60 (copy)
            local v61 = 0;
            local v62 = nil or 0;

            while true do
                repeat
                    v61 = v61 + RunService.RenderStepped:Wait();
                until v62 <= v61;

                if u60.TimePosition > 7.78 then
                    u60:AdjustSpeed(0);
                    u60.TimePosition = 7.8;

                    return;
                end;

                v61 = 0;
                v62 = nil or 0;
            end;
        end)();
        InputFunc:InvokeServer(p59);
        HumanoidRootPart.Anchored = false;
        Humanoid.AutoRotate = true;
        u60:Stop();
    end
};
v37["Dragon Fist"] = {
    Damage = 30,
    Stun = 1,
    Cooldown = 15,
    Checks = v2,
    Knockback = { 10, 0.25 },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(10, 10, 85),
        MaxRange = 35,
        Offset = CFrame.new(0, 0, -42.5)
    },
    HitAnimation = v3,
    Sound = { { "rbxassetid://7213364499", 5, 0, false } },
    Remotes = { { "FX", "HeavyEffect" }, { "FX", "Kur Heavy 2" } },
    HitData = {
        Color = Color3.new(1, 1, 1)
    },

    CustomInvoke = function(p63) -- Line: 340, Name: CustomInvoke
        -- upvalues: Animations (copy), TweenService (copy), RunService (copy), CollectionService (copy), raycastMap (copy), InputFunc (copy)
        local Character = game.Players.LocalPlayer.Character;
        local Value = Character.Values.Form.Value;

        if Value ~= "SSJ3" and Value ~= "SSJ4" then
            return;
        end;

        local HumanoidRootPart = Character.HumanoidRootPart;
        local u64 = Animations.playClient("Goku", "Dragon Fist");
        local v65 = TweenService:Create(HumanoidRootPart, TweenInfo.new(0.15, Enum.EasingStyle.Sine), {
            CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, 15)
        });
        v65:Play();
        v65.Completed:Wait();
        task.spawn(function() -- Line: 350
            -- upvalues: RunService (ref), CollectionService (ref), Character (copy), TweenService (ref), HumanoidRootPart (copy), raycastMap (ref), u64 (copy)
            local v66 = 0;
            local v67 = nil or 0;

            while true do
                repeat
                    v66 = v66 + RunService.RenderStepped:Wait();
                until v67 <= v66;

                if CollectionService:HasTag(Character, "Dragon Fist") then
                    local u68 = TweenService:Create(HumanoidRootPart, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
                        CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -100)
                    });
                    u68:Play();
                    task.spawn(function() -- Line: 354
                        -- upvalues: raycastMap (ref), HumanoidRootPart (ref), u68 (copy)
                        local v69 = os.clock();

                        while not raycastMap(HumanoidRootPart.CFrame.Position, HumanoidRootPart.CFrame.LookVector * 5) do
                            task.wait();

                            if os.clock() - v69 >= 5 then
                                return;
                            end;
                        end;

                        u68:Cancel();
                    end);
                    task.wait(0.5);
                    u64:Stop();

                    return;
                end;

                v66 = 0;
                v67 = nil or 0;
            end;
        end);
        InputFunc:InvokeServer(p63);
    end
};
v37.Blink = {
    Damage = 5,
    Tick = 0.1,
    Stun = 0.85,
    Cooldown = 25,
    Checks = v2,
    Knockback = { 5, 0.05 },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(15, 10, 80),
        MaxRange = 100,
        Offset = CFrame.new(0, 0, -40)
    },
    Sound = { { "rbxassetid://7161287623", 4, 0, false } },
    Remotes = { { "FX", "MUI Hit" } },
    HitData = {
        Color = Color3.new(1, 1, 1)
    },

    CustomInvoke = function(p70) -- Line: 403, Name: CustomInvoke
        -- upvalues: InputFunc (copy)
        local LocalPlayer = game.Players.LocalPlayer;
        local Value = LocalPlayer.Character.Values.Form.Value;

        if LocalPlayer.UserId ~= 110231579 and (Value ~= "UI" and Value ~= "MUI") then
            return;
        end;

        InputFunc:InvokeServer(p70);
    end
};
v37["Instant Transmission"] = {
    Checks = v2,

    CustomInvoke = function(p71) -- Line: 413, Name: CustomInvoke
        -- upvalues: Animations (copy), RunService (copy), InputFunc (copy)
        local v72 = game.Players.LocalPlayer:GetMouse();
        local u73 = Animations.playClient("Goku", "Instant Transmission");

        while true do
            local v74 = 0;

            repeat
                v74 = v74 + RunService.RenderStepped:Wait();
            until (nil or 0) <= v74;

            if u73.Length then
                coroutine.wrap(function() -- Line: 418
                    -- upvalues: u73 (copy), RunService (ref)
                    local v75 = 0;

                    repeat
                        v75 = v75 + RunService.RenderStepped:Wait();
                    until (u73.Length - 0.1 or 0) <= v75;

                    u73:AdjustSpeed(0);
                end)();
                InputFunc:InvokeServer(p71, v72.Hit);
                u73:Stop();

                return;
            end;
        end;
    end
};
v37.Charge = {
    Cooldown = 5,
    Checks = v2
};
v37.Taunt = {
    Checks = {
        CheckStunned = false,
        CheckDisabled = false,
        CheckSummoned = false,
        CheckActive = false,
        CheckTimestop = true
    },
    Quotes = { { "This is a Super saiyan.", "rbxassetid://6807812025", {
                ["Oh Lord in Heaven, "] = 1
            }, 2, 2.5 }, { "I\'m Goku a saiyan raised on earth, Or so they tell me.", "rbxassetid://6807817509", {
                ["I\'m Goku a saiyan raised on earth,"] = 0.85
            }, 2 }, { "HEY IT\'S ME GOKU!", "rbxassetid://6807816001", {}, 2 } }
};
v28.Goku = v37;
u1 = v28;

return u1;