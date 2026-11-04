 

 

local HttpService = game:GetService("HttpService");
local u1 = {};

local function encode_rank_colors(p2) -- Line: 7
    local v3 = {};

    for _, v in p2.Color or {
        { 0, Color3.fromRGB(255, 255, 255) },
        { 1, Color3.fromRGB(171, 171, 171) }
    } do
        table.insert(v3, {
            v[1],
            v[2].R,
            v[2].G,
            v[2].B
        });
    end;

    return v3;
end;

function u1.build_ranked_title_json(p4: number, p5: any) -- Line: 16
    -- upvalues: HttpService (copy), encode_rank_colors (copy)
    return HttpService:JSONEncode({
        tagText = string.format("(%s) %s", "S" .. p4, p5.Name),
        tagColor = encode_rank_colors(p5)
    });
end;

function u1.archive_season_ranked_title(p6: any, p7: number, p8: number, p9: any) -- Line: 23
    -- upvalues: u1 (copy)
    local storage = p6.storage;

    if not storage then
        return;
    end;

    if not storage.special_titles then
        storage.special_titles = {};
    end;

    local v10 = `S{p7} Ranked Title`;
    local RankedTitle = storage.special_titles.RankedTitle;

    if typeof(RankedTitle) == "string" and RankedTitle ~= "" then
        storage.special_titles[v10] = RankedTitle;
    else
        local v11 = p9.ReturnRank(p8);

        if v11.Name ~= "Unranked" then
            storage.special_titles[v10] = u1.build_ranked_title_json(p7, v11);
        end;
    end;

    storage.special_titles.RankedTitle = nil;
end;

function u1.apply(p12: any, p13: number, p14: any) -- Line: 47
    -- upvalues: u1 (copy)
    if p12.currentSeason == p13 then
        return false;
    end;

    local currentSeason = p12.currentSeason;
    local v15 = p12.elo or 0;

    if typeof(currentSeason) == "number" and (currentSeason > 0 and currentSeason ~= p13) then
        u1.archive_season_ranked_title(p12, currentSeason, v15, p14);
    end;

    p12.elo = 0;
    p12.currentSeason = p13;
    p12.lastSeasonPlayed = p13;

    return true;
end;

function u1.sync_live_ranked_title(p16: any, p17: number, p18: any) -- Line: 66
    -- upvalues: u1 (copy)
    local storage = p16.storage;

    if not storage then
        return;
    end;

    if not storage.special_titles then
        storage.special_titles = {};
    end;

    local v19 = p18.ReturnRank(p16.elo or 0);

    if v19.Name == "Unranked" then
        storage.special_titles.RankedTitle = nil;

        return;
    end;

    storage.special_titles.RankedTitle = u1.build_ranked_title_json(p17, v19);
end;

return u1;