  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local u1 = ReplicatedStorage["Client Assets"];
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local u2 = Knit.GetService("DialogueService");
local u3 = Knit.GetService("QuestLineService");
local u4 = nil;

local function ShenronClean() -- Line: 19
    -- upvalues: u4 (ref)
    if not u4 then
        return;
    end;

    u4:Destroy();
    u4 = nil;
end;

local v41 = {
    Title = "Goku",

    Start = function() -- Line: 12, Name: GetStart
        -- upvalues: u3 (copy)
        return "step_" .. (u3:GetCurrentStep(script.Name):expect() or 1);
    end,

    Nodes = {
        step_1 = {
            Text = "Hi there! What can I do for you?",
            Options = {
                {
                    Response = "How do I become strong like you?",
                    Next = {
                        Text = "If you wish to become strong like me, first you gotta obtain all 7 dragon balls",
                        Options = {
                            {
                                Response = "Very well I will obtain them",

                                Callback = function(p5) -- Line: 40, Name: Callback
                                    -- upvalues: u2 (copy)
                                    u2:CheckDialogue(script.Name):expect();
                                end,

                                Next = {
                                    Text = "Come back when you\'ve gotten all",
                                    Options = {}
                                }
                            },
                            {
                                Response = "Nevermind this is too hard",
                                Next = "",

                                Callback = function(p6) -- Line: 50, Name: Callback
                                    p6:Destroy();
                                end
                            }
                        }
                    }
                },
                {
                    Response = "Here, I\'ve found some of them",
                    Next = "",

                    Callback = function(p7) -- Line: 60, Name: Callback
                        -- upvalues: u2 (copy)
                        local v8 = u2:CheckDialogue(script.Name):expect();

                        if type(v8) == "number" then
                            p7:SetCurrentNode({
                                Text = string.format("You need to find [%s] more dragon balls", v8),
                                Options = {}
                            });

                            return;
                        end;

                        p7:Destroy();
                    end
                }
            }
        },
        step_2 = {
            Mutable = true,
            Text = "",

            Transformer = function(p9, p10) -- Line: 78, Name: Transformer
                -- upvalues: u2 (copy)
                p10.Text = "Come back when you\'ve found all 7";
                p10.Options = {
                    {
                        Response = "Here, I\'ve found some of them",
                        Next = "",

                        Callback = function(p11) -- Line: 83, Name: Callback
                            -- upvalues: u2 (ref)
                            local v12 = u2:CheckDialogue(script.Name):expect();

                            if type(v12) == "number" then
                                p11:SetCurrentNode({
                                    Text = string.format("You need to find [%s] more dragon balls", v12),
                                    Options = {}
                                });

                                return;
                            end;

                            p11:Destroy();
                        end
                    }
                };
            end,

            Options = {}
        },
        step_3 = {
            Mutable = true,
            Text = "",

            Transformer = function(p13, p14) -- Line: 104, Name: Transformer
                -- upvalues: u2 (copy)
                p14.Text = "Oh you\'re back, did you complete my request?";
                p14.Options = {
                    {
                        Response = "Yes",
                        Next = "",

                        Callback = function(p15) -- Line: 109, Name: Callback
                            -- upvalues: u2 (ref)
                            u2:CheckDialogue(script.Name);
                            p15:SetCurrentNode(p15:GetNode("step_4"));
                        end
                    },
                    {
                        Response = "No",
                        Next = "",

                        Callback = function(p16) -- Line: 117, Name: Callback
                            p16:Destroy();
                        end
                    }
                };
            end,

            Options = {}
        },
        step_4 = {
            Mutable = true,
            Text = "",

            Transformer = function(p17, p18) -- Line: 130, Name: Transformer
                p18.Text = "Come back when you\'ve completed these tasks";
                p18.Options = {};
            end,

            Options = {}
        },
        step_5 = {
            Mutable = true,
            Text = "",

            Transformer = function(p19, p20) -- Line: 140, Name: Transformer
                -- upvalues: Players (copy), u4 (ref), u1 (copy), u2 (copy)
                p20.Title = "Shenron";
                p20.Text = "What do you wish for mortal?";
                local LocalPlayer = Players.LocalPlayer;
                u4 = u1.Goku["Shenron GUI"]:Clone();
                u4.Parent = LocalPlayer.PlayerGui;

                local function SelectChoice(u21) -- Line: 147
                    -- upvalues: u2 (ref), u4 (ref)
                    return function(p22) -- Line: 148
                        -- upvalues: u2 (ref), u21 (copy), u4 (ref)
                        local v23 = u2:CheckDialogue(script.Name, u21):expect();

                        if u4 then
                            u4:Destroy();
                            u4 = nil;
                        end;

                        if v23 == true then
                            p22:Destroy();

                            return;
                        end;

                        p22:SetCurrentNode({
                            Text = tostring(v23),
                            Options = {}
                        });
                    end;
                end;

                local v24 = {};
                local v25 = {
                    Response = "Wealth",
                    Next = ""
                };
                local u26 = "Wealth";

                function v25.Callback(p27) -- Line: 148
                    -- upvalues: u2 (ref), u26 (copy), u4 (ref)
                    local v28 = u2:CheckDialogue(script.Name, u26):expect();

                    if u4 then
                        u4:Destroy();
                        u4 = nil;
                    end;

                    if v28 == true then
                        p27:Destroy();

                        return;
                    end;

                    p27:SetCurrentNode({
                        Text = tostring(v28),
                        Options = {}
                    });
                end;

                local v29 = {
                    Response = "Ascension",
                    Next = ""
                };
                local u30 = "Ascension";

                function v29.Callback(p31) -- Line: 148
                    -- upvalues: u2 (ref), u30 (copy), u4 (ref)
                    local v32 = u2:CheckDialogue(script.Name, u30):expect();

                    if u4 then
                        u4:Destroy();
                        u4 = nil;
                    end;

                    if v32 == true then
                        p31:Destroy();

                        return;
                    end;

                    p31:SetCurrentNode({
                        Text = tostring(v32),
                        Options = {}
                    });
                end;

                local v33 = {
                    Response = "Corruption",
                    Next = ""
                };
                local u34 = "Corruption";

                function v33.Callback(p35) -- Line: 148
                    -- upvalues: u2 (ref), u34 (copy), u4 (ref)
                    local v36 = u2:CheckDialogue(script.Name, u34):expect();

                    if u4 then
                        u4:Destroy();
                        u4 = nil;
                    end;

                    if v36 == true then
                        p35:Destroy();

                        return;
                    end;

                    p35:SetCurrentNode({
                        Text = tostring(v36),
                        Options = {}
                    });
                end;

                local v37 = {
                    Response = "Primal Power",
                    Next = ""
                };
                local u38 = "Primal Power";

                function v37.Callback(p39) -- Line: 148
                    -- upvalues: u2 (ref), u38 (copy), u4 (ref)
                    local v40 = u2:CheckDialogue(script.Name, u38):expect();

                    if u4 then
                        u4:Destroy();
                        u4 = nil;
                    end;

                    if v40 == true then
                        p39:Destroy();

                        return;
                    end;

                    p39:SetCurrentNode({
                        Text = tostring(v40),
                        Options = {}
                    });
                end;

                v24[1], v24[2], v24[3], v24[4] = v25, v29, v33, v37;
                p20.Options = v24;
            end,

            Options = {}
        }
    }
};
local Destroy = v41.Destroy;

function v41.Destroy(p42) -- Line: 197
    -- upvalues: u4 (ref), Destroy (copy)
    if u4 then
        u4:Destroy();
        u4 = nil;
    end;

    if Destroy then
        Destroy(p42);
    end;
end;

return v41;