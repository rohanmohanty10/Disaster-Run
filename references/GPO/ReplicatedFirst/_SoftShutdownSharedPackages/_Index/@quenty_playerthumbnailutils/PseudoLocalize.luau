 

local u16 = {
    ["pseudoLocalize"] = function(p1) --[[ Name: pseudoLocalize, Line 15 ]]
        --[[
        Upvalues:
            [1] = u16
        --]]
        local v2 = u16.PSEUDO_CHARACTER_MAP
        local v3 = ""
        local v4 = false
        for v5, v6 in utf8.graphemes(p1) do
            local v7 = p1:sub(v5, v6)
            if v7 == "{" or v7 == "[" then
                v3 = v3 .. v7
                v4 = true
            elseif v7 == "}" or v7 == "]" then
                v3 = v3 .. v7
                v4 = false
            elseif v4 or not v2[v7] then
                v3 = v3 .. v7
            else
                v3 = v3 .. v2[v7]
            end
        end
        return v3
    end,
    ["addToLocalizationTable"] = function(p8, p9, p10) --[[ Name: addToLocalizationTable, Line 46 ]]
        --[[
        Upvalues:
            [1] = u16
        --]]
        local v11 = p8:GetEntries()
        local v12 = p9 or "qlp-pls"
        local v13 = p10 or "en"
        for _, v14 in pairs(v11) do
            if not v14.Values[v12] then
                local v15 = v14.Values[v13]
                if v15 then
                    v14.Values[v12] = u16.pseudoLocalize(v15)
                else
                    warn(("[PseudoLocalize.addToLocalizationTable] - No entry in key %q for locale %q"):format(v14.Key, v13))
                end
            end
        end
        p8:SetEntries(v11)
    end,
    ["PSEUDO_CHARACTER_MAP"] = {
        ["a"] = "\195\161",
        ["b"] = "\206\178",
        ["c"] = "\195\167",
        ["d"] = "\206\180",
        ["e"] = "\195\168",
        ["f"] = "\198\146",
        ["g"] = "\207\177",
        ["h"] = "\206\187",
        ["i"] = "\195\175",
        ["j"] = "J",
        ["k"] = "\198\153",
        ["l"] = "\226\132\147",
        ["m"] = "\226\130\165",
        ["n"] = "\195\177",
        ["o"] = "\195\180",
        ["p"] = "\198\165",
        ["q"] = "9",
        ["r"] = "\197\153",
        ["s"] = "\198\168",
        ["t"] = "\198\173",
        ["u"] = "\195\186",
        ["v"] = "\198\178",
        ["w"] = "\207\137",
        ["x"] = "\208\182",
        ["y"] = "\194\165",
        ["z"] = "\198\186",
        ["A"] = "\195\130",
        ["B"] = "\195\159",
        ["C"] = "\195\135",
        ["D"] = "\195\144",
        ["E"] = "\195\137",
        ["F"] = "F",
        ["G"] = "G",
        ["H"] = "H",
        ["I"] = "\195\140",
        ["J"] = "J",
        ["K"] = "K",
        ["L"] = "\194\163",
        ["M"] = "M",
        ["N"] = "N",
        ["O"] = "\195\147",
        ["P"] = "\195\158",
        ["Q"] = "Q",
        ["R"] = "R",
        ["S"] = "\194\167",
        ["T"] = "T",
        ["U"] = "\195\155",
        ["V"] = "V",
        ["W"] = "W",
        ["X"] = "X",
        ["Y"] = "\195\157",
        ["Z"] = "Z"
    }
}
return u16