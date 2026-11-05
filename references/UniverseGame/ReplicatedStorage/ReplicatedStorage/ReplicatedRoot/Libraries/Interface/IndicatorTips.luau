  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
require(ReplicatedRoot.Core);
require(ReplicatedRoot.Libraries.Types.CommonTypes);
require(ReplicatedRoot.Libraries.Types.GameplayTypes);
local Enums = require(ReplicatedRoot.Libraries.Enums);
local CombatService = require(ReplicatedRoot.Services.CombatService);
local u1 = {
    Light = "<font color=\"rgb(255,235,200)\"><font weight=\"Bold\">%s</font></font>",
    Medium = "<font color=\"rgb(255,200,0)\"><font weight=\"Bold\">%s</font></font>",
    Heavy = "<font color=\"rgb(255,100,0)\"><font weight=\"Bold\">%s</font></font>",
    Super = "<font color=\"rgb(75,200,255)\"><font weight=\"Bold\">%s</font></font>",
    Ultimate = "<font color=\"rgb(225,50,255)\"><font weight=\"Bold\">%s</font></font>"
};

return {
    AttackPriority = {
        Text = "",
        Priority = Enums.IndicatorPriority.Priority + 0,

        Transformer = function(p2, p3) -- Line: 22, Name: Transformer
            -- upvalues: CombatService (copy), u1 (copy)
            local v4 = CombatService.CalculateAttackPriority(p2.Metadata.AttackPriority);

            if not u1[v4] then
                return v4;
            end;

            local v5;

            if v4 == "Super" or v4 == "Ultimate" then
                v5 = string.upper(v4);
            else
                v5 = v4;
            end;

            return string.format(u1[v4], v5);
        end,

        Check = function(p6) -- Line: 33, Name: Check
            return p6.Metadata.AttackPriority ~= nil;
        end
    },
    Input = {
        Text = "",
        Priority = Enums.IndicatorPriority.Input + 0,

        Transformer = function(p7, p8) -- Line: 41, Name: Transformer
            return `Use {p7.Metadata.UseCount}x`;
        end,

        Check = function(p9) -- Line: 44, Name: Check
            local v10;

            if typeof(p9.Metadata.UseCount) == "number" then
                v10 = p9.Metadata.UseCount > 1;
            else
                v10 = false;
            end;

            return v10;
        end
    },
    Held = {
        Text = "Held",
        Priority = Enums.IndicatorPriority.Input + 10,

        Check = function(p11) -- Line: 52, Name: Check
            return p11.Metadata.Held == true;
        end
    },
    Mobility = {
        Text = "Mobility",
        Priority = Enums.IndicatorPriority.Type + 0,

        Check = function(p12) -- Line: 60, Name: Check
            return p12.Metadata.Mobility == true;
        end
    },
    Evasive = {
        Text = "Evasive",
        Priority = Enums.IndicatorPriority.Type + 10,

        Check = function(p13) -- Line: 68, Name: Check
            return p13.Metadata.Evasive == true;
        end
    },
    Defensive = {
        Text = "Defensive",
        Priority = Enums.IndicatorPriority.Type + 20,

        Check = function(p14) -- Line: 76, Name: Check
            return p14.Metadata.Defensive == true;
        end
    },
    Cosmetic = {
        Text = "Cosmetic",
        Priority = Enums.IndicatorPriority.Type + 30,

        Check = function(p15) -- Line: 84, Name: Check
            return p15.Metadata.Cosmetic == true;
        end
    },
    ModeSwitch = {
        Text = "Mode Switch",
        Priority = Enums.IndicatorPriority.Type + 40,

        Check = function(p16) -- Line: 92, Name: Check
            return p16.Metadata.ModeSwitch == true;
        end
    },
    Armor = {
        Text = "Armor",
        Priority = Enums.IndicatorPriority.Behavior + 0,

        Check = function(p17) -- Line: 100, Name: Check
            return p17.Metadata.Armor == true;
        end
    },
    Projectile = {
        Text = "Projectile",
        Priority = Enums.IndicatorPriority.Behavior + 10,

        Check = function(p18) -- Line: 108, Name: Check
            return p18.Metadata.Projectile == true;
        end
    },
    Beam = {
        Text = "Beam",
        Priority = Enums.IndicatorPriority.Behavior + 10,

        Check = function(p19) -- Line: 116, Name: Check
            return p19.Metadata.Beam == true;
        end
    },
    AreaOfEffect = {
        Text = "AOE",
        Priority = Enums.IndicatorPriority.Behavior + 20,

        Check = function(p20) -- Line: 124, Name: Check
            return p20.Metadata.AreaOfEffect == true;
        end
    },
    CrowdControl = {
        Text = "Crowd Control",
        Priority = Enums.IndicatorPriority.Behavior + 30,

        Check = function(p21) -- Line: 132, Name: Check
            return p21.Metadata.CrowdControl == true;
        end
    },
    Grab = {
        Text = "Grapple",
        Priority = Enums.IndicatorPriority.Behavior + 40,

        Check = function(p22) -- Line: 140, Name: Check
            return p22.Metadata.Grab == true;
        end
    },
    BlockBreak = {
        Text = "Guard Break",
        Priority = Enums.IndicatorPriority.Effect + 0,

        Check = function(p23) -- Line: 148, Name: Check
            return p23.Metadata.BlockBreak == true;
        end
    },
    Ragdoll = {
        Text = "Knockdown",
        Priority = Enums.IndicatorPriority.Effect + 10,

        Check = function(p24) -- Line: 156, Name: Check
            return p24.Metadata.Ragdoll == true;
        end
    },
    ChargeMeter = {
        Text = "Charge Meter",
        Priority = Enums.IndicatorPriority.Effect + 20,

        Check = function(p25) -- Line: 164, Name: Check
            return p25.Metadata.ChargeMeter == true;
        end
    }
};