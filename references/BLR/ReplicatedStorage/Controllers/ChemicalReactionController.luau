  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local LocalPlayer = game.Players.LocalPlayer;
ReplicatedStorage:WaitForChild("Football");
local canRequestCR = require(ReplicatedStorage.Shared.utils.canRequestCR);
require(ReplicatedStorage.Modules.getPlayerTarget);
local isChemCD = require(ReplicatedStorage.Shared.utils.isChemCD);
local GetChemicalReaction = require(ReplicatedStorage.Modules.GetChemicalReaction);
local ChemicalReactions = require(ReplicatedStorage.Shared.Configs.ChemicalReactions);
local u1 = nil;
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local Knit = require(ReplicatedStorage.Packages.Knit);
local v2 = Knit.CreateController({
    Name = "ChemicalReactionController"
});
tick();

function v2.KnitStart(p3) -- Line: 27
    -- upvalues: u1 (ref), Knit (copy), LocalPlayer (copy), TweenService (copy), RunService (copy), ChemicalReactions (copy), GetChemicalReaction (copy), isChemCD (copy), canRequestCR (copy), ReplicatedStorage (copy)
    u1 = Knit.GetController("AbilityController");
    p3.ChemicalReactionService = Knit.GetService("ChemicalReactionService");
    p3.StatesController = Knit.GetController("StatesController");
    local RequestCR = LocalPlayer.PlayerGui:WaitForChild("Mobile"):WaitForChild("NoBall"):WaitForChild("RequestCR");
    local RequestCR2 = LocalPlayer.PlayerGui:WaitForChild("InGameUI"):WaitForChild("KeybindsPC"):WaitForChild("RequestCR");
    local RequestCR3 = LocalPlayer.PlayerGui:WaitForChild("InGameUI"):WaitForChild("KeybindsConsole"):WaitForChild("RequestCR");
    local CR = LocalPlayer.PlayerGui:WaitForChild("InGameUI"):WaitForChild("Bottom"):WaitForChild("Abilities"):WaitForChild("CR");
    LocalPlayer:WaitForChild("PlayerStats"):WaitForChild("Style");
    TweenService:Create(CR.Fader, TweenInfo.new(0.3), {
        ImageTransparency = 1,
        Size = UDim2.fromScale(1, 1)
    });
    CR.Visible = false;
    RunService.Heartbeat:Connect(function() -- Line: 43
        -- upvalues: LocalPlayer (ref), RequestCR (copy), RequestCR2 (copy), RequestCR3 (copy), CR (copy), ChemicalReactions (ref), GetChemicalReaction (ref), isChemCD (ref), canRequestCR (ref), ReplicatedStorage (ref)
        local Team = LocalPlayer.Team;

        if not Team then
            RequestCR.Visible = false;
            RequestCR2.Visible = false;
            RequestCR3.Visible = false;
            CR.Visible = false;

            return;
        end;

        local Attribute = LocalPlayer:GetAttribute("CRRequest");
        local v4;

        if Attribute then
            v4 = ChemicalReactions[Attribute] or nil;
        else
            v4 = nil;
        end;

        local v5 = v4 and v4.ServerArmed == true and true or false;
        local v6 = nil;
        local v7 = nil;

        if Attribute and not v5 then
            local Attribute2 = LocalPlayer:GetAttribute("CRSender");

            if typeof(Attribute2) == "number" then
                local v8;
                v6, v8, v7 = GetChemicalReaction(LocalPlayer, {
                    id = Attribute,
                    otherUserId = Attribute2
                });
            end;
        elseif not Attribute then
            local v9;
            v6, v9, v7 = GetChemicalReaction(LocalPlayer, {
                requestableOnly = true
            });
        end;

        local v10 = isChemCD(LocalPlayer);
        local v11 = canRequestCR(LocalPlayer);
        local v12;

        if v6 == nil then
            v12 = false;
        else
            v12 = v7 ~= nil;
        end;

        local v13 = not v5;

        if v13 then
            if v12 then
                v13 = v10 or (v11 or Attribute ~= nil);
            else
                v13 = v12;
            end;
        end;

        RequestCR.Visible = v13;
        RequestCR2.Visible = v13;
        RequestCR3.Visible = v13;
        local v14 = not v5;

        if v14 then
            if v12 then
                v12 = Attribute ~= nil and true or not v10 and v11;
            end;
        else
            v12 = v14;
        end;

        if v12 then
            CR.Visible = true;
            CR.AbilityLabel.Text = v7.displayName;
        elseif CR.Visible then
            CR.Visible = false;
        end;

        RequestCR2.ButtonName.Text = "Request CR";
        RequestCR3.ButtonName.Text = "Request CR";
        RequestCR.ButtonName.Text = "Request CR";
        local v15 = ReplicatedStorage.GameValues:FindFirstChild(Team.Name);

        if v15 then
            v15 = v15:FindFirstChild("ChemReactionCD");
        end;

        if v15 then
            v15 = v15.Value;
        end;

        if v15 and v15 > 0 then
            local v16 = v15 - workspace:GetServerTimeNow();

            if v16 <= 0 then
                return;
            end;

            RequestCR2.ButtonName.Text = `Request CR ({math.floor(v16 * 10) / 10}s)`;
            RequestCR3.ButtonName.Text = `Request CR ({math.floor(v16 * 10) / 10}s)`;
            RequestCR.ButtonName.Text = `Request CR\n({math.floor(v16 * 10) / 10}s)`;
            local UDim2_fromScale_ret = UDim2.fromScale(1, (math.clamp(v16 / 120, 0, 1)));
            RequestCR3.Icon.CdFront.Size = UDim2_fromScale_ret;
            RequestCR2.CdFront.Size = UDim2_fromScale_ret;
            RequestCR.CdFront.Size = UDim2_fromScale_ret;
        end;
    end);
    local u17 = CR.Parent:FindFirstChild("1");
    local u18 = CR.Parent:FindFirstChild("2");
    local u19 = CR.Parent:FindFirstChild("3");
    local u20 = nil;
    local u21 = nil;
    LocalPlayer:GetAttributeChangedSignal("CRRequest"):Connect(function() -- Line: 122
        -- upvalues: LocalPlayer (ref), u17 (copy), u18 (copy), u19 (copy), u20 (ref), u21 (ref), TweenService (ref)
        local Attribute = LocalPlayer:GetAttribute("CRRequest");
        local v22 = nil;

        if Attribute == "NELIsagiXHiori" or (Attribute == "IsagiBachiraCR" or (Attribute == "KaiserXNess" or Attribute == "SnuffyRebellion")) then
            v22 = u17;
        elseif Attribute == "DragonDriveCR" or Attribute == "ShidouXCharlesCR" then
            v22 = u18;
        elseif Attribute == "KaiserKiyoraCR" or Attribute == "AikuSelfishCaptain" then
            v22 = u19;
        end;

        if u20 then
            u20:Cancel();
            u20 = nil;
        end;

        if u21 and u21:FindFirstChild("UIScale") then
            u21.UIScale.Scale = 1;
        end;

        if v22 and v22:FindFirstChild("UIScale") then
            u21 = v22;
            v22.UIScale.Scale = 1;
            u20 = TweenService:Create(v22.UIScale, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
                Scale = 1.18
            });
            u20:Play();
        end;
    end);
end;

local u23 = false;
local u24 = 0;
local u25 = false;
local u26 = 0;

function v2.UseChemicalReaction(u27, u28) -- Line: 151
    -- upvalues: isChemCD (copy), LocalPlayer (copy), u23 (ref), ChemicalReactions (copy), GetChemicalReaction (copy), u24 (ref), Players (copy), u25 (ref), canRequestCR (copy), u26 (ref)
    if isChemCD(LocalPlayer) or not LocalPlayer.Team then
        return;
    end;

    local Character = LocalPlayer.Character;
    local v29;

    if Character then
        v29 = Character:FindFirstChildOfClass("Humanoid");
    else
        v29 = Character;
    end;

    if not (Character and (v29 and v29.Health > 0)) then
        return;
    end;

    local Attribute = LocalPlayer:GetAttribute("CRRequest");

    if not Attribute then
        if u25 then
            return;
        end;

        local u30, u31, v32 = GetChemicalReaction(LocalPlayer, {
            requestableOnly = true
        });

        if not (u30 and (u31 and (v32 and not v32.ServerArmed))) then
            return;
        end;

        local PlayerStats = LocalPlayer:FindFirstChild("PlayerStats");

        if PlayerStats then
            PlayerStats = PlayerStats:FindFirstChild("Style");
        end;

        if not (PlayerStats and (PlayerStats.Value == v32.sender and canRequestCR(LocalPlayer))) then
            return;
        end;

        local Character2 = u31.Character;

        if not Character2 then
            return;
        end;

        u25 = true;
        u26 = u26 + 1;
        local u33 = u26;
        local u34 = true;
        task.delay(5, function() -- Line: 305
            -- upvalues: u34 (ref), u25 (ref), u26 (ref), u33 (copy)
            if u34 and (u25 and u26 == u33) then
                u26 = u26 + 1;
                u25 = false;
            end;
        end);
        local success, result = pcall(function() -- Line: 315
            -- upvalues: u27 (copy), u30 (copy), u31 (copy)
            return u27.ChemicalReactionService:RequestChemicalReaction({
                Id = u30,
                ReceiverUserId = u31.UserId
            });
        end);
        u34 = false;

        if u26 ~= u33 then
            return;
        end;

        if not (success and (typeof(result) == "table" and (result.Ok == true and (result.Id == u30 and (result.ReceiverUserId == u31.UserId and typeof(result.Token) == "string"))))) then
            if u26 == u33 then
                u26 = u26 + 1;
                u25 = false;
            end;

            return;
        end;

        local Id = result.Id;
        local Token = result.Token;
        local u35 = ChemicalReactions[Id];
        task.delay(2.5, function() -- Line: 342
            -- upvalues: u26 (ref), u33 (copy), u25 (ref)
            if u26 == u33 then
                u25 = false;
            end;
        end);

        if not (u35 and (not u35.ServerArmed and u35.SenderAbility)) then
            return;
        end;

        task.spawn(function() -- Line: 354
            -- upvalues: u26 (ref), u33 (copy), LocalPlayer (ref), Id (copy), Token (copy), u25 (ref), Players (ref), result (copy), u35 (copy), Character2 (copy), u28 (copy), u27 (copy)
            local v36 = os.clock() + 2 + 0.25;

            while u26 == u33 and (os.clock() < v36 and (LocalPlayer:GetAttribute("AcceptCR") ~= Id or LocalPlayer:GetAttribute("AcceptCRToken") ~= Token)) do
                task.wait();
            end;

            if u26 ~= u33 or (LocalPlayer:GetAttribute("AcceptCR") ~= Id or LocalPlayer:GetAttribute("AcceptCRToken") ~= Token) then
                if u26 == u33 then
                    u25 = false;
                end;

                return;
            end;

            u25 = false;
            local Character3 = LocalPlayer.Character;
            local v37;

            if Character3 then
                v37 = Character3:FindFirstChildOfClass("Humanoid");
            else
                v37 = Character3;
            end;

            local v38;

            if Character3 then
                v38 = Character3:FindFirstChild("Values");
            else
                v38 = Character3;
            end;

            if v38 then
                v38 = v38:FindFirstChild("HasBall");
            end;

            local PlayerStats2 = LocalPlayer:FindFirstChild("PlayerStats");

            if PlayerStats2 then
                PlayerStats2 = PlayerStats2:FindFirstChild("Style");
            end;

            local PlayerByUserId = Players:GetPlayerByUserId(result.ReceiverUserId);
            local v39;

            if PlayerByUserId then
                v39 = PlayerByUserId.Character;
            else
                v39 = PlayerByUserId;
            end;

            local v40;

            if v39 then
                v40 = v39:FindFirstChildOfClass("Humanoid");
            else
                v40 = v39;
            end;

            local v41;

            if PlayerByUserId then
                v41 = PlayerByUserId:FindFirstChild("PlayerStats");
            else
                v41 = PlayerByUserId;
            end;

            if v41 then
                v41 = v41:FindFirstChild("Style");
            end;

            if not (Character3 and (v37 and (v37.Health > 0 and (v38 and (v38.Value and (PlayerStats2 and (PlayerStats2.Value == u35.sender and (PlayerByUserId and (PlayerByUserId.Team == LocalPlayer.Team and (v39 and (v39 == Character2 and (v40 and (v40.Health > 0 and (v41 and v41.Value == u35.receiver)))))))))))))) then
                return;
            end;

            local SenderAbility = u35.SenderAbility;
            local v42 = u28.UngroupedAbilities and u28.UngroupedAbilities[SenderAbility];

            if not v42 then
                return;
            end;

            local success2, result2 = pcall(v42, u28, LocalPlayer, Character3, {
                chemReaction = true,
                target = v39,
                RequestToken = Token
            });

            if success2 and result2 == true then
                u27.StatesController.CharacterEvents.OnAbilityUsed:Fire(SenderAbility);

                return;
            end;

            if not success2 then
                warn("[ChemicalReactionController] sender client failed:", result2);
            end;
        end);

        return;
    end;

    if u23 then
        return;
    end;

    local Attribute2 = LocalPlayer:GetAttribute("CRRequestToken");
    local Attribute3 = LocalPlayer:GetAttribute("CRSender");
    local v43 = ChemicalReactions[Attribute];

    if typeof(Attribute2) ~= "string" or (typeof(Attribute3) ~= "number" or (not v43 or v43.ServerArmed)) then
        return;
    end;

    local v44, v45, v46 = GetChemicalReaction(LocalPlayer, {
        id = Attribute,
        otherUserId = Attribute3
    });

    if v44 ~= Attribute or not (v45 and v46) then
        return;
    end;

    local Character2 = v45.Character;
    Character2 = Character2;
    local v47;

    if Character2 then
        v47 = Character2:FindFirstChildOfClass("Humanoid");
    end;

    Character2 = Character2;
    local v48;

    if Character2 then
        v48 = Character2:FindFirstChild("Values");
    else
        v48 = Character2;
    end;

    if v48 then
        v48 = v48:FindFirstChild("HasBall");
    end;

    if not (Character2 and (v47 and (v47.Health > 0 and (v48 and v48.Value)))) then
        return;
    end;

    if v46.AcceptConditions then
        local success, result = pcall(v46.AcceptConditions, LocalPlayer, v45);

        if not success or result ~= true then
            return;
        end;
    end;

    local v49 = Attribute .. "Receiver";
    local v50 = u28.UngroupedAbilities and u28.UngroupedAbilities[v49];

    if not v50 then
        return;
    end;

    u23 = true;
    u24 = u24 + 1;
    local u51 = u24;
    local u52 = true;
    task.delay(5, function() -- Line: 209
        -- upvalues: u52 (ref), u23 (ref), u24 (ref), u51 (copy)
        if u52 and (u23 and u24 == u51) then
            u24 = u24 + 1;
            u23 = false;
        end;
    end);
    local success, result = pcall(function() -- Line: 219
        -- upvalues: u27 (copy), Attribute (copy), Attribute2 (copy)
        return u27.ChemicalReactionService:AcceptChemicalReaction(Attribute, Attribute2);
    end);
    u52 = false;

    if u24 ~= u51 then
        return;
    end;

    u24 = u24 + 1;
    u23 = false;

    if not (success and (typeof(result) == "table" and result.Ok == true)) then
        return;
    end;

    if result.SenderUserId ~= Attribute3 or (LocalPlayer.Character ~= Character or v29.Health <= 0) then
        return;
    end;

    local PlayerByUserId = Players:GetPlayerByUserId(result.SenderUserId);
    local v53;

    if PlayerByUserId then
        v53 = PlayerByUserId.Character;
    else
        v53 = PlayerByUserId;
    end;

    local v54;

    if v53 then
        v54 = v53:FindFirstChildOfClass("Humanoid");
    else
        v54 = v53;
    end;

    if PlayerByUserId ~= v45 or (PlayerByUserId.Team ~= LocalPlayer.Team or (v53 ~= Character2 or (not v54 or v54.Health <= 0))) then
        return;
    end;

    local u55 = false;
    local u56 = false;
    local success2, result2 = pcall(v50, u28, LocalPlayer, Character, v53, function() -- Line: 249, Name: startReceiver
        -- upvalues: u55 (ref), u27 (copy), Attribute (copy), Attribute2 (copy), u56 (ref)
        if u55 then
            return false;
        end;

        u55 = true;
        local success2, result2 = pcall(function() -- Line: 254
            -- upvalues: u27 (ref), Attribute (ref), Attribute2 (ref)
            return u27.ChemicalReactionService:StartAcceptedReceiver(Attribute, Attribute2);
        end);
        local v57;

        if success2 then
            if typeof(result2) == "table" then
                v57 = result2.Ok == true;
            else
                v57 = false;
            end;
        else
            v57 = success2;
        end;

        u56 = v57;

        if success2 then
            return result2;
        end;

        return false;
    end);

    if success2 then
        if u56 then
            u27.StatesController.CharacterEvents.OnAbilityUsed:Fire(v49);
        end;

        return;
    end;

    warn("[ChemicalReactionController] receiver client failed:", result2);
end;

return v2;