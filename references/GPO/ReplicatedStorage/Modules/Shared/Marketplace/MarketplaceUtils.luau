 

game:GetService("Players")
local u1 = game:GetService("MarketplaceService")
local v2 = script.Parent.Parent.Promises
local u3 = require(v2.Promise)
return {
    ["PromiseGetProductInfo"] = function(u4, u5) --[[ Name: PromiseGetProductInfo, Line 12 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u1
        --]]
        return u3.spawn(function(p6, p7) --[[ Line: 13 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u4
                [3] = u5
            --]]
            local u8 = nil
            local v9, v10 = pcall(function() --[[ Line: 17 ]]
                --[[
                Upvalues:
                    [1] = u8
                    [2] = u1
                    [3] = u4
                    [4] = u5
                --]]
                u8 = u1:GetProductInfo(u4, u5 or Enum.InfoType.Asset)
            end)
            if not v9 then
                p7(v10)
            end
            p6(u8)
        end)
    end,
    ["convertAssetTypeIdToAssetType"] = function(p11) --[[ Name: convertAssetTypeIdToAssetType, Line 29 ]]
        local v12 = type(p11) == "number"
        assert(v12, "Bad assetTypeId")
        for _, v13 in pairs(Enum.AssetType:GetEnumItems()) do
            if v13.Value == p11 then
                return v13
            end
        end
        return nil
    end,
    ["convertAssetTypeIdToAvatarAssetType"] = function(p14) --[[ Name: convertAssetTypeIdToAvatarAssetType, Line 41 ]]
        local v15 = type(p14) == "number"
        assert(v15, "Bad assetTypeId")
        for _, v16 in pairs(Enum.AvatarAssetType:GetEnumItems()) do
            if v16.Value == p14 then
                return v16
            end
        end
        return nil
    end,
    ["promiseUserOwnsGamePass"] = function(u17, u18) --[[ Name: promiseUserOwnsGamePass, Line 53 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u1
        --]]
        local v19 = typeof(u17) == "number"
        assert(v19, "Bad userId")
        local v20 = type(u18) == "number"
        assert(v20, "Bad gamePassId")
        return u3.spawn(function(p21, p22) --[[ Line: 57 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u17
                [3] = u18
            --]]
            local u23 = nil
            local v24, v25 = pcall(function() --[[ Line: 59 ]]
                --[[
                Upvalues:
                    [1] = u23
                    [2] = u1
                    [3] = u17
                    [4] = u18
                --]]
                u23 = u1:UserOwnsGamePassAsync(u17, u18)
            end)
            if v24 then
                local v26 = u23
                if type(v26) == "boolean" then
                    return p21(u23)
                else
                    return p22("Bad result type")
                end
            else
                return p22(v25)
            end
        end)
    end,
    ["promisePlayerOwnsAsset"] = function(u27, u28) --[[ Name: promisePlayerOwnsAsset, Line 72 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u1
        --]]
        local v29 = typeof(u27) == "Instance"
        assert(v29, "Bad player")
        local v30 = type(u28) == "number"
        assert(v30, "Bad assetId")
        return u3.spawn(function(p31, p32) --[[ Line: 76 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u27
                [3] = u28
            --]]
            local u33 = nil
            local v34, v35 = pcall(function() --[[ Line: 78 ]]
                --[[
                Upvalues:
                    [1] = u33
                    [2] = u1
                    [3] = u27
                    [4] = u28
                --]]
                u33 = u1:PlayerOwnsAsset(u27, u28)
            end)
            if v34 then
                local v36 = u33
                if type(v36) == "boolean" then
                    return p31(u33)
                else
                    return p32("Bad result type")
                end
            else
                return p32(v35)
            end
        end)
    end,
    ["promisePlayerOwnsBundle"] = function(u37, u38) --[[ Name: promisePlayerOwnsBundle, Line 91 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u1
        --]]
        local v39 = typeof(u37) == "Instance"
        assert(v39, "Bad player")
        local v40 = type(u38) == "number"
        assert(v40, "Bad bundleId")
        return u3.spawn(function(p41, p42) --[[ Line: 95 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u37
                [3] = u38
            --]]
            local u43 = nil
            local v44, v45 = pcall(function() --[[ Line: 97 ]]
                --[[
                Upvalues:
                    [1] = u43
                    [2] = u1
                    [3] = u37
                    [4] = u38
                --]]
                u43 = u1:PlayerOwnsBundle(u37, u38)
            end)
            if v44 then
                local v46 = u43
                if type(v46) == "boolean" then
                    return p41(u43)
                else
                    return p42("Bad result type")
                end
            else
                return p42(v45)
            end
        end)
    end
}