  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Dialogue = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local Core = require(ReplicatedStorage.ReplicatedRoot:WaitForChild("Core"));
local ItemData = require(ReplicatedStorage.ReplicatedModules.ItemData);
local _ = ReplicatedStorage.ReplicatedRoot;
require(ReplicatedStorage.ReplicatedModules.Types);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
Core.GetClientService("LabService");
local u1 = Core.GetLegacyService("QuestLineService");
local u2 = Core.GetLegacyService("DialogueService");

local function GetItemRichText(p3) -- Line: 16
    -- upvalues: ItemData (copy)
    local v4 = ItemData.GetItemInfo(p3);

    if not v4 then
        return "";
    end;

    local v5 = ItemData.Rarities[v4.Rarity];
    local v6 = v4.Name or "";

    if v5 then
        v6 = `<Color=#{v5.Color:ToHex()}>{v6}<Color=/>`;
    end;

    return v6;
end;

local function GetItemText(p7) -- Line: 29
    -- upvalues: ItemData (copy)
    local v8 = ItemData.GetItemInfo(p7);

    if not v8 then
        return "";
    end;

    local v9 = ItemData.Rarities[v8.Rarity];
    local v10 = v8.Name or "";

    if v9 then
        v10 = `<font color="#{v9.Color:ToHex()}">{v10}</font>`;
    end;

    return v10;
end;

local function ColorRichText(p11, p12) -- Line: 42
    return `<Color=#{p12:ToHex()}>{p11}<Color=/>`;
end;

Random.new();
local LocalPlayer = game:GetService("Players").LocalPlayer;
local v14 = {
    Title = "???",

    Start = function() -- Line: 50, Name: Start
        -- upvalues: u2 (copy)
        local v13 = u2:CheckRequirement("ItemCountCheck", "ITEM_918"):expect();

        if v13 then
            v13 = v13 > 0;
        end;

        return v13 and "start_translator" or "start";
    end
};
local v19 = {
    start = {
        Text = "As you approach the crucible, you slowly feel your arm moving towards it, guided not by force, but intent. The surface of the crucible ripples faintly...",
        Options = { {
                Response = "<i>Get closer</i>",
                Next = "insanity"
            }, {
                Response = "<i>Back up</i>",
                Next = nil
            } }
    },
    insanity = {
        Text = "As your hand hovers inches above the crucible, your vision begins to narrow. You feel as if something was trying to enter your mind.",
        Options = {
            {
                Response = "<i>...</i>",
                Next = {},

                Callback = function(u15, p16) -- Line: 111, Name: Callback
                    -- upvalues: LocalPlayer (copy), EffectsHandler (copy), u2 (copy)
                    local u17 = EffectsHandler.CallEffect("Space_CrucibleInsanity", {
                        Amount = 8,
                        Time = 5,
                        Character = LocalPlayer.Character
                    });

                    if u17 then
                        local Model = u15:GetMetadata().Model;

                        if Model then
                            Model = Model:FindFirstChildWhichIsA("ProximityPrompt", true);
                        end;

                        if Model then
                            Model.Enabled = false;
                        end;

                        u15.Trove:Add(function() -- Line: 128
                            -- upvalues: Model (copy), u17 (copy)
                            if Model then
                                Model.Enabled = true;
                            end;

                            if not table.isfrozen(u17) then
                                u17:Destroy();
                            end;
                        end);
                        u17:Run();
                        u17.Ended:Connect(function(p18) -- Line: 140
                            -- upvalues: Model (copy), u15 (copy), u2 (ref)
                            Model.Enabled = true;

                            if p18 == "Won" then
                                u15:Choose({
                                    Response = "",
                                    Next = "insanity_won"
                                });

                                return;
                            end;

                            u2:CheckRequirement("CrucibleFail"):expect();
                            u15:Destroy();
                        end);
                    end;
                end
            }
        }
    },
    insanity_won = {
        Text = "The pressure fades. Symbols appear to manifest in the crucible.\n\"<AnimateYield=0.5><AnimateStyle=Fade><Font=RobotoMono><Color=85,255,127>∵ ∆ ∷<Color=/><Font=/><AnimateStyle=/>\"\n<AnimateYield=1>You aren\'t sure what to make of this, maybe consulting the lab can give a better insight.",
        Options = {
            {
                Response = "...",
                Next = nil,

                Callback = function() -- Line: 165, Name: Callback
                    -- upvalues: u1 (copy), u2 (copy)
                    if not u1:GetCurrentStep("Space Crucible"):expect() then
                        u2:CheckDialogue("Space Crucible"):expect();
                    end;
                end
            }
        }
    }
};
local v20 = {
    Mutable = true
};
local v21 = ItemData.GetItemInfo("ITEM_918");
local v22;

if v21 then
    local v23 = ItemData.Rarities[v21.Rarity];
    v22 = v21.Name or "";

    if v23 then
        v22 = `<Color=#{v23.Color:ToHex()}>{v22}<Color=/>`;
    end;
else
    v22 = "";
end;

local v24 = ItemData.GetItemInfo("ITEM_915");
local v25;

if v24 then
    local v26 = ItemData.Rarities[v24.Rarity];
    v25 = v24.Name or "";

    if v26 then
        v25 = `<Color=#{v26.Color:ToHex()}>{v25}<Color=/>`;
    end;
else
    v25 = "";
end;

v20.Text = `As you near the crucible, the {v22} in your possession begins to resonate faintly. This time, the pull feels different. The surface ripples, not with chaos, but with purpose.\nYour mind pictures a {v25}.`;

function v20.Transformer(p27, p28) -- Line: 179
    -- upvalues: u2 (copy), LocalPlayer (copy), ItemData (copy), EffectsHandler (copy)
    local v29 = u2:CheckRequirement("ItemCountCheck", "ITEM_915"):expect();

    if v29 then
        v29 = v29 > 0;
    end;

    if not v29 then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Fractured Sigil") then
            v29 = true;
        else
            for _, child in LocalPlayer:FindFirstChild("Backpack"):GetChildren() do
                if child.Name == "Fractured Sigil" then
                    v29 = true;
                    break;
                end;
            end;
        end;
    end;

    if v29 then
        local Options = p28.Options;
        local v30 = {
            Next = "teleport"
        };
        local v31 = ItemData.GetItemInfo("ITEM_915");
        local v32;

        if v31 then
            local v33 = ItemData.Rarities[v31.Rarity];
            v32 = v31.Name or "";

            if v33 then
                v32 = `<font color="#{v33.Color:ToHex()}">{v32}</font>`;
            end;
        else
            v32 = "";
        end;

        v30.Response = `<i>Reach out with {v32}</i>`;

        function v30.Callback() -- Line: 200
            -- upvalues: EffectsHandler (ref)
            task.spawn(EffectsHandler.CallEffect, "Yuki_Vignette", {
                LifeTime = 0.2,
                Transparency = 0.3,
                TweenIn = { 0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.In },
                TweenOut = { 0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut },
                Size = UDim2.fromScale(1, 1),
                Color = Color3.fromRGB(66, 198, 97)
            });
        end;

        table.insert(Options, 1, v30);
    end;
end;

v20.Options = { {
        Response = "<i>Step away</i>",
        Next = nil
    } };
v19.start_translator = v20;
v19.teleport = {
    Text = "The ripple strengthens.",
    Options = {
        {
            Response = "...",
            Next = Dialogue.PLACEHOLDER,

            Callback = function() -- Line: 230, Name: Callback
                -- upvalues: u2 (copy)
                u2:CheckRequirement("ShrineEnter"):expect();
            end
        }
    }
};
v19.invalid = {
    Text = "...",
    Options = { {
            Response = "...",
            Next = nil
        } }
};
v14.Nodes = v19;

return v14;