 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local Abilities = require(ReplicatedStorage.Shared.Tables.Cooldowns).Abilities;
local Parent = require(script.Parent.Parent);
local script_PlayCutsceneCircle = require(script.PlayCutsceneCircle);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local u6 = {};
local u7 = {};
local u8 = nil;
local u9 = nil;
local u10 = { "Perfection", "LukaDoncic", "Tatlis", "Cyber", "Psychic" };
ReplicatedStorage.Remotes.CreatorSecret.OnClientEvent:Connect(function(p11) -- Line: 36
    -- upvalues: LocalPlayer (copy), Knit (copy), u8 (ref), u9 (ref), script_PlayCutsceneCircle (copy), u10 (copy), ReplicatedStorage (copy)
    if LocalPlayer.Team == game.Teams.Visitor then
        return;
    end;

    local Controller = Knit.GetController("AbilityController");

    if p11.Task == "Create" then
        local u12 = script.BookPages:Clone();
        u12.Parent = LocalPlayer.PlayerGui;
        Controller.ChosenStyle = nil;
        local v13, v14 = script_PlayCutsceneCircle(u12, u10);
        u8 = v13;
        u9 = v14;

        if p11.Player == LocalPlayer then
            for _, v in ipairs(u8) do
                v.Container.MouseButton1Down:Connect(function() -- Line: 51
                    -- upvalues: Controller (copy), v (copy), ReplicatedStorage (ref)
                    if Controller.ChosenStyle then
                        return;
                    end;

                    Controller.ChosenStyle = v.Style;
                    ReplicatedStorage.Remotes.CreatorSecret:FireServer(v.Style);
                end);
            end;
        else
            for _, v in ipairs(u8) do
                v.Container.Active = false;
                v.Container.Interactable = false;
            end;
        end;

        task.delay(11.35, function() -- Line: 64
            -- upvalues: u12 (copy)
            if u12.Parent then
                u12:Destroy();
            end;
        end);

        return;
    end;

    if p11.Task == "Selected" then
        local BookPages = LocalPlayer.PlayerGui:FindFirstChild("BookPages");

        if not BookPages then
            return;
        end;

        if u8 and u9 then
            for _, v in ipairs(u8) do
                if v.Style == p11.Style then
                    u9(v);
                    break;
                end;
            end;
        end;

        if p11.Player == LocalPlayer then
            Controller.ChosenStyle = p11.Style;
        end;

        task.delay(2, function() -- Line: 86
            -- upvalues: BookPages (copy)
            if BookPages.Parent then
                BookPages:Destroy();
            end;
        end);
        u8 = nil;
        u9 = nil;
    end;
end);

return function(u15) -- Line: 97
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), Effects (copy), u6 (copy), Parent (copy), u7 (copy), Abilities (copy)
    local Character = LocalPlayer.Character;
    local _ = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = u15.AbilityService;
    u2 = u15.Animations;
    u3 = u15.MovementController;
    u4 = u15.BallController;
    u5 = u15.Network;

    if not u5.CharValues.InAwakening then
        u15.ChosenStyle = nil;

        return;
    end;

    if u5.CharValues.HasBall then
        Effects:Popup("Not usable with ball!");
        u15:ResetCD(3);

        return;
    end;

    if not (u15.AwakeningAbility1Used and u15.AwakeningAbility2Used) then
        Effects:Popup("Not usable until the other two awakening abilities have been used!");
        u15:ResetCD(3);

        return;
    end;

    u15.ChosenStyle = nil;
    u1.Ability:Fire("Creator\'s Secret", {
        TimeSent = workspace:GetServerTimeNow()
    });
    local v16 = tick();

    repeat
        task.wait();
    until tick() - v16 > 60 or u15.ChosenStyle;

    if not u15.ChosenStyle then
        return;
    end;

    for i = 1, 4 do
        u15:ResetCD(i);

        if not u6[i] then
            u6[i] = Parent.ChrolloV2[i];
        end;

        if not u7[i] then
            u7[i] = Abilities.ChrolloV2[i];
        end;

        if Parent[u15.ChosenStyle][i] then
            Parent.ChrolloV2[i] = Parent[u15.ChosenStyle][i];
        end;

        local v17;

        if Abilities[u15.ChosenStyle][i] then
            Abilities.ChrolloV2[i] = Abilities[u15.ChosenStyle][i];
            v17 = i;
        else
            v17 = i;
        end;
    end;

    local u18 = tick();
    task.spawn(function() -- Line: 151
        -- upvalues: u18 (copy), u15 (copy), LocalPlayer (ref), Effects (ref)
        repeat
            task.wait();
        until tick() - u18 > 295 or not (u15.ChosenStyle and (LocalPlayer.Style.Value == "ChrolloV2" and LocalPlayer.Team ~= game.Teams.Visitor));

        for i = 1, 5 do
            if not (u15.ChosenStyle and (LocalPlayer.Style.Value == "ChrolloV2" and LocalPlayer.Team ~= game.Teams.Visitor)) then
                return;
            end;

            Effects:Popup((`{tostring(5 - i)} SECONDS UNTIL ABILITIES ARE REVERTED.`));
            task.wait(1);
            local _ = i;
        end;
    end);

    repeat
        task.wait();
    until tick() - u18 > 300 or not (u15.ChosenStyle and (LocalPlayer.Style.Value == "ChrolloV2" and (LocalPlayer.Team ~= game.Teams.Visitor and u5.CharValues.InAwakening)));

    if u6[3] then
        Parent.ChrolloV2[3] = u6[3];
    end;

    if u7[3] then
        Abilities.ChrolloV2[3] = u7[3];
    end;

    repeat
        task.wait();
    until tick() - u18 > 300 or not (u15.ChosenStyle and (LocalPlayer.Style.Value == "ChrolloV2" and LocalPlayer.Team ~= game.Teams.Visitor));

    if u15.ChosenStyle then
        u15.ChosenStyle = nil;
    end;

    for i = 1, 4 do
        if u6[i] then
            Parent.ChrolloV2[i] = u6[i];
        end;

        local v19;

        if u7[i] then
            Abilities.ChrolloV2[i] = u7[i];
            v19 = i;
        else
            v19 = i;
        end;
    end;

    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability3.Visible = u5.CharValues.InAwakening;
end;