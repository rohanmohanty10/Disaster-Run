 

local u1 = game:GetService("ReplicatedStorage")
local u2 = game:GetService("Players")
local u3 = game:GetService("MarketplaceService")
local v7 = {
    ["GetMemberCount"] = function(p4) --[[ Name: GetMemberCount, Line 7 ]]
        local v5 = 0
        for _, v6 in pairs(p4.Members) do
            for _, _ in pairs(v6) do
                v5 = v5 + 1
            end
        end
        return v5
    end
}
local u8 = {}
function v7.IsImageIdValid(u9) --[[ Line: 20 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u3
    --]]
    if u8[u9] == nil then
        local u10 = nil
        local v11, _ = pcall(function() --[[ Line: 28 ]]
            --[[
            Upvalues:
                [1] = u10
                [2] = u3
                [3] = u9
            --]]
            u10 = u3:GetProductInfo(u9, Enum.InfoType.Asset)
        end)
        if v11 then
            if v11 and (u10 and ({
                [1] = true,
                [13] = true
            })[u10.AssetTypeId] ~= true) then
                u8[u9] = {
                    ["Success"] = false,
                    ["Result"] = "Invalid Image Id"
                }
                return false, "Invalid Image Id"
            else
                u8[u9] = {
                    ["Success"] = true,
                    ["Result"] = u10
                }
                return v11, u10
            end
        else
            return false, "Roblox error has occured"
        end
    else
        return u8[u9].Success, u8[u9].Result
    end
end
function v7.IsPositiveInteger(p12) --[[ Line: 52 ]]
    if type(p12) == "number" then
        if p12 == p12 and p12 > 0 then
            return p12 % 1 == 0
        else
            return false
        end
    else
        return false
    end
end
function v7.WaitForStatsFolder(p13, p14) --[[ Line: 64 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v15 = u1:FindFirstChild("Stats" .. p13.Name)
    if v15 == nil then
        local v16 = p14 or 1.5
        while v15 == nil and p13:IsDescendantOf(u2) do
            v15 = u1:FindFirstChild("Stats" .. p13.Name)
            if v15 ~= nil then
                break
            end
            task.wait(v16)
        end
    end
    return v15
end
function v7.GetLowestRankInCrew(p17) --[[ Line: 88 ]]
    local v18 = p17.Ranks
    local v19 = (1 / 0)
    local v20 = nil
    for v21, v22 in pairs(v18) do
        if v22.Id < v19 then
            v19 = v22.Id
            v20 = v21
        end
    end
    return v20
end
function v7.GetDefaultRank(p23) --[[ Line: 104 ]]
    local v24 = p23.Ranks
    local v25 = nil
    for v26, v27 in pairs(v24) do
        if v27.IsDefault == true then
            return v26
        end
    end
    return v25
end
function v7.GetRankInCrew(p28, p29) --[[ Line: 118 ]]
    local v30 = p29.Members or nil
    if v30 == nil then
        return "Unable to get rank (Invalid Members)"
    end
    local v31 = nil
    for v32, v33 in pairs(v30) do
        local v34 = p28.UserId
        if v33[tostring(v34)] ~= nil then
            return v32
        end
    end
    return v31
end
function v7.GetRankInCrewById(p35, p36) --[[ Line: 136 ]]
    local v37 = p36.Members or nil
    if v37 == nil then
        return "Unable to get rank (Invalid Members)"
    end
    local v38 = nil
    local v39 = nil
    for v40, v41 in pairs(v37) do
        if v41[tostring(p35)] ~= nil then
            return v40, v41[tostring(p35)]
        end
    end
    return v38, v39
end
return v7