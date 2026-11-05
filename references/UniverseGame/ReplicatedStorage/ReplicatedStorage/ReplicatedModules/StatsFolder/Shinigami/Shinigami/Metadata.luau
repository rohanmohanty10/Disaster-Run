  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = game.GameId ~= 1782832995;
local Middleware = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware);
local StoreHandler = require(PathShortcuts.ReplicatedModules.Independent.StoreHandler);

local function UpdateSouls(p2) -- Line: 10
    -- upvalues: Knit (copy), StoreHandler (copy)
    local Character = p2.Character;
    local Player = p2.Player;
    local v3 = Knit.GetService("StatService");
    local v4 = v3.GetStatsInfo(Character);

    if not v4 then
        return true;
    end;

    if Player.Data.Ability.Value ~= 6666666 then
        v4:SetExternalStats("ShinigamiStats", nil);

        return true;
    end;

    local v5 = Player:GetAttribute("ShinigamiSouls") * 1;
    local v6 = StoreHandler.GetStore("ShinigamiStats");

    for i, _ in pairs(v6) do
        if not i.Parent then
            v6[i] = nil;
        end;
    end;

    if not v6[Player] then
        v6[Player] = {
            Health = 0,
            Defense = 0,
            Attack = 0,
            Special = 0
        };
    end;

    local v7 = v6[Player];
    local v8 = 0;

    for _, v in pairs(v7) do
        v8 = v8 + v;
    end;

    if v8 / 1 > Player:GetAttribute("ShinigamiSouls") then
        for i, _ in pairs(v7) do
            v7[i] = 0;
        end;

        v8 = 0;
    end;

    if v8 < v5 then
        local v9 = v5 - v8;

        if v9 % 1 == 0 then
            local v10 = Random.new();
            local v11 = { "Health", "Defense", "Attack", "Special" };

            for _ = 1, v9 / 1 do
                local v12 = v11[v10:NextInteger(1, #v11)];
                v7[v12] = v7[v12] + 1;
            end;
        end;
    end;

    v4:SetExternalStats("ShinigamiStats", (v3.CreateStatsObject(v7)));

    return true;
end;

return {
    AbilityOutbound = function(u13) -- Line: 77, Name: AbilityOutbound
        -- upvalues: u1 (copy), Middleware (copy), Knit (copy), UpdateSouls (copy)
        local State = u13.State;
        local Attacker = u13.Attacker;
        local Target = u13.Target;

        if not (State.Killed or State.IsDead) then
            return;
        end;

        if typeof(Attacker) ~= "Instance" or typeof(Target) ~= "Instance" then
            return;
        end;

        if Target:GetAttribute("SOUL_COLLECTED") or Target:GetAttribute("Clone") then
            return;
        end;

        local v14;

        if Attacker:GetAttribute("NPC") then
            v14 = Attacker;
        else
            v14 = u13.AttackerPlayer;
        end;

        if not v14 then
            return;
        end;

        local v15 = v14:GetAttribute("ShinigamiSouls") or 0;
        local v16 = 250;
        local v17 = 15;
        local v18 = v14.Character:GetAttribute("MasteryRank") or 0;

        if v18 > 0 then
            v16 = v16 + v17 * v18;
        end;

        print(v16);

        if v14.Data.Ability.Value ~= 6666666 or v16 <= v15 then
            return;
        end;

        local v19;

        if Target:GetAttribute("NPC") then
            v19 = Target;
        else
            v19 = u13.TargetPlayer;
        end;

        if u1 or v19 then
            Middleware.GetMiddleware("CombatService").PlaySound(Attacker, "Kill");
            Target:SetAttribute("SOUL_COLLECTED", true);
            v14:SetAttribute("ShinigamiSouls", v14:GetAttribute("ShinigamiSouls") + 1);
            pcall(function() -- Line: 112
                -- upvalues: Knit (ref), Attacker (copy), Target (copy), u13 (copy)
                Knit.GetService("EffectService").FireAllClients("Emit Particle V3", {
                    Path = "Particles/SoulCapture",
                    AbilityName = "Shinigami",
                    AutoSerialize = true,
                    Character = Attacker,
                    AttachTo = {
                        Part = Target.Torso
                    },
                    SkinName = u13.SkinName
                });
            end);
            task.spawn(UpdateSouls, {
                Player = v14,
                Character = Attacker
            });

            return true;
        end;
    end,

    AbilityInbound = function(p20) -- Line: 131, Name: AbilityInbound
        local Target = p20.Target;

        if not Target then
            return;
        end;

        if not (Target:GetAttribute("NPC") or Target:GetAttribute("Dummy")) then
            return;
        end;

        local Attacker = p20.Attacker;

        if not Attacker:GetAttribute("NPC") then
            Attacker = p20.AttackerPlayer;
        end;

        if not Attacker then
            return;
        end;

        local v21 = Attacker:GetAttribute("ShinigamiSouls") or 0;
        local Stats = p20.Stats;

        if not Stats.SoulScaling then
            return;
        end;

        Stats.Damage = Stats.Damage + Stats.SoulScaling * v21;
    end,

    Hooks = {
        StatSetup = {
            CombatHook = "Moves",
            HookType = "PreMove",
            HookName = "ShinigamiStatHook",
            Priority = 1,
            HookFunction = UpdateSouls
        },
        OnSpawn = {
            CombatHook = "Setup",
            HookType = "OnSpawn",
            HookName = "ShinigamiOnSpawn",
            Priority = 1,

            HookFunction = function(p22) -- Line: 160, Name: HookFunction
                -- upvalues: Knit (copy)
                local Player = p22.Player;
                local Character = p22.Character;
                local v23 = Knit.GetService("StatService").GetStatsInfo(Character);

                if v23 and Player.Data.Ability.Value ~= 6666666 then
                    v23:SetExternalStats("ShinigamiStats", nil);
                end;

                return true;
            end
        }
    },

    CustomAddon = function(p24) -- Line: 176, Name: CustomAddon
        local Player = p24.Player;

        if Player:GetAttribute("ShinigamiSouls") then
            return;
        end;

        Player:SetAttribute("ShinigamiSouls", 0);
    end
};