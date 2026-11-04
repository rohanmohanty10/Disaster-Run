 

local v1 = {}
local u2 = {}
local u3 = table.create(64)
local u4 = table.create(64)
function v1.start(_, p5, p6) --[[ Line: 7 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if p5 == nil then
        warn("returned")
    else
        local v7 = u2
        table.insert(v7, { p5, p6, 0 })
    end
end
local u8 = workspace.CurrentCamera
local u9 = 0
local function v35(p10) --[[ Line: 23 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u3
        [3] = u4
        [4] = u8
        [5] = u2
    --]]
    u9 = os.clock()
    table.clear(u3)
    table.clear(u4)
    local v11 = u8.CFrame.Position
    local v12 = 0
    for v13 = #u2, 1, -1 do
        local v14 = u2[v13]
        if v14 then
            local v15 = v14[1]
            local v16 = v14[2]
            if v15 and (v15.Parent ~= nil and v15:IsDescendantOf(workspace)) then
                local v17 = nil
                if v15:IsA("BasePart") then
                    v17 = v15.Position
                    ::l12::
                    if v17 then
                        local v18 = (v11 - v17).Magnitude
                        if not _G.checkRenderDistance or _G.checkRenderDistance(v17) ~= false then
                            if v18 > 150 then
                                if u9 - v14[3] >= 0.166 then
                                    goto l19
                                end
                            elseif v18 <= 80 or u9 - v14[3] >= 0.066 then
                                goto l19
                            end
                        end
                    else
                        ::l19::
                        v14[3] = u9
                        local v19 = p10 * 60
                        local v20, v21, v22, v23, v24, v25, v26, v27, v28, v29, v30, v31 = v16:components()
                        local v32 = CFrame.new(v20 * v19, v21 * v19, v22 * v19, v23 * v19, v24 * v19, v25 * v19, v26 * v19, v27 * v19, v28 * v19, v29 * v19, v30 * v19, v31 * v19)
                        if v15:IsA("BasePart") then
                            v12 = v12 + 1
                            u3[v12] = v15
                            u4[v12] = v15.CFrame * v32
                        elseif v15:IsA("Model") then
                            v15:PivotTo(v15.PrimaryPart.CFrame * v32)
                        else
                            v15.C0 = v15.C0 * v32
                        end
                    end
                else
                    if not v15:IsA("Model") then
                        if v15.Parent and v15.Parent:IsA("BasePart") then
                            v17 = v15.Parent.Position
                        end
                        goto l12
                    end
                    if v15.PrimaryPart then
                        v17 = v15.PrimaryPart.Position
                        goto l12
                    end
                end
            else
                table.remove(u2, v13)
            end
        else
            table.remove(u2, v13)
        end
    end
    if v12 > 0 then
        local v33 = table.move(u3, 1, v12, 1, table.create(v12))
        local v34 = table.move(u4, 1, v12, 1, table.create(v12))
        workspace:BulkMoveTo(v33, v34, Enum.BulkMoveMode.FireCFrameChanged)
    end
end
game["Run Service"].RenderStepped:Connect(v35)
return v1