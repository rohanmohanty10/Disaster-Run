 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local SoundService = game:GetService("SoundService");
game:GetService("RunService");
game:GetService("UserInputService");
game:GetService("TextChatService");
game:GetService("StarterGui");
game:GetService("MarketplaceService");
local AvatarEditorService = game:GetService("AvatarEditorService");
local _ = workspace.CurrentCamera;
local soundUtil = require(ReplicatedStorage.util.soundUtil);
require(ReplicatedStorage.util.actionUtil);
require(ReplicatedStorage.util.raycast);
require(ReplicatedStorage.util.animationUtil);
require(ReplicatedStorage.forum.trove);
require(ReplicatedStorage.forum.fastSignal);
local starterPlayer = ReplicatedStorage.client.starterPlayer;
local packets = require(ReplicatedStorage.packets);

return function(u1) -- Line: 27
    -- upvalues: AvatarEditorService (copy), starterPlayer (copy), Players (copy), soundUtil (copy), ReplicatedStorage (copy), SoundService (copy), packets (copy)
    u1:destroyContainer();
    print(u1.outfitPermission);
    local u2 = 0;
    local outfitPermission = u1.outfitPermission;
    local u3 = {};

    local function promptPermission() -- Line: 50
        -- upvalues: AvatarEditorService (ref), outfitPermission (ref)
        AvatarEditorService:PromptAllowInventoryReadAccess();
        outfitPermission = AvatarEditorService.PromptAllowInventoryReadAccessCompleted:Wait();
    end;

    local function getAllOutfits(p4: userdata) -- Line: 55
        -- upvalues: outfitPermission (ref), u3 (copy)
        while outfitPermission do
            for _, v in ipairs(p4:GetCurrentPage()) do
                if v.IsEditable then
                    table.insert(u3, v);
                end;
            end;

            task.wait();

            if p4.IsFinished then
                break;
            end;

            p4:AdvanceToNextPageAsync();
        end;
    end;

    if not outfitPermission then
        AvatarEditorService:PromptAllowInventoryReadAccess();
        outfitPermission = AvatarEditorService.PromptAllowInventoryReadAccessCompleted:Wait();

        if outfitPermission ~= Enum.AvatarPromptResult.Success then
            u1.inoutfit = false;

            return;
        end;

        u1.Permission = true;
    end;

    getAllOutfits(AvatarEditorService:GetOutfits());
    local u5 = starterPlayer.Outfit:Clone();
    u5.Parent = u1.playerGui;
    local Frame2 = u5.Frame.Frame2;
    local char = Frame2.char;
    local u6 = char.ViewportFrame.WorldModel.Preview:FindFirstChildOfClass("Humanoid");
    local v7 = Frame2.base:Clone();
    v7.Parent = Frame2.Storage;
    v7.Main.Text = "Default";
    v7.Visible = true;
    v7.Button.MouseButton1Up:connect(function() -- Line: 98
        -- upvalues: char (copy), Players (ref), u1 (copy), u6 (copy), soundUtil (ref), ReplicatedStorage (ref), SoundService (ref), u2 (ref)
        char.outfitName.Text = "Default";
        u6:ApplyDescription((Players:GetHumanoidDescriptionFromUserId(u1.player.UserId)));
        soundUtil:play(ReplicatedStorage.Resources.click, SoundService);
        u2 = 0;
    end);

    for _, v in u3 do
        local v8 = Frame2.base:Clone();
        v8.Parent = Frame2.Storage;
        v8.Main.Text = v.Name;
        v8.Visible = true;
        v8.Button.MouseButton1Up:connect(function() -- Line: 120
            -- upvalues: char (copy), v (copy), Players (ref), u6 (copy), soundUtil (ref), ReplicatedStorage (ref), SoundService (ref), u2 (ref)
            char.outfitName.Text = v.Name;
            u6:ApplyDescription((Players:GetHumanoidDescriptionFromOutfitId(v.Id)));
            soundUtil:play(ReplicatedStorage.Resources.click, SoundService);
            u2 = v.Id;
        end);
    end;

    Frame2.Close.Button.MouseButton1Up:Once(function() -- Line: 141
        -- upvalues: soundUtil (ref), ReplicatedStorage (ref), SoundService (ref), packets (ref), u2 (ref), u5 (copy)
        soundUtil:play(ReplicatedStorage.Resources.click, SoundService);
        packets.bytenet_settingChange.send({
            name = "awakeningOutfitId",
            value = u2
        });
        u5:Destroy();
    end);
end;