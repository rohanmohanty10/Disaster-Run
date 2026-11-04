  

local u1 = {
    PlayerCard = "Cards",
    Cosmetic = "Cosmetics",
    Emote = "Emotes",
    GoalEffect = "GoalEffects",
    BallSkin = "BallSkins",
    MVPCutscene = "MVPCutscenes"
};

return function(p2: any, p3: string, p4: string) -- Line: 19, Name: playerOwnsItem
    -- upvalues: u1 (copy)
    if not u1[p3] then
        return false;
    end;

    local v5 = u1[p3];
    assert(v5);

    return table.find(p2.Customization[v5], p4) ~= nil;
end;