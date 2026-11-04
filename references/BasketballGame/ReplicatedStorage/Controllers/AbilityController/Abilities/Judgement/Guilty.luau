 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local LocalPlayer = Players.LocalPlayer;
ReplicatedStorage.Remotes.GuiltyVote.OnClientEvent:Connect(function(u5) -- Line: 17
    -- upvalues: LocalPlayer (copy), Effects (copy), ReplicatedStorage (copy), Players (copy)
    if LocalPlayer.Team == game.Teams.Visitor then
        return;
    end;

    if u5.Task == "Create" then
        local TimeSent = u5.TimeSent;
        local v6 = workspace:GetServerTimeNow() - TimeSent;
        local u7 = script.GuiltyVote:Clone();
        u7.Parent = LocalPlayer.PlayerGui;

        for _, child in u7.Buttons:GetChildren() do
            if child:IsA("ImageButton") then
                child.Activated:Connect(function() -- Line: 29
                    -- upvalues: u5 (copy), LocalPlayer (ref), u7 (copy), Effects (ref), ReplicatedStorage (ref), child (copy)
                    if not u5.Votes[tostring(LocalPlayer.UserId)] then
                        Effects:Popup("You aren\'t allowed to vote!");

                        return;
                    end;

                    if u7.Buttons.Chrollo.Votes:FindFirstChild((tostring(LocalPlayer.UserId))) or u7.Buttons.Tatlis.Votes:FindFirstChild((tostring(LocalPlayer.UserId))) then
                        Effects:Popup("You have already voted!");

                        return;
                    end;

                    ReplicatedStorage.Remotes.GuiltyVote:FireServer(child.Name);
                end);
            end;
        end;

        task.wait(16.65 - v6);
        u7:Destroy();

        return;
    end;

    if u5.Task ~= "Update" then
        if u5.Task == "Guilty" then
            local GuiltyVote = LocalPlayer.PlayerGui:FindFirstChild("GuiltyVote");

            if not GuiltyVote then
                return;
            end;

            for _, child in GuiltyVote.Buttons:GetChildren() do
                if child:IsA("ImageButton") then
                    if child.Name == u5.Guilty then
                        child.Guilty.Visible = true;
                    else
                        child.Innocent.Visible = true;
                    end;
                end;
            end;

            GuiltyVote.Guilty.Visible = true;
            GuiltyVote.Guilty.Label.Text = `{string.upper(u5.Guilty)} GUILTY!`;
        end;

        return;
    end;

    local GuiltyVote = LocalPlayer.PlayerGui:FindFirstChild("GuiltyVote");

    if not GuiltyVote then
        return;
    end;

    local v8 = 0;
    local v9 = 0;

    for i, v in u5.Votes do
        if v == "Chrollo" then
            v9 = v9 + 1;
            task.spawn(function() -- Line: 62
                -- upvalues: GuiltyVote (copy), v (copy), i (copy), Players (ref)
                if not GuiltyVote.Buttons:FindFirstChild(v).Votes:FindFirstChild(i) then
                    local v10 = script.Template:Clone();
                    v10.Parent = GuiltyVote.Buttons:FindFirstChild(v).Votes;
                    v10.Name = i;
                    v10.Icon.Image = Players:GetUserThumbnailAsync(tonumber(i), Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100);
                end;
            end);
        elseif v == "Tatlis" then
            v8 = v8 + 1;
            task.spawn(function() -- Line: 62
                -- upvalues: GuiltyVote (copy), v (copy), i (copy), Players (ref)
                if not GuiltyVote.Buttons:FindFirstChild(v).Votes:FindFirstChild(i) then
                    local v10 = script.Template:Clone();
                    v10.Parent = GuiltyVote.Buttons:FindFirstChild(v).Votes;
                    v10.Name = i;
                    v10.Icon.Image = Players:GetUserThumbnailAsync(tonumber(i), Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100);
                end;
            end);
        end;
    end;

    GuiltyVote.Buttons.Chrollo.Amount.Text = `VOTES: {v9}`;
    GuiltyVote.Buttons.Tatlis.Amount.Text = `VOTES: {v8}`;
end);

return function(p11) -- Line: 94
    -- upvalues: u1 (ref), u2 (ref), u3 (ref), u4 (ref), LocalPlayer (copy), RunService (copy), Effects (copy)
    u1 = p11.AbilityService;
    u2 = p11.Animations;
    u3 = p11.MovementController;
    u4 = p11.BallController;
    local _ = LocalPlayer.Character.HumanoidRootPart;
    local v12;

    if RunService:IsStudio() then
        v12 = workspace.DefenseRig;
    else
        v12 = u4:GetCharacterPossessingBall();
        local PlayerPossessingBall = u4:GetPlayerPossessingBall();

        if not v12 then
            p11:ResetCD(3);
            Effects:Popup("Ball must be on enemy player!");

            return;
        end;

        if not PlayerPossessingBall then
            p11:ResetCD(3);
            Effects:Popup("Ball must be on enemy player!");

            return;
        end;

        if PlayerPossessingBall.Team == LocalPlayer.Team then
            p11:ResetCD(3);
            Effects:Popup("Ball must be on enemy player!");

            return;
        end;

        if v12.Humanoid:GetState() == Enum.HumanoidStateType.Jumping or v12.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
            p11:ResetCD(3);
            Effects:Popup("Enemy player must be on the ground!");

            return;
        end;
    end;

    u3.States.Ability = true;
    u3.States.NoWalk = true;
    task.delay(16.65, function() -- Line: 138
        -- upvalues: u3 (ref)
        u3.States.Ability = false;
        u3.States.NoWalk = false;
    end);
    u2:StopAll();
    u1.Ability:Fire("Guilty", {
        TimeSent = workspace:GetServerTimeNow(),
        Other = v12
    });
end;