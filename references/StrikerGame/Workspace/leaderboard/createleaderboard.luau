 

 

local DataStoreService = game:GetService("DataStoreService");
local ServerStorage = game:GetService("ServerStorage");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local script_retryAsync = require(script.retryAsync);
local profile = require(ServerStorage:WaitForChild("profile"));
local emoteWiki = ReplicatedStorage.emoteWiki;
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local animationUtil = require(ReplicatedStorage.util.animationUtil);
local u1 = require(emoteWiki);
local u2 = {};

for i, _ in u1 do
    table.insert(u2, i);
end;

return function(u3, p4) -- Line: 17
    -- upvalues: DataStoreService (copy), u1 (copy), u2 (copy), animationUtil (copy), soundUtil (copy), Players (copy), script_retryAsync (copy), profile (copy)
    local OrderedDataStore = DataStoreService:GetOrderedDataStore((`azure.latch.leaderboardV2.{u3}`));
    local u5 = script.Parent[u3];
    local List = u5.sufui.List;
    local Rig = u5.Rig;
    local animation = u1[u2[Random.new():NextInteger(1, #u2)]].animation;

    if animation then
        local v6 = animationUtil:loadAnimation(Rig, animation);
        v6.Looped = true;
        v6:Play();
    end;

    local function updateLeaderboard() -- Line: 31
        -- upvalues: soundUtil (ref), u5 (copy), List (copy), OrderedDataStore (copy), Players (ref), Rig (copy)
        soundUtil:play(script.spawn, u5);

        for _, child in List:GetChildren() do
            if child:IsA("Frame") then
                child:Destroy();
            end;
        end;

        local CurrentPage = OrderedDataStore:GetSortedAsync(false, 100, 1, 1e31):GetCurrentPage();
        local v7 = {};

        for _, v in ipairs(CurrentPage) do
            local key = v.key;
            local value = v.value;
            local u8 = "[Failed To Load]";
            local _, _ = pcall(function() -- Line: 52
                -- upvalues: u8 (ref), Players (ref), key (copy)
                u8 = Players:GetNameFromUserIdAsync(key);
            end);
            local v9 = {
                u8,
                value,
                Players:GetUserThumbnailAsync(key, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150),
                key
            };
            table.insert(v7, v9);
        end;

        for i, v in pairs(v7) do
            local v10 = v[1];
            local v11 = v[2];
            local v12 = v[3];
            local u13 = v[4];
            local v14 = script.Template:Clone();
            v14.LayoutOrder = i;
            v14.ImageLabel.Image = v12;
            v14.pname.Text = v10;
            v14.score.Text = v11;
            v14.Parent = List;
            v14.Name = v10;
            v14.Visible = true;

            if i < 4 then
                v14.topgradient.Enabled = true;

                if i == 1 then
                    v14.topgradient.Color = ColorSequence.new(Color3.fromRGB(255, 218, 85));
                    local _, _ = pcall(function() -- Line: 83
                        -- upvalues: Players (ref), u13 (copy), Rig (ref)
                        local HumanoidDescriptionFromUserId = Players:GetHumanoidDescriptionFromUserId(u13);
                        Rig.Humanoid:ApplyDescriptionReset(HumanoidDescriptionFromUserId);
                    end);
                elseif i == 2 then
                    v14.topgradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255));
                else
                    v14.topgradient.Color = ColorSequence.new(Color3.fromRGB(255, 119, 74));
                end;
            else
                v14.Transparency = 1;
            end;
        end;

        return true;
    end;

    local v15 = true;

    while v15 and task.wait(math.random(p4[2][1], p4[2][2])) or task.wait(p4[1]) do
        if v15 then
            v15 = false;
        end;

        script_retryAsync(function() -- Line: 123
            -- upvalues: Players (ref), profile (ref), OrderedDataStore (copy), u3 (copy), updateLeaderboard (copy)
            for _, v in Players:GetPlayers() do
                local Data = profile.getData(v);

                if Data then
                    OrderedDataStore:SetAsync(v.UserId, Data.profile.Data[u3]);
                end;
            end;

            return updateLeaderboard();
        end, 3, 1, 2);
    end;
end;