  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Dialogue = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local u1 = require(ReplicatedStorage.ReplicatedRoot:WaitForChild("Core")).GetClientService("LabService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Sequence_V3 = require(ReplicatedStorage.ReplicatedModules.Classes.Sequence_V3);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local u2 = Knit.GetService("DialogueService");
local ItemData = require(ReplicatedStorage.ReplicatedModules.ItemData);

local function GetItemText(p3) -- Line: 17
    -- upvalues: ItemData (copy)
    local v4 = ItemData.GetItemInfo(p3);

    if not v4 then
        return "";
    end;

    local v5 = ItemData.Rarities[v4.Rarity];
    local v6 = v4.Name or "";

    if v5 then
        v6 = `<font color="#{v5.Color:ToHex()}">{v6}</font>`;
    end;

    return v6;
end;

local function GetItemRichText(p7, p8) -- Line: 30
    -- upvalues: ItemData (copy)
    local v9 = ItemData.GetItemInfo(p7);

    if not v9 then
        return "";
    end;

    local v10 = ItemData.Rarities[v9.Rarity];
    local v11 = v9.Name or "";

    if v10 then
        v11 = `<Color=#{v10.Color:ToHex()}>{p8 and p8 .. " " or " "}{v11}<Color=/>`;
    end;

    return v11;
end;

local v12 = {
    Resisted = { "PLANET // SHAPER", "Gryphon", "Killua", "Cid Kagenou", "Soft & Wet", "Whitesnake", "Gold Experience", "The Vessel", "Xeno", "Ope", "Umbra", "Reaper", "Shinigami", "Dawn", "Anshen", "King of Curses", "The Strongest", "Wonder Of U", "The World: Over Heaven", "Candy Cutlass", "Hito Model: Nika", "The Mercenaries", "Tusk", "D4C: Love Train / D4C", "Locke", "Dragon Knight", "Conjurer" },
    Effective = { "Standless", "Casey" }
};

local function FormatAbilityList(p13, p14) -- Line: 82
    local v15 = p14 or "and";

    if #p13 == 1 then
        return p13[1];
    end;

    if #p13 == 2 then
        return p13[1] .. " " .. v15 .. " " .. p13[2];
    end;

    local v16 = "";

    for i = 1, #p13 - 1 do
        v16 = v16 .. p13[i] .. ", ";
    end;

    return v16 .. v15 .. " " .. p13[#p13];
end;

local v17 = {
    Title = "???",

    Start = function() -- Line: 99, Name: Start
        -- upvalues: u1 (copy)
        return u1:HasTalkedToLabNPC("Mingo"):expect() and "TalkedStart" or "FreshStart";
    end
};
local v18 = {
    FreshStart = {
        Mutable = true,
        Text = "... A visitor. It has been long since someone crossed into this realm.",
        Options = { {
                Response = "Who are you? Where am I?",
                Next = "Introduction"
            } }
    }
};
local v19 = {
    Mutable = true,
    Title = "Mingo, Sun\'s Contempt"
};
local v20 = ItemData.GetItemInfo("ITEM_912");
local v21;

if v20 then
    local v22 = ItemData.Rarities[v20.Rarity];
    v21 = v20.Name or "";

    if v22 then
        v21 = `<Color=#{v22.Color:ToHex()}> {v21}<Color=/>`;
    end;
else
    v21 = "";
end;

v19.Text = `I am Mingo, once known as Sun's Contempt in the Previous Universe. You have crossed into the realm between time and space due to your teleportation incident with the {v21}.`;

function v19.Transformer(p23, p24) -- Line: 125
    if p24.Options[1] then
        p24.Options[1].Response = string.format(p24.Options[1].Response, game:GetService("Players").LocalPlayer.Name);
    end;
end;

v19.Options = {
    {
        Response = "My name is %s. I have questions about this place.",
        Next = "QuestionHub",

        Callback = function(p25, p26) -- Line: 134, Name: Callback
            -- upvalues: u1 (copy)
            u1:SetTalkedToLabNPC("Mingo");
        end
    }
};
v18.Introduction = v19;
local v29 = {
    Mutable = true,
    Title = "Mingo, Sun\'s Contempt",
    Text = "Ask what you will, %s. Knowledge is the foundation of power, and you will need both for what lies ahead.",

    Transformer = function(p27, p28) -- Line: 145, Name: Transformer
        p28.Text = string.format(p28.Text, game:GetService("Players").LocalPlayer.Name);
    end
};
local v30 = {};
local v31 = {
    Response = "Where exactly are we?",
    Next = "LocationExplain"
};
local v32 = {
    Next = "CatalystExplanation"
};
local v33 = ItemData.GetItemInfo("ITEM_912");
local v34;

if v33 then
    local v35 = ItemData.Rarities[v33.Rarity];
    v34 = v33.Name or "";

    if v35 then
        v34 = `<font color="#{v35.Color:ToHex()}">{v34}</font>`;
    end;
else
    v34 = "";
end;

v32.Response = `What is this {v34} you mentioned?`;
v30[1], v30[2], v30[3], v30[4], v30[5], v30[6], v30[7] = v31, v32, {
    Response = "Tell me about the previous universe.",
    Next = "UniverseHistory"
}, {
    Response = "Why are you here?",
    Next = "MingoReason"
}, {
    Response = "How can I get stronger?",
    Next = "StrengthPath"
}, {
    Response = "Can you help me?",
    Next = "HelpOffer"
}, {
    Response = "I\'m ready to face my previous self.",
    Next = "AcceptChallenge"
};
v29.Options = v30;
v18.QuestionHub = v29;
local v36 = {
    Title = "Mingo, Sun\'s Contempt"
};
local v37 = ItemData.GetItemInfo("ITEM_912");
local v38;

if v37 then
    local v39 = ItemData.Rarities[v37.Rarity];
    v38 = v37.Name or "";

    if v39 then
        v38 = `<Color=#{v39.Color:ToHex()}> {v38}<Color=/>`;
    end;
else
    v38 = "";
end;

v36.Text = `This is the boundary realm between time and space. Your {v38}-induced teleportation tore through reality and deposited you here temporarily. You are not trapped as I am - you can return to your world.`;
v36.Options = { {
        Response = "Why are you trapped here?",
        Next = "TrappedExplain"
    }, {
        Response = "How do I get back?",
        Next = "ReturnPath"
    }, {
        Response = "Ask something else.",
        Next = "QuestionHub"
    } };
v18.LocationExplain = v36;
v18.TrappedExplain = {
    Title = "Mingo, Sun\'s Contempt",
    Text = "I originate from the Previous Universe. When it collapsed, I survived by anchoring myself to this boundary realm. I cannot leave, as I have no universe to return to. This is my eternal vigil.",
    Options = { {
            Response = "That sounds lonely.",
            Next = "LonelyResponse"
        }, {
            Response = "How long have you been here?",
            Next = "TimeSpent"
        }, {
            Response = "Ask something else.",
            Next = "QuestionHub"
        } }
};
local v40 = {
    Title = "Mingo, Sun\'s Contempt"
};
local v41 = ItemData.GetItemInfo("ITEM_912");
local v42;

if v41 then
    local v43 = ItemData.Rarities[v41.Rarity];
    v42 = v41.Name or "";

    if v43 then
        v42 = `<Color=#{v43.Color:ToHex()}> {v42}<Color=/>`;
    end;
else
    v42 = "";
end;

v40.Text = `The {v42} will naturally pull you back once its energy stabilizes. This only happens after you defeat your previous self.`;
v40.Options = { {
        Response = "Tell me about my previous self.",
        Next = "PreviousSelfInfo"
    }, {
        Response = "Ask something else.",
        Next = "QuestionHub"
    } };
v18.ReturnPath = v40;
v18.LonelyResponse = {
    Title = "Mingo, Sun\'s Contempt",
    Text = "Perhaps. But solitude brings wisdom, and I have learned much in my time here. Including how to help those like yourself reach new heights.",
    Options = { {
            Response = "Ask something else.",
            Next = "QuestionHub"
        } }
};
v18.TimeSpent = {
    Title = "Mingo, Sun\'s Contempt",
    Text = "Eons beyond counting. Time flows differently here. But your arrival brings purpose to my existence once more - a chance to guide another toward ascension.",
    Options = { {
            Response = "Ask something else.",
            Next = "QuestionHub"
        } }
};
local v44 = {
    Title = "Mingo, Sun\'s Contempt"
};
local v45 = ItemData.GetItemInfo("ITEM_912");
local v46;

if v45 then
    local v47 = ItemData.Rarities[v45.Rarity];
    v46 = v45.Name or "";

    if v47 then
        v46 = `<Color=#{v47.Color:ToHex()}> {v46}<Color=/>`;
    end;
else
    v46 = "";
end;

v44.Text = `The {v46} is a fragment of pure creation energy from the universe. It caused your teleportation incident and brought you here, but more importantly, it can be used to manifest powerful adversaries.`;
v44.Options = { {
        Response = "What kind of adversaries?",
        Next = "AdversaryExplain"
    }, {
        Response = "How does it grant potential?",
        Next = "PotentialExplain"
    }, {
        Response = "Ask something else.",
        Next = "QuestionHub"
    } };
v18.CatalystExplanation = v44;
v18.SoulExplain = {
    Title = "Mingo, Sun\'s Contempt",
    Text = "Your fighting soul is the manifestation of your inner power. \'Made In Heaven\' is its current form, but with the right catalyst, it can evolve beyond its present limitations.",
    Options = { {
            Response = "How can it evolve?",
            Next = "EvolutionMethod"
        }, {
            Response = "Ask something else.",
            Next = "QuestionHub"
        } }
};
local v48 = {
    Title = "Mingo, Sun\'s Contempt"
};
local v49 = ItemData.GetItemInfo("ITEM_912");
local v50;

if v49 then
    local v51 = ItemData.Rarities[v49.Rarity];
    v50 = v49.Name or "";

    if v51 then
        v50 = `<Color=#{v51.Color:ToHex()}> {v50}<Color=/>`;
    end;
else
    v50 = "";
end;

v48.Text = `I can use the {v50} to summon your Previous Universe equivalent - a version of yourself that achieved greater power before the collapse.`;
v48.Options = { {
        Response = "What would I gain from fighting them?",
        Next = "BattleRewards"
    }, {
        Response = "Ask something else.",
        Next = "QuestionHub"
    } };
v18.AdversaryExplain = v48;
local v52 = {
    Title = "Mingo, Sun\'s Contempt"
};
local v53 = ItemData.GetItemInfo("ITEM_912");
local v54;

if v53 then
    local v55 = ItemData.Rarities[v53.Rarity];
    v54 = v53.Name or "";

    if v55 then
        v54 = `<Color=#{v55.Color:ToHex()}> {v54}<Color=/>`;
    end;
else
    v54 = "";
end;

v52.Text = `The {v54} can manifest powerful opponents. Defeating them yields special items that can enhance your abilities, particularly your Stand if you possess one.`;
v52.Options = { {
        Response = "What kind of items?",
        Next = "ItemExplain"
    }, {
        Response = "Ask something else.",
        Next = "QuestionHub"
    } };
v18.PotentialExplain = v52;
v18.UniverseHistory = {
    Title = "Mingo, Sun\'s Contempt",
    Text = "My universe was a realm of immense power and knowledge. Its inhabitants reached heights your current reality cannot imagine. Then came the collapse that destroyed everything.",
    Options = { {
            Response = "What caused the collapse?",
            Next = "CollapseReason"
        }, {
            Response = "Were you powerful in your universe?",
            Next = "PastPower"
        }, {
            Response = "Ask something else.",
            Next = "QuestionHub"
        } }
};
v18.CollapseReason = {
    Title = "Mingo, Sun\'s Contempt",
    Text = "The fundamental forces became unstable. Reality itself unraveled when the cosmic balance was disrupted. I was among the few who saw it coming and prepared accordingly.",
    Options = { {
            Response = "Could my universe face the same fate?",
            Next = "UniverseWarning"
        }, {
            Response = "Ask something else.",
            Next = "QuestionHub"
        } }
};
v18.PastPower = {
    Title = "Mingo, Sun\'s Contempt",
    Text = "I was considerably strong in my universe, thus the reason for my survival. \'Sun\'s Contempt\' was a title earned through countless trials. That knowledge and experience remain with me.",
    Options = { {
            Response = "Ask something else.",
            Next = "QuestionHub"
        } }
};
v18.UniverseWarning = {
    Title = "Mingo, Sun\'s Contempt",
    Text = "Potentially. But stronger individuals can help maintain the cosmic balance. This is why I\'m willing to help you grow - power used wisely serves a greater purpose.",
    Options = { {
            Response = "Ask something else.",
            Next = "QuestionHub"
        } }
};
v18.MingoReason = {
    Title = "Mingo, Sun\'s Contempt",
    Text = "I am bound to this place by necessity, not choice. When the Previous Universe collapsed, I anchored myself here to survive. Now I exist in this boundary realm, and from this exile, I guide those who seek knowledge from beyond their reality.",
    Options = { {
            Response = "Ask something else.",
            Next = "QuestionHub"
        } }
};
v18.StrengthPath = {
    Title = "Mingo, Sun\'s Contempt",
    Text = "True strength comes from overcoming your greatest challenge - yourself. I can summon your Previous Universe equivalent, a version of you that achieved greater power before the collapse.",
    Options = { {
            Response = "Fight myself? How would that help?",
            Next = "SelfBattleExplain"
        }, {
            Response = "What would I gain from winning?",
            Next = "VictoryRewards"
        }, {
            Response = "Ask something else.",
            Next = "QuestionHub"
        } }
};
v18.HelpOffer = {
    Title = "Mingo, Sun\'s Contempt",
    Text = "Indeed. I can provide you with an opportunity for growth that exists nowhere else - the chance to face and overcome your previous universe self, claiming their power as your own.",
    Options = { {
            Response = "Tell me more about this opportunity.",
            Next = "OpportunityDetails"
        }, {
            Response = "What do you get out of helping me?",
            Next = "MingoMotivation"
        }, {
            Response = "Ask something else.",
            Next = "QuestionHub"
        } }
};
v18.SelfBattleExplain = {
    Title = "Mingo, Sun\'s Contempt",
    Text = "By defeating a version of yourself that achieved greater heights, you prove your superiority and claim their power. It\'s the ultimate test of growth and determination.",
    Options = { {
            Response = "What happens if I lose?",
            Next = "DefeatConsequences"
        }, {
            Response = "How strong is my previous self?",
            Next = "PreviousSelfPower"
        }, {
            Response = "Ask something else.",
            Next = "QuestionHub"
        } }
};
local v56 = {
    Title = "Mingo, Sun\'s Contempt"
};
local v57 = ItemData.GetItemInfo("ITEM_921");
local v58;

if v57 then
    local v59 = ItemData.Rarities[v57.Rarity];
    v58 = v57.Name or "";

    if v59 then
        v58 = `<Color=#{v59.Color:ToHex()}> {v58}<Color=/>`;
    end;
else
    v58 = "";
end;

v56.Text = `Victory against yourself will cause them to drop a {v58}. If you possess the Stand 'Made In Heaven', you can use this fragment to evolve it beyond its current limitations.`;
local v60 = {};
local v61 = {
    Next = "FragmentDetails"
};
local v62 = ItemData.GetItemInfo("ITEM_921");
local v63;

if v62 then
    local v64 = ItemData.Rarities[v62.Rarity];
    v63 = v62.Name or "";

    if v64 then
        v63 = `<font color="#{v64.Color:ToHex()}">{v63}</font>`;
    end;
else
    v63 = "";
end;

v61.Response = `{v63}? Tell me more.`;
v60[1], v60[2] = v61, {
    Response = "Ask something else.",
    Next = "QuestionHub"
};
v56.Options = v60;
v18.VictoryRewards = v56;
local v65 = {
    Title = "Mingo, Sun\'s Contempt"
};
local v66 = ItemData.GetItemInfo("ITEM_921");
local v67;

if v66 then
    local v68 = ItemData.Rarities[v66.Rarity];
    v67 = v66.Name or "";

    if v68 then
        v67 = `<Color=#{v68.Color:ToHex()}> {v67}<Color=/>`;
    end;
else
    v67 = "";
end;

v65.Text = `I will summon your Previous Universe self - they will manifest with all their power and knowledge. Defeat them to claim their {v67} and ascend your fighting soul.`;
v65.Options = { {
        Response = "What are their strengths and weaknesses?",
        Next = "CombatAnalysis"
    }, {
        Response = "Ask something else.",
        Next = "QuestionHub"
    } };
v18.OpportunityDetails = v65;
v18.MingoMotivation = {
    Title = "Mingo, Sun\'s Contempt",
    Text = "Helping worthy souls grow stronger serves the cosmic balance. Your growth benefits your universe. Besides, witnessing such evolution brings purpose to my eternal vigil.",
    Options = { {
            Response = "Ask something else.",
            Next = "QuestionHub"
        } }
};
local v69 = {
    Title = "Mingo, Sun\'s Contempt"
};
local v70 = ItemData.GetItemInfo("ITEM_921");
local v71;

if v70 then
    local v72 = ItemData.Rarities[v70.Rarity];
    v71 = v70.Name or "";

    if v72 then
        v71 = `<Color=#{v72.Color:ToHex()}> {v71}<Color=/>`;
    end;
else
    v71 = "";
end;

v69.Text = `Defeating your previous self proves your growth and grants their power. More importantly, they will drop a {v71} - an item specifically useful for enhancing the Made In Heaven Stand.`;
v69.Options = { {
        Response = "Tell me about this fragment.",
        Next = "FragmentDetails"
    }, {
        Response = "Ask something else.",
        Next = "QuestionHub"
    } };
v18.BattleRewards = v69;
local v73 = {
    Title = "Mingo, Sun\'s Contempt"
};
local v74 = ItemData.GetItemInfo("ITEM_921");
local v75;

if v74 then
    local v76 = ItemData.Rarities[v74.Rarity];
    v75 = v74.Name or "";

    if v76 then
        v75 = `<Color=#{v76.Color:ToHex()}> {v75}<Color=/>`;
    end;
else
    v75 = "";
end;

v73.Text = `The {v75} - a crystallized piece of ascension energy that specifically resonates with certain Stand. If you have Made In Heaven, this fragment can evolve it to new heights.`;
v73.Options = { {
        Response = "How does the evolution work?",
        Next = "EvolutionProcess"
    }, {
        Response = "Ask something else.",
        Next = "QuestionHub"
    } };
v18.ItemExplain = v73;
local v77 = {
    Title = "Mingo, Sun\'s Contempt"
};
local v78 = ItemData.GetItemInfo("ITEM_921");
local v79;

if v78 then
    local v80 = ItemData.Rarities[v78.Rarity];
    v79 = v78.Name or "";

    if v80 then
        v79 = `<Color=#{v80.Color:ToHex()}> {v79}<Color=/>`;
    end;
else
    v79 = "";
end;

v77.Text = `The {v79} appears as a glowing crystalline shard. It contains concentrated evolution energy from the Previous Universe, specifically attuned to enhance the Made In Heaven Stand.`;
local v81 = {};
local v82 = {
    Next = "ItemExplain"
};
local v83 = ItemData.GetItemInfo("ITEM_921");
local v84;

if v83 then
    local v85 = ItemData.Rarities[v83.Rarity];
    v84 = v83.Name or "";

    if v85 then
        v84 = `<font color="#{v85.Color:ToHex()}">{v84}</font>`;
    end;
else
    v84 = "";
end;

v82.Response = `What is {v84}?`;
v81[1], v81[2], v81[3] = v82, {
    Response = "How do I apply it to Made In Heaven?",
    Next = "ApplicationMethod"
}, {
    Response = "Ask something else.",
    Next = "QuestionHub"
};
v77.Options = v81;
v18.ItemDetails = v77;
v18.PreviousSelfInfo = {
    Title = "Mingo, Sun\'s Contempt",
    Text = "Your previous self achieved mastery before the collapse. They are formidable, but not invincible. Understanding their combat patterns will be crucial to your victory.",
    Options = { {
            Response = "What should I know about fighting them?",
            Next = "CombatStrategy"
        }, {
            Response = "Ask something else.",
            Next = "QuestionHub"
        } }
};
v18.DefeatConsequences = {
    Title = "Mingo, Sun\'s Contempt",
    Text = "If you fall, the manifestation will fade as it requires your life force to maintain coherence. You would return to your world unchanged, but the opportunity for ascension would be lost.",
    Options = { {
            Response = "So they disappear if I lose?",
            Next = "DespawnConfirm"
        }, {
            Response = "Ask something else.",
            Next = "QuestionHub"
        } }
};
v18.PreviousSelfPower = {
    Title = "Mingo, Sun\'s Contempt",
    Text = "They possess the culmination of power you could have achieved in the Previous Universe. Stronger than your current self, but your potential remains equal to theirs.",
    Options = { {
            Response = "Any tactical advice?",
            Next = "TacticalAdvice"
        }, {
            Response = "Ask something else.",
            Next = "QuestionHub"
        } }
};
local v86 = {
    Title = "Mingo, Sun\'s Contempt"
};
local v87 = ItemData.GetItemInfo("ITEM_921");
local v88;

if v87 then
    local v89 = ItemData.Rarities[v87.Rarity];
    v88 = v87.Name or "";

    if v89 then
        v88 = `<Color=#{v89.Color:ToHex()}> {v88}<Color=/>`;
    end;
else
    v88 = "";
end;

v86.Text = `The {v88} contains concentrated ascension energy from the Previous Universe. It appears as a glowing crystalline shard that specifically enhances the Made In Heaven Stand when applied.`;
v86.Options = { {
        Response = "How do I apply it to Made In Heaven?",
        Next = "ApplicationMethod"
    }, {
        Response = "Ask something else.",
        Next = "QuestionHub"
    } };
v18.FragmentDetails = v86;
v18.EvolutionProcess = {
    Title = "Mingo, Sun\'s Contempt",
    Text = "The fragment contains evolution data specifically for Made In Heaven. When applied, it unlocks new abilities and power levels that transcend the Stand\'s current limitations.",
    Options = { {
            Response = "Ask something else.",
            Next = "QuestionHub"
        } }
};
v18.CombatAnalysis = {
    Title = "Mingo, Sun\'s Contempt",
    Text = "Your previous self maintains the resistances of advanced souls - highly resistant to " .. FormatAbilityList(v12.Resisted) .. " abilities. However, they are vulnerable to " .. FormatAbilityList(v12.Effective) .. " specifically. Your Trait and Stats (including soul stats) will be disabled.",
    Options = {
        {
            Next = "StandlessWeakness",
            Response = "Why are they weak to " .. FormatAbilityList(v12.Effective) .. "?"
        },
        {
            Response = "Ask something else.",
            Next = "QuestionHub"
        }
    }
};
v18.CombatStrategy = {
    Title = "Mingo, Sun\'s Contempt",
    Text = "They fight as you would, but with greater experience. Study your own patterns and adapt. Remember - they are highly resistant to most advanced abilities but vulnerable to pure fighting abilities.",
    Options = { {
            Response = "Tell me about their resistances.",
            Next = "ResistanceDetails"
        }, {
            Response = "Ask something else.",
            Next = "QuestionHub"
        } }
};
local v90 = {
    Title = "Mingo, Sun\'s Contempt"
};
local v91 = ItemData.GetItemInfo("ITEM_912");
local v92;

if v91 then
    local v93 = ItemData.Rarities[v91.Rarity];
    v92 = v91.Name or "";

    if v93 then
        v92 = `<Color=#{v93.Color:ToHex()}> {v92}<Color=/>`;
    end;
else
    v92 = "";
end;

v90.Text = `Correct. The manifestation draws from your life energy through the {v92}. Without your continued existence, they cannot maintain form and return to the void.`;
v90.Options = { {
        Response = "Ask something else.",
        Next = "QuestionHub"
    } };
v18.DespawnConfirm = v90;
v18.TacticalAdvice = {
    Title = "Mingo, Sun\'s Contempt",
    Text = "Focus on " .. FormatAbilityList(v12.Effective) .. " if you are struggling - it is your greatest advantage. Avoid relying on " .. FormatAbilityList(v12.Resisted, "or") .. " abilities as they will be largely ineffective.",
    Options = {
        {
            Next = "StandlessAdvantage",
            Response = "Why is " .. FormatAbilityList(v12.Effective) .. " so effective?"
        },
        {
            Response = "Ask something else.",
            Next = "QuestionHub"
        }
    }
};
v18.ApplicationMethod = {
    Title = "Mingo, Sun\'s Contempt",
    Text = "The fragment will recognize the Made In Heaven Stand and merge with it upon contact. The evolution process is instantaneous and will unlock new abilities and greater power.",
    Options = { {
            Response = "Ask something else.",
            Next = "QuestionHub"
        } }
};
v18.StandlessWeakness = {
    Title = "Mingo, Sun\'s Contempt",
    Text = "Advanced souls in the Previous Universe were so specialized in complex abilities that they neglected pure combat fundamentals. Raw fighting abilities bypass their sophisticated defenses.",
    Options = { {
            Response = "Ask something else.",
            Next = "QuestionHub"
        } }
};
v18.ResistanceDetails = {
    Title = "Mingo, Sun\'s Contempt",
    Text = "They possess significant resistance to " .. FormatAbilityList(v12.Resisted) .. " abilities - your attacks in these categories will be greatly diminished in effectiveness. And your Trait and Stats (including soul stats) will be disabled.",
    Options = { {
            Response = "Ask something else.",
            Next = "QuestionHub"
        } }
};
v18.StandlessAdvantage = {
    Title = "Mingo, Sun\'s Contempt",
    Text = "Pure fighting skill was considered primitive in the Previous Universe, so their defenses were never optimized against it. Standless will deal significantly more damage due to this.",
    Options = { {
            Response = "Ask something else.",
            Next = "QuestionHub"
        } }
};
local v94 = {
    Title = "Mingo, Sun\'s Contempt",
    Mutable = true
};
local v95 = ItemData.GetItemInfo("ITEM_912");
local v96;

if v95 then
    local v97 = ItemData.Rarities[v95.Rarity];
    v96 = v95.Name or "";

    if v97 then
        v96 = `<Color=#{v97.Color:ToHex()}> {v96}<Color=/>`;
    end;
else
    v96 = "";
end;

local v98 = ItemData.GetItemInfo("ITEM_921");
local v99;

if v98 then
    local v100 = ItemData.Rarities[v98.Rarity];
    v99 = v98.Name or "";

    if v100 then
        v99 = `<Color=#{v100.Color:ToHex()}> {v99}<Color=/>`;
    end;
else
    v99 = "";
end;

v94.Text = `Excellent. I will use the {v96} to manifest your Previous Universe equivalent. Defeat them to claim their {v99} and evolve your abilities.`;

function v94.Transformer(p101, p102) -- Line: 709
    -- upvalues: u2 (copy), ItemData (copy)
    local v103 = u2:CheckRequirement("ItemCountCheck", "ITEM_912"):expect();
    local v104;

    if typeof(v103) == "number" then
        v104 = v103 > 0;
    else
        v104 = false;
    end;

    if not v104 then
        local v105 = ItemData.GetItemInfo("ITEM_912");
        local v106;

        if v105 then
            local v107 = ItemData.Rarities[v105.Rarity];
            v106 = v105.Name or "";

            if v107 then
                v106 = `<Color=#{v107.Color:ToHex()}> {v106}<Color=/>`;
            end;
        else
            v106 = "";
        end;

        local v108 = ItemData.GetItemInfo("ITEM_912");
        local v109;

        if v108 then
            local v110 = ItemData.Rarities[v108.Rarity];
            v109 = v108.Name or "";

            if v110 then
                v109 = `<Color=#{v110.Color:ToHex()}> {v109}<Color=/>`;
            end;
        else
            v109 = "";
        end;

        p102.Text = `I require a {v106} to manifest your Previous Universe equivalent. Without it, the manifestation cannot be completed. Seek out this {v109} and return to me.`;
        p102.Options = { {
                Response = "I\'ll return when I have it.",
                Next = nil
            } };
    end;

    return p102;
end;

local v111 = {};
local v129 = {
    Response = "I\'m ready. Summon them.",

    Callback = function(u112, p113) -- Line: 728, Name: Callback
        -- upvalues: Trove (copy), Sequence_V3 (copy), EffectsHandler (copy), u2 (copy)
        p113.Next = nil;
        task.spawn(function() -- Line: 730
            -- upvalues: u112 (copy), Trove (ref), Sequence_V3 (ref), EffectsHandler (ref), u2 (ref)
            local Model = u112.Metadata.Model;
            local Humanoid = Model.Humanoid;
            local u114 = Trove.new();
            local u115 = u114:Construct(Instance, "Animation");
            u115.Name = "Snap";
            u115.AnimationId = "rbxassetid://127930561944460";
            u115.Parent = Model;
            local u116 = u114:Construct(Instance, "Sound");
            u116.Name = "Snap";
            u116.SoundId = "rbxassetid://83778057013661";
            u116.Volume = 3.5;
            u116.Parent = Model;
            local v128 = Sequence_V3.new({
                Speed = 1,

                Validate = function() -- Line: 747, Name: Validate
                    -- upvalues: Model (copy)
                    local v117 = Model and Model:IsDescendantOf(workspace);

                    return v117;
                end,

                Frames = {
                    { 0, function(p118, p119) -- Line: 751
                            -- upvalues: Humanoid (copy), u115 (copy), u116 (copy), Model (copy), u114 (copy)
                            Humanoid:LoadAnimation(u115):Play(0, 10, p118:GetSpeed());
                            u116:Play();

                            for _, descendant in Model:GetDescendants() do
                                if descendant:IsA("ProximityPrompt") then
                                    descendant:Destroy();
                                end;
                            end;

                            u114:Add(function() -- Line: 762
                                -- upvalues: Model (ref)
                                Model:Destroy();
                            end);
                        end },
                    { 95, function(p120, p121) -- Line: 767
                            -- upvalues: EffectsHandler (ref), Model (copy)
                            EffectsHandler.CallEffect("Emit Particle V3", {
                                RawPath = true,
                                IgnoreData = true,
                                AutoSerialize = true,
                                Path = "Abilities/NUCLEAR-STAR/Misc/FingerSnap",
                                AttachTo = {
                                    Part = Model["Left Arm"],
                                    Offset = CFrame.new(0, 1, -0.3)
                                },
                                Character = Model
                            });
                        end },
                    { 190, function(p122, p123) -- Line: 778
                            -- upvalues: EffectsHandler (ref), Model (copy)
                            local v124 = p122:GetSpeed();
                            EffectsHandler.CallEffect("Emit Particle V3", {
                                RawPath = true,
                                IgnoreData = true,
                                AutoSerialize = true,
                                Path = "Abilities/NUCLEAR-STAR/Misc/Disappear",
                                AttachTo = {
                                    Part = Model.Torso,
                                    Offset = CFrame.identity
                                },
                                Character = Model
                            });
                            EffectsHandler.CallEffect("SK_VANISH", {
                                Transparency = 1,
                                Character = Model,
                                TweenInfo = { (213 - p123) / 60 / v124, Enum.EasingStyle.Linear, Enum.EasingDirection.In }
                            });
                        end },
                    { 220, function(p125, p126) -- Line: 800
                            -- upvalues: u2 (ref)
                            u2:CheckDialogue(script.Name):expect();
                        end },
                    { 300, function(p127) -- Line: 804
                        end }
                }
            });
            u114:Add(v128);
            v128:Play();

            while v128:IsPlaying() do
                task.wait(0.1);
            end;

            v128:Destroy();
            u114:Destroy();
        end);
    end,

    Next = Dialogue.PLACEHOLDER
};
local v130 = {
    Response = "I need more time to prepare."
};
local v131 = {};
local v132 = ItemData.GetItemInfo("ITEM_912");
local v133;

if v132 then
    local v134 = ItemData.Rarities[v132.Rarity];
    v133 = v132.Name or "";

    if v134 then
        v133 = `<Color=#{v134.Color:ToHex()}> {v133}<Color=/>`;
    end;
else
    v133 = "";
end;

v131.Text = `The {v133} will remain dormant until you are truly ready for this confrontation.`;
v130.Next = v131;
v111[1], v111[2] = v129, v130;
v94.Options = v111;
v18.AcceptChallenge = v94;
local v135 = {
    Title = "Mingo, Sun\'s Contempt"
};
local v136 = ItemData.GetItemInfo("ITEM_921");
local v137;

if v136 then
    local v138 = ItemData.Rarities[v136.Rarity];
    v137 = v136.Name or "";

    if v138 then
        v137 = `<Color=#{v138.Color:ToHex()}> {v137}<Color=/>`;
    end;
else
    v137 = "";
end;

v135.Text = `You have returned. Are you ready to face your previous self and claim the {v137}, or do you wish to ask more questions?`;
v135.Options = { {
        Response = "I\'m ready to face my previous self.",
        Next = "AcceptChallenge"
    }, {
        Response = "I have more questions.",
        Next = "QuestionHub"
    }, {
        Response = "Not yet.",
        Next = nil
    } };
v18.TalkedStart = v135;
v18.invalid = {
    Text = "...",
    Options = { {
            Response = "...",
            Next = nil
        } }
};
v17.Nodes = v18;

return v17;