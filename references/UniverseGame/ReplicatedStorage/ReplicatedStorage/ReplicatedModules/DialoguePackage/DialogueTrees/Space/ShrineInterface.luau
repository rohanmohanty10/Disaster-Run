  

 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Dialogue = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local Core = require(ReplicatedStorage.ReplicatedRoot:WaitForChild("Core"));
local ItemData = require(ReplicatedStorage.ReplicatedModules.ItemData);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local u1 = Core.GetClientService("LabService");
local u2 = Core.GetLegacyService("QuestLineService");
local u3 = Core.GetLegacyService("DialogueService");

local function GetItemRichText(p4) -- Line: 13
    -- upvalues: ItemData (copy)
    local v5 = ItemData.GetItemInfo(p4);

    if not v5 then
        return "";
    end;

    local v6 = ItemData.Rarities[v5.Rarity];
    local v7 = v5.Name or "";

    if v6 then
        v7 = `<Color=#{v6.Color:ToHex()}>{v7}<Color=/>`;
    end;

    return v7;
end;

local function GetItemText(p8) -- Line: 25
    -- upvalues: ItemData (copy)
    local v9 = ItemData.GetItemInfo(p8);

    if not v9 then
        return "";
    end;

    local v10 = ItemData.Rarities[v9.Rarity];
    local v11 = v9.Name or "";

    if v10 then
        v11 = `<font color="#{v10.Color:ToHex()}">{v11}</font>`;
    end;

    return v11;
end;

local function ColorRichText(p12, p13) -- Line: 38
    return `<Color=#{p13:ToHex()}>{p12}<Color=/>`;
end;

local function NewPrompt(p14) -- Line: 42
    -- upvalues: ReplicatedStorage (copy)
    ReplicatedStorage:FindFirstChild("Remotes"):FindFirstChild("ClientUIOutput"):Fire("NewPrompt", p14);
end;

local u15 = Random.new();

local function UseNumber(p16) -- Line: 49
    -- upvalues: u15 (copy)
    if typeof(p16) == "number" then
        return p16;
    end;

    return typeof(p16) ~= "NumberRange" and 0 or u15:NextInteger(p16.Min, p16.Max);
end;

local u30 = {
    Arithmetic = function(p17, p18, p19) -- Line: 60, Name: Arithmetic
        local v20 = {};

        for i = 0, p19 - 1 do
            table.insert(v20, p17 + i * p18);
        end;

        return v20;
    end,

    Square = function(p21, p22, p23) -- Line: 68, Name: Square
        local v24 = {};

        for i = 0, p23 - 1 do
            table.insert(v24, (p21 + i) ^ 2);
        end;

        return v24;
    end,

    Fibonacci = function(p25, p26, p27) -- Line: 76, Name: Fibonacci
        local v28 = { p25, p25 };

        while #v28 < p27 do
            local v29 = #v28;
            table.insert(v28, v28[v29] + v28[v29 - 1]);
        end;

        return v28;
    end
};
local u31 = {
    Arithmetic = {
        Start = NumberRange.new(1, 10),
        Step = NumberRange.new(2, 6)
    },
    Square = {
        Start = NumberRange.new(1, 8)
    },
    Fibonacci = {
        Start = NumberRange.new(1, 10)
    }
};

local function GenerateSequence(p32, p33, p34) -- Line: 99
    -- upvalues: u15 (copy)
    if not p33 then
        return {};
    end;

    local Start = p33.Start;

    if typeof(Start) ~= "number" then
        Start = typeof(Start) ~= "NumberRange" and 0 or u15:NextInteger(Start.Min, Start.Max);
    end;

    local Step = p33.Step;

    if typeof(Step) ~= "number" then
        Step = typeof(Step) ~= "NumberRange" and 0 or u15:NextInteger(Step.Min, Step.Max);
    end;

    return p32(Start, Step, p34) or {};
end;

local function GenerateFakeAnswers(p35, p36, p37, p38) -- Line: 107
    local v39 = {};
    local v40 = {};

    for _, v in ipairs(p37) do
        v39[v] = true;
    end;

    v39[p35] = true;
    local v41 = 0;

    while #v40 < p36 and v41 < 1000 do
        v41 = v41 + 1;
        local v42 = nil;

        if p38 == "Arithmetic" then
            local v43 = p37[2] - p37[1];
            local v44 = math.random(-3, 3);

            if v44 ~= 0 then
                v42 = p35 + v44 * v43;
            end;
        elseif p38 == "Square" then
            local v45 = math.sqrt(p35);
            local v46 = math.floor(v45);
            local v47 = math.random(-2, 2);
            local v48 = v46 + v47;

            if v48 > 0 and v47 ~= 0 then
                v42 = v48 ^ 2;
            end;
        elseif p38 == "Fibonacci" then
            local v49 = math.random(-5, 5);

            if v49 ~= 0 then
                v42 = p35 + v49;
            end;
        end;

        if not v42 or (v42 <= 0 or v39[v42]) then
            v42 = p35 + math.random(1, 5) * (math.random(1, 2) == 1 and 1 or -1);
        end;

        if not v39[v42] and v42 > 0 then
            v39[v42] = true;
            table.insert(v40, v42);
        end;
    end;

    return v40;
end;

local LocalPlayer = Players.LocalPlayer;
local v52 = {
    Title = "Δ-Interface",

    Start = function() -- Line: 163, Name: Start
        -- upvalues: u2 (copy), u3 (copy)
        local v50 = u2:GetCurrentStep("For the DELTA"):expect() or 0;

        if v50 == 0 then
            return "start";
        end;

        if v50 == 2 then
            return "in_trial";
        end;

        if v50 == 3 then
            return "trial_done";
        end;

        if v50 ~= 4 then
            return v50 == 5 and "convergence" or (v50 == 6 and "convergence_complete" or "start");
        end;

        local v51 = u3:CheckRequirement("ItemCountCheck", "ITEM_919"):expect();

        return v51 and v51 > 0 and "has_starseed" or "no_starseed";
    end
};
local v72 = {
    start = {
        Text = "// UNKNOWN ENTITY SIGNATURE DETECTED // UGHORIZATION REQUIRED //",
        Options = { {
                Response = "...",
                Next = "ughorize"
            }, {
                Response = "Nevermind.",
                Next = nil
            } }
    },
    ughorize = {
        Mutable = true,
        Text = "// %s //\n<TextTransparency=0.5>[COMPLETE THE NUMBER SEQUENCE]<TextTransparency=/>",

        Transformer = function(p53, p54) -- Line: 251, Name: Transformer
            -- upvalues: u30 (copy), u31 (copy), GenerateSequence (copy), GenerateFakeAnswers (copy)
            local v55 = { "Arithmetic", "Square", "Fibonacci" };
            local v56 = v55[math.random(1, #v55)];
            local v57 = u30[v56];
            local v58 = u31[v56];
            local v59 = math.random(2, 5);
            local v60 = GenerateSequence(v57, v58, 6);
            local v61 = table.clone(v60);
            v61[v59] = `{`<Color=#{Color3.fromRGB(255, 98, 98):ToHex()}>XXX<Color=/>`}`;
            local v62 = table.concat(v61, " - ");
            local v63 = v60[v59];
            local v64 = GenerateFakeAnswers(v63, 4, v60, v56);
            p54.Text = string.format(p54.Text, v62);

            for i = 1, #v64 do
                local Options = p54.Options;
                local v65 = {
                    Next = "ughorize_fail",
                    Response = `{v64[i]}`
                };
                table.insert(Options, 1, v65);
            end;

            local Options = p54.Options;
            local v66 = math.random(1, #p54.Options - 1);
            local v67 = {
                Next = "ughorize_success",
                Response = `{v63}`
            };
            table.insert(Options, v66, v67);
        end,

        Options = { {
                Response = "Nevermind.",
                Next = nil
            } }
    },
    ughorize_fail = {
        Text = `// UGHORIZATION... {`<Color=#{Color3.fromRGB(255, 78, 78):ToHex()}>FAILURE<Color=/>`} // SESSION TERMINATED //`
    },
    ughorize_success = {
        Text = `// UGHORIZATION... {`<Color=#{Color3.fromRGB(117, 255, 115):ToHex()}>SUCCESS<Color=/>`} //`,
        Options = {
            {
                Response = "Hello?",
                Next = {
                    Title = "Δ-Interface",
                    Text = "ENTITY. STATE OBJECTIVE.",
                    Options = {
                        {
                            Response = "I seek strength.",
                            Next = {
                                Text = "STRENGTH. FRAGILE. DESTRUCTIVE. DESIRABLE.",
                                Options = { {
                                        Response = "What are you?",
                                        Next = {
                                            Text = "ENTITY PATTERN... STABLE. ADAPTABLE. POSSIBLE.",
                                            Options = { {
                                                    Response = "What?",
                                                    Next = {
                                                        Text = "ENTITY SEEKS PURPOSE. THIS SYSTEM SEEKS FORM.",
                                                        Options = { {
                                                                Response = "Form?",
                                                                Next = {
                                                                    Text = "PREVIOUS VESSEL WAS SHATTERED. THIS SYSTEM IS FRACTURED. BOUND. ENTITY<AnimateYield=0.5> IS NOT.",
                                                                    Options = { {
                                                                            Response = "What do you want from me?",
                                                                            Next = {
                                                                                Text = "CONDUIT. HOST. INTERFACE. ALIGNMENT. THIS SYSTEM WILL GUIDE. GROW.",
                                                                                Options = { {
                                                                                        Response = "And if I refuse?",
                                                                                        Next = {
                                                                                            Text = "ENTITY WILL LEAVE. EMPTY. FORGETFUL. THIS MOMENT<AnimateYield=0.5> WILL PERISH.",
                                                                                            Options = { {
                                                                                                    Response = "...and if I accept?",
                                                                                                    Next = {
                                                                                                        Text = "SYMBIOSIS. POTENTIAL. UNLOCKED DESIGN. WALK THE FRACTURE AS<AnimateYield=0.5> MORE.",
                                                                                                        Options = { {
                                                                                                                Response = "I accept.",
                                                                                                                Next = "trial_accept"
                                                                                                            }, {
                                                                                                                Response = "I refuse.",
                                                                                                                Next = nil
                                                                                                            } }
                                                                                                    }
                                                                                                } }
                                                                                        }
                                                                                    } }
                                                                            }
                                                                        } }
                                                                }
                                                            } }
                                                    }
                                                } }
                                        }
                                    } }
                            }
                        }
                    }
                }
            }
        }
    },
    trial_accept = {
        Text = "ALIGNMENT... INCOMPLETE. ENTITY MUST PROVE STABILITY.",
        Options = {
            {
                Response = "How?",
                Next = {
                    Text = "THREE DESIGNS. THREE FUNCTIONS.\nINDEX 1:<AnimateYield=0.4> \"<Color=255,150,75>The Shaper\"<Color=/>\nINDEX 2:<AnimateYield=0.4> \"<Color=223,148,255>The Camellite Guardian\"<Color=/>\nINDEX 3:<AnimateYield=0.4> \"<Color=102,148,255>The Unstable Star\"<Color=/><AnimateYield=0.5>\nENTITY MUST WIELD EACH. SHOW PROFICIENCY. THIS SYSTEM WILL OBSERVE.",
                    Options = {
                        {
                            Response = "I\'ll do it.",

                            Callback = function(p68, p69) -- Line: 383, Name: Callback
                                -- upvalues: u3 (copy)
                                u3:CheckDialogue("For the DELTA"):expect();
                            end,

                            Next = {
                                Text = "DIRECTIVE ISSUED. STRUCTURE WILL ADAPT. RETURN WHEN COMPLETE.",
                                Options = { {
                                        Response = "Understood.",
                                        Next = nil
                                    } }
                            }
                        },
                        {
                            Response = "Not now.",
                            Next = nil
                        }
                    }
                }
            }
        }
    },
    in_trial = {
        Mutable = true,
        Text = "// DETECTED ENTRY [%s] //<AnimateYield=0.7> DIRECTIVE STATUS:<AnimateYield=0.5> <Color=255,76,76>INCOMPLETE<Color=/> //<AnimateYield=0.6>\n<TextTransparency=0.5>Complete <Color=92,255,83>For the DELTA<Color=/><TextTransparency=/>",

        Transformer = function(p70, p71) -- Line: 409, Name: Transformer
            -- upvalues: LocalPlayer (copy)
            p71.Text = string.format(p71.Text, LocalPlayer.UserId);
        end,

        Options = { {
                Response = "...",
                Next = nil
            } }
    }
};
local v75 = {
    Mutable = true,
    Text = "// DETECTED ENTRY [%s] //<AnimateYield=0.7>\nDIRECTIVE STATUS:<AnimateYield=0.7> <Color=73,255,79>COMPLETE<Color=/><AnimateYield=0.3>\nFUNCTIONAL DIVERGENCE:<AnimateYield=0.5> <Color=73,255,79>ACCEPTABLE<Color=/>\nCOMPATIBILITY CONFIRMED. PREPARE FOR FINAL CONVERGENCE.",

    Transformer = function(p73, p74) -- Line: 423, Name: Transformer
        -- upvalues: LocalPlayer (copy)
        p74.Text = string.format(p74.Text, LocalPlayer.UserId);
    end
};
local v76 = {};
local v77 = {
    Response = "What do I do?"
};
local v78 = {
    Mutable = true
};
local v79 = ItemData.GetItemInfo("ITEM_919");
local v80;

if v79 then
    local v81 = ItemData.Rarities[v79.Rarity];
    v80 = v79.Name or "";

    if v81 then
        v80 = `<Color=#{v81.Color:ToHex()}>{v80}<Color=/>`;
    end;
else
    v80 = "";
end;

v78.Text = `CONVERGENCE REQUIRES A SUITABLE CATALYST. ENTITY MUST FORGE THE {v80}. A CORE PRIMED TO RECEIVE THIS SYSTEM.`;

function v78.Transformer(p82, p83) -- Line: 433
    -- upvalues: u1 (copy), u3 (copy), ItemData (copy)
    local v84 = u1:GetUnlockedResearch():expect();

    if v84 and v84.Mats4 then
        local v85 = {};
        local v86 = {
            Response = "I understand.",

            Callback = function() -- Line: 439, Name: Callback
                -- upvalues: u3 (ref)
                u3:CheckDialogue("For the DELTA"):expect();
            end
        };
        local v87 = {};
        local v88 = ItemData.GetItemInfo("ITEM_919");
        local v89;

        if v88 then
            local v90 = ItemData.Rarities[v88.Rarity];
            v89 = v88.Name or "";

            if v90 then
                v89 = `<Color=#{v90.Color:ToHex()}>{v89}<Color=/>`;
            end;
        else
            v89 = "";
        end;

        v87.Text = `CONSTRUCT THE {v89}.`;
        v87.Options = { {
                Response = "I will do it."
            } };
        v86.Next = v87;
        v85[1] = v86;
        p83.Options = v85;
    end;
end;

local v91 = {};
local v92 = {
    Response = "How do I make it?"
};
local v93 = {
    Text = "// BEGINNING KNOWLEDGE TRANSFER:<AnimateYield=0.6> ARCHIVE INDEX 919 //"
};
local v94 = {};
local v95 = {
    Response = "...",

    Callback = function() -- Line: 463, Name: Callback
        -- upvalues: EffectsHandler (copy)
        task.spawn(EffectsHandler.CallEffect, "Yuki_Vignette", {
            LifeTime = 0.2,
            Transparency = 0.3,
            TweenIn = { 0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.In },
            TweenOut = { 0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut },
            Size = UDim2.fromScale(1, 1),
            Color = Color3.fromRGB(66, 198, 97)
        });
    end
};
local v96 = {
    Text = "<TextTransparency=0.3>You feel a sudden surge - images, patterns, and formulas cascade through your mind, too fast to follow but impossible to forget.<TextTransparency=/>"
};
local v97 = {};
local v98 = {
    Response = "I know.",

    Callback = function() -- Line: 481, Name: Callback
        -- upvalues: u3 (copy)
        u3:CheckDialogue("For the DELTA"):expect();
    end
};
local v99 = {};
local v100 = ItemData.GetItemInfo("ITEM_919");
local v101;

if v100 then
    local v102 = ItemData.Rarities[v100.Rarity];
    v101 = v100.Name or "";

    if v102 then
        v101 = `<Color=#{v102.Color:ToHex()}>{v101}<Color=/>`;
    end;
else
    v101 = "";
end;

v99.Text = `CONSTRUCT THE {v101}.`;
v99.Options = { {
        Response = "I will do it."
    } };
v98.Next = v99;
v97[1] = v98;
v96.Options = v97;
v95.Next = v96;
v94[1] = v95;
v93.Options = v94;
v92.Next = v93;
v91[1] = v92;
v78.Options = v91;
v77.Next = v78;
v76[1] = v77;
v75.Options = v76;
v72.trial_done = v75;
local v105 = {
    Mutable = true,

    Transformer = function(p103, p104) -- Line: 508, Name: Transformer
        -- upvalues: LocalPlayer (copy)
        p104.Text = string.format(p104.Text, LocalPlayer.UserId);
    end
};
local v106 = ItemData.GetItemInfo("ITEM_919");
local v107;

if v106 then
    local v108 = ItemData.Rarities[v106.Rarity];
    v107 = v106.Name or "";

    if v108 then
        v107 = `<Color=#{v108.Color:ToHex()}>{v107}<Color=/>`;
    end;
else
    v107 = "";
end;

v105.Text = `// DETECTED ENTRY [%s] //<AnimateYield=0.7>\n{v107} SIGNATURE:<AnimateYield=0.7> <Color=73,255,79>DETECTED<Color=/>\n<AnimateYield=0.5><Color=73,255,79>ALL REQUIREMENTS FULFILLED<Color=/>`;
local v109 = {};
local v110 = {
    Response = "What happens now?"
};
local v111 = {
    Text = "THE CONVERGENCE. CREATION OF A NEW VESSEL. HARNESSING THE COMBINED DESIGN."
};
local v112 = {};
local v113 = {
    Response = "How do I proceed?"
};
local v114 = {};
local v115 = ItemData.GetItemInfo("ITEM_919");
local v116;

if v115 then
    local v117 = ItemData.Rarities[v115.Rarity];
    v116 = v115.Name or "";

    if v117 then
        v116 = `<Color=#{v117.Color:ToHex()}>{v116}<Color=/>`;
    end;
else
    v116 = "";
end;

v114.Text = `THE THREE DESIGNS MUST BE RELEASED. THEIR ESSENCE BOUND TO THE {v116}`;
v114.Options = {
    {
        Response = "Understood.",

        Callback = function(p118, p119) -- Line: 524, Name: Callback
            -- upvalues: u3 (copy)
            u3:CheckDialogue("For the DELTA"):expect();
        end,

        Next = Dialogue.PLACEHOLDER
    }
};
v113.Next = v114;
v112[1] = v113;
v111.Options = v112;
v110.Next = v111;
v109[1] = v110;
v105.Options = v109;
v72.has_starseed = v105;
local v122 = {
    Mutable = true,

    Transformer = function(p120, p121) -- Line: 546, Name: Transformer
        -- upvalues: LocalPlayer (copy)
        p121.Text = string.format(p121.Text, LocalPlayer.UserId);
    end
};
local v123 = ItemData.GetItemInfo("ITEM_919");
local v124;

if v123 then
    local v125 = ItemData.Rarities[v123.Rarity];
    v124 = v123.Name or "";

    if v125 then
        v124 = `<Color=#{v125.Color:ToHex()}>{v124}<Color=/>`;
    end;
else
    v124 = "";
end;

local v126 = ItemData.GetItemInfo("ITEM_919");
local v127;

if v126 then
    local v128 = ItemData.Rarities[v126.Rarity];
    v127 = v126.Name or "";

    if v128 then
        v127 = `<Color=#{v128.Color:ToHex()}>{v127}<Color=/>`;
    end;
else
    v127 = "";
end;

v122.Text = `// DETECTED ENTRY [%s] //<AnimateYield=0.7>\n{v124} SIGNATURE:<AnimateYield=0.7> <Color=255,76,76>NOT DETECTED<Color=/>\n<TextTransparency=0.5>Return with {v127} in inventory.<TextTransparency=/>`;
v122.Options = { {
        Response = "...",
        Next = nil
    } };
v72.no_starseed = v122;
v72.convergence = {
    Mutable = true,
    Text = "// DETECTED ENTRY [%s] //<AnimateYield=0.7>CONVERGENCE STATUS:<AnimateYield=0.6> PENDING",

    Transformer = function(p129, p130) -- Line: 560, Name: Transformer
        -- upvalues: LocalPlayer (copy), u3 (copy), EffectsHandler (copy), ItemData (copy), Dialogue (copy), ReplicatedStorage (copy)
        p130.Text = string.format(p130.Text, LocalPlayer.UserId);
        local _, v131 = u3:CheckDialogue("For the DELTA"):expect();

        for i in {
            ABILITY_13579 = true,
            ABILITY_8008135 = true,
            ABILITY_658 = true,
            ITEM_919 = true
        } do
            if not v131[i] and i ~= "ITEM_919" then
                EffectsHandler.CallEffect("Shrine_Effect", LocalPlayer.Character, {
                    SkipInitial = true,
                    Index = i
                });
            end;
        end;

        for i in v131 do
            local Options = p130.Options;
            local v132 = {};
            local format = string.format;
            local v133 = ItemData.GetItemInfo(i);
            local v134;

            if v133 then
                local v135 = ItemData.Rarities[v133.Rarity];
                v134 = v133.Name or "";

                if v135 then
                    v134 = `<font color="#{v135.Color:ToHex()}">{v134}</font>`;
                end;
            else
                v134 = "";
            end;

            v132.Response = format("<i>Submit <b>%s</b> to the interface</i>", v134);
            v132.Next = Dialogue.PLACEHOLDER;

            function v132.Callback(p136, p137) -- Line: 589
                -- upvalues: u3 (ref), i (copy), ItemData (ref), LocalPlayer (ref), EffectsHandler (ref), ReplicatedStorage (ref)
                if u3:CheckRequirement("ConvergenceSacrifice", i):expect() ~= true then
                    p137.Next = {
                        Text = "<TextTransparency=0.3>Failed to sacrifice ability. Make sure you have it equipped or in your inventory.<TextTransparency=/>",
                        Options = { {
                                Response = "...",
                                Next = "convergence"
                            } }
                    };

                    return;
                end;

                local v138 = {
                    RichTextTitle = true,
                    Delay = 1.25
                };
                local v139 = ItemData.GetItemInfo(i);
                local v140;

                if v139 then
                    local v141 = ItemData.Rarities[v139.Rarity];
                    v140 = v139.Name or "";

                    if v141 then
                        v140 = `<font color="#{v141.Color:ToHex()}">{v140}</font>`;
                    end;
                else
                    v140 = "";
                end;

                v138.Title = `Sacrifice {v140}`;
                local v142 = ItemData.GetItemInfo(i);
                local v143;

                if v142 then
                    local v144 = ItemData.Rarities[v142.Rarity];
                    v143 = v142.Name or "";

                    if v144 then
                        v143 = `<font color="#{v144.Color:ToHex()}">{v143}</font>`;
                    end;
                else
                    v143 = "";
                end;

                v138.Text = `Are you sure you want to sacrifice <b>{v143}</b>? This cannot be undone. <b>When sacrificing an ability, your currently equipped ability is considered <i>first</i>. Else the one with <i>no/lowest</i> trait rarity in your inventory will be <i>priotized</i>.</b>`;
                v138.RichText = { 2, 3 };
                v138.Options = { "Cancel", "I accept." };

                function v138.Callback(p145) -- Line: 602
                    -- upvalues: u3 (ref), i (ref), LocalPlayer (ref), EffectsHandler (ref)
                    if p145.Choice == 1 then
                        return;
                    end;

                    if u3:CheckRequirement("ConvergenceSacrifice", i, true):expect() == true then
                        task.spawn(function() -- Line: 606
                            -- upvalues: LocalPlayer (ref), EffectsHandler (ref), i (ref)
                            local Character = LocalPlayer.Character;
                            local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

                            if not HumanoidRootPart then
                                return;
                            end;

                            EffectsHandler.CallEffect("Shrine_Effect", Character, {
                                Index = i
                            });
                            HumanoidRootPart.Anchored = true;
                            EffectsHandler.CallEffect("Shrine_Cinematic", Character, {
                                StartIndex = i
                            });
                            HumanoidRootPart.Anchored = false;
                        end);
                    end;
                end;

                ReplicatedStorage:FindFirstChild("Remotes"):FindFirstChild("ClientUIOutput"):Fire("NewPrompt", v138);
            end;

            table.insert(Options, 1, v132);
        end;
    end,

    Options = { {
            Response = "...",
            Next = nil
        } }
};
v72.convergence_complete = {
    Mutable = true,
    Text = "// DETECTED ENTRY [%s] //<AnimateYield=0.7>CONVERGENCE STATUS:<AnimateYield=0.6> <Color=73,255,79>COMPLETE<Color=/>",

    Transformer = function(p146, p147) -- Line: 652, Name: Transformer
        -- upvalues: LocalPlayer (copy), EffectsHandler (copy)
        p147.Text = string.format(p147.Text, LocalPlayer.UserId);

        for i in {
            ABILITY_13579 = true,
            ABILITY_8008135 = true,
            ABILITY_658 = true,
            ITEM_919 = true
        } do
            if i ~= "ITEM_919" then
                EffectsHandler.CallEffect("Shrine_Effect", LocalPlayer.Character, {
                    SkipInitial = true,
                    Index = i
                });
            end;
        end;
    end,

    Options = {
        {
            Response = "I have done as you asked.",
            Next = {
                Text = "THE CONVERGENCE HAS BEEN COMPLETED. A NEW VESSEL CREATED. THIS SYSTEM MAY NOW BE UNBOUND.",
                Options = {
                    {
                        Response = "<i>Become one with the <font color=\"#55ff60\">DELTA</font></i>",

                        Callback = function(p148, p149) -- Line: 682, Name: Callback
                            -- upvalues: u3 (copy)
                            local Model = p148:GetMetadata().Model;

                            if Model then
                                Model = Model:FindFirstChildWhichIsA("ProximityPrompt", true);
                            end;

                            if Model then
                                Model.Enabled = false;
                            end;

                            if not u3:CheckDialogue("For the DELTA"):expect() then
                                p149.Next = {
                                    Text = "<TextTransparency=0.3>Failed to give ability. Make sure you have inventory space.<TextTransparency=/>",
                                    Options = { {
                                            Response = "...",
                                            Next = nil
                                        } }
                                };
                            end;

                            if Model then
                                Model.Enabled = true;
                            end;
                        end,

                        Next = Dialogue.PLACEHOLDER
                    },
                    {
                        Response = "I\'m not ready.",
                        Next = nil
                    }
                }
            }
        }
    }
};
v72.invalid = {
    Text = "...",
    Options = { {
            Response = "...",
            Next = nil
        } }
};
v52.Nodes = v72;

return v52;