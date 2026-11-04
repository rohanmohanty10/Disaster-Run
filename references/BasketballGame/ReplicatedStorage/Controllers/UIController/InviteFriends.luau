 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SocialService = game:GetService("SocialService");
game:GetService("HttpService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.TopbarPlus);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local v1 = Knit.CreateController({
    Name = "InviteFriendsController"
});

local function canInvite() -- Line: 15
    -- upvalues: SocialService (copy), LocalPlayer (copy)
    local success, result = pcall(function() -- Line: 16
        -- upvalues: SocialService (ref), LocalPlayer (ref)
        return SocialService:CanSendGameInviteAsync(LocalPlayer);
    end);

    if success then
        return result;
    end;

    return false;
end;

function v1.KnitInit(p2) -- Line: 27
    -- upvalues: LocalPlayer (copy), SocialService (copy), Knit (copy), Effects (copy)
    local InviteFriends = LocalPlayer.PlayerGui:WaitForChild("HUD"):WaitForChild("InviteFriends");
    local success, result = pcall(function() -- Line: 16
        -- upvalues: SocialService (ref), LocalPlayer (ref)
        return SocialService:CanSendGameInviteAsync(LocalPlayer);
    end);

    if not success then
        result = false;
    end;

    if not result then
        InviteFriends:Destroy();

        return;
    end;

    local ExperienceInviteOptions = Instance.new("ExperienceInviteOptions");
    ExperienceInviteOptions.PromptMessage = "Invite a friend for FREE REWARDS";
    InviteFriends.MouseButton1Click:Connect(function() -- Line: 39
        -- upvalues: SocialService (ref), LocalPlayer (ref), ExperienceInviteOptions (copy)
        SocialService:PromptGameInvite(LocalPlayer, ExperienceInviteOptions);
    end);
    Knit.GetService("FriendInvitesService").Notify:Connect(function(p3: string) -- Line: 44
        -- upvalues: Effects (ref)
        Effects:Popup(p3, 5, Color3.fromRGB(0, 255, 0));
    end);
end;

function v1.KnitStart(p4) -- Line: 49
end;

return v1;