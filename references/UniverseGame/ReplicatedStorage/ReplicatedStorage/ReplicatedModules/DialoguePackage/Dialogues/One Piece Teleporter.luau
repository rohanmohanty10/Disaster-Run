  

 

local v1 = script:FindFirstAncestor("DialoguePackage");
local Dialogue = require(v1.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
local u2 = Knit.GetService("DialogueService");
Knit.GetService("QuestLineService");
local u3 = Knit.GetService("PlayerDataService");
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);
local u4 = Dialogue.new();
local LocalPlayer = game:GetService("Players").LocalPlayer;
local TweenService = game:GetService("TweenService");
local ClientAssets = PathShortcuts.ClientAssets;

local function IsPlayerInCombat(p5) -- Line: 20
    if p5 and p5.Character then
        return p5.Character:GetAttribute("InCombat") == true;
    end;

    return false;
end;

local function DetermineLocation(p6) -- Line: 28
    local v7 = { "Valentine Island", "Main Spawn", "Syrup Village", "Punk Hazard", "Marineford", "Orange Town" };
    local v8 = p6:GetAttribute("Location");

    if v8 then
        if table.find(v7, v8) then
            table.remove(v7, table.find(v7, v8));
        end;

        return v7;
    end;
end;

u4:SetTitle("Bartholomew Kuma");
u4:SetStarterText("Which One Piece location would you like to go?");

function u4.Setup(p9) -- Line: 50
    -- upvalues: u4 (copy), u2 (copy), u3 (copy), LocalPlayer (copy), DetermineLocation (copy), ClientAssets (copy), TweenService (copy), EffectsHandler (copy)
    u4:AddCallback("OnDestroy", function(p10) -- Line: 51
        table.clear(p10._Responses);
    end);
    local u11 = p9:GetNPCModel();

    if not u11 then
        return;
    end;

    local v12 = u2:CheckRequirement("ItemCountCheck", "ITEM_89"):expect();

    if not u3:GetNPCFlag("UsedKumaBook"):expect() and (not v12 or v12 < 1) then
        u4:SetText("You lack the respect and honor to talk to me. Find my <Color=RareBlue><AnimateStyle=Wiggle><AnimateStepFrequency=1><AnimateStyleTime=2>Kuma\'s Book<AnimateStyle=/><AnimateStepFrequency=/><AnimateStyleTime=/><Color=/><TextScale=/> first [STORE IT IN INVENTORY] [YOU CAN ALSO USE IT TO PERMANENTLY UNLOCK TRANSPORTATION].");

        return;
    end;

    local v13 = LocalPlayer;
    local v14;

    if v13 and v13.Character then
        v14 = v13.Character:GetAttribute("InCombat") == true;
    else
        v14 = false;
    end;

    if v14 then
        u4:SetText("You\'re currently fighting someone, I\'m unable to help you at this time.");

        return;
    end;

    local v15 = DetermineLocation(u11);
    local Teleports = workspace.Map.Teleports;
    local v16 = {
        ["Valentine Island"] = "Valentine_Teleport",
        ["Syrup Village"] = "Syrup_Village",
        ["Main Spawn"] = "Main_Spawn",
        ["Punk Hazard"] = "Punk_Hazard",
        Marineford = "Marineford",
        ["Orange Town"] = "Orange_Town"
    };

    for i = 1, #v15 do
        if not v15[i] then
            return;
        end;

        local u17 = u2:CheckRequirement("NPCLocation", Teleports, v16[v15[i]]):expect();

        if not u17 then
            return;
        end;

        u4:AddResponse("Take me to " .. v15[i], function() -- Line: 90
            -- upvalues: LocalPlayer (ref), u4 (ref), u11 (copy), u17 (copy), ClientAssets (ref), TweenService (ref), EffectsHandler (ref)
            local v18 = LocalPlayer;
            local v19;

            if v18 and v18.Character then
                v19 = v18.Character:GetAttribute("InCombat") == true;
            else
                v19 = false;
            end;

            if v19 then
                u4:SetText("You\'re currently fighting someone, I\'m unable to help you at this time.");

                return "ClearResponses";
            end;

            u4:SetText("As you wish.");
            u11.Humanoid.Animator:LoadAnimation(script.Teleport):Play(0.5, nil, 1);
            script.Sound:Play();
            task.delay(0.6833333333333333, function() -- Line: 112
                -- upvalues: LocalPlayer (ref), u17 (ref), ClientAssets (ref), TweenService (ref), EffectsHandler (ref)
                if not (LocalPlayer and LocalPlayer.Character) then
                    return;
                end;

                local Position = u17.Position;
                local v20 = ClientAssets.BlackScreen:Clone();
                local BlackScreen = v20.BlackScreen;
                v20.Parent = LocalPlayer.PlayerGui;
                task.delay(5, v20.Destroy, v20);
                TweenService:Create(BlackScreen, TweenInfo.new(0.2), {
                    BackgroundTransparency = 0
                }):Play();
                task.spawn(function() -- Line: 127
                    -- upvalues: EffectsHandler (ref), LocalPlayer (ref), u17 (ref)
                    EffectsHandler.CallEffect("Shambles", LocalPlayer.Character, {
                        Lightning = false,
                        CustomPath = "Particles/PawTeleport",
                        Locations = { LocalPlayer.Character.HumanoidRootPart.CFrame }
                    });
                    EffectsHandler.CallEffect("Shambles", LocalPlayer.Character, {
                        Lightning = false,
                        FadeCharacter = false,
                        PlaySounds = false,
                        CustomPath = "Particles/GammaKnife/Shambles",
                        Locations = { u17 }
                    });
                end);
                task.wait(0.25);
                LocalPlayer.Character.HumanoidRootPart.Anchored = true;
                local v21 = os.clock();

                while LocalPlayer.Character:IsDescendantOf(game) and os.clock() - v21 <= 3 do
                    LocalPlayer.Character:PivotTo(CFrame.new(Position + Vector3.new(0, 5, 0)));
                    task.wait(0.25);
                end;

                TweenService:Create(BlackScreen, TweenInfo.new(0.5), {
                    BackgroundTransparency = 1
                }):Play();
                LocalPlayer.Character.HumanoidRootPart.Anchored = false;
                task.wait(0.5);
                v20:Destroy();
            end);

            return "ClearResponses";
        end);
    end;
end;

return u4;