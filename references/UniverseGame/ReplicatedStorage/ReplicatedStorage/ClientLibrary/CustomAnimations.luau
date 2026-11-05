  

 

local CollectionService = game:GetService("CollectionService");
require(game.ReplicatedStorage.ReplicatedModules.Animations);
local AbilityProxies = require(game.ReplicatedStorage.ReplicatedModules.AbilityProxies);
local wait = task.wait;
local u42 = {
    Handlers = {
        [9] = function(p1) -- Line: 7
            local _ = p1.Character;
            local Cache = p1.Cache;
            local _ = p1.Trove;
            local Animations = p1.Animations;
            local _ = p1.DefaultAnimations;
            local Ability = p1.Ability;
            local u2 = { "Idle", "Unsummon", "PlatformStand", "Falling" };

            local function Callback(p3, p4) -- Line: 16
                -- upvalues: Animations (copy), Cache (copy), u2 (copy)
                local v5 = Animations:GetAnimation("KC_Run");
                local v6 = Animations:GetAnimation("KC_Walk");

                if not (v5 and v6) then
                    return;
                end;

                if p3 == "Moving" and p4.Summoned then
                    if p4.MovementType == "Run" then
                        v6:Stop();
                        Cache.Animation = v5;

                        if not v5.IsPlaying then
                            v5:Play();
                        end;
                    elseif p4.MovementType == "Walk" then
                        v5:Stop();
                        Cache.Animation = v6;

                        if not v6.IsPlaying then
                            v6:Play();
                        end;
                    end;
                elseif table.find(u2, p3) then
                    v5:Stop();
                    v6:Stop();
                end;
            end;

            if not Cache[Ability.Value] then
                Cache[Ability.Value] = true;
                p1.Callback = Callback;
            end;
        end,

        [1300] = function(p7) -- Line: 40
            -- upvalues: CollectionService (copy)
            local Character = p7.Character;
            local Cache = p7.Cache;
            local Trove = p7.Trove;
            local Animations = p7.Animations;
            local AbilityAnimations = p7.AbilityAnimations;
            local DefaultAnimations = p7.DefaultAnimations;
            local Ability = p7.Ability;

            local function ChangeAnimations() -- Line: 49
                -- upvalues: CollectionService (ref), Character (copy), Animations (copy), AbilityAnimations (copy), DefaultAnimations (copy)
                if CollectionService:HasTag(Character, "PluckToggled") then
                    Animations:OverrideAnimation("Idle", Animations:GetAnimation("Pluck Idle"));
                    local v8 = Animations:GetAnimation("Pluck Walk");
                    local v9 = Animations:GetAnimation("Pluck Run");

                    if v8 then
                        Animations:OverrideAnimation("Walk", v8);
                    end;

                    if v9 then
                        Animations:OverrideAnimation("Run", v9);
                    end;
                else
                    Animations:OverrideAnimation("Idle", AbilityAnimations.Idle);
                    Animations:OverrideAnimation("Walk", AbilityAnimations.Walk or DefaultAnimations.Walk);
                    Animations:OverrideAnimation("Run", AbilityAnimations.Run or DefaultAnimations.Run);
                end;
            end;

            ChangeAnimations();

            if not Cache[Ability.Value] then
                Cache[Ability.Value] = true;
                p7.SummonedBinded = true;
                Trove:Add(CollectionService:GetInstanceAddedSignal("PluckToggled"):Connect(function(p10) -- Line: 77
                    -- upvalues: Character (copy), ChangeAnimations (copy)
                    if p10 == Character then
                        ChangeAnimations();
                    end;
                end));
                Trove:Add(CollectionService:GetInstanceRemovedSignal("PluckToggled"):Connect(function(p11) -- Line: 83
                    -- upvalues: Character (copy), ChangeAnimations (copy)
                    if p11 == Character then
                        ChangeAnimations();
                    end;
                end));
            end;
        end,

        [46] = function(p12) -- Line: 90
            -- upvalues: CollectionService (copy)
            local Character = p12.Character;
            local Cache = p12.Cache;
            local Trove = p12.Trove;
            local Animations = p12.Animations;
            local DefaultAnimations = p12.DefaultAnimations;
            local Ability = p12.Ability;

            local function u15() -- Line: 110
                -- upvalues: CollectionService (ref), Character (copy), Animations (copy), DefaultAnimations (copy)
                if CollectionService:HasTag(Character, "Summoned") then
                    if not CollectionService:HasTag(Character, "Sovereign") then
                        Animations:OverrideAnimation("Idle", Animations:GetAnimation("SummonedIdle"));
                        Animations:OverrideAnimation("SummonedWalk", Animations:GetAnimation("SummonedWalk") or DefaultAnimations.Walk);
                        Animations:OverrideAnimation("SummonedRun", Animations:GetAnimation("SummonedRun") or DefaultAnimations.Run);
                        Animations:StopAnimation("Walk");
                        Animations:StopAnimation("Run");

                        return;
                    end;

                    Animations:OverrideAnimation("Idle", Animations:GetAnimation("SovereignIdle"));
                    local v13 = Animations:GetAnimation("SovereignWalk");
                    local v14 = Animations:GetAnimation("SovereignRun");

                    if v13 then
                        Animations:OverrideAnimation("SummonedWalk", v13);
                        Animations:StopAnimation("Walk");
                    end;

                    if v14 then
                        Animations:OverrideAnimation("SummonedRun", v14);
                        Animations:StopAnimation("Run");
                    end;
                else
                    Animations:OverrideAnimation("Idle", DefaultAnimations.Idle);
                end;
            end;

            u15();

            if not Cache[Ability.Value] then
                Cache[Ability.Value] = true;
                p12.SummonedBinded = true;
                Trove:Add(CollectionService:GetInstanceAddedSignal("Sovereign"):Connect(function(p16) -- Line: 140
                    -- upvalues: Character (copy), u15 (copy)
                    if p16 == Character then
                        u15();
                    end;
                end));
                Trove:Add(CollectionService:GetInstanceRemovedSignal("Sovereign"):Connect(function(p17) -- Line: 146
                    -- upvalues: Character (copy), u15 (copy)
                    if p17 == Character then
                        u15();
                    end;
                end));
                Trove:Add(CollectionService:GetInstanceAddedSignal("Summoned"):Connect(function(p18) -- Line: 152
                    -- upvalues: Character (copy), u15 (copy)
                    if p18 == Character then
                        u15();
                    end;
                end));
                Trove:Add(CollectionService:GetInstanceRemovedSignal("Summoned"):Connect(function(p19) -- Line: 158
                    -- upvalues: Character (copy), u15 (copy)
                    if p19 == Character then
                        u15();
                    end;
                end));
            end;
        end,

        [701] = function(p20) -- Line: 165
            -- upvalues: CollectionService (copy)
            local Character = p20.Character;
            local Cache = p20.Cache;
            local Trove = p20.Trove;
            local Animations = p20.Animations;
            local _ = p20.DefaultAnimations;
            local AbilityAnimations = p20.AbilityAnimations;
            local Ability = p20.Ability;

            local function u21() -- Line: 173
                -- upvalues: CollectionService (ref), Character (copy), Animations (copy), AbilityAnimations (copy)
                if CollectionService:HasTag(Character, "LoveTrain") then
                    Animations:OverrideAnimation("Idle", Animations:GetAnimation("LoveTrainIdle"));
                    Animations:OverrideAnimation("Run", Animations:GetAnimation("LoveTrainRun"));
                    Animations:OverrideAnimation("Walk", Animations:GetAnimation("LoveTrainWalk"));

                    return;
                end;

                Animations:OverrideAnimation("Idle", AbilityAnimations.Idle);
                Animations:OverrideAnimation("Run", AbilityAnimations.Run);
                Animations:OverrideAnimation("Walk", AbilityAnimations.Walk);
            end;

            if not Cache[Ability.Value] then
                Cache[Ability.Value] = true;
                Trove:Add(CollectionService:GetInstanceAddedSignal("LoveTrain"):Connect(function(p22) -- Line: 186
                    -- upvalues: Character (copy), u21 (copy)
                    if p22 == Character then
                        u21();
                    end;
                end));
                Trove:Add(CollectionService:GetInstanceRemovedSignal("LoveTrain"):Connect(function(p23) -- Line: 192
                    -- upvalues: Character (copy), u21 (copy)
                    if p23 == Character then
                        u21();
                    end;
                end));
            end;
        end,

        [555555] = function(p24) -- Line: 199
            -- upvalues: CollectionService (copy)
            local Character = p24.Character;
            local Cache = p24.Cache;
            local Trove = p24.Trove;
            local Animations = p24.Animations;
            local _ = p24.DefaultAnimations;
            local AbilityAnimations = p24.AbilityAnimations;
            local Ability = p24.Ability;

            local function u25() -- Line: 207
                -- upvalues: CollectionService (ref), Character (copy), Animations (copy), AbilityAnimations (copy)
                if CollectionService:HasTag(Character, "Summoned") then
                    Animations:OverrideAnimation("Idle", Animations:GetAnimation("SummonedIdle"));
                    Animations:OverrideAnimation("Run", Animations:GetAnimation("SummonedRun"));
                    Animations:OverrideAnimation("Walk", Animations:GetAnimation("SummonedWalk"));

                    return;
                end;

                Animations:OverrideAnimation("Idle", AbilityAnimations.Idle);
                Animations:OverrideAnimation("Run", AbilityAnimations.Run);
                Animations:OverrideAnimation("Walk", AbilityAnimations.Walk);
            end;

            if not Cache[Ability.Value] then
                Cache[Ability.Value] = true;
                Trove:Add(CollectionService:GetInstanceAddedSignal("Summoned"):Connect(function(p26) -- Line: 220
                    -- upvalues: Character (copy), u25 (copy)
                    if p26 == Character then
                        u25();
                    end;
                end));
                Trove:Add(CollectionService:GetInstanceRemovedSignal("Summoned"):Connect(function(p27) -- Line: 226
                    -- upvalues: Character (copy), u25 (copy)
                    if p27 == Character then
                        u25();
                    end;
                end));
            end;
        end,

        [1000] = function(p28) -- Line: 233
            -- upvalues: CollectionService (copy)
            local Character = p28.Character;
            local _ = p28.Cache;
            local Trove = p28.Trove;
            local Animations = p28.Animations;
            local DefaultAnimations = p28.DefaultAnimations;
            local _ = p28.AbilityAnimations;
            local _ = p28.Ability;

            local function u29() -- Line: 241
                -- upvalues: CollectionService (ref), Character (copy), Animations (copy), DefaultAnimations (copy)
                if CollectionService:HasTag(Character, "Summoned") then
                    Animations:OverrideAnimation("Idle", Animations:GetAnimation("SummonedIdle"));
                    Animations:OverrideAnimation("Run", Animations:GetAnimation("SummonedRun"));
                    Animations:OverrideAnimation("Walk", Animations:GetAnimation("SummonedWalk"));

                    return;
                end;

                Animations:OverrideAnimation("Idle", DefaultAnimations.Idle);
                Animations:OverrideAnimation("Run", DefaultAnimations.Run);
                Animations:OverrideAnimation("Walk", DefaultAnimations.Walk);
            end;

            p28.SummonedBinded = true;
            Trove:Add(CollectionService:GetInstanceAddedSignal("Summoned"):Connect(function(p30) -- Line: 253
                -- upvalues: Character (copy), u29 (copy)
                if p30 == Character then
                    u29();
                end;
            end));
            Trove:Add(CollectionService:GetInstanceRemovedSignal("Summoned"):Connect(function(p31) -- Line: 259
                -- upvalues: Character (copy), u29 (copy)
                if p31 == Character then
                    u29();
                end;
            end));
        end,

        [1010] = function(p32) -- Line: 265
            local _ = p32.Character;
            local Cache = p32.Cache;
            local Trove = p32.Trove;
            local Animations = p32.Animations;
            local _ = p32.DefaultAnimations;
            local Ability = p32.Ability;
            local ACTValue = p32.Player.Data:WaitForChild("ACTValue");

            local function ChangeIdle(p33) -- Line: 274
                -- upvalues: Animations (copy)
                Animations:PlayAnimation("ACT" .. p33 .. "Idle");
            end;

            Animations:PlayAnimation("ACT" .. ACTValue.Value .. "Idle");

            if not Cache[Ability.Value] then
                Cache[Ability.Value] = true;
                Trove:Add(ACTValue.Changed:Connect(ChangeIdle));
            end;
        end,

        [10019] = function(p34) -- Line: 283
            -- upvalues: CollectionService (copy)
            local Character = p34.Character;
            local _ = p34.Cache;
            local Trove = p34.Trove;
            local Animations = p34.Animations;
            local _ = p34.DefaultAnimations;
            local AbilityAnimations = p34.AbilityAnimations;
            local _ = p34.Ability;

            local function u35() -- Line: 291
                -- upvalues: CollectionService (ref), Character (copy), Animations (copy), AbilityAnimations (copy)
                if CollectionService:HasTag(Character, "Crouching") then
                    Animations:OverrideAnimation("Run", AbilityAnimations.CrouchRun);
                    Animations:OverrideAnimation("Walk", AbilityAnimations.CrouchWalk);
                    Animations:OverrideAnimation("Idle", AbilityAnimations.Crouch);

                    return;
                end;

                Animations:OverrideAnimation("Run", AbilityAnimations.Run);
                Animations:OverrideAnimation("Walk", AbilityAnimations.Walk);
                Animations:OverrideAnimation("Idle", AbilityAnimations.Idle);
            end;

            u35();
            Trove:Add(CollectionService:GetInstanceAddedSignal("Crouching"):Connect(function(p36) -- Line: 303
                -- upvalues: Character (copy), u35 (copy)
                if p36 == Character then
                    u35();
                end;
            end));
            Trove:Add(CollectionService:GetInstanceRemovedSignal("Crouching"):Connect(function(p37) -- Line: 309
                -- upvalues: Character (copy), u35 (copy)
                if p37 == Character then
                    u35();
                end;
            end));
        end,

        [55555] = function(p38) -- Line: 315
            -- upvalues: wait (copy)
            local Character = p38.Character;
            local Trove = p38.Trove;
            local Animations = p38.Animations;
            local Cache = p38.Cache;
            local Ability = p38.Ability;

            repeat
                wait(0.01);
            until Character:FindFirstChild("Values"):FindFirstChild("Form") or Character.Parent == nil;

            local Form = Character.Values.Form;

            if Cache[Ability.Value] then
                return;
            end;

            local v39 = Animations:GetAnimation(Form.Value);

            if v39 then
                Animations:OverrideAnimation("Idle", v39):Play();
            end;

            if not Cache[Ability.Value] then
                Cache[Ability.Value] = true;
                Trove:Add(Form.Changed:Connect(function(p40) -- Line: 334
                    -- upvalues: Animations (copy)
                    local v41 = Animations:GetAnimation(p40);

                    if v41 then
                        Animations:OverrideAnimation("Idle", v41):Play();
                    end;
                end));
            end;
        end
    },
    Tags = {}
};

local function GetBind(p43) -- Line: 347
    -- upvalues: u42 (copy)
    return u42.Handlers[p43];
end;

u42.Handlers[10021] = u42.Handlers[10019];

function u42.LoadCustomBinds(p44) -- Line: 353
    -- upvalues: AbilityProxies (copy), u42 (copy)
    local v45 = AbilityProxies.GetProxyId(p44.Ability.Value);

    if u42.Handlers[v45] then
        u42.Handlers[v45](p44);
    end;
end;

function u42.LoadTags(u46) -- Line: 360
    -- upvalues: u42 (copy), CollectionService (copy)
    local Trove = u46.Trove;
    local Character = u46.Character;

    for i, v in pairs(u42.Tags) do
        Trove:Connect(CollectionService:GetInstanceAddedSignal(i), function(p47) -- Line: 364
            -- upvalues: Character (copy), v (copy), u46 (copy)
            if p47 == Character then
                v(true, u46);
            end;
        end);
        Trove:Connect(CollectionService:GetInstanceRemovedSignal(i), function(p48) -- Line: 369
            -- upvalues: Character (copy), v (copy), u46 (copy)
            if p48 == Character then
                v(false, u46);
            end;
        end);
    end;
end;

return u42;