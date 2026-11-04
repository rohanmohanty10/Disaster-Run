 

local u1 = game:GetService("LocalizationService")
local u2 = game:GetService("HttpService")
local u3 = game:GetService("RunService")
local u4 = {}
local function u12(p5, p6, p7, p8) --[[ Line: 22 ]]
    --[[
    Upvalues:
        [1] = u12
    --]]
    if p7 ~= "" then
        p7 = p7 .. "."
    end
    for v9, v10 in pairs(p8) do
        local v11 = p7 .. v9
        if type(v10) == "table" then
            u12(p5, p6, v11, v10)
        elseif type(v10) == "string" then
            p5:SetEntryValue(v11, p6 ~= "en" and "" or v10, "", p6, v10)
        else
            error("Bad type for value in \'" .. v11 .. "\'.")
        end
    end
end
function u4.localeFromName(p13) --[[ Line: 51 ]]
    if p13:sub(-5) == ".json" then
        return p13:sub(1, #p13 - 5)
    else
        return p13
    end
end
function u4.getOrCreateLocalizationTable() --[[ Line: 59 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
    --]]
    local v14 = u1:FindFirstChild("GeneratedJSONTable")
    if not v14 then
        v14 = Instance.new("LocalizationTable")
        v14.Name = "GeneratedJSONTable"
        if u3:IsRunning() then
            v14.Parent = u1
        end
    end
    return v14
end
function u4.loadFolder(p15) --[[ Line: 78 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u12
    --]]
    local v16 = u4.getOrCreateLocalizationTable()
    for _, v17 in pairs(p15:GetDescendants()) do
        if v17:IsA("StringValue") then
            local v18 = u4.localeFromName(v17.Name)
            u4.addJsonToTable(v16, v18, v17.Value)
        elseif v17:IsA("ModuleScript") then
            u12(v16, u4.localeFromName(v17.Name), "", require(v17))
        end
    end
    return v16
end
function u4.toLocalizationTable(p19, p20) --[[ Line: 99 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    if typeof(p19) == "Instance" then
        return u4.loadFolder(p19)
    end
    if type(p19) == "string" and type(p20) == "table" then
        return u4.loadTable(p19, p20)
    end
    error("Bad args")
end
function u4.loadTable(p21, p22) --[[ Line: 118 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u12
    --]]
    local v23 = u4.getOrCreateLocalizationTable()
    u12(v23, p21, "", p22)
    return v23
end
function u4.addJsonToTable(p24, p25, p26) --[[ Line: 132 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u12
    --]]
    u12(p24, p25, "", (u2:JSONDecode(p26)))
end
return u4