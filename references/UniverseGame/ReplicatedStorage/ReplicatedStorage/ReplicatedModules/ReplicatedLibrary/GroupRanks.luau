  

 

local u1 = { 298048611, 47351572, 44197365, 799577326 };
local u4 = {
    Ranks = {
        [696133166] = {
            TagText = "The Wolf",
            Executor = true,
            StandChanger = true,
            OtherStandChanger = true,
            TagColor = Color3.fromRGB(0, 0, 0)
        },
        [252] = {
            TagText = "Director",
            Executor = true,
            StandChanger = true,
            OtherStandChanger = true,
            TagColor = Color3.fromRGB(255, 100, 0)
        },
        [249] = {
            TagText = "Head Developer",
            Executor = true,
            StandChanger = true,
            OtherStandChanger = true,
            TagColor = Color3.fromRGB(255, 103, 0)
        },
        [248] = {
            TagText = "Scripter",
            Executor = true,
            StandChanger = true,
            TagColor = Color3.fromRGB(158, 112, 203)
        },
        [247] = {
            TagText = "Animator",
            StandChanger = true,
            TagColor = Color3.fromRGB(158, 112, 203)
        },
        [246] = {
            TagText = "3D Modeller",
            StandChanger = true,
            TagColor = Color3.fromRGB(158, 112, 203)
        },
        [243] = {
            TagText = "SFX Designer",
            StandChanger = true,
            TagColor = Color3.fromRGB(158, 112, 203)
        },
        [220] = {
            TagText = "Contributor",
            TagColor = Color3.fromRGB(255, 85, 0)
        },
        [206] = {
            TagText = "Head of Staff",
            StandChanger = true,
            TagColor = Color3.fromRGB(111, 130, 255)
        },
        [205] = {
            TagText = "Admin",
            StandChanger = true,
            TagColor = Color3.fromRGB(188, 22, 24)
        },
        [202] = {
            TagText = "Head Moderator",
            TagColor = Color3.fromRGB(23, 34, 188)
        },
        [201] = {
            TagText = "Moderator",
            TagColor = Color3.fromRGB(20, 160, 188)
        },
        [200] = {
            TagText = "Trading Staff",
            TagColor = Color3.fromRGB(255, 185, 42)
        },
        [7] = {
            TagText = "Info Manager",
            TagColor = Color3.fromRGB(255, 185, 42)
        },
        [6] = {
            TagText = "Uncle Tester",
            TagColor = Color3.fromRGB(85, 170, 255)
        },
        [5] = {
            TagText = "Tester",
            TagColor = Color3.fromRGB(78, 252, 237)
        },
        [4] = {
            TagText = "Youtuber",
            TagColor = Color3.fromRGB(255, 0, 0)
        },
        [459880822] = {
            TagText = "Sixer",
            StandChanger = true,
            TagColor = Color3.fromRGB(170, 0, 255)
        },
        [186015418] = {
            TagText = "<font face=\"Jura\" weight=\"bold\"><b>Hands Of Time</b></font>",
            Executor = true,
            StandChanger = true,
            TagColor = Color3.fromRGB(152, 255, 181)
        }
    },
    RankCallbacks = {
        Challenger = {
            Priority = 100,
            TagColor = Color3.fromRGB(255, 255, 0),

            Requirement = function(p2) -- Line: 38, Name: Requirement
                -- upvalues: u1 (copy)
                return table.find(u1, p2.UserId);
            end
        },
        Donator = {
            Priority = 1,
            TagColor = Color3.fromRGB(170, 0, 255),

            Requirement = function(p3) -- Line: 45, Name: Requirement
                return p3:GetAttribute("Donator");
            end
        }
    }
};

for i, v in pairs(u4.Ranks) do
    v.RankId = i;
end;

for i, v in pairs(u4.RankCallbacks) do
    v.TagText = i;
end;

if game.GameId == 1900951801 then
    for _, v in pairs(u4.Ranks) do
        v.StandChanger = true;
    end;
end;

function u4.GetRank(p5) -- Line: 72
    -- upvalues: u4 (copy)
    local v6 = p5:GetAttribute("GroupRank") or 0;
    local v7 = u4.Ranks[p5.UserId] or u4.Ranks[v6];

    if v7 then
        return v7;
    end;

    local v8 = 0;

    for _, v in pairs(u4.RankCallbacks) do
        if type(v.Priority) == "number" and (v.Priority > v8 and v.Requirement(p5)) then
            v8 = v.Priority;
            v7 = v;
        end;
    end;

    return v7 or {};
end;

local MarketplaceService = game:GetService("MarketplaceService");
local RBXGeneral = game:GetService("TextChatService"):WaitForChild("TextChannels"):WaitForChild("RBXGeneral");

if game:GetService("RunService"):IsServer() then
    local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
    local Knit = require(PathShortcuts.KnitPath.Knit);
    Knit.OnStart():await();
    local u9 = Knit.GetService("ShopService");

    local function CacheRankValues(p10) -- Line: 102
        -- upvalues: RBXGeneral (copy), MarketplaceService (copy), u9 (copy)
        p10:SetAttribute("GroupRank", p10:GetRankInGroup(6556072));
        local v11 = RBXGeneral:FindFirstChild(p10.Name);

        if v11 then
            v11:SetAttribute("GroupRank", p10:GetAttribute("GroupRank"));
            v11:SetAttribute("ToggleTag", p10:GetAttribute("ToggleTag") == nil and true or p10:GetAttribute("ToggleTag"));
        end;

        if MarketplaceService:UserOwnsGamePassAsync(p10.UserId, 10753254) or u9.OwnsGamepass(p10.UserId, 10753254) then
            p10:SetAttribute("Donator", true);

            if v11 then
                v11:SetAttribute("Donator", true);
            end;
        end;
    end;

    game.Players.PlayerAdded:Connect(CacheRankValues);

    for _, v in game.Players:GetPlayers() do
        task.spawn(CacheRankValues, v);
    end;
end;

return u4;