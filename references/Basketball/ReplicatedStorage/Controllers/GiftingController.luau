 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local LocalPlayer = Players.LocalPlayer;
local Knit = require(ReplicatedStorage.Packages.Knit);
local Trove = require(ReplicatedStorage.Packages.Trove);
local Promise = require(ReplicatedStorage.Packages.Promise);
local CustomScrollbar = require(ReplicatedStorage.Shared.Utility.CustomScrollbar);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local GiftPlayer = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("GiftPlayer");
local u1 = Trove.new();
local u2 = CustomScrollbar.new(GiftPlayer:WaitForChild("Content"):WaitForChild("Content"), GiftPlayer.Content.Content:WaitForChild("Scrollbar"):WaitForChild("Scrollbar"));
local u3 = Knit.CreateController({
    Name = "GiftingController",
    PlayerIconCache = {}
});

function u3.PromptPlayerSelect(u4: function, p5: function?) -- Line: 22
    -- upvalues: u1 (copy), u2 (copy), GiftPlayer (copy), Players (copy), Promise (copy), u3 (copy)
    u1:Clean();
    u2:Start();
    GiftPlayer.Enabled = true;
    local v6 = {};

    for _, v in Players:GetPlayers() do
        if not p5 or p5(v) ~= false then
            table.insert(v6, Promise.new(function(p7) -- Line: 35
                -- upvalues: u1 (ref), v (copy), u3 (ref), GiftPlayer (ref), u4 (copy)
                local v8 = u1:Add(script:WaitForChild("Player"):Clone());
                v8.PlayerIcon_Outline.Background.PlayerNickname.Text = `@{v.Name}`;
                local v9 = u3.PlayerIconCache[v.UserId];

                if not v9 then
                    v9 = `rbxthumb://type=AvatarHeadShot&id={v.UserId}&w=48&h=48`;
                    u3.PlayerIconCache[v.UserId] = v9;
                end;

                v8.PlayerIcon_Outline.PlayerIcon.Image = v9;
                v8.Parent = GiftPlayer.Content.Content;
                v8.Select.MouseButton1Click:Connect(function() -- Line: 49
                    -- upvalues: u4 (ref), v (ref), u1 (ref)
                    task.spawn(u4, v);
                    u1:Clean();
                end);
                p7();
            end));
        end;
    end;

    u1:AddPromise(Promise.allSettled(v6));
    u1:Add(function() -- Line: 61
        -- upvalues: GiftPlayer (ref), u2 (ref)
        GiftPlayer.Enabled = false;
        u2:Stop();
    end);
end;

function u3.PromptGiftPlayer(u10: number, u11: function?) -- Line: 67
    -- upvalues: u1 (copy), u2 (copy), GiftPlayer (copy), Players (copy), LocalPlayer (copy), Promise (copy), u3 (copy), Knit (copy), Effects (copy)
    u1:Clean();
    u2:Start();
    GiftPlayer.Enabled = true;
    local v12 = {};

    for _, v in Players:GetPlayers() do
        if v ~= LocalPlayer then
            table.insert(v12, Promise.new(function(p13) -- Line: 80
                -- upvalues: u1 (ref), v (copy), u3 (ref), GiftPlayer (ref), u11 (copy), Knit (ref), u10 (copy), Effects (ref)
                local v14 = u1:Add(script:WaitForChild("Player"):Clone());
                v14.PlayerIcon_Outline.Background.PlayerNickname.Text = `@{v.Name}`;
                local v15 = u3.PlayerIconCache[v.UserId];

                if not v15 then
                    v15 = `rbxthumb://type=AvatarHeadShot&id={v.UserId}&w=48&h=48`;
                    u3.PlayerIconCache[v.UserId] = v15;
                end;

                v14.PlayerIcon_Outline.PlayerIcon.Image = v15;
                v14.Parent = GiftPlayer.Content.Content;
                v14.Select.MouseButton1Click:Connect(function() -- Line: 94
                    -- upvalues: u11 (ref), v (ref), Knit (ref), u10 (ref), Effects (ref), u1 (ref)
                    if u11 and u11(v) == false then
                        return;
                    end;

                    local v16, v17 = Knit.GetService("MarketService"):GiftProduct(v, u10);

                    if v16 == false then
                        Effects:Popup(v17, 5, Color3.fromRGB(255, 0, 0));
                    end;

                    u1:Clean();
                end);
                p13();
            end));
        end;
    end;

    u1:AddPromise(Promise.allSettled(v12));
    u1:Add(function() -- Line: 116
        -- upvalues: GiftPlayer (ref), u2 (ref)
        GiftPlayer.Enabled = false;
        u2:Stop();
    end);
end;

function u3.KnitInit(p18) -- Line: 122
    -- upvalues: GiftPlayer (copy), u1 (copy)
    GiftPlayer.Content:WaitForChild("Close").MouseButton1Click:Connect(function() -- Line: 123
        -- upvalues: u1 (ref)
        u1:Clean();
    end);
end;

function u3.KnitStart(p19) -- Line: 128
    -- upvalues: Knit (copy), Effects (copy)
    Knit.GetService("MarketService").OnPlayerGifted:Connect(function(p20: string) -- Line: 131
        -- upvalues: Effects (ref)
        Effects:Popup(p20, 4, Color3.fromRGB(0, 255, 0));
    end);
end;

return u3;