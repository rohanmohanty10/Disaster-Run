 
 

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
local Rarities = require(ReplicatedStorage.Shared.Tables.Rarities);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local LocalPlayer = game.Players.LocalPlayer;

local function onCharacterAdded(p4) -- Line: 21
    -- upvalues: u1 (ref)
    if u1 then
        u1.CachedPillaged = nil;
    end;
end;

if LocalPlayer.Character then
    local _ = LocalPlayer.Character;

    if u1 then
        u1.CachedPillaged = nil;
    end;
end;

LocalPlayer.CharacterAdded:Connect(onCharacterAdded);

return function(u5) -- Line: 33
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), Cooldowns (copy), Parent (copy), Effects (copy), RunService (copy), Players (copy), Rarities (copy), Styles (copy)
    local Character = LocalPlayer.Character;
    local _ = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = u5;
    u2 = u5.AbilityService;
    u3 = u5.Network;

    if not u5.CachedPillaged then
        u5.CachedPillaged = {};
    end;

    if u5.CopiedSetting then
        local u6 = u5.CDS[2];
        local v7 = tick() + 60;

        if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or u5.TotalTheft)) then
            u5.CDS[1] = v7;
        end;

        task.spawn(function() -- Line: 56
            -- upvalues: u5 (copy)
            require(u5.CopiedSetting.Ability)(u5);
        end);

        local function reset() -- Line: 60
            -- upvalues: u5 (copy), Cooldowns (ref), LocalPlayer (ref), Parent (ref), u6 (copy)
            task.delay(0.1, function() -- Line: 61
                -- upvalues: u5 (ref), Cooldowns (ref), LocalPlayer (ref), Parent (ref), u6 (ref)
                if not u5.LastReset or u5.LastReset[2] < tick() - 0.15 then
                    if u5.CopyTrove then
                        u5.CopyTrove:Disconnect();
                        u5.CopyTrove = nil;
                    end;

                    Cooldowns.Abilities.Thief[1] = Cooldowns.Abilities[u5.CopiedSetting.Style][u5.CopiedSetting.Index];

                    if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or u5.TotalTheft)) then
                        u5.CDS[1] = tick() + Cooldowns.Abilities[u5.CopiedSetting.Style][u5.CopiedSetting.Index];
                    end;

                    u5.CopiedSetting = nil;
                    Parent.Thief[1].Ability = script;
                    Parent.Thief[1].Name = "Pillage";
                    Parent.Thief[1].BallName = nil;
                    Parent.Thief[1].RequiresBall = "Both";
                    Parent.Thief[1].Steal = nil;
                    Parent.Thief[1].Jump = nil;
                end;

                if u6 ~= u5.CDS[2] then
                    if not (workspace:GetAttribute("NoAbilityCooldowns") or LocalPlayer:GetAttribute("NoAbilityCooldowns")) then
                        u5.CDS[2] = u6;
                    end;

                    u5.CDS[1] = tick() - 1;
                end;
            end);
        end;

        task.delay(0.1, function() -- Line: 61
            -- upvalues: u5 (copy), Cooldowns (ref), LocalPlayer (ref), Parent (ref), u6 (copy)
            if not u5.LastReset or u5.LastReset[2] < tick() - 0.15 then
                if u5.CopyTrove then
                    u5.CopyTrove:Disconnect();
                    u5.CopyTrove = nil;
                end;

                Cooldowns.Abilities.Thief[1] = Cooldowns.Abilities[u5.CopiedSetting.Style][u5.CopiedSetting.Index];

                if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or u5.TotalTheft)) then
                    u5.CDS[1] = tick() + Cooldowns.Abilities[u5.CopiedSetting.Style][u5.CopiedSetting.Index];
                end;

                u5.CopiedSetting = nil;
                Parent.Thief[1].Ability = script;
                Parent.Thief[1].Name = "Pillage";
                Parent.Thief[1].BallName = nil;
                Parent.Thief[1].RequiresBall = "Both";
                Parent.Thief[1].Steal = nil;
                Parent.Thief[1].Jump = nil;
            end;

            if u6 ~= u5.CDS[2] then
                if not (workspace:GetAttribute("NoAbilityCooldowns") or LocalPlayer:GetAttribute("NoAbilityCooldowns")) then
                    u5.CDS[2] = u6;
                end;

                u5.CDS[1] = tick() - 1;
            end;
        end);

        return;
    end;

    if u3.CharValues.InAwakening and not u5.TotalTheft then
        u5.TotalTheft = true;
        Parent.Thief[1].AwakeningName = nil;
        u5.CDS[1] = tick() + (u3.CharValues.InAwakening and 0 or 1);
        Effects:Popup("NO COOLDOWNS WHEN STEALING.", 2, Color3.new(0.376471, 0.627451, 1));
        task.delay(0.5, function() -- Line: 99
            -- upvalues: Effects (ref)
            Effects:Popup("STEAL ALL ABILITIES.", 2, Color3.new(0.376471, 0.627451, 1));
        end);
        task.delay(1.5, function() -- Line: 102
            -- upvalues: Effects (ref)
            Effects:Popup("TOTAL THEFT ENDS IN 15 SECONDS OR WHEN AWAKENING ENDS.", 2, Color3.new(1, 0.2, 0.2));
        end);
        task.delay(10, function() -- Line: 106
            -- upvalues: u5 (copy), Effects (ref)
            for i = 1, 5 do
                if not u5.Network.CharValues.InAwakening then
                    return;
                end;

                Effects:Popup((`{tostring(5 - i)} SECONDS LEFT.`));
                task.wait(1);
                local _ = i;
            end;

            Effects:Popup("TOTAL THEFT ENDED.");
        end);
        local u8 = nil;
        u8 = RunService.Heartbeat:Connect(function() -- Line: 116
            -- upvalues: u5 (copy), u8 (ref), Parent (ref), LocalPlayer (ref)
            if not u5.Network.CharValues.InAwakening then
                u5.TotalTheft = nil;
                u8:Disconnect();

                if not u5.CopiedSetting then
                    Parent.Thief[1].AwakeningName = "Total Theft";
                end;

                if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or not u5.Network.CharValues.InAwakening)) then
                    u5.CDS[1] = tick() + 120;
                end;
            end;
        end);
        task.delay(15, function() -- Line: 132
            -- upvalues: u5 (copy), u8 (ref), Parent (ref), LocalPlayer (ref)
            u5.TotalTheft = nil;
            u8:Disconnect();

            if not u5.CopiedSetting then
                Parent.Thief[1].AwakeningName = "Total Theft";
            end;

            if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or not u5.Network.CharValues.InAwakening)) then
                u5.CDS[1] = tick() + 120;
            end;
        end);

        return;
    end;

    local LookingDirect = u5.Pass.LookingDirect;
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(LookingDirect);
    local v9 = nil;
    local v10 = nil;

    if LookingDirect and PlayerFromCharacter then
        v9 = PlayerFromCharacter.Style.Value;
        v10 = PlayerFromCharacter.Style:GetAttribute("AbilityIndex");

        if not u5.CachedPillaged[PlayerFromCharacter.Name] then
            u5.CachedPillaged[PlayerFromCharacter.Name] = {};
        end;

        if not u5.CachedPillaged[PlayerFromCharacter.Name][v9] then
            u5.CachedPillaged[PlayerFromCharacter.Name][v9] = {};
        end;

        if not table.find(u5.CachedPillaged[PlayerFromCharacter.Name][v9], v10) then
            table.insert(u5.CachedPillaged[PlayerFromCharacter.Name][v9], v10);
        end;
    elseif RunService:IsStudio() then
        v9 = "Emperor";
        warn((`[TESTING MODE]: Testing pillaging '{v9}' style`));
        v10 = 2;
    end;

    if v9 == nil then
        Effects:Popup("Must be looking at an opponent!");
        u5:ResetCD(1);

        return;
    end;

    if v9 == "Thief" then
        Effects:Popup("Can\'t pillage other thiefs!");
        u5:ResetCD(1);

        return;
    end;

    if v9 == "Copycat" then
        Effects:Popup("Can\'t pillage copycats!");
        u5:ResetCD(1);

        return;
    end;

    if not (u3.CharValues.InZone and LocalPlayer.Zone.Value == "Devour" or (u3.CharValues.InAwakening or not table.find(Rarities.Limited, Styles.Styles[v9].Rarity))) then
        Effects:Popup("Can\'t pillage limited styles!");
        u5:ResetCD(1);

        return;
    end;

    if v9 == "Perfection" then
        Effects:Popup("Can\'t pillage that style!");
        u5:ResetCD(1);

        return;
    end;

    if v9 == "PerfectionV2" then
        Effects:Popup("Can\'t pillage that style!");
        u5:ResetCD(1);

        return;
    end;

    if v9 == "BasketballGod" then
        Effects:Popup("Can\'t pillage that style!");
        u5:ResetCD(1);

        return;
    end;

    if v9 == "UncleSam" then
        Effects:Popup("Can\'t pillage that style!");
        u5:ResetCD(1);

        return;
    end;

    if v9 == "Psychic" then
        Effects:Popup("Can\'t pillage that style!");
        u5:ResetCD(1);

        return;
    end;

    if v9 == "Cyber" then
        Effects:Popup("Can\'t pillage that style!");
        u5:ResetCD(1);

        return;
    end;

    if v9 == "OGCyber" then
        Effects:Popup("Can\'t pillage that style!");
        u5:ResetCD(1);

        return;
    end;

    if v9 == "Rubberman" then
        Effects:Popup("Can\'t pillage that style!");
        u5:ResetCD(1);

        return;
    end;

    if v9 == "LukaDoncic" then
        Effects:Popup("Can\'t pillage that style!");
        u5:ResetCD(1);

        return;
    end;

    if v9 == "Dealer" then
        Effects:Popup("Can\'t pillage that style!");
        u5:ResetCD(1);

        return;
    end;

    if v9 == "Alien" then
        Effects:Popup("Can\'t pillage that style!");
        u5:ResetCD(1);

        return;
    end;

    if Styles.Styles[v9].Rarity == "Dev" then
        Effects:Popup("Can\'t pillage that style!");
        u5:ResetCD(1);

        return;
    end;

    if v10 == nil then
        Effects:Popup("Opponent must have used an ability!");
        u5:ResetCD(1);

        return;
    end;

    if u5.CopyTrove then
        u5.CopyTrove:Disconnect();
    end;

    u5.CDS[1] = tick() + 1;
    u5.CopiedSetting = {};
    u5.CopiedSetting.Style = v9;
    u5.CopiedSetting.Index = v10;
    u5.CopiedSetting.Ability = Parent[v9][v10].Ability;

    if Parent[u5.CopiedSetting.Style][v10].Multi then
        Parent.Thief[1].Ability = Parent[u5.CopiedSetting.Style][v10].Ability;
    end;

    Parent.Thief[1].Name = Parent[u5.CopiedSetting.Style][v10].Name;
    Parent.Thief[1].BallName = Parent[u5.CopiedSetting.Style][v10].BallName;
    Parent.Thief[1].AwakeningName = nil;
    Parent.Thief[1].RequiresBall = Parent[u5.CopiedSetting.Style][v10].RequiresBall;
    Parent.Thief[1].Steal = Parent[u5.CopiedSetting.Style][v10].Seal;
    Parent.Thief[1].Jump = Parent[u5.CopiedSetting.Style][v10].Jump;
    u2.Ability:Fire("Pillage", {
        TimeSent = workspace:GetServerTimeNow(),
        Enemy = PlayerFromCharacter,
        Index = v10,
        Style = v9
    });
end;