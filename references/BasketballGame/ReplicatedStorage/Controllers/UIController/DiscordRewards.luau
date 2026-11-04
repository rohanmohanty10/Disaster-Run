 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local LocalPlayer = Players.LocalPlayer;
local Knit = require(ReplicatedStorage.Packages.Knit);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Trove = require(ReplicatedStorage.Shared.Utility.Trove);
local Content = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("DiscordRewards"):WaitForChild("Content");
local u1 = Knit.CreateController({
    Name = "DiscordRewardsController"
});

function u1.InitGui() -- Line: 17
    -- upvalues: Knit (copy), Content (copy), Effects (copy)
    local Service = Knit.GetService("DiscordRewardsService");

    local function RedeemCode() -- Line: 22
        -- upvalues: Content (ref), Service (copy), Effects (ref)
        local RewardCodeText = Content.MainBox.RewardCodeContainer.RewardCodeText;
        local Text = RewardCodeText.Text;
        RewardCodeText.TextEditable = false;
        local v2, v3 = Service:Redeem(Text);
        Effects:Popup(v3, 2, v2 and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0));

        if v2 ~= true then
            RewardCodeText.TextEditable = true;

            return;
        end;

        workspace.Lobby.Discord:Destroy();
        RewardCodeText.Text = "CLAIMED!";
    end;

    Content.MainBox.RewardCodeContainer.RewardCodeText.ReturnPressedFromOnScreenKeyboard:Connect(RedeemCode);
    Content.MainBox.Check.MouseButton1Click:Connect(RedeemCode);
end;

function u1.InitLobby() -- Line: 44
    -- upvalues: Knit (copy), Trove (copy), RunService (copy), Players (copy), LocalPlayer (copy), Content (copy)
    local Service = Knit.GetService("DiscordRewardsService");
    local Controller = Knit.GetController("UIController");
    local Discord = workspace:WaitForChild("Lobby"):WaitForChild("Discord");

    if not Service:CheckEligibility() then
        Discord:Destroy();

        return;
    end;

    local Logo = Discord:WaitForChild("Logo");
    local Hitbox = Discord:WaitForChild("Hitbox");
    local Position = Logo.Position;
    local v4 = Trove.new();
    v4:Add(RunService.PostSimulation:Connect(function(p5: number) -- Line: 63
        -- upvalues: Logo (copy), Position (copy)
        local CFrame_Angles_ret = CFrame.Angles(0, time() * 0.5, 0);
        local CFrame_Angles = CFrame.Angles;
        local v6 = time() * 0.5;
        local v7 = CFrame_Angles_ret * CFrame_Angles(0, 0, math.sin(v6) * 3.141592653589793 * 0.05);
        local v8 = time();
        local v9 = math.sin(v8) * 0.5;
        Logo.CFrame = v7 + Vector3.new(0, v9, 0) + Position;
    end));
    v4:Add(Hitbox.Touched:Connect(function(p10) -- Line: 71
        -- upvalues: Players (ref), LocalPlayer (ref), Content (ref), Controller (copy)
        if Players:GetPlayerFromCharacter(p10.Parent) ~= LocalPlayer then
            return;
        end;

        if Content.Parent.Enabled then
            return;
        end;

        Content.Parent.Enabled = true;
        LocalPlayer.PlayerGui.HUD.Enabled = false;
        Controller:Focus(true, Content.Parent);
    end));
    v4:AttachToInstance(Discord);
end;

function u1.KnitInit(p11) -- Line: 92
end;

function u1.KnitStart(p12) -- Line: 96
    -- upvalues: u1 (copy)
    task.spawn(u1.InitGui);
    task.spawn(u1.InitLobby);
end;

return u1;