  

local BlueLockCupEventData = require(script.Parent.BlueLockCupEventData);
local v1 = { "The Egoist", "The Emperor", "Monster", "New Gen 11", "Chameleon", "Wildcard" };
local v2 = { "WorldCupEgoist", "NEL_REAL", "NEL_Munchen", "NEL_PXG", "NEL_Arsenaly", "NEL_Manshine", "NEL_Barcha", "NEL_Ubers", "WT_Striker", "WT_Defender", "WT_Keeper" };
local v3 = {};
local v4 = {
    Order = v1,
    LegendaryOrder = v1,
    DisplayOrder = { "The Egoist", "The Emperor", "Monster", "New Gen 11", "Chameleon", "Wildcard", "WorldCupEgoist", "NEL_REAL", "NEL_Munchen", "NEL_PXG", "NEL_Arsenaly", "NEL_Manshine", "NEL_Barcha", "NEL_Ubers", "WT_Striker", "WT_Defender", "WT_Keeper" },
    SourceOrder = v2,
    ["The Egoist"] = {
        DisplayName = "The Egoist",
        Color = "#3B82F6",
        StrokeColor = "#07172E",
        Gamepass = "LegendaryTitles"
    },
    ["The Emperor"] = {
        DisplayName = "The Emperor",
        Color = "#EF4444",
        StrokeColor = "#3A0808",
        Gamepass = "LegendaryTitles"
    },
    Monster = {
        DisplayName = "Monster",
        Color = "#FACC15",
        StrokeColor = "#3B2F00",
        Gamepass = "LegendaryTitles"
    },
    ["New Gen 11"] = {
        DisplayName = "New Gen 11",
        Color = "#FFFFFF",
        StrokeColor = "#111111",
        Gamepass = "LegendaryTitles"
    },
    Chameleon = {
        DisplayName = "Chameleon",
        Color = "#A855F7",
        StrokeColor = "#25043F",
        Gamepass = "LegendaryTitles"
    },
    Wildcard = {
        DisplayName = "Wildcard",
        Color = "#F97316",
        StrokeColor = "#451A03",
        Gamepass = "LegendaryTitles"
    },
    WorldCupEgoist = {
        DisplayName = "Egoist",
        Color = "#FFC337",
        StrokeColor = "#5C3700",
        Source = "ChatTag",
        ChatTag = "Egoist"
    },
    NEL_REAL = {
        DisplayName = "REAL",
        Color = "#5A96FF",
        StrokeColor = "#07172E",
        Source = "ChatTag",
        ChatTag = "REAL Tag"
    },
    NEL_Munchen = {
        DisplayName = "Munchen",
        Color = "#FF5A5A",
        StrokeColor = "#4A0808",
        Source = "ChatTag",
        ChatTag = "Munchen Tag"
    },
    NEL_PXG = {
        DisplayName = "PXG",
        Color = "#3764E6",
        StrokeColor = "#060B2E",
        Source = "ChatTag",
        ChatTag = "PXG Tag"
    },
    NEL_Arsenaly = {
        DisplayName = "Arsenaly",
        Color = "#FFC34B",
        StrokeColor = "#4A1F00",
        Source = "ChatTag",
        ChatTag = "Arsenaly Tag"
    },
    NEL_Manshine = {
        DisplayName = "Manshine",
        Color = "#87D7FF",
        StrokeColor = "#07334A",
        Source = "ChatTag",
        ChatTag = "Manshine Tag"
    },
    NEL_Barcha = {
        DisplayName = "Barcha",
        Color = "#A02350",
        StrokeColor = "#2A0612",
        Source = "ChatTag",
        ChatTag = "Barcha Tag"
    },
    NEL_Ubers = {
        DisplayName = "Ubers",
        Color = "#8C5FD7",
        StrokeColor = "#21083D",
        Source = "ChatTag",
        ChatTag = "Ubers Tag"
    },
    WT_Striker = {
        DisplayName = "STRIKER",
        Color = "#EF4444",
        StrokeColor = "#3A0808",
        Source = "ChatTag",
        ChatTag = "Striker Tag"
    },
    WT_Defender = {
        DisplayName = "DEFENDER",
        Color = "#22C55E",
        StrokeColor = "#052E12",
        Source = "ChatTag",
        ChatTag = "Defender Tag"
    },
    WT_Keeper = {
        DisplayName = "KEEPER",
        Color = "#A855F7",
        StrokeColor = "#25043F",
        Source = "ChatTag",
        ChatTag = "Keeper Tag"
    }
};

for _, v in BlueLockCupEventData.Groups do
    for _, v5 in v do
        table.insert(v3, v5);
    end;
end;

table.sort(v3, function(p5, p6) -- Line: 177
    return p5.Name < p6.Name;
end);

for _, v in v3 do
    local v7 = "WorldCupTeam_" .. string.gsub(v.Code, "[^%w]", "_");
    local TeamChatTag = BlueLockCupEventData.GetTeamChatTag(v.Name);
    table.insert(v2, v7);
    table.insert(v4.DisplayOrder, v7);
    v4[v7] = {
        Color = "#FFC337",
        StrokeColor = "#5C3700",
        Source = "ChatTag",
        DisplayName = TeamChatTag,
        ChatTag = TeamChatTag
    };
end;

return v4;