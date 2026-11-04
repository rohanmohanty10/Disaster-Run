  

local Icon = require(script.Parent.Icon);
local v1 = Icon.new():setLabel("INVITE"):setImage(82007157883583, "Selected"):setImage(82007157883583, "Deselected");
local v2 = Icon.new():setLabel():setImage(7059346373, "Selected"):setImage(7059346373, "Deselected");
local HttpService = game:GetService("HttpService");
game:GetService("SocialService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local v3 = HttpService:JSONEncode({
    senderUserID = LocalPlayer.UserId
});
local ExperienceInviteOptions = Instance.new("ExperienceInviteOptions");
ExperienceInviteOptions.LaunchData = v3;
v1.selected:Connect(function() -- Line: 68
    -- upvalues: ExperienceInviteOptions (copy)
    game:GetService("SocialService"):PromptGameInvite(game.Players.LocalPlayer, ExperienceInviteOptions);
end);
v2.selected:Connect(function() -- Line: 73
    -- upvalues: LocalPlayer (copy)
    LocalPlayer.PlayerGui.Settings.Enabled = not LocalPlayer.PlayerGui.Settings.Enabled;
end);