  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.EnumsModule);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local _ = PathShortcuts.ClientAssets;
local u1 = {
    Moveset = {
        Groups = {
            Universal = {
                Visible = true
            },
            StandOff = {
                Visible = true
            },
            StandOn = {
                Visible = false
            }
        },
        Moves = {
            Q = "QMoves",
            MouseButton1 = "LMBMoves",
            F = "Block",
            C = "Quickstep",
            X = "XMoves",
            One = "WS",
            Two = "CM",
            Three = "MIH",
            Four = "SS",
            E = "EMoves",
            R = "RMoves",
            T = "TMoves",
            Y = "YMoves",
            U = "UMoves",
            G = "GMoves",
            H = "HMoves",
            V = "VMoves",
            B = "BMoves",
            J = "JMoves",
            P = "PMoves"
        }
    },
    Stats = {},
    Animations = require(script.Animations),
    Sounds = require(script.Sounds),
    QuoteInfo = require(script.Quotes),
    Resources = require(script.Resources)
};
local StatsHandler = require(PathShortcuts.ReplicatedModules.StatsHandler);
local u2 = {
    WS = "Whitesnake",
    CM = "C-Moon",
    MIH = "Made In Heaven",
    SS = "Soul Survivor"
};

local function Invoke(p3, p4) -- Line: 155
    -- upvalues: Knit (copy), u1 (copy), PathShortcuts (copy), u2 (copy)
    local Character = p3.Player.Character;
    local v5 = Character:FindFirstChild(p4 .. "_Stand");
    local Input = p3.Input;
    Knit.GetController("MoveInputController");
    local v6 = Knit.GetService("MoveInputService");
    local v7 = Knit.GetController("MoveIndicatorController").GetSingleton();
    v6:FireInput(Input);

    for _, v in pairs(u1.Stats) do
        if v.Indicators then
            for _, v2 in pairs(v.Indicators) do
                if v2.Ability then
                    local v8 = v7:GetMove(v2.Group, v2.Name);

                    if v8 then
                        v8.Visible = v2.Ability == p4;
                    end;
                end;
            end;
        end;
    end;

    v7.VisibilityUpdated:Fire();
    local AnimationHandler = require(PathShortcuts.ReplicatedModules.AnimationHandler);
    local v9 = AnimationHandler.Get(Character.Humanoid.Animator);

    if not v9 then
        return;
    end;

    for _, v in pairs(Character.Humanoid.Animator:GetPlayingAnimationTracks()) do
        v:Stop();
    end;

    v9:StopAllAnimations();
    v9:ClearAnimations();
    local v10 = AnimationHandler.CreateAnimations(u2[p4], v5:GetAttribute("SkinName"));
    local v11 = AnimationHandler.CreateAnimations("DefaultAnims");
    v9:AddAnimations(v10);
    v9:AddAnimations(v11);
    task.defer(function() -- Line: 205
        -- upvalues: Character (copy), AnimationHandler (copy)
        for _, v in pairs(Character.Humanoid.Animator:GetPlayingAnimationTracks()) do
            v:Stop();
        end;

        AnimationHandler.CharacterAnimationObject:OnIdle();
        AnimationHandler.CharacterAnimationObject.Callbacks.UpdateState(AnimationHandler.CharacterAnimationObject.CurrentState);
    end);
end;

u1.Stats.WS = {
    Actionable = {},
    Indicators = { {
            Group = "Universal",
            DisplayName = "Whitesnake",
            InputText = "%s",
            Order = -100,
            Priority = 1,
            Visible = true
        } },

    Invoke = function(p12) -- Line: 226, Name: Invoke
        -- upvalues: Invoke (copy)
        Invoke(p12, "WS");
    end
};
u1.Stats.CM = {
    Actionable = {},
    Indicators = { {
            Group = "Universal",
            DisplayName = "C-Moon",
            InputText = "%s",
            Order = -100,
            Priority = 2,
            Visible = true
        } },

    Invoke = function(p13) -- Line: 243, Name: Invoke
        -- upvalues: Invoke (copy)
        Invoke(p13, "CM");
    end
};
u1.Stats.MIH = {
    Actionable = {},
    Indicators = { {
            Group = "Universal",
            DisplayName = "Made In Heaven",
            InputText = "%s",
            Order = -100,
            Priority = 3,
            Visible = true
        } },

    Invoke = function(p14) -- Line: 260, Name: Invoke
        -- upvalues: Invoke (copy)
        Invoke(p14, "MIH");
    end
};
u1.Stats.SS = {
    Actionable = {},
    Indicators = { {
            Group = "Universal",
            DisplayName = "Soul Survivor",
            InputText = "%s",
            Order = -100,
            Priority = 4,
            Visible = true
        } },

    Invoke = function(p15) -- Line: 277, Name: Invoke
        -- upvalues: Invoke (copy)
        Invoke(p15, "SS");
    end
};
u1.Stats.Block = {
    From = "Combat.Block"
};
u1.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
local v16 = {
    WS = StatsHandler.GetStats("Whitesnake"),
    CM = StatsHandler.GetStats("C-Moon"),
    MIH = StatsHandler.GetStats("Made In Heaven"),
    SS = StatsHandler.GetStats("Soul Survivor")
};

for i, v in pairs({
    LMBMoves = {
        WS = "Rush Attack",
        CM = "Rush Attack",
        MIH = "Rush Attack",
        SS = "Rush Attack"
    },
    QMoves = {
        WS = "Summon",
        CM = "Summon",
        MIH = "Summon"
    },
    EMoves = {
        WS = "EMoves",
        CM = "EMoves",
        MIH = "Accelerated Rushdown / Accelerated Barrage",
        SS = "Thy End Is Now"
    },
    RMoves = {
        WS = "RMoves",
        CM = "RMoves",
        MIH = "Throat Slit / Instant Slice / Heavenly Strike",
        SS = "Uppercut / Overhead"
    },
    TMoves = {
        WS = "TMoves",
        CM = "TMoves",
        MIH = "Knife Throw / Checkmate",
        SS = "Prepare Thyself"
    },
    YMoves = {
        WS = "YMoves",
        CM = "YMoves",
        MIH = "Sanctimonious Counter",
        SS = "Judgement"
    },
    UMoves = {
        WS = "UMoves"
    },
    GMoves = {
        WS = "GMoves",
        CM = "GMoves",
        MIH = "Hand of Destiny / Divine Judgment",
        SS = "Die"
    },
    HMoves = {
        WS = "HMoves",
        CM = "HMoves",
        MIH = "Made In Heaven",
        SS = "Crush"
    },
    JMoves = {
        WS = "JMoves",
        CM = "JMoves",
        MIH = "Prime Numbers"
    },
    VMoves = {
        WS = "Remote Control",
        CM = "Remote Control",
        MIH = "Godly Speed",
        SS = "Useless"
    },
    BMoves = {
        WS = "BMoves",
        CM = "BMoves",
        MIH = "Time Accelerate",
        SS = "WEAK"
    },
    PMoves = {
        WS = "Pose",
        CM = "Pose",
        MIH = "Pose",
        SS = "Pose"
    },
    XMoves = {
        WS = "Grab",
        CM = "Grab",
        MIH = "Grab",
        SS = "Grab"
    }
}) do
    if not u1.Stats[i] then
        u1.Stats[i] = {
            Active = false,
            Indicators = {}
        };
    end;

    local u17 = u1.Stats[i];

    for i2, v2 in pairs(v) do
        local v18 = v16[i2];
        local v19 = v18.Stats[v2];

        if v2:match("/") then
            local v20 = v2:split(" / ");

            for _, v3 in pairs(v20) do
                local v21 = v18.Stats[v3];

                if v21 then
                    u1.Stats[v3] = v21;
                end;
            end;
        end;

        if v19 and v19.Indicators then
            for _, v3 in pairs(v19.Indicators) do
                local v22 = TableUtil.Copy(v3, true);
                v22.Group = v22.Group or "Universal";
                v22.DisplayName = v22.DisplayName or (v22.Name or v2);
                v22.Name = i2 .. "_" .. (v22.Name or v2);
                v22.Visible = i2 == "WS";
                v22.Ability = i2;
                table.insert(u17.Indicators, v22);
            end;

            u17[i2] = v19;
        end;
    end;

    function u17.Invoke(p23) -- Line: 333
        -- upvalues: u17 (copy), Knit (copy)
        local v24 = u17[p23.Player.Character:GetAttribute("CurrentAbility") or "WS"];

        if v24 then
            if v24.Invoke then
                return v24.Invoke(p23);
            end;

            local Input = p23.Input;
            Knit.GetController("MoveInputController");
            Knit.GetService("MoveInputService"):FireInput(Input);
        end;
    end;
end;

return u1;