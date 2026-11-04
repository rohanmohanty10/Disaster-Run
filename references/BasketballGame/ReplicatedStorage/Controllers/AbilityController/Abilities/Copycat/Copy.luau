 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Parent = require(script.Parent.Parent);
local Cooldowns = require(ReplicatedStorage.Shared.Tables.Cooldowns);
local Styles = require(ReplicatedStorage.Shared.Tables.Styles);
local u1 = nil;
local u2 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u3) -- Line: 18
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), Cooldowns (copy), Parent (copy), Players (copy), RunService (copy), Effects (copy), Styles (copy)
    local Character = LocalPlayer.Character;
    local _ = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = u3.AbilityService;
    u2 = u3.Network;

    if u3.CopiedSetting then
        local u4 = u3.CDS[2];
        local v5 = tick() + 60;

        if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u3.TotalTheft) then
            u3.CDS[1] = v5;
        end;

        task.spawn(function() -- Line: 35
            -- upvalues: u3 (copy)
            require(u3.CopiedSetting.Ability)(u3);
        end);

        local function reset() -- Line: 39
            -- upvalues: u3 (copy), Cooldowns (ref), LocalPlayer (ref), Parent (ref), u4 (copy)
            task.delay(0.1, function() -- Line: 40
                -- upvalues: u3 (ref), Cooldowns (ref), LocalPlayer (ref), Parent (ref), u4 (ref)
                if not u3.LastReset or u3.LastReset[2] < tick() - 0.15 then
                    if u3.CopyTrove then
                        u3.CopyTrove:Disconnect();
                        u3.CopyTrove = nil;
                    end;

                    Cooldowns.Abilities.Copycat[1] = Cooldowns.Abilities[u3.CopiedSetting.Style][u3.CopiedSetting.Index];

                    if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat"))) then
                        u3.CDS[1] = tick() + Cooldowns.Abilities[u3.CopiedSetting.Style][u3.CopiedSetting.Index];
                    end;

                    u3.CopiedSetting = nil;
                    Parent.Copycat[1].Ability = script;
                    Parent.Copycat[1].Name = "Copy";
                    Parent.Copycat[1].BallName = nil;
                    Parent.Copycat[1].RequiresBall = "Both";
                    Parent.Copycat[1].Steal = nil;
                    Parent.Copycat[1].Jump = nil;
                end;

                if u4 ~= u3.CDS[2] then
                    if not (workspace:GetAttribute("NoAbilityCooldowns") or LocalPlayer:GetAttribute("NoAbilityCooldowns")) then
                        u3.CDS[2] = u4;
                    end;

                    u3.CDS[1] = tick() - 1;
                end;
            end);
        end;

        task.delay(0.1, function() -- Line: 40
            -- upvalues: u3 (copy), Cooldowns (ref), LocalPlayer (ref), Parent (ref), u4 (copy)
            if not u3.LastReset or u3.LastReset[2] < tick() - 0.15 then
                if u3.CopyTrove then
                    u3.CopyTrove:Disconnect();
                    u3.CopyTrove = nil;
                end;

                Cooldowns.Abilities.Copycat[1] = Cooldowns.Abilities[u3.CopiedSetting.Style][u3.CopiedSetting.Index];

                if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat"))) then
                    u3.CDS[1] = tick() + Cooldowns.Abilities[u3.CopiedSetting.Style][u3.CopiedSetting.Index];
                end;

                u3.CopiedSetting = nil;
                Parent.Copycat[1].Ability = script;
                Parent.Copycat[1].Name = "Copy";
                Parent.Copycat[1].BallName = nil;
                Parent.Copycat[1].RequiresBall = "Both";
                Parent.Copycat[1].Steal = nil;
                Parent.Copycat[1].Jump = nil;
            end;

            if u4 ~= u3.CDS[2] then
                if not (workspace:GetAttribute("NoAbilityCooldowns") or LocalPlayer:GetAttribute("NoAbilityCooldowns")) then
                    u3.CDS[2] = u4;
                end;

                u3.CDS[1] = tick() - 1;
            end;
        end);

        return;
    end;

    local LookingDirect = u3.Pass.LookingDirect;
    local v6 = nil;

    if LookingDirect then
        local PlayerFromCharacter = Players:GetPlayerFromCharacter(LookingDirect);

        if PlayerFromCharacter then
            v6 = PlayerFromCharacter.Style.Value;
        end;
    elseif RunService:IsStudio() then
        v6 = "Emperor";
        warn((`[TESTING MODE]: Testing copying '{v6}' style`));
    end;

    if v6 == nil then
        Effects:Popup("Must be looking at an opponent!");
        u3:ResetCD(1);

        return;
    end;

    if v6 == "Copycat" then
        Effects:Popup("Can\'t copy other copycats!");
        u3:ResetCD(1);

        return;
    end;

    if v6 == "Thief" then
        Effects:Popup("Can\'t copy thiefs!");
        u3:ResetCD(1);

        return;
    end;

    if v6 == "Perfection" then
        Effects:Popup("Can\'t copy that style!");
        u3:ResetCD(1);

        return;
    end;

    if v6 == "PerfectionV2" then
        Effects:Popup("Can\'t copy that style!");
        u3:ResetCD(1);

        return;
    end;

    if v6 == "BasketballGod" then
        Effects:Popup("Can\'t copy that style!");
        u3:ResetCD(1);

        return;
    end;

    if v6 == "UncleSam" then
        Effects:Popup("Can\'t copy that style!");
        u3:ResetCD(1);

        return;
    end;

    if v6 == "Psychic" then
        Effects:Popup("Can\'t copy that style!");
        u3:ResetCD(1);

        return;
    end;

    if v6 == "Cyber" then
        Effects:Popup("Can\'t copy that style!");
        u3:ResetCD(1);

        return;
    end;

    if v6 == "OGCyber" then
        Effects:Popup("Can\'t copy that style!");
        u3:ResetCD(1);

        return;
    end;

    if v6 == "Rubberman" then
        Effects:Popup("Can\'t copy that style!");
        u3:ResetCD(1);

        return;
    end;

    if v6 == "LukaDoncic" then
        Effects:Popup("Can\'t copy that style!");
        u3:ResetCD(1);

        return;
    end;

    if v6 == "Dealer" then
        Effects:Popup("Can\'t copy that style!");
        u3:ResetCD(1);

        return;
    end;

    if v6 == "Alien" then
        Effects:Popup("Can\'t copy that style!");
        u3:ResetCD(1);

        return;
    end;

    if Styles.Styles[v6].Rarity == "Dev" then
        Effects:Popup("Can\'t copy that style!");
        u3:ResetCD(1);

        return;
    end;

    if u3.CopyTrove then
        u3.CopyTrove:Disconnect();
    end;

    u3.CDS[1] = tick() + 1;
    local v7 = Random.new(os.clock() * 1000):NextNumber(1, 2);
    local math_round_ret = math.round(v7);
    u3.CopiedSetting = {};
    u3.CopiedSetting.Style = v6;
    u3.CopiedSetting.Index = math_round_ret;
    u3.CopiedSetting.Ability = Parent[v6][math_round_ret].Ability;

    if Parent[u3.CopiedSetting.Style][math_round_ret].Multi then
        Parent.Copycat[1].Ability = Parent[u3.CopiedSetting.Style][math_round_ret].Ability;
    end;

    Parent.Copycat[1].Name = Parent[u3.CopiedSetting.Style][math_round_ret].Name;
    Parent.Copycat[1].BallName = Parent[u3.CopiedSetting.Style][math_round_ret].BallName;
    Parent.Copycat[1].RequiresBall = Parent[u3.CopiedSetting.Style][math_round_ret].RequiresBall;
    Parent.Copycat[1].Steal = Parent[u3.CopiedSetting.Style][math_round_ret].Steal;
    Parent.Copycat[1].Jump = Parent[u3.CopiedSetting.Style][math_round_ret].Jump;
    u1.Ability:Fire("Copy", {
        TimeSent = workspace:GetServerTimeNow(),
        Style = v6
    });
end;