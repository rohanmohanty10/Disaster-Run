 

game:GetService("TweenService")
local u1 = game:GetService("RunService")
game:GetService("HttpService")
local u2 = {}
local u3 = script.Assets
local u7 = (function() --[[ Line: 10 ]]
    local v4 = {}
    for _, v5 in script.Markup:GetChildren() do
        v4[v5.Name] = {}
        for _, v6 in v5:GetChildren() do
            v4[v5.Name][v6.Name] = require(v6)
        end
    end
    return v4
end)()
local u8 = u3.Frame.TextLabel
local v9 = script.Utils
local u10 = {
    ["FontFace"] = u8.FontFace,
    ["TextSize"] = u8.TextSize
}
local u11 = require(v9.TableUtils)
local u12 = require(v9.TextlabelCacher)
local u13 = require(v9.Signal)
local u14 = {}
u14.__index = u14
function u14.new(p15) --[[ Line: 39 ]]
    --[[
    Upvalues:
        [1] = u14
        [2] = u11
        [3] = u10
        [4] = u13
    --]]
    local v16 = u14
    local v17 = setmetatable({}, v16)
    v17.TextProperties = u11.Merge(p15.TextProperties or {}, u10)
    v17.Parent = p15.Parent
    v17.CharacterAdded = p15.CharacterAdded
    v17.OnCharacterAdded = u13.new()
    v17.ScrollingFrame = v17:_createScrollingFrame()
    v17.UIListLayout = v17:_createUIListLayout()
    v17.Lines = {}
    v17.Characters = {}
    v17.Objects = {}
    v17.TextThread = nil
    v17.TextFinished = u13.new()
    v17.IsTextFinished = false
    v17.ID = nil
    return v17
end
function u14._createScrollingFrame(p18) --[[ Line: 62 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v19 = u3.ScrollingFrame:Clone()
    v19.Parent = p18.Parent
    return v19
end
function u14._createUIListLayout(p20) --[[ Line: 69 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v21 = u3.UIListLayout:Clone()
    v21.Parent = p20.ScrollingFrame
    return v21
end
function u14._parseProperties(_, p22, p23) --[[ Line: 76 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    local v24 = u7[p22]
    local v25 = {}
    for v26, v29 in p23:gmatch("%s?(.-)%s?=%s?%\"(.-)%\"") do
        local v28 = v24[v26]
        if v28 then
            local v29 = v28:GetValue(v29) or v29
        end
        v25[v26] = v29
    end
    return v25
end
function u14._snapshotMarkup(_, p30) --[[ Line: 86 ]]
    local v31 = {}
    for _, v32 in p30 do
        local v33 = v31[v32.Name] or {}
        for v34, v35 in v32.Properties do
            v33[v34] = v33[v34] or {}
            local v36 = v33[v34]
            table.insert(v36, v35)
        end
        v31[v32.Name] = v33
    end
    return v31
end
function u14._serializeText(p37, p38) --[[ Line: 99 ]]
    local v39 = 1
    local v40 = {}
    local v41 = {}
    while true do
        while true do
            if v39 > #p38 then
                return v41
            end
            local v42 = string.find(p38, "<", v39, true)
            if not v42 then
                local v43 = p38:sub(v39)
                if #v43 > 0 then
                    local v44 = {
                        ["Text"] = v43,
                        ["Markup"] = p37:_snapshotMarkup(v40)
                    }
                    table.insert(v41, v44)
                    return v41
                end
            end
            if v39 < v42 then
                local v45 = {
                    ["Text"] = p38:sub(v39, v42 - 1),
                    ["Markup"] = p37:_snapshotMarkup(v40)
                }
                table.insert(v41, v45)
            end
            local v46 = p38:sub(v42)
            local v47, v48 = v46:match("^</(%w+)>()")
            if v47 then
                break
            end
            local v49, v50, v51 = v46:match("^<(%w+)%s?([^>]-)>()")
            if v49 then
                local v52 = {
                    ["Name"] = v49,
                    ["Properties"] = p37:_parseProperties(v49, v50)
                }
                table.insert(v40, v52)
                v39 = v42 + v51 - 1
            else
                local v53 = {
                    ["Text"] = "<",
                    ["Markup"] = p37:_snapshotMarkup(v40)
                }
                table.insert(v41, v53)
                v39 = v39 + 1
            end
        end
        for v54 = #v40, 1, -1 do
            if v40[v54].Name == v47 then
                table.remove(v40, v54)
                break
            end
        end
        v39 = v42 + v48 - 1
    end
end
function u14._getTextSize(p55) --[[ Line: 167 ]]
    --[[
    Upvalues:
        [1] = u8
    --]]
    local v56 = p55.TextProperties
    if v56.TextScaled then
        return p55.ScrollingFrame.AbsoluteSize.Y * v56.TextScaled
    elseif v56.TextSize then
        return v56.TextSize
    else
        return u8.TextSize
    end
end
function u14._displayText(p57, p58) --[[ Line: 181 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u12
        [3] = u7
        [4] = u2
    --]]
    p57.IsTextFinished = false
    local _ = p57.ID
    local v59 = p57.ScrollingFrame.AbsoluteSize.X
    local v60 = p57:_getTextSize()
    local v61 = p57.TextProperties.FontFace
    local _ = p57.OnCharacterAdded
    local v62 = 0
    local v63 = nil
    v62 = 0
    v63 = u3.Line:Clone()
    v63.Parent = p57.ScrollingFrame
    local v64 = p57.Lines
    local v65 = v63
    table.insert(v64, v65)
    local v66 = v63
    local v67 = {}
    for _, v68 in p58 do
        local v69 = v68.Text
        local v70 = v68.Markup
        local v71 = 1
        while v71 <= #v69 do
            local v72 = 0
            local v73 = {}
            while true do
                local v74 = v69:sub(v71, v71)
                local v75 = u12:GetText({
                    ["Font"] = v61,
                    ["TextSize"] = v60,
                    ["Text"] = v74
                })
                if #v74 == 0 then
                    break
                end
                table.insert(v73, v75)
                v72 = v72 + v75.Size.X.Offset
                v71 = v71 + 1
                if not v74:match("%w") then
                    break
                end
            end
            if v62 + v72 < v59 then
                for _, v76 in v73 do
                    table.insert(v67, {
                        ["Character"] = v76,
                        ["Line"] = v66,
                        ["Markups"] = v70
                    })
                end
            elseif v72 < v59 then
                v62 = 0
                v63 = u3.Line:Clone()
                v63.Parent = p57.ScrollingFrame
                local v77 = p57.Lines
                local v78 = v63
                table.insert(v77, v78)
                v66 = v63
                for _, v79 in v73 do
                    table.insert(v67, {
                        ["Character"] = v79,
                        ["Line"] = v66,
                        ["Markups"] = v70
                    })
                end
            else
                local v80 = #v73
                local v81 = 1
                while v81 < v80 do
                    local v82 = false
                    while v81 < v80 do
                        local v83 = v73[v81]
                        local v84 = v83.Size.X.Offset
                        local v85 = v73[v81 + 1] and (v73[v81 + 1].Size.X.Offset or 0) or 0
                        if v62 + v84 + v85 >= v59 then
                            v82 = true
                            break
                        end
                        table.insert(v67, {
                            ["Character"] = v83,
                            ["Line"] = v66
                        })
                        v81 = v81 + 1
                        v62 = v62 + v84
                    end
                    if v81 <= v80 and v82 then
                        table.insert(v67, {
                            ["Character"] = {
                                ["Font"] = v61,
                                ["TextSize"] = v60,
                                ["Text"] = "-"
                            },
                            ["Line"] = v66,
                            ["Markups"] = v70
                        })
                    end
                    v62 = 0
                    v63 = u3.Line:Clone()
                    v63.Parent = p57.ScrollingFrame
                    local v86 = p57.Lines
                    local v87 = v63
                    table.insert(v86, v87)
                    v66 = v63
                end
            end
            v62 = v62 + v72
        end
    end
    for _, v88 in v67 do
        local v89 = v88.Character
        local v90 = v89.TextLabel
        local _ = v90.Position
        local v91 = v88.Markups
        for v92, v93 in p57.TextProperties do
            v90[v92] = v93
        end
        for v94, v95 in v91 do
            local v96 = u7[v94]
            for v97, v98 in v95 do
                local v99 = v96[v97]
                for _, v100 in v98 do
                    local v101 = v99:Render(v89, v100)
                    if typeof(v101) == "table" then
                        local v102 = p57.Objects
                        table.insert(v102, v101)
                        u2[p57] = true
                    end
                end
            end
        end
        v89.Parent = v88.Line
        local v103 = p57.Characters
        table.insert(v103, v89)
        if p57.CharacterAdded then
            p57.CharacterAdded(v90.Text)
        end
        p57.OnCharacterAdded:Fire(v90.Text)
    end
    p57.TextFinished:Fire()
    p57.IsTextFinished = true
end
function u14.Display(u104, u105) --[[ Line: 328 ]]
    u104:Clear()
    u104.TextThread = task.defer(function() --[[ Line: 330 ]]
        --[[
        Upvalues:
            [1] = u104
            [2] = u105
        --]]
        u104:_displayText((u104:_serializeText(u105)))
    end)
end
function u14.GetCharacters(p106) --[[ Line: 336 ]]
    return p106.Characters
end
function u14.Clear(p107) --[[ Line: 340 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    u2[p107] = nil
    local v108 = p107.TextThread
    if v108 and coroutine.status(v108) ~= "dead" then
        task.defer(task.cancel, v108)
    end
    p107.TextThread = nil
    for _, v109 in { p107.Lines, p107.Characters } do
        for v110, v111 in v109 do
            v111:Destroy()
            v109[v110] = nil
        end
    end
end
function u14.Init() --[[ Line: 358 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    u1.Heartbeat:Connect(function(p112) --[[ Line: 359 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        for v113 in u2 do
            local v114 = {}
            for _, v115 in v113.Objects do
                local v116 = v115.TextLabel
                local v117 = v115.Module:Update(v115, p112)
                if v117 then
                    for v118, v121 in v117 do
                        v114[v116] = v114[v116] or {}
                        local v120 = v114[v116]
                        if v114[v116] and v114[v116][v118] then
                            local v121 = v114[v116][v118] + v121 or v121
                        end
                        v120[v118] = v121
                    end
                end
            end
            for v122, v123 in v114 do
                for v124, v125 in v123 do
                    v122[v124] = v125
                end
            end
        end
    end)
end
return u14