 

return {
    ["start"] = function(_, p1, _, _, p2) --[[ Name: start, Line 5 ]]
        if _G.checkRenderDistance(p1.PrimaryPart.Position) == false then
            return
        else
            local v3 = p2 == nil and 0.1 or p2
            local v4 = p1.PrimaryPart:GetChildren()
            local v5 = {}
            local v6 = {}
            for v7 = 1, #v4 do
                if v4[v7]:IsA("Attachment") and v4[v7].Name:match("attach") ~= nil then
                    local v8, _ = string.gsub(v4[v7].Name, "attach", "")
                    local v9 = p1.PrimaryPart:FindFirstChild(v8, true)
                    v5[v4[v7]] = v9
                    v6[v4[v7]] = v9.WorldCFrame
                end
            end
            local v10 = 10 / UserSettings().GameSettings.SavedQualityLevel.Value
            local v11 = 0
            while true do
                game["Run Service"].RenderStepped:Wait()
                local v12 = false
                for v13, v14 in v5 do
                    if tick() - v11 >= 0.1 * v10 then
                        v13.Sand:Emit(1)
                        if math.random(1, 2) == 1 then
                            v13.Wisps:Emit(1)
                            v12 = true
                        else
                            v12 = true
                        end
                    elseif v3 < (v6[v13].Position - v13.WorldPosition).Magnitude and p1.Name == "slash" then
                        v13.Sand:Emit(1)
                        if math.random(1, 2) == 1 then
                            v13.Wisps:Emit(1)
                        end
                        v6[v13] = v13.WorldCFrame
                    end
                    v13.WorldCFrame = v14.TransformedWorldCFrame
                end
                if v12 == true then
                    v11 = tick()
                end
                if p1:IsDescendantOf(workspace) == false or p1.Name == "tet" then
                    return
                end
            end
        end
    end
}