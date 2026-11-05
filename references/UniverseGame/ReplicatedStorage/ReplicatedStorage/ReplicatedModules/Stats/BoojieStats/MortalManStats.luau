  

 

local v1 = {};
local v2 = {};
v1["Mortal Man"] = v2;
local PathShortcuts = require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.Trove);
v2.Summon = {
    StartCooldown = 1,
    EndCooldown = 1,
    Checks = {
        CheckStunned = true,
        CheckDisabled = true,
        CheckSummoned = false,
        CheckActive = true,
        CheckTimestop = true
    },

    CustomInvoke = function(p3) -- Line: 16, Name: CustomInvoke
        -- upvalues: Knit (copy)
        local LocalPlayer = game.Players.LocalPlayer;
        local Character = LocalPlayer.Character;
        local v4 = LocalPlayer:GetMouse();
        Character.Values.Active.Value = "temp";
        Knit.Remotes.InputFunc:InvokeServer("Q", v4.Hit.p);
    end
};
v2.VMoves = {
    Checks = {
        CheckStunned = true,
        CheckDisabled = true,
        CheckSummoned = false,
        CheckActive = true,
        CheckTimestop = true
    },

    CustomInvoke = function(p5) -- Line: 28, Name: CustomInvoke
        -- upvalues: Knit (copy)
        local LocalPlayer = game.Players.LocalPlayer;
        local Character = LocalPlayer.Character;
        local v6 = LocalPlayer:GetMouse();
        local v7 = Knit.GetController("PilotController");
        local v8 = {
            HookWalkSpeed = true,
            HookJumpPower = true,
            HookJump = true,
            Animations = Character:WaitForChild("StandAnimations"),
            Radius = Knit.ClientAssets.Whitesnake.PilotRadius,

            Check = function() -- Line: 40, Name: Check
                -- upvalues: Knit (ref), Character (copy)
                return Knit.CollectionService:HasTag(Character, "Piloting");
            end
        };

        if Knit.CollectionService:HasTag(Character, "Piloting") then
            local v9 = v7:GetPilot(Character);

            if Knit.CollectionService:HasTag(Character, "Piloting") then
                if v7.ActivePilot == v9 then
                    Knit.Remotes.InputFunc:InvokeServer("V", false);
                    v7:Reset();

                    return;
                end;

                Knit.Remotes.InputFunc:InvokeServer("V", true);
                v7:Control(v9, v8);
            end;

            return;
        end;

        Character.Values.Active.Value = "temp";
        Knit.Remotes.InputFunc:InvokeServer("Q", v6.Hit.p);
        local v10 = v7:GetPilot(Character);

        if v10 then
            v7:Control(v10, v8);
        end;

        Knit.Remotes.InputFunc:InvokeServer("V", true);
        print("1");
    end
};
v2.FMoves = {
    Checks = {
        CheckStunned = true,
        CheckDisabled = true,
        CheckSummoned = false,
        CheckActive = true,
        CheckTimestop = true
    }
};
v2.GMoves = {
    Checks = {
        CheckStunned = true,
        CheckDisabled = true,
        CheckSummoned = false,
        CheckActive = true,
        CheckTimestop = true
    }
};
v2.BMoves = {
    Checks = {
        CheckStunned = true,
        CheckDisabled = true,
        CheckSummoned = false,
        CheckActive = true,
        CheckTimestop = true
    }
};

return v1;